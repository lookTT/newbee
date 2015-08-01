#include "lualogic.h"
#include <glog/logging.h>
#include "app.h"
#include "websockets.h"
#include "md5.h"

static int CCF_Send2Client(lua_State* pLuaState) {
    if (!lua_isstring(pLuaState, 1) || !lua_isstring(pLuaState, 2)) {
        LOG(ERROR) << "lua call cpp function error:CCF_Send2Client()";
        return 0;
    }
    const char* p_uguid = lua_tostring(pLuaState, 1);
    const char* json = lua_tostring(pLuaState, 2);

    uint64 uguid = 0;
    sscanf(p_uguid, "%llu", &uguid);

    SUserHandler* pSUserHandler = g_pWebSocketsServer->GetUserHandler(uguid);
    libwebsocket_context * context = g_pWebSocketsServer->GetContext();
    if (NULL == pSUserHandler || NULL == context) {
        LOG(ERROR) << "lua call cpp function error:CCF_Send2Client()  NULL == pSUserHandler || NULL == context";
        return 0;
    }

    uint32 len = strlen(json);
    s_message_buffer p;
    memcpy(p.buf, json, len);
    p.len = len;
    pSUserHandler->msg_buffer.push(p); // Direct call memory copy operation efficiency should be O(n)

    libwebsocket_callback_on_writable(context, pSUserHandler->wsi);

    return 0;
}

// Create a local unique ID
static int CCF_CreateObjID(lua_State* pLuaState) {
    /**
     * platformid<= 255 serverid<= 255 seedid<=65535
     * [0] = platformid
     * [1] = serverid
     * [2] \time
     * [3] \time
     * [4] /time
     * [5] /time
     * [6] \ seedid
     * [7] / seedid
     * */

    if (!lua_isnumber(pLuaState, 1) || !lua_isnumber(pLuaState, 2)) {
        LOG(ERROR) << "lua call cpp function param type error:CCF_CreateObjID()";
        return 0;
    }
    // Get data
    uint64 platfromid = (uint64) lua_tointeger(pLuaState, 1);
    uint64 serverid = (uint64) lua_tointeger(pLuaState, 2);

    time_t timeCur;
    time(&timeCur);
    uint64 curTime = timeCur & 0xffffffff;

    static uint64 seed = 0;
    if (seed > 0xffff)
        seed = 0;

    // create guid
    uint64 guid = ((platfromid) << (8 + 32 + 16)) | ((serverid) << (32 + 16)) | ((curTime) << 16) | ((seed) & 0xffff);

    // Formating string
    char pBuff[32];
    memset(pBuff, 0, sizeof(pBuff));
    sprintf(pBuff, "%llu", guid);

    lua_pushstring(pLuaState, pBuff);

    return 1;
}

static int CCF_GLOG(lua_State* pLuaState) {
    if (!lua_isstring(pLuaState, 1)) {
        LOG(ERROR) << "lua call cpp function error:CCF_GLOG()";
        return 0;
    }
    const char* c = lua_tostring(pLuaState, 1);
    LOG(INFO) << c;
    return 0;
}

static int CCF_MD5(lua_State* pLuaState) {
    if (!lua_isstring(pLuaState, 1)) {
        LOG(ERROR) << "lua call cpp function error:CCF_MD5()";
        return 0;
    }

    lua_pushstring(pLuaState, md5(lua_tostring(pLuaState, 1)).c_str());
    return 1;
}

extern void lua_openServerLogic(lua_State* pLuaState) {
    lua_register(pLuaState, "CCF_Send2Client", CCF_Send2Client);

    lua_register(pLuaState, "CCF_CreateObjID", CCF_CreateObjID);
    lua_register(pLuaState, "CCF_GLOG", CCF_GLOG);
    lua_register(pLuaState, "CCF_MD5", CCF_MD5);
}
