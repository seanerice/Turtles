local astar = require('lib.astar')
local inspect = require('lib.inspect')

local function distance(nodeA, nodeB)
    return math.sqrt(math.pow(nodeA.x - nodeB.x, 2) +
                         math.pow(nodeA.y - nodeB.y, 2) +
                         math.pow(nodeA.z - nodeB.z, 2))
end

local valid_node_func = function(node, neighbor)

    local max_dist = 1

    if distance(node, neighbor) <= max_dist then return true end

    return false
end

local function create3dNodeGraph(graph, x, y, z)
    if x < 1 or y < 1 or z < 1 then
        error("x, y, and z value must be 1 or greater.")
    end

    for i = 1, y do
        for j = 1, x do
            for k = 1, z do
                table.insert(graph, {x = j - 1, y = i - 1, z = k - 1})
                print(j, i, k)
            end
        end
    end
end

local graph = {}
local nodeS = {x = 0, y = 0, z = 0}
local nodeE = {x = 2, y = 2, z = 2}
local allNodes = create3dNodeGraph(graph, 3, 3, 3)

print(inspect(graph))

local path = astar.path(nodeS, nodeE, graph, false, valid_node_func)
