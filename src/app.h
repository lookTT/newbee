/*
 * App.h
 *
 *  Created on: 2014-12-22
 */

#ifndef APP_H_
#define APP_H_

#include <map>
#include "newbee.h"

class CApp {
public:
    ~CApp();
    static CApp* getInstance();

    lua_State* getLuaState() const {
        return _pLua;
    }

    bool init();
    void run();
    void close();

    void addSearchPath(const char* path);
private:
    CApp();

    bool initLuaStack();
private:
    // luaState
    lua_State* _pLua;
    // mar shutdown the server
    bool _isShutDown;
};

#define g_pApp      (CApp::getInstance())

#endif /* APP_H_ */
