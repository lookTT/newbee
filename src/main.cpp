//============================================================================
// Name        : main.cpp
// Author      : longtao
// Version     :
// Copyright   : Free and hope you like.
// Description : Hello World in C++, Ansi-style
//============================================================================


#include "newbee.h"
#include "config.h"
#include "app.h"

#include <iostream>

using namespace std;

struct CConfig* config = CConfig::getInstance();

void createPidFile(void) {
    /* Try to write the pid file in a best-effort way. */
    FILE *fp = fopen(config->pidfile, "w");
    if (fp) {
        fprintf(fp, "%d\n", (int) getpid());
        fclose(fp);
    }
}

void daemonize(void) {
    int fd;

    if (fork() != 0)
        exit(0); /* parent exits */
    setsid(); /* create a new session */

    /* Every output goes to /dev/null. If Server is daemonized but
     * the 'logfile' is set to 'stdout' in the configuration file
     * it will not log at all. */
    if ((fd = open("/dev/null", O_RDWR, 0)) != -1) {
        dup2(fd, STDIN_FILENO);
        dup2(fd, STDOUT_FILENO);
        dup2(fd, STDERR_FILENO);
        if (fd > STDERR_FILENO)
            close(fd);
    }
}

int main(int argc, char* argv[]) {

    google::InitGoogleLogging(argv[0]);

    if (argc == 2 && !g_pConf->init(argv[1])) {
        std::cout << "Please check the configuration file options" << endl;
        std::cout << "Example:[NickName@localhost ~]$ ./newbee /home/newbee/config.lua" << endl;
        return -1;
    }

    if (!g_pApp->init()) {
        return -2;
    }

    google::SetLogDestination(google::INFO, g_pConf->glog_info_file);
    google::SetLogDestination(google::WARNING, g_pConf->glog_warning_file);
    google::SetLogDestination(google::ERROR, g_pConf->glog_error_file);

    if (g_pConf->daemonize) {
        daemonize();
        //createPidFile();
    }

    g_pApp->run();

    google::ShutdownGoogleLogging();

    return 0;
}
