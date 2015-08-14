
---
--@module m_interface
local m = {}

-- just to find the client info fast <guid:{uguid=uguid,ip=ip}>
local all_client_by_guid = {}
m.addClient = function (uguid, ip)
    uguid = tostring(uguid)
    ip = tostring(ip)
    all_client_by_guid[uguid] = {uguid = uguid, ip = ip, }
end
m.delClient = function (uguid)
    uguid = tostring(uguid)
    all_client_by_guid[uguid] = nil
end
m.getClient = function (uguid)
    return all_client_by_guid[uguid]
end


local all_client_uguid_with_uid ={}
local all_client_uid_with_uguid ={}
m.updateClientMap =function (uguid, uid)
    all_client_uguid_with_uid[uguid]= uid
    all_client_uid_with_uguid[uid] = uguid
end
m.getUguidByUid = function (uid)
    return all_client_uid_with_uguid[uid]
end
m.getUidByUguid = function (uguid)
    return all_client_uguid_with_uid[uguid]
end


-- <msgid:function>
local all_bind_websockets_logic_call_back = {}
m.registWebsocketsLogicCallBack = function (msgid, func)
    msgid = tonumber(msgid)
    if msgid == nil or type(func) ~= "function" then return end
    all_bind_websockets_logic_call_back[msgid] = func
end
m.getWebsocketsLogicCallBack = function (msgid)
    msgid = tonumber(msgid)
    if msgid == nil then return end
    return all_bind_websockets_logic_call_back[msgid]
end


-- <msgid:function>
local all_bind_http_logic_call_back = {}
m.registHttpLogicCallBack = function (msgid, func)
    msgid = tonumber(msgid)
    if msgid == nil or type(func) ~= "function" then return end
    all_bind_http_logic_call_back[msgid] = func
end
m.getHttpLogicCallBack = function (msgid)
    msgid = tonumber(msgid)
    if msgid == nil then return end
    return all_bind_http_logic_call_back[msgid]
end


local update_bind_call_back = {}
m.update = function ()
    for _, func in pairs(update_bind_call_back) do
        func()
    end
end
m.registUpdateLogicCallBack = function (func)
    if type(func) ~= "function" then return end
    table.insert(update_bind_call_back, func)
end


--store the signin function list
local t_user_signin = {}
m.registUserSigninFunc = function (func)
    if type(func) ~= "function" then return end
    table.insert(t_user_signin, func)
end
m.doSigninCallback = function (uguid)
    local uid = m.getUidByUguid(uguid)
    if uid then
        for _, func in pairs(t_user_signin) do
            func(uguid, uid)
        end
    end
end


--store the signout function list
local t_user_signout = {}
m.registUserSignoutFunc = function (func)
    if type(func) ~= "function" then return end
    table.insert(t_user_signout, func)
end
m.doSignoutCallback = function (uguid)
    local uid = m.getUidByUguid(uguid)
    if uid then
        for _, func in pairs(t_user_signout) do
            func(uguid, uid)
        end
    end
end




return m
