
---
--@module init
local path_framework = "./script/framework/"
local path_app = "./script/app/"

for file in io.popen('find -name "*.lua" -type f'):lines() do
    local s , e = string.find(file, 'config.lua')
    local ss ,ee  = string.find(file, 'init.lua')
    if s == nil and ss == nil then
        local s , e = string.find(file, path_framework)
        if s ~= nil then
            local module = string.gsub(string.sub(file, #path_framework+1, #file), "/", ".")
            module = string.gsub(module, ".lua", "")
            require(module)
        end

        local s , e = string.find(file, path_app)
        if s ~= nil then
            local module = string.gsub(string.sub(file, #path_app+1, #file), "/", ".")
            module = string.gsub(module, ".lua", "")
            require(module)
        end
    end
end

return nil

