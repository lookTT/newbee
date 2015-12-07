newbee是什么?
--------------
newbee是个遵循简单美学的小东西，意在建立简单好用的lua服务器

很多手机软件工程师都会用到脚本语言(比如lua)，使用lua做服务器可以节省开发者学习Java、PHP、Python等服务器编程语言的语言学习成本。

newbee使用了C++和lua进行开发，希望大家喜欢。

项目使用了很多其他开源库，毕竟有这么多巨人的肩膀。

(libevent, libwebsokets, luajit, luarocks, lua-cjson, luasocket, luasql-mysql, redis-lua)

增加了一个简单的setup.sh的shell脚本来安装这些必要的依赖库，都是默认安装，编写时使用的操作系统是CentOS 6.7，理论上是支持所有Linux like的操作系统，建议在CentOS 6.x上做开发部署

构建newbee
--------------
Simple as:

    $ git clone https://github.com/lookTT/newbee.git
    $ sh setup.sh
    $ cd build
    $ make

对应cocos2dx 例子
--------------

例子中的"abc"是对应websockets.cpp文件中protocols来写的例子，在实际的环境下为了协议安全建议大家写一个31字长以下的字符串。
至于为什么是31位大家可以自己试更大的长度，也可以看看warmcat/libwebsockets的实现。

lua:

    websocket = cc.WebSocket:createByAProtocol("127.0.0.1:8080", "abc")
    if nil ~= websocket then
        websocket:registerScriptHandler(websocket_open,cc.WEBSOCKET_OPEN)
        websocket:registerScriptHandler(websocket_message,cc.WEBSOCKET_MESSAGE)
        websocket:registerScriptHandler(websocket_close,cc.WEBSOCKET_CLOSE)
        websocket:registerScriptHandler(websocket_error,cc.WEBSOCKET_ERROR)
    end
 
 
js:

    var WebSocket = WebSocket || window.WebSocket || window.MozWebSocket;
    var _wsiSendText = new WebSocket("ws://127.0.0.1:8080", "abc");
    //连接成功
    _wsiSendText.onopen = function (evt) {
        cc.log("_wsiSendText onopen");
    };
    //收到信息
    _wsiSendText.onmessage = function (evt) {
        cc.log("response text msg: " + evt.data);
    };
    //连接错误
    _wsiSendText.onerror = function (evt) {
        cc.log("sendText Error was fired");
    };
    //连接关闭
    _wsiSendText.onclose = function (evt) {
        cc.log("_wsiSendText websocket instance closed.");
    };

联系我
--------------
Email:zltdhr@gmail.com
