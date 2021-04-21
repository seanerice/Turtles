local astar = require('lib.astar')
local inspect = require('lib.inspect')
local vec = require('lib.vec')
local move = require('lib.move')
local fuel = require('lib.fuel')

local function distance(nodeA, nodeB)
    return math.sqrt(math.pow(nodeA.x - nodeB.x, 2) +
                         math.pow(nodeA.y - nodeB.y, 2) +
                         math.pow(nodeA.z - nodeB.z, 2))
end

local valid_node_func = function(node, neighbor)
    local max_dist = 1

    if distance(node, neighbor) <= max_dist and
        (neighbor.obstacle == nil or neighbor.obstacle == false) then
        return true
    end

    return false
end

local function create3dNodeGraph(x, y, z)
    local graph = {}

    if x < 1 or y < 1 or z < 1 then
        error("x, y, and z value must be 1 or greater.")
    end

    for i = 1, y do
        for j = 1, x do
            for k = 1, z do
                table.insert(graph, vec.new(j - 1, i - 1, k - 1))
            end
        end
    end

    return graph
end

local function getNode(graph, x, y, z)
    for i, node in ipairs(graph) do
        if x == node.x and y == node.y and z == node.z then return node end
    end
end

-- local function removeNode(graph, x, y, z)
--     for i, node in ipairs(graph) do
--         if x == node.x and y == node.y and z == node.z then
--             table.remove(graph, i)
--         end
--     end
-- end

local function path2VecPath(path)
    local vecPath = {}
    local lastNode = nil
    for i, node in ipairs(path) do
        if i > 1 then table.insert(vecPath, vec.sub(node, lastNode)) end
        lastNode = node
    end
    return vecPath
end

local function tryReachGoal(graph, endNode)
    local startNode = getNode(graph, move.pos.x, move.pos.y, move.pos.z)
    local path = astar.path(startNode, endNode, graph, true, valid_node_func)
    if path == nil then error("could not find path") end

    local vecPath = path2VecPath(path)

    for _, dir in ipairs(vecPath) do
        fuel.refuel(1)
        local nextPos = vec.add(move.pos, dir)

        if vec.equals(dir, vec.top) then
            if turtle.getFuelLevel() > 0 and not move.up() then
                getNode(graph, nextPos.x, nextPos.y, nextPos.z).obstacle = true
                return false
            end
        elseif vec.equals(dir, vec.bottom) then
            if turtle.getFuelLevel() > 0 and not move.down() then
                getNode(graph, nextPos.x, nextPos.y, nextPos.z).obstacle = true
                return false
            end
        else
            move.setDir(dir)
            if turtle.getFuelLevel() > 0 and not move.forward() then
                getNode(graph, nextPos.x, nextPos.y, nextPos.z).obstacle = true
                return false
            end
        end
    end
    return true
end

local graph = create3dNodeGraph(10, 10, 10)
local nodeE = getNode(graph, 5, 0, 5)

while not tryReachGoal(graph, nodeE) do print("Blocked, trying again...") end
