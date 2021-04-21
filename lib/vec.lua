local module = {}

function module.new(x, y, z) return {x = x, y = y, z = z} end

module.left = module.new(-1, 0, 0)
module.right = module.new(1, 0, 0)
module.front = module.new(0, 0, 1)
module.back = module.new(0, 0, -1)
module.top = module.new(0, 1, 0)
module.bottom = module.new(0, -1, 0)

function module.dir2Idx(dir)
    if (module.equals(dir, left)) then return 3 end
    if (module.equals(dir, right)) then return 1 end
    if (module.equals(dir, front)) then return 0 end
    if (module.equals(dir, back)) then return 2 end
    return 0
end

function module.add(a, b) return {x = a.x + b.x, y = a.y + b.y, z = a.z + b.z} end

function module.sub(a, b) return {x = a.x - b.x, y = a.y - b.y, z = a.z - b.z} end

function module.equals(a, b) return a.x == b.x and a.y == b.y and a.z == b.z end

return module;
