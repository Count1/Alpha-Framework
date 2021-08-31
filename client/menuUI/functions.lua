
RegisterKeyMapping("inventory", "Open inventory", 'keyboard', main.inventoryKey)
RegisterCommand("inventory", function()
    OpenInventoryMenu()
end, false)

AddEventHandler("Alpha:InvRefresh", function(inv, weight)
    LiveRefreshMenu(inv, weight, nil, nil)
end)

AddEventHandler("Alpha:AccountsRefresh", function(money, bank)
    LiveRefreshMenu(nil, nil, money, bank)
end)