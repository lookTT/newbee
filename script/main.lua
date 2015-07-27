
--Initialization necessary information
require("init")
local util = require("util")

local main = function()
    -- avoid memory leak
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)

    util.glog("let's rock now!!!")
end

xpcall(main,util.trackback)
