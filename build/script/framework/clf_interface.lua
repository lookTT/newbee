
---
--@module clf_interface
local m = {}

local nb = require("nb")
local glog = nb.glog

local m_interface = require("m_interface")

---
-- Client connections to the server via websockets agreement
CLF_ClientConnect = function (uguid, ip)
    if type(uguid) ~= "string" or type(ip) ~= "string" then
        return
    end
    m_interface.addClient(uguid,ip)
end


---
--Client Dropped Callback
CLF_ClientDropped = function (uguid)
    m_interface.doSignoutCallback(uguid)
    m_interface.delClient(uguid)
end

CLF_DealWithWebsocketsLogic = function (uguid, json)
    uguid = tostring(uguid)
    json = tostring(json)
    json = nb.jsonDecode(json)
    if json == nil or json.msgid == nil then
        return
    end
    local msgid = tonumber(json.msgid)

    local f = m_interface.getWebsocketsLogicCallBack(msgid)
    if type(f) ~= "function" then return end
    local call = function()
        f(uguid, json)
    end
    local clock = os.clock()
    xpcall(call, nb.trackback)
    clock = (os.clock()-clock) * 1000
    if clock > 5 then
        glog("CLF_DealWithWebsocketsLogic::msgid[%s] elapsed time: %.5f\n", msgid, clock)
    end
end


CLF_DealWithHttpLogic = function (str)
    local json = nb.jsonDecode(str)
    local r_msg = nil
    if type(json) ~= "table" then return "1" end
    if type(json.msgid) == "nil" then return "2" end
    local msgid = tonumber(json.msgid)

    local f = m_interface.getHttpLogicCallBack(msgid)
    if type(f) ~= "function" then return "3" end
    local call = function()
        r_msg = f(json)
    end

    local clock = os.clock()
    xpcall(call, nb.trackback)
    clock = (os.clock()-clock) * 1000
    if clock > 5 then
        glog("CLF_DealWithHttpLogic::msgid[%s] elapsed time: %.5f\n", msgid, clock)
    end
    r_msg = r_msg or ""
    if type(r_msg) == "table" then
        r_msg = nb.jsonEncode(r_msg)
    end

    return r_msg
end

local mark_time = 0
CLF_Update = function ()
    local curTime = os.time()
    if curTime - mark_time < 1 then return end
    mark_time = curTime
    m_interface.update()
end

return m
