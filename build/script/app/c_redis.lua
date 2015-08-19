
---
--@module c_redis
local m = {}

local tonumber = tonumber
local tostring = tostring
local type = type

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
    --服务器配置信息
    server = {
        db = 0,
        key = {
            --自增推广号
            increase_spreadnum = "increase_spreadnum",
        },
    },
    --sesson对应uid
    session = {
        db = 1,
    },
    --用户信息
    user = {
        db = 2,
        key = {
            --玩家id
            uid = 'uid',
            --账号
            account = 'account',
            --密码
            passwd = 'passwd',
            --昵称
            name= 'name',
            --自身的推广号
            spreadnum = 'spreadnum',
            --注册时间
            signup_time = 'signup_time',
            --最近一次登录时间
            signin_time = 'signin_time',
            --银币
            money = 'money',
            --金币
            gold = 'gold',
            --钻石
            diamond = 'diamond',
        },

    },
    --account对应uid
    account = {
        db = 3,
    },
    --name对应uid
    name = {
        db = 4,
    },
}

--str:sha1
local shafunc = {}
---将部分脚本提前导入到redis服务器内
local evalsha = function (str, numkeys, ...)
    str = tostring(str)
    numkeys = tonumber(numkeys)
    if type(str) ~= 'string' or type(numkeys) ~= 'number' then
        return
    end
    --检查是否加载了该脚本
    local sha1 = shafunc[str]
    if not sha1 then
        --没有加载脚本，进行脚本加载
        shafunc[str] = redis:script("LOAD", str)
        sha1 = shafunc[str]
    end

    --执行脚本
    redis:evalsha(sha1, numkeys, ...)
end

---初始化redis服务器信息
local init = function ()
    redis:select(redis_db.server.db)
    if not redis:exists(redis_db.server.key.increase_spreadnum) then
        redis:set(redis_db.server.key.increase_spreadnum, 10000)
    end
end
init()

---
--获取一个新的推广号
m.new_spreadnum = function()
    redis:select(redis_db.server.db)
    return redis:incr(redis_db.server.key.increase_spreadnum)
end

---
--检测账号是否重复
--@function [parent=#c_redis]
m.check_account = function(account)
    redis:select(redis_db.account.db)
    if redis:exists(account) then
        return true
    end
    return false
end

---
--检测昵称是否重复
--@function [parent=#c_redis]
m.check_name = function(name)
    redis:select(redis_db.name.db)
    if redis:exists(name) then
        return true
    end
    return false
end

---
--注册账号信息
--@function [parent=#c_redis]
m.signup = function (uid, account, passwd, name)
    uid = tostring(uid)
    account = tostring(account)
    passwd = tostring(passwd)
    name = tostring(name)

    local str = [[
    redis.pcall('SELECT', ARGV[#ARGV])
    for i= 1, 5 do
        redis.pcall('HSET', ARGV[1], KEYS[i], ARGV[i])
    end
    return redis.pcall("HGETALL", ARGV[2])
]]

    local info = redis_db.user.key
    evalsha(str,
        5,

        info.uid, --1
        info.account,
        info.passwd,
        info.name,
        info.spreadnum,--5
        info.signup_time,
        info.signin_time,
        info.money,
        info.gold,
        info.diamond,--10

        uid, --1
        account,
        passwd,
        name,
        m.new_spreadnum(),--5
        os.time(),
        0,
        0,
        0,
        0,--10

        info.db)

    --记录account与uid对应关系
    redis:select(redis_db.account.db)
    redis:set(account, uid)
    --记录name与uid对应关系
    redis:select(redis_db.name.db)
    redis:set(name, uid)
end

return m



