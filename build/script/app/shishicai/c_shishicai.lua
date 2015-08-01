
---
--@module shishicai.c_shishicai
local m = {}

local d_msgcode = require("d_msgcode")
local m_interface = require("m_interface")
local registWebsocket = m_interface.registWebsocketsLogicCallBack
local registHttp = m_interface.registHttpLogicCallBack


local nb = require("nb")
local send = nb.send2client


m.websockets = function(uguid, t)

    local r_msg = {name="kill", sex=1, module="websockets"}

    send(uguid,t)
end

m.http = function(t)

    return t
end

local init = function ()
    registWebsocket(d_msgcode.websockets, m.websockets)

    registHttp(d_msgcode.http, m.http)
end
init()

return m
