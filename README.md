newbee是什么?
--------------
newbee是个遵循简单美学的小东西，意在建立简单好用的lua服务器

很多手机软件工程师都会用到脚本语言(比如lua)，使用lua做服务器可以节省开发者学习Java、PHP、Python等服务器编程语言的语言学习成本。

newbee使用了C++和lua进行开发，希望大家喜欢。

项目使用了很多其他开源库，毕竟有这么多巨人的肩膀。

(libevent, libwebsokets, luajit, luarocks, lua-cjson, luasocket, luasql-mysql, redis-lua)

增加了一个简单的setup.sh的shell脚本来安装这些必要的依赖库，都是默认安装，编写时使用的操作系统是CentOS6.7，理论上是支持所有Red Hat AS系列

构建newbee
--------------
Simple as:
    $ sh setup.sh
    $ cd build
    $ make

联系我
--------------
Email:zltdhr@gmail.com
