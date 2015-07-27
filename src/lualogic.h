#ifndef LUALOGIC_H_
#define LUALOGIC_H_

//extern "C" {
//#ifdef WIN32
//#include "lua/lauxlib.h"
//#include "lua/lua.h"
//#include "lua/lualib.h"
//#else
//#include "luajit-2.0/lauxlib.h"
//#include "luajit-2.0/lua.h"
//#include "luajit-2.0/lualib.h"
//#endif // WIN32
//}

#include "newbee.h"

// register c function in lua state
extern void lua_openServerLogic(lua_State* pLuaState);

#endif /* LUALOGIC_H_ */
