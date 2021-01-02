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

return module
