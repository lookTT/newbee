
--Initialization necessary information
require("init")
local nb = require("nb")

local main = function()
    -- avoid memory leak
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)

    require("c_redis")
    require("shishicai.c_shishicai")

    nb.glog("let's rock now!!!")
end

xpcall(main,nb.trackback)
