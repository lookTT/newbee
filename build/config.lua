--By default newbee does not run as a daemon. Use '1' if you need it.
--默认情况下newbee不是守护进程, 如果需要请设置为1.
daemonize = 0

--Websockets
--Accept connections on the specified port, default is 8000.
--接受制定的端口连接 默认端口号8000
port = 8000

--HTTP
--Accept connections on the specified port, default is 3501.
--接受制定的端口连接 默认端口号3501
port_http = 3501

--When running daemonized, newbee writes a pid file in /var/run/newbee.pid by default. 
--You can specify a custom pid file location here.
--当以守护进程运行时 默认状态下newbee会在/var/run/newbee.pid位置写一个pid文件
--你可以在这里制定一个pid文件的自定义位置
pidfile = "/var/run/newbee.pid"

--Record log directory location, the default is no logging(/dev/null)
--记录日志的目录位置 默认所不记录任何日志的
logfile = "/dev/null"

--lua scripts directory.  By default It's 'script' directory (under the startup directory).
--lua脚本目录 默认为启动目录下的script目录
luapath = ""

--lua entrance filename
--lua入口文件名
lua_entrance = "main"

--lua suffix
--lua后缀名
lua_suffix = "lua"
