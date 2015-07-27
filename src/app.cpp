#include "app.h"
#include "config.h"
#include "websockets.h"
#include "lualogic.h"

//  The minimum interval to execute a update function
#define UPDATE_SLEEP        25

CApp::CApp() :
    _pLua(NULL), _isShutDown(false) {
}

CApp::~CApp() {
}

CApp* CApp::getInstance() {
    static CApp oApp;

    return &oApp;
}

bool CApp::init() {
    if (!g_pWebSocketsServer->Open(g_pConf->port)) {
        return false;
    }

    //
    if (!initLuaStack()) {
        return false;
    }

    return true;
}

void CApp::run() {
    //main loop
    while (!_isShutDown) {
        g_pWebSocketsServer->EventLoop();

        sleep(1);
    }

    // release all
    g_pWebSocketsServer->OnClosed();
}

void CApp::close() {
    _isShutDown = true;
}

void CApp::addSearchPath(const char* path) {
    // add search path
    lua_getglobal(_pLua, "package");
    lua_getfield(_pLua, -1, "path");
    const char* cur_path = lua_tostring(_pLua, -1);
    //lua_pushfstring(_pLua, "%s;%s?.%s", cur_path, g_pConf->lua_script_path, g_pConf->lua_suffix);
    lua_pushfstring(_pLua, "%s;%s?.%s", cur_path, path, g_pConf->lua_suffix);
    lua_setfield(_pLua, -3, "path");
    lua_pop(_pLua, -2);
}

bool CApp::initLuaStack() {
    _pLua = luaL_newstate();
    if (NULL == _pLua) {
        return false;
    }
    // open libs
    luaL_openlibs(_pLua);
    lua_openServerLogic(_pLua);

    addSearchPath(g_pConf->lua_script_path);
    addSearchPath(g_pConf->lua_framework);
    addSearchPath(g_pConf->lua_app);

    char dofile[256];
    memset(dofile, 0, sizeof(dofile));
    sprintf(dofile, "%s%s.%s", g_pConf->lua_script_path, g_pConf->lua_entrance, g_pConf->lua_suffix);
    // load and call
    if (0 != luaL_dofile(_pLua, dofile)) {
        LOG(ERROR) << "Failed to load or call script:" << lua_tostring(
                _pLua, -1);
        return false;
    }

    return true;
}

