local module = {}

module.pos = {x = 0, y = 0, z = 0}
module.dir = {x = 0, y = 0, z = 1}

local up = {x = 0, y = 1, z = 0}
local down = {x = 0, y = -1, z = 0}

local function rightDir() return rotateRight(module.dir) end
local function leftDir() return rotateLeft(module.dir) end
local function frontDir() return module.dir end
local function backDir()
    return {x = -module.dir.x, y = module.dir.y, z = -module.dir.z}
end
local function upDir() return up end
local function downDir() return down end

local function vec3Add(a, b) return {
    x = a.x + b.x,
    y = a.y + b.y,
    z = a.z + b.z
} end

local function rotateRight(dir) return {x = dir.z, y = dir.y, z = -dir.z} end
local function rotateLeft(dir) return {x = -dir.z, y = dir.y, z = dir.z} end

function module.forward()
    if not (turtle.forward()) then
        error("can't move forward", 3)
        return false
    end

    module.pos = vec3Add(module.pos, frontDir())
    return true
end

function module.backward()
    if not (turtle.back()) then
        error("can't move backwarad", 3)
        return false
    end

    module.pos = vec3Add(module.pos, backDir())
    return true
end

function module.up()
    if not (turtle.up()) then
        error("can't move up", 3)
        return false
    end

    module.pos = vec3Add(module.pos, upDir())
    return true
end

function module.down()
    if not (turtle.down()) then
        error("can't move down", 3)
        return false
    end

    module.pos = vec3Add(module.pos, downDir())
    return true
end

function module.turnRight()
    if not (turtle.turnRight()) then
        error("can't turn right")
        return false
    end

    module.dir = rotateRight(module.dir)
    return true
end

function module.turnLeft()
    if not (turtle.turnLeft()) then
        error("can't turn left")
        return false
    end

    module.dir = rotateLeft(module.dir)
    return true
end

return module
