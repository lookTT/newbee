
---
-- @module redis_doc
local m = {}

---
--@function [parent=#redis_doc] punsubscribe
function m:punsubscribe() end
---
--@function [parent=#redis_doc] expireat
function m:expireat() end
---
--@function [parent=#redis_doc] psetex
function m:psetex() end
---
--@function [parent=#redis_doc] slaveof
function m:slaveof() end
---
--@function [parent=#redis_doc] psubscribe
function m:psubscribe() end
---
--@function [parent=#redis_doc] srandmember
function m:srandmember() end
---
--@function [parent=#redis_doc] exists
function m:exists() end
---
--@function [parent=#redis_doc] hmget
function m:hmget() end
---
--@function [parent=#redis_doc] zcard
function m:zcard() end
---
--@function [parent=#redis_doc] sscan
function m:sscan() end
---
--@function [parent=#redis_doc] lindex
function m:lindex() end
---
--@function [parent=#redis_doc] echo
function m:echo() end
---
--@function [parent=#redis_doc] scard
function m:scard() end
---
--@function [parent=#redis_doc] brpop
function m:brpop() end
---
--@function [parent=#redis_doc] zinterstore
function m:zinterstore() end
---
--@function [parent=#redis_doc] hscan
function m:hscan() end
---
--@function [parent=#redis_doc] zunionstore
function m:zunionstore() end
---
--@function [parent=#redis_doc] setnx
function m:setnx() end
---
--@function [parent=#redis_doc] linsert
function m:linsert() end
---
--@function [parent=#redis_doc] scan
function m:scan() end
---
--@function [parent=#redis_doc] sdiffstore
function m:sdiffstore() end
---
--@function [parent=#redis_doc] hdel
function m:hdel() end
---
--@function [parent=#redis_doc] bitop
function m:bitop() end
---
--@function [parent=#redis_doc] rename
function m:rename() end
---
--@function [parent=#redis_doc] bitcount
function m:bitcount() end
---
--@function [parent=#redis_doc] sdiff
function m:sdiff() end
---
--@function [parent=#redis_doc] spop
function m:spop() end
---
--@function [parent=#redis_doc] rpop
function m:rpop() end
---
--@function [parent=#redis_doc] save
function m:save() end
---
--@function [parent=#redis_doc] del
function m:del() end
---
--@function [parent=#redis_doc] smove
function m:smove() end
---
--@function [parent=#redis_doc] decr
function m:decr() end
---
--@function [parent=#redis_doc] ttl
function m:ttl() end
---
--@function [parent=#redis_doc] set
function m:set() end
---
--@function [parent=#redis_doc] hkeys
function m:hkeys() end
---
--@function [parent=#redis_doc] setex
function m:setex() end
---
--@function [parent=#redis_doc] zrangebyscore
function m:zrangebyscore() end
---
--@function [parent=#redis_doc] sinter
function m:sinter() end
---
--@function [parent=#redis_doc] incr
function m:incr() end
---
--@function [parent=#redis_doc] zscan
function m:zscan() end
---
--@function [parent=#redis_doc] get
function m:get() end
---
--@function [parent=#redis_doc] eval
function m:eval() end
---
--@function [parent=#redis_doc] zscore
function m:zscore() end
---
--@function [parent=#redis_doc] setrange
function m:setrange() end
---
--@function [parent=#redis_doc] time
function m:time() end
---
--@function [parent=#redis_doc] evalsha
function m:evalsha() end
---
--@function [parent=#redis_doc] zremrangebyrank
function m:zremrangebyrank() end
---
--@function [parent=#redis_doc] client
function m:client() end
---
--@function [parent=#redis_doc] pexpire
function m:pexpire() end
---
--@function [parent=#redis_doc] type
function m:type() end
---
--@function [parent=#redis_doc] script
function m:script() end
---
--@function [parent=#redis_doc] hget
function m:hget() end
---
--@function [parent=#redis_doc] mget
function m:mget() end
---
--@function [parent=#redis_doc] rpush
function m:rpush() end
---
--@function [parent=#redis_doc] zincrby
function m:zincrby() end
---
--@function [parent=#redis_doc] lrange
function m:lrange() end
---
--@function [parent=#redis_doc] zrevrangebyscore
function m:zrevrangebyscore() end
---
--@function [parent=#redis_doc] mset
function m:mset() end
---
--@function [parent=#redis_doc] ping
function m:ping() end
---
--@function [parent=#redis_doc] zrank
function m:zrank() end
---
--@function [parent=#redis_doc] move
function m:move() end
---
--@function [parent=#redis_doc] persist
function m:persist() end
---
--@function [parent=#redis_doc] lpushx
function m:lpushx() end
---
--@function [parent=#redis_doc] getrange
function m:getrange() end
---
--@function [parent=#redis_doc] hvals
function m:hvals() end
---
--@function [parent=#redis_doc] renamenx
function m:renamenx() end
---
--@function [parent=#redis_doc] pttl
function m:pttl() end
---
--@function [parent=#redis_doc] rpushx
function m:rpushx() end
---
--@function [parent=#redis_doc] zcount
function m:zcount() end
---
--@function [parent=#redis_doc] substr
function m:substr() end
---
--@function [parent=#redis_doc] keys
function m:keys() end
---
--@function [parent=#redis_doc] pexpireat
function m:pexpireat() end
---
--@function [parent=#redis_doc] zadd
function m:zadd() end
---
--@function [parent=#redis_doc] slowlog
function m:slowlog() end
---
--@function [parent=#redis_doc] getset
function m:getset() end
---
--@function [parent=#redis_doc] decrby
function m:decrby() end
---
--@function [parent=#redis_doc] config
function m:config() end
---
--@function [parent=#redis_doc] lpop
function m:lpop() end
---
--@function [parent=#redis_doc] zrange
function m:zrange() end
---
--@function [parent=#redis_doc] sunion
function m:sunion() end
---
--@function [parent=#redis_doc] incrbyfloat
function m:incrbyfloat() end
---
--@function [parent=#redis_doc] dbsize
function m:dbsize() end
---
--@function [parent=#redis_doc] discard
function m:discard() end
---
--@function [parent=#redis_doc] setbit
function m:setbit() end
---
--@function [parent=#redis_doc] multi
function m:multi() end
---
--@function [parent=#redis_doc] getbit
function m:getbit() end
---
--@function [parent=#redis_doc] strlen
function m:strlen() end
---
--@function [parent=#redis_doc] info
function m:info() end
---
--@function [parent=#redis_doc] bgrewriteaof
function m:bgrewriteaof() end
---
--@function [parent=#redis_doc] monitor
function m:monitor() end
---
--@function [parent=#redis_doc] zrevrank
function m:zrevrank() end
---
--@function [parent=#redis_doc] brpoplpush
function m:brpoplpush() end
---
--@function [parent=#redis_doc] hincrby
function m:hincrby() end
---
--@function [parent=#redis_doc] flushdb
function m:flushdb() end
---
--@function [parent=#redis_doc] lastsave
function m:lastsave() end
---
--@function [parent=#redis_doc] bgsave
function m:bgsave() end
---
--@function [parent=#redis_doc] blpop
function m:blpop() end
---
--@function [parent=#redis_doc] unsubscribe
function m:unsubscribe() end
---
--@function [parent=#redis_doc] append
function m:append() end
---
--@function [parent=#redis_doc] publish
function m:publish() end
---
--@function [parent=#redis_doc] subscribe
function m:subscribe() end
---
--@function [parent=#redis_doc] unwatch
function m:unwatch() end
---
--@function [parent=#redis_doc] flushall
function m:flushall() end
---
--@function [parent=#redis_doc] randomkey
function m:randomkey() end
---
--@function [parent=#redis_doc] exec
function m:exec() end
---
--@function [parent=#redis_doc] select
function m:select() end
---
--@function [parent=#redis_doc] msetnx
function m:msetnx() end
---
--@function [parent=#redis_doc] incrby
function m:incrby() end
---
--@function [parent=#redis_doc] hgetall
function m:hgetall() end
---
--@function [parent=#redis_doc] srem
function m:srem() end
---
--@function [parent=#redis_doc] hlen
function m:hlen() end
---
--@function [parent=#redis_doc] hexists
function m:hexists() end
---
--@function [parent=#redis_doc] sort
function m:sort() end
---
--@function [parent=#redis_doc] hincrbyfloat
function m:hincrbyfloat() end
---
--@function [parent=#redis_doc] lrem
function m:lrem() end
---
--@function [parent=#redis_doc] watch
function m:watch() end
---
--@function [parent=#redis_doc] hmset
function m:hmset() end
---
--@function [parent=#redis_doc] hsetnx
function m:hsetnx() end
---
--@function [parent=#redis_doc] llen
function m:llen() end
---
--@function [parent=#redis_doc] ltrim
function m:ltrim() end
---
--@function [parent=#redis_doc] zremrangebyscore
function m:zremrangebyscore() end
---
--@function [parent=#redis_doc] smembers
function m:smembers() end
---
--@function [parent=#redis_doc] hset
function m:hset() end
---
--@function [parent=#redis_doc] expire
function m:expire() end
---
--@function [parent=#redis_doc] zrevrange
function m:zrevrange() end
---
--@function [parent=#redis_doc] sunionstore
function m:sunionstore() end
---
--@function [parent=#redis_doc] sinterstore
function m:sinterstore() end
---
--@function [parent=#redis_doc] sismember
function m:sismember() end
---
--@function [parent=#redis_doc] lpush
function m:lpush() end
---
--@function [parent=#redis_doc] sadd
function m:sadd() end
---
--@function [parent=#redis_doc] rpoplpush
function m:rpoplpush() end
---
--@function [parent=#redis_doc] lset
function m:lset() end
---
--@function [parent=#redis_doc] zrem
function m:zrem() end
---
--@function [parent=#redis_doc] auth
function m:auth() end

---
--@function [parent=#redis_doc]
function m:raw_cmd() end
---
--@function [parent=#redis_doc]
function m:define_command() end
---
--@function [parent=#redis_doc]
function m:undefine_command() end
---
--@function [parent=#redis_doc]
function m:quit() end
---
--@function [parent=#redis_doc]
function m:shutdown() end
---
--@function [parent=#redis_doc]
function m:pipeline() end


return m
