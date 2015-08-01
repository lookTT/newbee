
---
--@module ccf_interface
local m = {}

local util = require("util")

---
-- @function [parent=#ccf_interface]
m.send2Client = function(uguid, json)
    uguid = tostring(uguid)
    if type(json) == 'table' then
        json = util.jsonEncode(json)
    end

    if type(json) ~= 'string' then
        util.trackback(string.format("ccf_interface.ccf_Send2Client json type is [%s]", type(json)))
        return
    end

    CCF_Send2Client(uguid, json)
end

---
--@function [parent=#ccf_interface]
m.md5 = function (str)
    return CCF_MD5(str)
end

return m
