#include "websockets.h"

static char peer_name[128];

static int callback_logic(struct libwebsocket_context *context, struct libwebsocket *wsi, enum libwebsocket_callback_reasons reason, void *user, void *in, size_t len);

static struct libwebsocket_protocols protocols[] = {

{ "abc", callback_logic, sizeof(struct per_session_data) },

{ NULL, NULL, 0 } };

CWebSocketsServer* CWebSocketsServer::Instance() {
    static CWebSocketsServer o;

    return &o;
}

CWebSocketsServer::CWebSocketsServer() :
    m_context(NULL) {

    memset(&m_info, 0, sizeof(m_info));
    m_mapUserHandler.clear();
}

CWebSocketsServer::~CWebSocketsServer() {
}

bool CWebSocketsServer::Open(const uint16& nPort) {
    if (0 == nPort) {
        return true;
    }

    m_info.port = nPort;
    m_info.iface = NULL;
    m_info.protocols = protocols;
    m_info.extensions = libwebsocket_get_internal_extensions();
    m_info.ssl_cert_filepath = NULL;
    m_info.ssl_private_key_filepath = NULL;
    m_info.gid = -1;
    m_info.uid = -1;
    m_info.options = 0;

    m_context = libwebsocket_create_context(&m_info);

    return true;
}

void CWebSocketsServer::EventLoop() {
    //create libwebsocket context representing this server
    if (m_context != NULL) {
        libwebsocket_service(m_context, 0);
    }

}

void CWebSocketsServer::OnClosed() {
    libwebsocket_context_destroy(m_context);
}

static int callback_logic(struct libwebsocket_context *context, struct libwebsocket *wsi, enum libwebsocket_callback_reasons reason, void *user, void *in, size_t len) {

    uint64 uguid = (uint64) user;
    //uint64 wguid = (uint64) wsi;

    struct per_session_data *pss = (struct per_session_data *) user;
    int n;

    lua_State* pLuaState = g_pApp->getLuaState();

    switch (reason) {
    case LWS_CALLBACK_ESTABLISHED: {
        //init the data
        memset(pss, 0, sizeof(pss));
        g_pWebSocketsServer->AddUserHandler(uguid, pss, wsi);
        char ip[32];
        libwebsockets_get_peer_addresses(context, wsi, libwebsocket_get_socket_fd(wsi), peer_name, sizeof(peer_name), ip, sizeof(ip));

        char str_uguid[64];
        memset(str_uguid, 0, sizeof(str_uguid));
        sprintf(str_uguid, "%llu", uguid);

        lua_settop(pLuaState, 0);
        lua_getglobal(pLuaState, "CLF_ClientConnect");
        lua_pushstring(pLuaState, str_uguid);
        lua_pushstring(pLuaState, ip);
        if (0 != lua_pcall(pLuaState, 2, 0, 0)) {
            LOG(ERROR) << "Failed to call LUA function 'CLF_ClientConnect':" << lua_tostring(pLuaState, -1);
        }
        break;
    }
        /* when the callback is used for server operations --> */
    case LWS_CALLBACK_SERVER_WRITEABLE: {

        //Forces the user offline
        if (pss->isKickOff) {
            return -1;
        }

        SUserHandler* pSUserHandler = g_pWebSocketsServer->GetUserHandler(uguid);
        if (NULL == pSUserHandler || NULL == context) {
            return -1;
        }

        if (pSUserHandler->msg_buffer.size() == 0) {
            break;
        }

        s_message_buffer& pSMessageBuffer = pSUserHandler->msg_buffer.front();
        memcpy(&pss->buf[LWS_SEND_BUFFER_PRE_PADDING], pSMessageBuffer.buf, pSMessageBuffer.len);
        pss->len = pSMessageBuffer.len;
        pSUserHandler->msg_buffer.pop();

        //Send msg
        n = libwebsocket_write(wsi, &pss->buf[LWS_SEND_BUFFER_PRE_PADDING], pss->len, LWS_WRITE_TEXT);
        if (n < 0) {
            lwsl_err("ERROR %d writing to socket, hanging up\n", n);
            return 1;
        }
        if (n < (int) pss->len) {
            lwsl_err("Partial write\n");
            for (uint32 i = 0; i < pSUserHandler->msg_buffer.size(); ++i) {
                pSUserHandler->msg_buffer.pop();
            }
            return -1;
        }

        if (pSUserHandler->msg_buffer.size() != 0) {
            libwebsocket_callback_on_writable(context, pSUserHandler->wsi);
        }

        break;
    }

    case LWS_CALLBACK_RECEIVE: {
        if (len > MAX_DATA_SIZE) {
            lwsl_err("Server received packet bigger than %u, hanging up\n", MAX_DATA_SIZE);
            return 1;
        }
        char data[MAX_DATA_SIZE];
        memset(data, 0, sizeof(data));
        memcpy(data, in, len);

        char str_uguid[64];
        memset(str_uguid, 0, sizeof(str_uguid));
        sprintf(str_uguid, "%llu", uguid);

        lua_settop(pLuaState, 0);
        lua_getglobal(pLuaState, "CLF_DealWithWebsocketsLogic");
        lua_pushstring(pLuaState, str_uguid);
        lua_pushstring(pLuaState, data);
        if (0 != lua_pcall(pLuaState, 2, 0, 0)) {
            LOG(ERROR) << "Failed to call LUA function 'CLF_DealWithWebsocketsLogic':" << lua_tostring(pLuaState, -1);
        }

        break;
    }

    case LWS_CALLBACK_CLOSED: {
        char str_uguid[64];
        memset(str_uguid, 0, sizeof(str_uguid));
        sprintf(str_uguid, "%llu", uguid);

        lua_settop(pLuaState, 0);
        lua_getglobal(pLuaState, "CLF_ClientDropped");
        lua_pushstring(pLuaState, str_uguid);
        if (0 != lua_pcall(pLuaState, 1, 0, 0)) {
            LOG(ERROR) << "Failed to call LUA function 'CLF_ClientDropped':" << lua_tostring(pLuaState, -1);
        }
        g_pWebSocketsServer->DelUserHandler(uguid);

        break;
    }

    case LWS_CALLBACK_WSI_DESTROY:
        break;

    default:
        break;
    }

    return 0;
}

