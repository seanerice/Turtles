local moduleDir = (...):match("(.-)[^%.]+$")
local move = require(moduleDir .. "move")

local module = {}

module.mappedCoords = {}

function module.addEntry(coord, blockInfo)
    module.mappedCoords[coord:tostring()] = blockInfo
end

function module.removeEntry(coord) module.addEntry(coord, nil) end

local function inspect(coord, inspectFunc)
    local success, data = inspectFunc()

    if success then
        module.addEntry(coord, data)
    else
        module.removeEntry(coord, data)
    end

    return success, data
end

function module.inspectForward()
    return inspect(move.pos + move.frontDir(), turtle.inspect)
end

function module.inspectUp()
    return inspect(move.pos + move.upDir(), turtle.inspectUp)
end

function module.inspectDown()
    return inspect(move.pos + move.downDir(), turtle.inspectDown)
end

function module.inspectAround()
    module.inspectUp()
    module.inspectDown()
    module.inspectForward()

    move.turnRight()
    module.inspectForward()

    move.turnRight()
    module.inspectForward()

    move.turnRight()
    module.inspectForward()

    move.turnRight()
end
