---
-- @module util
local m = {}

---
-- @function [parent=#util]
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
-- @function [parent=#util]
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

---
--@function [parent=#util]
--@param #string module_name
m.unload = function (module_name)
    package.loaded[module_name] = nil
end

---
--Create a local unique ID
--@function [parent=#util]
--@param #string platfromid
--@param #string serverid
--@return #string uint64
m.createObjID = function (platfromid, serverid)
    -- in C++ code: uint64 guid = ((platfromid)<<(8+32+16)) | ((serverid)<<(32 + 16)) | ((curTime)<<16) | ((seed)&0xffff);
    platfromid = tonumber(platfromid)
    platfromid = platfromid or 0

    serverid = tonumber(serverid)
    serverid = serverid or 0

    local guid = CCF_CreateObjID(platfromid, serverid)

    return guid
end

---
-- @function [parent=#util]
-- @param #string filename
-- @return #bool
m.isFileExist = function (filename)
    if filename == nil then
        return false
    end

    local f = io.open(filename)
    if f == nil then
        return false
    end
    io.close(f)
    return true
end

---
-- @function [parent=#util] LoadFile
-- @param #string filename
-- @return #string
m.loadFile = function (filename)
    local file
    if filename == nil then
        file = io.stdin
    else
        local err
        file, err = io.open(filename, "rb")
        if file == nil then
            error(("Unable to read '%s': %s"):format(filename, err))
        end
    end
    local data = file:read("*a")

    if filename ~= nil then
        file:close()
    end

    if data == nil then
        error("Failed to read " .. filename)
    end

    return data
end

---
-- @function [parent=#util] saveFile
-- @param #string filename
-- @param #string data
-- @return #nil
m.saveFile = function (filename, data)
    local file
    if filename == nil then
        file = io.stdout
    else
        local err
        file, err = io.open(filename, "wb")
        if file == nil then
            error(("Unable to write '%s': %s"):format(filename, err))
        end
    end
    file:write(data)
    if filename ~= nil then
        file:close()
    end
end

-- json tool
local json = require("cjson")

---
-- string 2 table
-- @function [parent=#util]
-- @param #string str
-- @return #table
m.jsonDecode = function (str)
    return json.decode(str)
end

---
-- table 2 string
-- @function [parent=#util]
-- @param #table t
-- @return #string
m.jsonEncode = function (t)
    return json.encode(t)
end

---
-- uri string 2 json string
-- @function [parent=#util]
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
-- @function [parent=#util]
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
--@function [parent=#util]
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

return m
