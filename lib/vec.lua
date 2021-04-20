local module = {}

function module.new(x, y, z) return {x = x, y = y, z = z} end

local left = module.new(-1, 0, 0)
local right = module.new(1, 0, 0)
local front = module.new(0, 0, 1)
local back = module.new(0, 0, -1)

function module.dir2Idx(dir)
    if (module.equals(dir, left)) then return 3 end
    if (module.equals(dir, right)) then return 1 end
    if (module.equals(dir, front)) then return 0 end
    if (module.equals(dir, back)) then return 2 end
    return 0
end

function module.sub(a, b) return {x = a.x - b.x, y = a.y - b.y, z = a.z - b.z} end

function module.equals(a, b) return a.x == b.x and a.y == b.y and a.z == b.z end

return module;
