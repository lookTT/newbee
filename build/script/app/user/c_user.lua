
---
--@module user.c_user
local m = {}

local nb = require("nb")
local glog = nb.glog
local send = nb.send2client
local back = nb.back2client

local d_msgcode = require("d_msgcode")

local m_interface = require("m_interface")
local registWebsocket = m_interface.registWebsocketsLogicCallBack
local registHttp = m_interface.registHttpLogicCallBack


local c_redis = require("c_redis")


---
--心跳
--@function [parent=#user.c_user]
m.heartbeat = function (uguid, t)
    local rmsg = {
        msgid = 0,
        errorid = 0,
        time = os.time()
    }
    send(uguid, rmsg)
end

---
--注册
--@function [parent=#user.c_user]
m.signup = function (uid, msg)
    local account = msg.account
    local passwd = msg.passwd
    local name = msg.name
    local spreadnum = msg.spreadnum

    local rmsg = {}
    rmsg.errorid = 0
    rmsg.account = account
    --检测是否有重复账号
    if c_redis.check_account(account) then
        rmsg.errorid = 1;
        return back(rmsg)
    end
    --检测昵称是否重复
    if c_redis.check_name(name) then
        rmsg.errorid = 2;
        return back(rmsg)
    end

    --创建uuid
    local uid = nb.uuidgen()
    --进行注册
    c_redis.signup(uid, account,passwd,name,spreadnum)

    return back(rmsg)
end

---
--登陆
--@function [parent=#user.c_user]
m.signin = function (uid, msg)
    local account = msg.account
    local passwd = msg.passwd

    local rmsg = {}
    rmsg.errorid = 0
    --登录
    local userinfo = c_redis.signin(account,passwd)

end

---
--登出
--@function [parent=#user.c_user]
m.signout = function (uid, msg)

end


local init = function ()
    registWebsocket(d_msgcode.w_heartbeat, m.heartbeat)

    registHttp(d_msgcode.h_signup, m.signup)
    registHttp(d_msgcode.h_signin, m.signin)
    registHttp(d_msgcode.h_signout, m.signout)
end
init()

return m
