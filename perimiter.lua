--  ===========================================================================
--  Script: perimeter.lua
--  Purpose: 
--      Excavate a volume of blocks. You can specify the boundaries of the
--      volume relative to the turtle.
--  Use: 
--      excavate [-l <left_boundary>] 
--          [-r <right_boundary>]
--          [-u <upper_boundary>]
--          [-d <lower_boundary>] 
--          [-f <forward_boundary>]
--          [-b <backward_bondary>]
--  Author: Sean Rice
--  Date: January 1st, 2021
--  ===========================================================================
local dig = require("lib.dig")

local function parseArgs(args)
    local parsedArgs = {
        ["l"] = 0,
        ["r"] = 0,
        ["u"] = 0,
        ["d"] = 0,
        ["f"] = 0,
        ["b"] = 0
    }

    for i, arg in pairs(args) do
        if arg == "-l" then
            parsedArgs["l"] = tonumber(args[i + 1])
        elseif arg == "-r" then
            parsedArgs["r"] = tonumber(args[i + 1])
        elseif arg == "-f" then
            parsedArgs["f"] = tonumber(args[i + 1])
        elseif arg == "-b" then
            parsedArgs["b"] = tonumber(args[i + 1])
        elseif arg == "-u" then
            parsedArgs["u"] = tonumber(args[i + 1])
        elseif arg == "-d" then
            parsedArgs["d"] = tonumber(args[i + 1])
        end
    end

    return parsedArgs
end

local args = {...}
parsed = parseArgs(args)

dig.digPlane(parsed['l'], parsed['b'], parsed['r'], parsed['f'])
