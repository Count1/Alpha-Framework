function RegisterNewItem(item, _label, _weight, _prop)
	if items_sys.items_config[tostring(item)] == nil then
		if dev.enable_prints then
			print("^2ITEM REGISTERED: ^7"..item, _label, _weight, _prop)
		end
		items_sys.items_config[tostring(item)] = {label = tostring(_label), weight = tonumber(_weight), prop = _prop}
	else
		if dev.enable_prints then
			print("^1ERROR:^7 Item already exist")
		end
	end
end

RegisterNetEvent("RegisterNewItem")
AddEventHandler("RegisterNewItem", function(item, _label, _weight, prop)
    if source == "" then -- Only accept item register from server side to avoid cheater registering their own items lel
        RegisterNewItem(item, _label, _weight, prop)
    end
end)