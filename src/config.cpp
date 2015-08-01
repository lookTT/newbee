/*
 * config.cpp
 *
 *  Created on: 2015-6-23
 *      Author: longtao
 */

#include "config.h"

//
#define FREE_C_STRING(str)  if(NULL != str){ free(str); str = NULL; }

// For readability
#define LUA_GET_NUMBER(plua, key, value) \
        lua_getglobal(plua, key);\
        value = lua_tonumber(plua, -1);\
        lua_pop(plua, 1);

//For readability
#define LUA_GET_STRING(plua, key, value) \
        lua_getglobal(plua, key);\
        if(strcmp(lua_tostring(plua, -1), value)){\
            FREE_C_STRING(value)\
            value = strdup(lua_tostring(plua, -1));\
            lua_pop(plua, 1);\
        }

void getAppRootDir(char* str) {
    char buf[128];
    memset(buf, 0, sizeof(buf));
    readlink("/proc/self/exe", buf, sizeof(buf));
    uint32 size = strlen(buf);
    char * p = NULL;
    if (size > 0) {
        for (uint32 i = size - 1; i >= 0; --i) {
            p = &buf[i];
            if (*p == '/')
                break;
        }
    }
    memcpy(str, buf, p - buf + 1);
}

CConfig::CConfig() :
    pid(0),
    daemonize(NEWBEE_DEAMONIZE),
    port(NEWBEE_PORT),
    port_http(NEWBEE_PORT_HTTP),
    pidfile(strdup(NEWBEE_DEFAULT_PID_FILE)),
    glog_info_file(strdup(NEWBEE_DEFAULT_NULL_FILE)),
    glog_warning_file(strdup(NEWBEE_DEFAULT_NULL_FILE)),
    glog_error_file(strdup(NEWBEE_DEFAULT_NULL_FILE)),
    /*lua_script_path(strdup("")),*/
    lua_entrance(strdup(NEWBEE_DEFAULT_LUA_ENTRANCE)),
    lua_suffix(strdup(NEWBEE_DEFAULT_LUA_SUFFIX))/*,*/
    /*lua_framework(NULL)*/ {

    lua_script_path = (char*) malloc(NEWBEE_MAX_PATH_LEN);
    memset(lua_script_path, 0, sizeof(lua_script_path));
    //find the defult script path
    getAppRootDir(lua_script_path);
    strcat(lua_script_path, NEWBEE_DEFAULT_LUA_SCRIPT_FILE);
    if (lua_script_path[strlen(lua_script_path) - 1] != '/') {
        lua_script_path[strlen(lua_script_path)] = '/';
    }

    FREE_C_STRING(lua_framework);
    lua_framework = (char*) malloc(NEWBEE_MAX_PATH_LEN);
    memset(lua_framework, 0, NEWBEE_MAX_PATH_LEN);
    strcat(lua_framework, lua_script_path);
    strcat(lua_framework, NEWBEE_DEFAULT_LUA_FRAMEWORK);

    FREE_C_STRING(lua_app);
    lua_app = (char*) malloc(NEWBEE_MAX_PATH_LEN);
    memset(lua_app, 0, NEWBEE_MAX_PATH_LEN);
    strcat(lua_app, lua_script_path);
    strcat(lua_app, NEWBEE_DEFAULT_LUA_APP);
}

CConfig::~CConfig() {
    FREE_C_STRING(pidfile);
    FREE_C_STRING(glog_info_file);
    FREE_C_STRING(glog_warning_file);
    FREE_C_STRING(glog_error_file);
    FREE_C_STRING(lua_script_path);
}

CConfig* CConfig::getInstance() {
    static CConfig o;
    return &o;
}

bool CConfig::init(char* config_path) {
    lua_State* plua = luaL_newstate();
    if (luaL_dofile(plua, config_path) != 0) {
        lua_close(plua);
        return false;
    }

    LUA_GET_NUMBER(plua,"daemonize",daemonize)
    LUA_GET_NUMBER(plua,"port", port)
    LUA_GET_NUMBER(plua,"port_http", port_http)
    LUA_GET_STRING(plua,"pidfile",pidfile)
    LUA_GET_STRING(plua,"logfile", glog_info_file)
    LUA_GET_STRING(plua,"logfile", glog_warning_file)
    LUA_GET_STRING(plua,"logfile", glog_error_file)

    //Some lua configuration
    LUA_GET_STRING(plua,"luapath", lua_script_path)
    //TODO: OK, I know is not cool
    if (strcmp(lua_script_path, "") == 0) {
        FREE_C_STRING(lua_script_path);
        lua_script_path = (char*) malloc(NEWBEE_MAX_PATH_LEN);
        memset(lua_script_path, 0, sizeof(lua_script_path));
        //find the defult script path
        getAppRootDir(lua_script_path);
        strcat(lua_script_path, NEWBEE_DEFAULT_LUA_SCRIPT_FILE);
        if (lua_script_path[strlen(lua_script_path) - 1] != '/') {
            lua_script_path[strlen(lua_script_path)] = '/';
        }
    }

    LUA_GET_STRING(plua, "lua_entrance", lua_entrance);
    LUA_GET_STRING(plua, "lua_suffix", lua_suffix);

    FREE_C_STRING(lua_framework);
    lua_framework = (char*) malloc(NEWBEE_MAX_PATH_LEN);
    memset(lua_framework, 0, NEWBEE_MAX_PATH_LEN);
    strcat(lua_framework, lua_script_path);
    strcat(lua_framework, NEWBEE_DEFAULT_LUA_FRAMEWORK);

    FREE_C_STRING(lua_app);
    lua_app = (char*) malloc(NEWBEE_MAX_PATH_LEN);
    memset(lua_app, 0, NEWBEE_MAX_PATH_LEN);
    strcat(lua_app, lua_script_path);
    strcat(lua_app, NEWBEE_DEFAULT_LUA_APP);


    return true;
}
