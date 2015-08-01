
---
--@module user.c_user
local m = {}

local nb = require("nb")
local glog = nb.glog

local d_msgcode = require("d_msgcode")

local m_interface = require("m_interface")
local registWebsocket = m_interface.registWebsocketsLogicCallBack
local registHttp = m_interface.registHttpLogicCallBack

---
--注册
--@function [parent=#user.c_user]
m.signup = function (i)
    local account = i.account
    local passwd = i.passwd
    local nickname = i.nickname
    local spreadnum = i.spreadnum
    local safenum = i.safenum
    
    

    local o = {}
    o.errorid = 0
    o.account = account
    return o
end

m.signin = function (i)

end


local init = function ()
    registHttp(d_msgcode.h_signup, m.signup)
    registHttp(d_msgcode.h_signin, m.signin)
end
init()

return m
