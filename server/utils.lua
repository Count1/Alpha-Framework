local playerCount = 0
local list = {}

function GetLicense(id)
    local identifiers = GetPlayerIdentifiers(id)
    for _, v in pairs(identifiers) do
        if string.find(v, "license") then
            return v
        end
    end
end

RegisterNetEvent("DeleteEntity")
AddEventHandler("DeleteEntity", function(list)
    for k,v in pairs(list) do
        local entity = NetworkGetEntityFromNetworkId(v)
        DeleteEntity(entity)
    end
end) 

RegisterNetEvent("Alpha:RegisterNewItem")
AddEventHandler("Alpha:RegisterNewItem", function(item, _label, _weight)
	if items_sys.items_config[item] == nil then
		items_sys.items_config[item] = {label = _label, weight = _weight}
	else
    if dev.enable_prints then	
      print("^1ERROR:^7 Item already exist")
    end
	end
end)

local errorsCode = {
    [1] = "Trying to do action on an item that do not exist.",
    [2] = "Trying to do action on an item that do not exist in player inventory.",
    [3] = "Trying to transfer invalid money (value > player's money / bank)",
    [4] = "Trying to do action on invalid society name",
    [5] = "Trying to do action on invalide item count, probably server desync OR player trying duplication",
    [6] = "Trying to change player job while not being boss",
}
function ErrorHandling(source, code)   
  if dev.enable_prints then 
    print("^1ERROR:^7 "..errorsCode[code].." | Error triggered by ["..source.."]")
  end
end


RegisterServerEvent('playerActivated')
AddEventHandler('playerActivated', function()
  if not list[source] then
    playerCount = playerCount + 1
    list[source] = true
  end
end)

AddEventHandler('playerDropped', function()
  if list[source] then
    playerCount = playerCount - 1
    list[source] = nil
  end
end)