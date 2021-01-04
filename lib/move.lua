local module = {}

module.pos = vector.new(0, 0, 0)
module.dir = vector.new(0, 0, 1)

local up = vector.new(0, 1, 0)
local down = vector.new(0, -1, 0)

local function upDir() return up end
local function downDir() return down end
local function frontDir() return module.dir end
local function backDir() return -frontDir() end
local function rightDir() return upDir():cross(frontDir()) end
local function leftDir() return frontDir():cross(upDir()) end

local function vec3Add(a, b) return {
    x = a.x + b.x,
    y = a.y + b.y,
    z = a.z + b.z
} end

module.frontDir = frontDir
module.upDir = upDir
module.downDir = downDir
module.leftDir = leftDir
module.rightDir = rightDir
module.backDir = backDir

function module.forward()
    if not (turtle.forward()) then return false end

    module.pos = module.pos:add(frontDir())
    return true
end

function module.backward()
    if not (turtle.back()) then return false end

    module.pos = module.pos:add(backDir())
    return true
end

function module.up()
    if not (turtle.up()) then return false end

    module.pos = module.pos:add(upDir())
    return true
end

function module.down()
    if not (turtle.down()) then return false end

    module.pos = module.pos:add(downDir())
    return true
end

function module.turnRight()
    if not (turtle.turnRight()) then return false end

    module.dir = rightDir()
    return true
end

function module.turnLeft()
    if not (turtle.turnLeft()) then return false end

    module.dir = leftDir()
    return true
end

local function vectorEquals(vec1, vec2)
    return vec1.x == vec2.x and vec1.y == vec2.y and vec1.z == vec2.z
end

local worldX = vector.new(1, 0, 0)
local worldZ = vector.new(0, 0, 1)
local function validDir(dir)
    return
        vectorEquals(module.dir, worldX) or vectorEquals(module.dir, -worldX) or
            vectorEquals(module.dir, worldZ) or
            vectorEquals(module.dir, -worldZ)
end

function module.setDir(newDir)
    if not validDir(newDir) then return false end
    while not vectorEquals(module.dir, newDir) do module.turnRight() end
    return true
end

return module
