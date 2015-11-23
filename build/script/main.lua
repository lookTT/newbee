--如果不需要debugger注释掉即可
require("debugger")("192.168.1.95", "10000", "luaidekey")
--Initialization necessary information
local nb = require("nb")
require("init")

local main = function()
    -- avoid memory leak
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)

    nb.glog("let's rock now!!!")
end

xpcall(main,nb.trackback)
