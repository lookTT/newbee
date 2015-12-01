--如果需要debugger去掉注释掉即可 HOST填写调试IP 作者使用LDT作为编辑调试工具
--require("debugger")("127.0.0.1", "10000", "luaidekey")

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
