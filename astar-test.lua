local astar = require('lib.astar')
local inspect = require('lib.inspect')
local vec = require('lib.vec')

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
            end
        end
    end
end

local function getNode(graph, x, y, z)
    for i, node in ipairs(graph) do
        if x == node.x and y == node.y and z == node.z then return node end
    end
end

local graph = {}
create3dNodeGraph(graph, 3, 3, 3)

local nodeS = getNode(graph, 0, 0, 0)
local nodeE = getNode(graph, 2, 2, 2)

local path = astar.path(nodeS, nodeE, graph, true, valid_node_func)

local function path2VecPath(path, vecPath)
    local lastNode = nil
    for i, node in ipairs(path) do
        if i > 1 then table.insert(vecPath, vec.sub(node, lastNode)) end
        lastNode = node
    end
end

local vecPath = {}

path2VecPath(path, vecPath)

local move = require('lib.move')
local fuel = require('lib.fuel')

for _, dir in ipairs(vecPath) do
    fuel.refuel(1)
    if vec.equals(dir, vec.new(0, 1, 0)) then
        while not move.up() do print("Stuck: Can't move up") end
    elseif vec.equals(dir, vec.new(0, -1, 0)) then
        while not move.down() do print("Stuck: Can't move down") end
    else
        move.setDir(dir)
        while not move.forward() do print("Stuck: Can't move forward") end
    end
end
