
---
--@module clf_interface
local m = {}

m.client_info = {
    uguid = "",
    ip = "",
}

-- just to find the client info fast <guid:uid>
local all_client_by_guid = {}
--all of the client info <uid:client_info>
local all_client_by_uid = {}

---
-- Client connections to the server via websockets agreement
CLF_ClientConnect = function (uguid, ip)
    if type(uguid) ~= "string" or type(ip) ~= "string" then
        return
    end

    all_client_by_guid[uguid] = {uguid = uguid, ip = ip, }
end


---
--Client Dropped Callback
CLF_ClientDropped = function (uguid)

    local uid = all_client_by_guid[uguid].uid
    if uid ~= nil or type(uid) then
        all_client_by_guid[uguid] = nil
        all_client_by_uid[uid] = nil
    end

end

return m
