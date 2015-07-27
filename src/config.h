/*
 * config.h
 *
 *  Created on: 2015-6-23
 *      Author: longtao
 */

#ifndef CONFIG_H_
#define CONFIG_H_

#include "newbee.h"
#include "string"

#define NEWBEE_MAX_PATH_LEN (256)

#define NEWBEE_PORT (8080)
#define NEWBEE_PORT_HTTP (3501)
#define NEWBEE_DEAMONIZE (0)

#define NEWBEE_DEFAULT_PID_FILE "/var/run/server.pid"
#define NEWBEE_DEFAULT_NULL_FILE "/dev/null"
#define NEWBEE_DEFAULT_LUA_SCRIPT_FILE "scrip"
#define NEWBEE_DEFAULT_LUA_ENTRANCE "main"
#define NEWBEE_DEFAULT_LUA_SUFFIX "lua"
#define NEWBEE_DEFAULT_LUA_FRAMEWORK "framework/"
#define NEWBEE_DEFAULT_LUA_APP "app/"

class CConfig {

public:
    static CConfig* getInstance();
    ~CConfig();

    bool init(char* config_path);
private:
    CConfig();

public:
    /* Main process pid. */
    pid_t pid;
    /* True if running as a daemon */
    uint32 daemonize;
    /* TCP listening port */
    uint32 port;
    /* HTTP listening port */
    uint32 port_http;
    /* PID file path */
    char *pidfile;
    /* glog info file path */
    char * glog_info_file;
    /* glog warning file path */
    char * glog_warning_file;
    /* glog error file path */
    char * glog_error_file;
    /* lua script path */
    char* lua_script_path;
    char* lua_entrance;
    char* lua_suffix;
    char* lua_framework;
    char* lua_app;
};

#define g_pConf      (CConfig::getInstance())

#endif /* CONFIG_H_ */
