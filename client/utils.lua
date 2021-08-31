RegisterNetEvent("Alpha:OnGetItem")
AddEventHandler("Alpha:OnGetItem", function(item, count)
    SendNUIMessage({
		additem = true,
		item = item,
		count = count,
    })
end)

RegisterNetEvent("Alpha:OnRemoveItem")
AddEventHandler("Alpha:OnRemoveItem", function(item, count)
    SendNUIMessage({
		rmvItem = true,
		item = item,
		count = count,
    })
end)

RegisterNetEvent("Alpha:OnWeightLimit")
AddEventHandler("Alpha:OnWeightLimit", function(item)
    SendNUIMessage({
		cantTake = true,
		item = item,
    })
end)


function RegisterItemAction(item, action)
	if items_sys.items_config[item] ~= nil then	
		items_sys.items_config[item].action = action
	else
		if dev.enable_prints then
			print("^1ERROR:^7 Try to add action to invalid item")
		end
	end
end

function UseItem(item)
	if items_sys.items_config[item] ~= nil then
		if items_sys.items_config[item].action ~= nil then
			items_sys.items_config[item].action()
		else
			if dev.enable_prints then
				print("^1ERROR:^7 No action on item '"..item.."'")
			end
		end
	else
		if dev.enable_prints then
			print("^1ERROR:^7 Try to use invalid item")
		end
	end
end

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if NetworkIsSessionStarted() then
			TriggerServerEvent('playerActivated')
			return
		end
	end
end)