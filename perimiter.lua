--  ===========================================================================
--  Script: perimeter.lua
--  Purpose: 
--      Excavate a volume of blocks. You can specify the boundaries of the
--      volume relative to the turtle.
--  Use: 
--      excavate [-l <left_boundary>] 
--          [-r <right_boundary>]
--          [-u <upper_boundary>]
--          [-d <lower_boundary>] 
--          [-f <forward_boundary>]
--          [-b <backward_bondary>]
--  Author: Sean Rice
--  Date: January 1st, 2021
--  ===========================================================================
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
