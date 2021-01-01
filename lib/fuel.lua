fuel = {"minecraft:lava_bucket", "minecraft:coal"}

local module = {}

function module.refuel()
    if turtle.getFuelLevel() == 0 then
        selectFuel()
        turtle.refuel(4)
        if turtle.getFuelLevel() > 0 then
            print("Fuel added. ", turtle.getFuelLevel())
        end
    end
end

local function inList(cmp, list)
    for _, v in pairs(list) do if v == cmp then return true end end
    return false
end

function module.selectFuel()
    for i = 1, 16 do
        local id = turtle.getItemDetail(i)
        if id ~= nil and inList(id.name, fuel) then
            turtle.select(i)
            return true
        end
    end
    return false
end

return module;
