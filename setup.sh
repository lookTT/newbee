#!/bin/sh

echo "Preparing to install gcc and g++"
yum install -y gcc gcc-c++

echo "Preparing to install libuuid-devel"
yum install -y libuuid-devel

echo "Preparing to install mysql-devel"
yum install -y mysql-devel

echo "Preparing to install lua-devel"
yum install -y lua-devel

echo "Preparing to install CMake"
yum install -y cmake

echo "Preparing to install openssl-devel"
yum install -y openssl-devel

echo "Preparing to install libevent"
cd /tmp
wget http://superb-dca2.dl.sourceforge.net/project/levent/libevent/libevent-2.0/libevent-2.0.22-stable.tar.gz
tar zxvf libevent-2.0.22-stable.tar.gz
cd libevent-2.0.22-stable
./configure
make
make install
cd /tmp
rm -fr libevent-2.0.22-stable.tar.gz
rm -fr libevent-2.0.22-stable

echo "Preparing to install glog"
cd /tmp
wget https://codeload.github.com/google/glog/zip/master -O glog-master.zip
unzip glog-master.zip
cd glog-master
./configure
make
make install
cd /tmp
rm -fr glog-master.zip
rm -fr glog-master

echo "Preparing to install Luajit"
cd /tmp
wget http://luajit.org/download/LuaJIT-2.0.4.tar.gz
tar zxvf LuaJIT-2.0.4.tar.gz
cd LuaJIT-2.0.4
make
make install
cd /tmp
rm -fr LuaJIT-2.0.4.tar.gz
rm -fr LuaJIT-2.0.4

echo "Preparing to install luarocks"
cd /tmp
wget http://luarocks.org/releases/luarocks-2.2.2.tar.gz
tar zxvf luarocks-2.2.2.tar.gz
cd luarocks-2.2.2
./configure
make bootstrap
cd /tmp
rm -fr luarocks-2.2.2.tar.gz
rm -fr luarocks-2.2.2

echo "Preparing to install lua-cjson"
luarocks install lua-cjson

echo "Preparing to install luasocket"
luarocks install luasocket

echo "Preparing to install Luasql-mysql"
luarocks install luasql-mysql MYSQL_LIBDIR=/usr/lib64/mysql MYSQL_INCDIR=/usr/include/mysql

echo "Preparing to install libwebsockets"
cd /tmp
wget https://codeload.github.com/warmcat/libwebsockets/zip/master -O libwebsockets-master.zip
unzip libwebsockets-master.zip
cd libwebsockets-master
cmake CMakeLists.txt
make
make install
cd /tmp
rm -fr libwebsockets-master.zip
rm -fr libwebsockets-master

echo "Preparing to install redis"
cd /tmp
wget http://download.redis.io/releases/redis-3.0.4.tar.gz
tar zxvf redis-3.0.4.tar.gz
cd redis-3.0.4
make
make install
cd /tmp
rm -fr redis-3.0.4.tar.gz
rm -fr redis-3.0.4

echo "Setting ldconfig"
echo /usr/local/lib > /etc/ld.so.conf.d/mylib.conf
ldconfig
