#ifndef WEBSOCKETS_H_
#define WEBSOCKETS_H_

#include <map>
#include <queue>
#include "newbee.h"
#include "libwebsockets.h"
#include "app.h"

#define MAX_DATA_SIZE (32*1024)

//static const char* g_teaKey = "[/28!~&0sM1-)G&z";
//static const uint32 g_teaKeyLen = strlen(g_teaKey);

struct per_session_data {
    unsigned char buf[LWS_SEND_BUFFER_PRE_PADDING + MAX_DATA_SIZE + LWS_SEND_BUFFER_POST_PADDING];
    unsigned int len;
    bool isKickOff;
};

//
struct s_message_buffer {
    unsigned char buf[MAX_DATA_SIZE];
    unsigned int len;

    s_message_buffer() {
        memset(buf, 0, MAX_DATA_SIZE);
        len = 0;
    }
};

struct SUserHandler {
    struct per_session_data * userData;
    struct libwebsocket *wsi;
    std::queue<s_message_buffer> msg_buffer;
};

class CWebSocketsServer {
public:
    static CWebSocketsServer* Instance();
    ~CWebSocketsServer();

    bool Open(const uint16& nPort);
    void EventLoop();
    void OnClosed();

    libwebsocket_context * GetContext() {
        return m_context;
    }

    void AddUserHandler(uint64 uguid, struct per_session_data * pUserData, struct libwebsocket *pWsi) {
        if (NULL == pUserData || NULL == pWsi)
            return;

        SUserHandler* p = new SUserHandler();
        p->userData = pUserData;
        p->wsi = pWsi;
        for (uint32 i = 0; i < p->msg_buffer.size(); ++i) {
            p->msg_buffer.pop();
        }
        m_mapUserHandler[uguid] = p;
    }

    void DelUserHandler(uint64 uguid) {
        std::map<uint64, SUserHandler*>::iterator iter = m_mapUserHandler.find(uguid);
        if (iter != m_mapUserHandler.end()) {
            delete iter->second;
            m_mapUserHandler.erase(iter);
        }
    }

    SUserHandler* GetUserHandler(uint64 uguid) {
        std::map<uint64, SUserHandler*>::iterator iter = m_mapUserHandler.find(uguid);
        if (iter != m_mapUserHandler.end()) {
            return iter->second;
        }
        return NULL;
    }

    std::map<uint64, SUserHandler*>& GetAllUserHandler() {
        return m_mapUserHandler;
    }

private:
    CWebSocketsServer();

private:
    struct lws_context_creation_info m_info;
    struct libwebsocket_context *m_context;

    std::map<uint64, SUserHandler*> m_mapUserHandler;
};

#define g_pWebSocketsServer      (CWebSocketsServer::Instance())

#endif /* WEBSOCKETS_H_ */
