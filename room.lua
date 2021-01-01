--  ==================================
--  Script: room.lua
--  Purpose: Excavate a 3d volume with
--      a mining turtle.
--  Use: You are prompted to give the
--      dimensions. The turtle will
--      dig from the origin right, up,
--      and forward, clearing the
--      defined volume.
--  Author: Sean Rice
--  Date: August 8, 2019
--  ==================================
function refuel() if turtle.getFuelLevel() == 0 then turtle.refuel() end end

function dig() while turtle.detect() do turtle.dig() end end

function digUp() while turtle.detectUp() do turtle.digUp() end end

function digLine(mag)
    for i = 1, mag do
        while not turtle.forward() do
            dig()
            refuel()
        end
    end
end

function digPlane(x, z)
    for i = 0, x do
        digLine(z)
        if i ~= x then
            if i % 2 == 0 then
                turtle.turnRight()
                dig()
                turtle.forward()
                turtle.turnRight()
            else
                turtle.turnLeft()
                dig()
                turtle.forward()
                turtle.turnLeft()
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
                temp = desz
                desz = desx
                desx = temp
            end
        end
    end
end

function readNum(msg)
    print(msg)
    return tonumber(read())
end

function parseParams()
    print("How many blocks to dig?")
    right = readNum("right:")
    up = readNum("up:")
    forward = readNum("forward:")
end

-- INIT ==============================
parseParams()
print(left, right, up, down, forward, back)

-- MAIN ==============================
digVolume(right, up, forward)
