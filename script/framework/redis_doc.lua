
---
-- @module redis_doc
local m = {}

---
--@function [parent=#doc.redis_doc] punsubscribe
function m:punsubscribe() end
---
--@function [parent=#doc.redis_doc] expireat
function m:expireat() end
---
--@function [parent=#doc.redis_doc] psetex
function m:psetex() end
---
--@function [parent=#doc.redis_doc] slaveof
function m:slaveof() end
---
--@function [parent=#doc.redis_doc] psubscribe
function m:psubscribe() end
---
--@function [parent=#doc.redis_doc] srandmember
function m:srandmember() end
---
--@function [parent=#doc.redis_doc] exists
function m:exists() end
---
--@function [parent=#doc.redis_doc] hmget
function m:hmget() end
---
--@function [parent=#doc.redis_doc] zcard
function m:zcard() end
---
--@function [parent=#doc.redis_doc] sscan
function m:sscan() end
---
--@function [parent=#doc.redis_doc] lindex
function m:lindex() end
---
--@function [parent=#doc.redis_doc] echo
function m:echo() end
---
--@function [parent=#doc.redis_doc] scard
function m:scard() end
---
--@function [parent=#doc.redis_doc] brpop
function m:brpop() end
---
--@function [parent=#doc.redis_doc] zinterstore
function m:zinterstore() end
---
--@function [parent=#doc.redis_doc] hscan
function m:hscan() end
---
--@function [parent=#doc.redis_doc] zunionstore
function m:zunionstore() end
---
--@function [parent=#doc.redis_doc] setnx
function m:setnx() end
---
--@function [parent=#doc.redis_doc] linsert
function m:linsert() end
---
--@function [parent=#doc.redis_doc] scan
function m:scan() end
---
--@function [parent=#doc.redis_doc] sdiffstore
function m:sdiffstore() end
---
--@function [parent=#doc.redis_doc] hdel
function m:hdel() end
---
--@function [parent=#doc.redis_doc] bitop
function m:bitop() end
---
--@function [parent=#doc.redis_doc] rename
function m:rename() end
---
--@function [parent=#doc.redis_doc] bitcount
function m:bitcount() end
---
--@function [parent=#doc.redis_doc] sdiff
function m:sdiff() end
---
--@function [parent=#doc.redis_doc] spop
function m:spop() end
---
--@function [parent=#doc.redis_doc] rpop
function m:rpop() end
---
--@function [parent=#doc.redis_doc] save
function m:save() end
---
--@function [parent=#doc.redis_doc] del
function m:del() end
---
--@function [parent=#doc.redis_doc] smove
function m:smove() end
---
--@function [parent=#doc.redis_doc] decr
function m:decr() end
---
--@function [parent=#doc.redis_doc] ttl
function m:ttl() end
---
--@function [parent=#doc.redis_doc] set
function m:set() end
---
--@function [parent=#doc.redis_doc] hkeys
function m:hkeys() end
---
--@function [parent=#doc.redis_doc] setex
function m:setex() end
---
--@function [parent=#doc.redis_doc] zrangebyscore
function m:zrangebyscore() end
---
--@function [parent=#doc.redis_doc] sinter
function m:sinter() end
---
--@function [parent=#doc.redis_doc] incr
function m:incr() end
---
--@function [parent=#doc.redis_doc] zscan
function m:zscan() end
---
--@function [parent=#doc.redis_doc] get
function m:get() end
---
--@function [parent=#doc.redis_doc] eval
function m:eval() end
---
--@function [parent=#doc.redis_doc] zscore
function m:zscore() end
---
--@function [parent=#doc.redis_doc] setrange
function m:setrange() end
---
--@function [parent=#doc.redis_doc] time
function m:time() end
---
--@function [parent=#doc.redis_doc] evalsha
function m:evalsha() end
---
--@function [parent=#doc.redis_doc] zremrangebyrank
function m:zremrangebyrank() end
---
--@function [parent=#doc.redis_doc] client
function m:client() end
---
--@function [parent=#doc.redis_doc] pexpire
function m:pexpire() end
---
--@function [parent=#doc.redis_doc] type
function m:type() end
---
--@function [parent=#doc.redis_doc] script
function m:script() end
---
--@function [parent=#doc.redis_doc] hget
function m:hget() end
---
--@function [parent=#doc.redis_doc] mget
function m:mget() end
---
--@function [parent=#doc.redis_doc] rpush
function m:rpush() end
---
--@function [parent=#doc.redis_doc] zincrby
function m:zincrby() end
---
--@function [parent=#doc.redis_doc] lrange
function m:lrange() end
---
--@function [parent=#doc.redis_doc] zrevrangebyscore
function m:zrevrangebyscore() end
---
--@function [parent=#doc.redis_doc] mset
function m:mset() end
---
--@function [parent=#doc.redis_doc] ping
function m:ping() end
---
--@function [parent=#doc.redis_doc] zrank
function m:zrank() end
---
--@function [parent=#doc.redis_doc] move
function m:move() end
---
--@function [parent=#doc.redis_doc] persist
function m:persist() end
---
--@function [parent=#doc.redis_doc] lpushx
function m:lpushx() end
---
--@function [parent=#doc.redis_doc] getrange
function m:getrange() end
---
--@function [parent=#doc.redis_doc] hvals
function m:hvals() end
---
--@function [parent=#doc.redis_doc] renamenx
function m:renamenx() end
---
--@function [parent=#doc.redis_doc] pttl
function m:pttl() end
---
--@function [parent=#doc.redis_doc] rpushx
function m:rpushx() end
---
--@function [parent=#doc.redis_doc] zcount
function m:zcount() end
---
--@function [parent=#doc.redis_doc] substr
function m:substr() end
---
--@function [parent=#doc.redis_doc] keys
function m:keys() end
---
--@function [parent=#doc.redis_doc] pexpireat
function m:pexpireat() end
---
--@function [parent=#doc.redis_doc] zadd
function m:zadd() end
---
--@function [parent=#doc.redis_doc] slowlog
function m:slowlog() end
---
--@function [parent=#doc.redis_doc] getset
function m:getset() end
---
--@function [parent=#doc.redis_doc] decrby
function m:decrby() end
---
--@function [parent=#doc.redis_doc] config
function m:config() end
---
--@function [parent=#doc.redis_doc] lpop
function m:lpop() end
---
--@function [parent=#doc.redis_doc] zrange
function m:zrange() end
---
--@function [parent=#doc.redis_doc] sunion
function m:sunion() end
---
--@function [parent=#doc.redis_doc] incrbyfloat
function m:incrbyfloat() end
---
--@function [parent=#doc.redis_doc] dbsize
function m:dbsize() end
---
--@function [parent=#doc.redis_doc] discard
function m:discard() end
---
--@function [parent=#doc.redis_doc] setbit
function m:setbit() end
---
--@function [parent=#doc.redis_doc] multi
function m:multi() end
---
--@function [parent=#doc.redis_doc] getbit
function m:getbit() end
---
--@function [parent=#doc.redis_doc] strlen
function m:strlen() end
---
--@function [parent=#doc.redis_doc] info
function m:info() end
---
--@function [parent=#doc.redis_doc] bgrewriteaof
function m:bgrewriteaof() end
---
--@function [parent=#doc.redis_doc] monitor
function m:monitor() end
---
--@function [parent=#doc.redis_doc] zrevrank
function m:zrevrank() end
---
--@function [parent=#doc.redis_doc] brpoplpush
function m:brpoplpush() end
---
--@function [parent=#doc.redis_doc] hincrby
function m:hincrby() end
---
--@function [parent=#doc.redis_doc] flushdb
function m:flushdb() end
---
--@function [parent=#doc.redis_doc] lastsave
function m:lastsave() end
---
--@function [parent=#doc.redis_doc] bgsave
function m:bgsave() end
---
--@function [parent=#doc.redis_doc] blpop
function m:blpop() end
---
--@function [parent=#doc.redis_doc] unsubscribe
function m:unsubscribe() end
---
--@function [parent=#doc.redis_doc] append
function m:append() end
---
--@function [parent=#doc.redis_doc] publish
function m:publish() end
---
--@function [parent=#doc.redis_doc] subscribe
function m:subscribe() end
---
--@function [parent=#doc.redis_doc] unwatch
function m:unwatch() end
---
--@function [parent=#doc.redis_doc] flushall
function m:flushall() end
---
--@function [parent=#doc.redis_doc] randomkey
function m:randomkey() end
---
--@function [parent=#doc.redis_doc] exec
function m:exec() end
---
--@function [parent=#doc.redis_doc] select
function m:select() end
---
--@function [parent=#doc.redis_doc] msetnx
function m:msetnx() end
---
--@function [parent=#doc.redis_doc] incrby
function m:incrby() end
---
--@function [parent=#doc.redis_doc] hgetall
function m:hgetall() end
---
--@function [parent=#doc.redis_doc] srem
function m:srem() end
---
--@function [parent=#doc.redis_doc] hlen
function m:hlen() end
---
--@function [parent=#doc.redis_doc] hexists
function m:hexists() end
---
--@function [parent=#doc.redis_doc] sort
function m:sort() end
---
--@function [parent=#doc.redis_doc] hincrbyfloat
function m:hincrbyfloat() end
---
--@function [parent=#doc.redis_doc] lrem
function m:lrem() end
---
--@function [parent=#doc.redis_doc] watch
function m:watch() end
---
--@function [parent=#doc.redis_doc] hmset
function m:hmset() end
---
--@function [parent=#doc.redis_doc] hsetnx
function m:hsetnx() end
---
--@function [parent=#doc.redis_doc] llen
function m:llen() end
---
--@function [parent=#doc.redis_doc] ltrim
function m:ltrim() end
---
--@function [parent=#doc.redis_doc] zremrangebyscore
function m:zremrangebyscore() end
---
--@function [parent=#doc.redis_doc] smembers
function m:smembers() end
---
--@function [parent=#doc.redis_doc] hset
function m:hset() end
---
--@function [parent=#doc.redis_doc] expire
function m:expire() end
---
--@function [parent=#doc.redis_doc] zrevrange
function m:zrevrange() end
---
--@function [parent=#doc.redis_doc] sunionstore
function m:sunionstore() end
---
--@function [parent=#doc.redis_doc] sinterstore
function m:sinterstore() end
---
--@function [parent=#doc.redis_doc] sismember
function m:sismember() end
---
--@function [parent=#doc.redis_doc] lpush
function m:lpush() end
---
--@function [parent=#doc.redis_doc] sadd
function m:sadd() end
---
--@function [parent=#doc.redis_doc] rpoplpush
function m:rpoplpush() end
---
--@function [parent=#doc.redis_doc] lset
function m:lset() end
---
--@function [parent=#doc.redis_doc] zrem
function m:zrem() end
---
--@function [parent=#doc.redis_doc] auth
function m:auth() end

---
--@function [parent=#doc.redis_doc]
function m:raw_cmd() end
---
--@function [parent=#doc.redis_doc]
function m:define_command() end
---
--@function [parent=#doc.redis_doc]
function m:undefine_command() end
---
--@function [parent=#doc.redis_doc]
function m:quit() end
---
--@function [parent=#doc.redis_doc]
function m:shutdown() end
---
--@function [parent=#doc.redis_doc]
function m:pipeline() end


return m
