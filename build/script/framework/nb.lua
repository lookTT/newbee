

---
--@module nb
local m = {}

local string = string
local type = type
local os = os
local io = io
local print = print
local tostring = tostring
local tonumber = tonumber

---
-- @function [parent=#nb]
-- @param ...
-- @return #nil
m.glog = function (...)
    --do return end
    local str = "LUA INFO:".. string.format(...)
    print(str)
    --输出到c端的glog内
    CCF_GLOG(str)
end

---
-- @function [parent=#nb]
-- @param #unknow msg
-- @return #nil
m.trackback = function (msg)
    local str_line = "----------------------------------------"
    local str = string.format("\nTrackback Start%s\n%s\n%s\n%s\nTrackback End%s\n",str_line, os.date("%c", os.time()),"LUA ERROR: " .. tostring(msg), debug.traceback(), str_line)
    print(str)
    CCF_GLOG(str)
end

-- rewrite the require
do
    local re = require
    require = function( moduleName )
        local clock = os.clock()
        xpcall(function()re( moduleName )end, m.trackback)
        clock = (os.clock()-clock) * 1000
        if clock > 5 then
            m.glog("require[%s] elapsed time: %.5f\n",  moduleName, clock)
        end
        return re(moduleName)
    end
end

m.load = function (module_name)
    require(module_name)
end

---
--@function [parent=#nb]
--@param #string module_name
m.unload = function (module_name)
    package.loaded[module_name] = nil
end

---
--Create a local unique ID
--@function [parent=#nb]
--@param #string platfromid
--@param #string serverid
--@return #string uint64
m.createObjID = function (platfromid, serverid)
    -- in C++ code: uint64 guid = ((platfromid)<<(8+32+16)) | ((serverid)<<(32 + 16)) | ((curTime)<<16) | ((seed)&0xffff);
    platfromid = tonumber(platfromid)
    platfromid = platfromid or 1

    serverid = tonumber(serverid)
    serverid = serverid or 1

    local guid = CCF_CreateObjID(platfromid, serverid)

    return guid
end


-- json tool
local json = require("cjson")

---
-- string 2 table
-- @function [parent=#nb]
-- @param #string str
-- @return #table
m.jsonDecode = function (str)
    return json.decode(str)
end

---
-- table 2 string
-- @function [parent=#nb]
-- @param #table t
-- @return #string
m.jsonEncode = function (t)
    return json.encode(t)
end

---
-- uri string 2 json string
-- @function [parent=#nb]
-- @param #string str
-- @return #string
m.urlDecode = function (str)
    --return CLF_DecodeURI(str)
    local s = string.gsub(str, "+", " ")
    s = string.gsub(s, '%%(%x%x)', function(h) return string.char(tonumber(h, 16)) end)
    return s
end
---
-- json string 2 uri string
-- @function [parent=#nb]
-- @param #string str
-- @return #string
m.urlEncode = function (str)
    --return CLF_EncodeURI(str)
    local s = string.gsub(str, "([^%w%.%- ])", function(c) return string.format("%%%02X", string.byte(c)) end)
    s = string.gsub(s, " ", "+")
    return s
end

--仅用作串行化表示字符串使用后应清空该字串
local str_serialize = ""
---
-- @function
-- @param #number,string,table o
local function serialize (o)
    str_serialize = str_serialize or ""
    if o == nil then
        io.write("nil")
        str_serialize = str_serialize.."nil"
        return
    end
    if type(o) == "number" then
        io.write(o)
        str_serialize = str_serialize..o
    elseif type(o) == "string" then
        io.write(string.format("%q", o))
        str_serialize = str_serialize..string.format("%q", o)
    elseif type(o) == "table" then
        io.write("{\n")
        str_serialize = str_serialize.."{\n"
        for k,v in pairs(o) do
            io.write(" [");
            str_serialize = str_serialize.." ["
            serialize(k);
            io.write("] = ")
            str_serialize = str_serialize.."] = "
            serialize(v)
            io.write(",\n")
            str_serialize = str_serialize..",\n"
        end
        io.write("}")
        str_serialize = str_serialize.."}"
    elseif type(o) == "boolean" then
        io.write( o and "true" or "false" )
        str_serialize = str_serialize..(o and "true" or "false")
    elseif type(o) == "function" then
        io.write( "function" )
        str_serialize = str_serialize.."function"
    else
        error("cannot serialize a " .. type(o))
    end
    return
end

---
--打印输出对象
--@function [parent=#nb]
--@param #any o
m.glogEX = function (o)
    --do return end
    serialize(o)
    io.write("\n")
    --输出到c端的glog内
    CCF_GLOG(str_serialize)
    --清空字串
    str_serialize = ""
end

---
--@function [parent=#nb]
m.send2client = function(uguid, json)
    uguid = tostring(uguid)
    if type(json) == 'table' then
        json = m.jsonEncode(json)
    end

    if type(json) ~= 'string' then
        m.trackback(string.format("nb.send2client json type is [%s]", type(json)))
        return
    end

    CCF_Send2Client(uguid, json)
end

---
--http信息返回，仅可做回复，不可做推送
--@function [parent=#nb]
m.back2client = function (json)
    if type(json) == 'table' then
        json = m.jsonEncode(json)
    end

    if type(json) ~= 'string' then
        m.trackback(string.format("nb.back2client json type is [%s]", type(json)))
        return
    end

    return json
end

---
--@function [parent=#nb]
m.md5 = function (str)
    return CCF_MD5(str)
end

local uuid = require("uuid")
---
--@function [parent=#nb]
m.uuidgen = function ()
    return m.md5(uuid.generate())
end

return m
