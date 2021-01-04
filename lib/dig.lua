local moduleDir = (...):match("(.-)[^%.]+$")

local move = require(moduleDir .. "move")
local fuel = require(moduleDir .. "fuel")
local inspect = require(moduleDir .. "inspect")

local module = {}

local function size(arr)
    count = 0
    for i, v in pairs(arr) do count = count + 1 end
end

local lowerBound = vector.new()

function module.digUntilCleared(maxAttempts)
    maxAttempts = maxAttempts or 64
    for attempt = 1, maxAttempts, 1 do
        turtle.dig()
        os.sleep(0.25)

        if not turtle.detect() then return true end
    end

    return false
end

function module.digAndMoveForward()
    while not move.forward() do
        if turtle.getFuelLevel() == 0 then
            if not fuel.refuel() then
                error(
                    "Can't find fuel to add. Turtle is out of fuel. Shutting down.",
                    2)
                return false;
            end
        elseif not module.digUntilCleared(50) then
            error(
                "Failed to clear away obstacle after 50 attempts, shutting down")
        end
    end

    return true
end

function module.digLine(z) for i = 1, z do module.digAndMoveForward() end end

-- Move             
function digAndMoveTo(relativeCoords) end

local function vectorCopy(vec) return vector.new(vec.x, vec.y, vec.z) end
local function vectorEquals(vec1, vec2)
    return vec1.x == vec2.x and vec1.y == vec2.y and vec1.z == vec2.z
end

function module.digPlane(left, back, right, front)
    local fwdDir = vectorCopy(move.frontDir())
    local leftDir = vectorCopy(move.leftDir())
    local backDir = vectorCopy(move.backDir())

    -- Move to left of boundary
    if left > 0 then
        move.setDir(leftDir)
        module.digLine(left)
    end

    -- Move to back of boundary
    if back > 0 then
        move.setDir(backDir)
        module.digLine(back)
    end

    move.setDir(fwdDir)

    local sizeX = left + right
    local sizeZ = front + back

    for i = 1, sizeX do
        module.digLine(sizeZ)
        if i < sizeX then
            if vectorEquals(move.dir, fwdDir) then
                move.turnRight()
                module.digAndMoveForward()
                move.turnRight()
            else
                move.turnLeft()
                module.digAndMoveForward()
                move.turnLeft()
            end
        end
    end
end

function digVolume(x, y, z)
    desx = x
    desy = y
    desz = z
    for i = 0, desy do
        digPlane(desx, desz)
        if desy ~= i then
            if desx % 2 == 0 then
                digUp()
                turtle.up()
                turtle.turnRight()
                turtle.turnRight()
            else
                digUp()
                turtle.up()
                turtle.turnRight()
                temp = deszd
                desz = desx
                desx = temp
            end
        end
    end
end

return module
