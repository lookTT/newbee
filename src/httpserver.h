/*
 * httpserver.h
 *
 *  Created on: 2015-7-28
 *      Author: longtao
 */

#ifndef HTTPSERVER_H_
#define HTTPSERVER_H_

#include "newbee.h"

class CHttpServer {
public:
    static CHttpServer* Instance();
    ~CHttpServer();

    bool Open(const uint16 nPort);
    void EventLoop();
    void OnClosed();

private:
    CHttpServer();

    /**
     * php interface
     * @param req url_path
     * @param arg custom_param
     * @return
     */
    static void HttpHandler(struct evhttp_request *req, void *arg);

private:
    struct event_base* m_pBackstageBase;
    struct evhttp* m_pBackstageHttp;
};

#define g_pHttpServer      (CHttpServer::Instance())

#endif /* HTTPSERVER_H_ */
