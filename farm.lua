--  ==================================
--  Script: farm.lua
--  Purpose: Till/plant/harvest
--      strips of land.
--  Use: You are prompted to give the
--      dimensions. The turtle will
--      till out and right from the
--      origin.
--  Author: Sean Rice
--  Date: August 10, 2019
--  ==================================

fuel = {
    "minecraft:lava_bucket",
    "minecraft:coal"
}

crops = {
    "natura:barley_crop",
    "wheat"
}

transItems = {
    "natura:materials"    
}

seeds = {
    "natura:overworld_seeds"    
}

function deposit()    
    for i=1,16 do
        local id = turtle.getItemDetail(i)
        if id~=nil then
            if inList(id.name, transItems) then
                turtle.select(i)
                turtle.dropDown()
            end
        end
    end
end

function inList(cmp, list)
    for _,v in pairs(list) do
        if v == cmp then
            return true
        end
    end
    return false
end

function selectFuel()
    for i=1,16 do
        local id = turtle.getItemDetail(i)
        if id~=nul and inList(id.name, fuel) then
            turtle.select(i)
            return true
        end
    end    
    return false
end

function removeExcessSeeds()
    local seedCount = itemStacks("natura:overworld_seeds")
    if seedCount > 2 then
        for i=1,seedCount-2 do
            selectSeed()
            turtle.drop()
        end
    end
end

function itemStacks(name)
    local count = 0
    for i=1,16 do
        local id = turtle.getItemDetail(i)
        if id~=null and id.name == name then
            count = count + 1
        end
    end
    return count
end

function selectSeed()
    for i=1,16 do
        local id = turtle.getItemDetail(i)
        if id~=nul and inList(id.name, seeds) then
            turtle.select(i)
            return true
        end
    end    
    return false
end

function refuel()
    if turtle.getFuelLevel() == 0 then
        selectFuel()
        turtle.refuel(4)
        if turtle.getFuelLevel() > 0 then
            print("Fuel added. ", turtle.getFuelLevel())
        end
    end
end

function tryTill()
    local succ, data = turtle.inspectDown()
    if not succ then
        turtle.digDown()
    end
end

function tryHarvest()
    local succ, data = turtle.inspectDown()
    if succ then
        -- print(data.name, data.metadata)
        if inList(data.name, crops) and data.metadata == 3 then
            turtle.digDown()
        end
    end
end

function tryPlant()
    selectSeed()
    turtle.placeDown()
end

function tryForward()
    if not turtle.forward() then
        refuel()
        if not turtle.forward() then
            print("Turtle stuck")
            while not turtle.forward() do
                refuel()
            end
        end
    end
    return true
end

function digLine(mag)
    for i=1,mag do
        tryTill()
        tryHarvest()
        tryPlant()
        tryForward()        
    end
end

function digPlane(x, z)
    for i=0,x do
        digLine(z)
        tryTill()
        tryHarvest()
        tryPlant()
        if i ~= x then
            if i % 2 == 0 then
                turtle.turnRight()
                tryForward()
                turtle.turnRight()
            else
                turtle.turnLeft()
                tryForward()
                turtle.turnLeft()
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
    --left = readNum("left:")
    right = readNum("right:")
    --up = readNum("up:")
    --down = readNum("down:")
    forward = readNum("forward:")
    --back = readNum("back:")
end

-- INIT ==============================
parseParams()
print(right, forward)

-- MAIN LOOP =========================
while(true) do
    digPlane(right, forward)

    -- RESET =============================
    if right % 2 == 0 then
        turtle.refuel()
        turtle.turnLeft()
        turtle.turnLeft()
        for i=1,forward do
            tryForward()
        end
    end
    turtle.turnRight()
    for i=1,right do
        tryForward()
    end 
    turtle.turnRight()

    -- DEPOSIT IN CHEST ==================
    turtle.back()
    turtle.back()
    deposit()
    turtle.forward()
    turtle.forward()
    removeExcessSeeds()
    os.sleep(300)
end
