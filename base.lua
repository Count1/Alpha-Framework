AddEventHandler('playerConnecting', function(name)
    print('^5[Alpha] ^2Player Connecting:^7 [ ' .. GetPlayerName(source) .. ' ]^7')
end)

AddEventHandler('playerDropped', function(name)
    print('^5[Alpha] ^1Player Disconnect:^7 [ ' .. GetPlayerName(source) .. ' ]^7')
end)