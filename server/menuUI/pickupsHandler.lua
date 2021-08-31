local pickups = {}

function DropItem(id, item, itemid, count, coords)
    if RemoveItem(id, item, itemid, count) then
        pickups[#pickups+1] = {item = item, count = count, coords = coords, added = false}
        TriggerClientEvent("Alpha:SendAllPickups", -1, pickups)
    end
end

function CreatePickupItem(pickupsToAdd)
    for k,v in pairs(pickupsToAdd) do
        pickups[#pickups+1] = {item = v.item, count = v.count, coords = v.coords, added = false}
    end
    TriggerClientEvent("Alpha:SendAllPickups", -1, pickups)
end


RegisterNetEvent("Alpha:TakePickup")
AddEventHandler("Alpha:TakePickup", function(id, item, amount, count)
    GetPickupIfCan(source, id, item, amount, count)
end)

function GetPickupIfCan(id, idPickup, item, amount, count)
    if pickups[idPickup] ~= nil then
        if pickups[idPickup].count == count then
            if AddItemIf(id, item, amount) then
                if pickups[idPickup].count - amount == 0 then
                    pickups[idPickup] = nil
                    TriggerClientEvent("Alpha:SendAllPickups", -1, pickups, idPickup, true, 0)
                elseif pickups[idPickup].count - amount > 0 then
                    pickups[idPickup].count = pickups[idPickup].count - amount
                    TriggerClientEvent("Alpha:SendAllPickups", -1, pickups, idPickup, false, pickups[idPickup].count)
                elseif pickups[idPickup].count - amount < 0 then
                    return
                end
            end
        end
    end
end