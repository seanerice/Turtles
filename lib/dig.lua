local moduleDir = (...):match("(.-)[^%.]+$")

local move = require(moduleDir .. "move")
local fuel = require(moduleDir .. "fuel")

local function size(arr)
    count = 0
    for i, v in pairs(arr) do count = count + 1 end
end

local lowerBound = vector.new()

function digUntilCleared(maxAttempts)
    maxAttempts = maxAttempts or 64
    for attempt = 1, maxAttempts, 1 do
        turtle.dig()
        turtle.sleep(0.25)

        if not turtle.detect() then return true end
    end

    return false
end

function digAndMoveForward()
    while not move.foward() do
        if turtle.getFuelLevel() == 0 then
            if not fuel.refuel() then
                error(
                    "Can't find fuel to add. Turtle is out of fuel. Shutting down.",
                    2)
                return false;
            end
        elseif not digUntilCleared(50) then
            error(
                "Failed to clear away obstacle after 50 attempts, shutting down")
        end
    end

    return true
end
