/*
 * httpserver.cpp
 *
 *  Created on: 2015-7-28
 *      Author: longtao
 */

#include "httpserver.h"
#include "app.h"
#include <evhttp.h>

CHttpServer* CHttpServer::Instance() {
    static CHttpServer o;
    return &o;
}

CHttpServer::CHttpServer() :
    m_pBackstageBase(NULL), m_pBackstageHttp(NULL) {
}

CHttpServer::~CHttpServer() {

}

bool CHttpServer::Open(const uint16 nPort) {
    // web
    m_pBackstageBase = event_base_new();
    m_pBackstageHttp = evhttp_new(m_pBackstageBase);
    if (NULL == m_pBackstageHttp) {
        LOG(ERROR) << "Can't Create HTTP Server";
        return false;
    }

    struct evhttp_bound_socket *handle;
    handle = evhttp_bind_socket_with_handle(m_pBackstageHttp, "0.0.0.0", nPort);

    //listen from web server
    evhttp_set_timeout(m_pBackstageHttp, 5);
    evhttp_set_gencb(m_pBackstageHttp, HttpHandler, NULL);

    return true;
}

void CHttpServer::EventLoop() {
    event_base_loop(m_pBackstageBase, EVLOOP_NONBLOCK);
}

void CHttpServer::OnClosed() {

}

void CHttpServer::HttpHandler(struct evhttp_request* pReq, void* arg) {
    /* Analysis of URL parameters */
    char* pDecodeUri = strdup((char*) evhttp_request_uri(pReq));
    struct evkeyvalq sHttpQuery;
    evhttp_parse_query(pDecodeUri, &sHttpQuery);
    free(pDecodeUri);

    /// Get the parameters from GET Form
    //const char* time = evhttp_find_header(&sHttpQuery, "t");


    lua_State* pluaState = g_pApp->getLuaState();
    if (NULL == pluaState)
        return;

    const char* json = evhttp_find_header(&sHttpQuery, "json");

    int errorid = 0;
    lua_settop(pluaState, 0);
    lua_getglobal(pluaState, "CLF_DealWithHttpLogic");
    lua_pushstring(pluaState, json);
    if (0 != lua_pcall(pluaState, 1, 1, 0)) {
        LOG(ERROR) << "Failed to call LUA function 'CLF_DealWithHttpLogic':" << lua_tostring(pluaState, -1);
        errorid = 1;
    }
    // get the lua return value
    if (!lua_isstring(pluaState, 1)) {
        LOG(ERROR) << "CHttpServer::HttpHandler::CLF_DealWithHttpLogic get the lua return value type error";
        errorid = 2;
    }
    const char* r_json = errorid == 0 ? lua_tostring(pluaState, 1) : "0";

    //Initialization returned to the client data cache
    struct evbuffer* pEvBuf = evbuffer_new();
    //Processing output header header
    evhttp_add_header(pReq->output_headers, "Content-Type", "text/plain");
    evhttp_add_header(pReq->output_headers, "Connection", "keep-alive");
    evhttp_add_header(pReq->output_headers, "Cache-Control", "no-cache");

    //Here is the output data to be displayed
    evbuffer_add_printf(pEvBuf, r_json);
    //Return code 200
    evhttp_send_reply(pReq, HTTP_OK, "OK", pEvBuf);

    //Release memory
    evhttp_clear_headers(&sHttpQuery);
    evbuffer_free(pEvBuf);
}
