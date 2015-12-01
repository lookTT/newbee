
---
--@module c_mysql
local m = {}

local nb = require("nb")
local glog = nb.glog

--mysql实例
--local mysql =  require("luasql.mysql").mysql():connect("test", "root", "root", "192.168.145.128", 3306)
--切换字符集
--mysql:execute("SET NAMES UTF8")

--执行SELECT语句时返回一条信息
local function rows (connection, sql_statement)
    local cursor = assert (connection:execute (sql_statement))
    return function ()
        return cursor:fetch()
    end
end

--[[

一些小例子

--INSERT
mysql:execute("INSERT INTO contacts values('支持','反对')")

--UPDATE
conn:execute("UPDATE sample3 SET name='John' where id ='12'")

--DELETE
conn:execute("DELETE from sample3 where id ='12'")

--SELECT
for name, address in rows (mysql, "select name, address from contacts") do
    print("----------------------")
    print (string.format ("%s: %s", name, address))
    print("----------------------")
end

--]]

m.cli = function (parameters)

end



return m
