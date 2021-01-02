local move = require("lib.move")
local fuel = require("lib.fuel")

local function printVec3(vec3) print("<", vec3.x, ",", vec3.y, ",", vec3.z, ">") end

local function printPos()
    print("Pos:")
    printVec3(move.pos)
    print("Dir:")
    printVec3(move.dir)
    print("\n")
end

fuel.refuel()

move.forward()
printPos()

move.backward()
printPos()

move.up()
printPos()

move.down()
printPos()

