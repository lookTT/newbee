
---
--@module c_redis
local m = {}

local nb = require("nb")
local glog = nb.glog

local redis_server = require("redis")
local redis = require("redis_doc")

redis = redis_server.connect("127.0.0.1", 6379)
--redis:auth("lvyuan123!@#")

if redis:ping() then
    glog(" REDIS CONNECT SUCCESS")
end

local redis_db = {
    --用户信息
    user = 0,
}

local script_load = function (str, ...)
    redis:script("LOAD", str, 0, ...)
end

---
--检测账号是否重复
--@function [parent=#c_redis]
m.check_account = function(account)
    redis:select(redis_db.user)
    redis:exists(account)

end

m.signup = function (account)

    local str = [[
    return {ARGV[1],ARGV[2]}
]]

    script_load(str)


end

return m



