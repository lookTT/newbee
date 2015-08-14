
---
--@module c_redis
local m = {}

local nb = require("nb")
local glog = nb.glog

local redis_server = require("redis")
local redis = require("redis_doc")

redis = redis_server.connect("127.0.0.1", 6379)
--redis:auth("someone!@#")

if redis:ping() then
    glog("CONNECTED REDIS SERVER")
end

local redis_db = {
    --用户信息
    user = 0,
}

--str:sha1
local shafunc = {}
---将部分脚本提前导入到redis服务器内
local evalsha = function (str, ...)
    --检查是否加载了该脚本
    local sha1 = shafunc[str]
    if not sha1 then
        --没有加载脚本，进行脚本加载
        shafunc[str] = redis:script("LOAD", str)
        sha1 = shafunc[str]
    end

    --执行脚本
    redis:evalsha(sha1, 0, ...)
end

---
--检测账号是否重复
--@function [parent=#c_redis]
m.check_account = function(account)
    redis:select(redis_db.user)
    if redis:exists(account) then
        return true
    end
    return false
end

---
--注册账号信息
--@function [parent=#c_redis]
m.signup = function (uid, account, passwd, name, spreadnum)
    local str = [[
    redis.pcall('SELECT', ARGV[1])
    redis.pcall('HSET', ARGV[2], 'uid', ARGV[2])
    redis.pcall('HSET', ARGV[2], 'account', ARGV[3])
    redis.pcall('HSET', ARGV[2], 'passwd', ARGV[4])
    redis.pcall('HSET', ARGV[2], 'name', ARGV[5])
    redis.pcall('HSET', ARGV[2], 'spreadnum', ARGV[6])
    return redis.pcall("HGETALL", ARGV[2])
]]

    evalsha(str,
        redis_db.user,--1
        uid,
        account,
        passwd,
        name,
        spreadnum)
end

return m



