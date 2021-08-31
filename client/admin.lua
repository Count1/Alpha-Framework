Alpha = {}
Tunnel.bindInterface("Alpha", Alpha)


function Alpha.RapierVeh()
    local pPed = GetPlayerPed(-1)
    local pVeh = GetVehiclePedIsIn(pPed, false)
    SetVehicleFixed(pVeh)
    SetVehicleDirtLevel(pVeh, 0.0)
end

function Alpha.Revive()
    local ped = GetPlayerPed(-1)
    ReviveInjuredPed(ped)
    NetworkResurrectLocalPlayer(GetEntityCoords(ped), 100.0, 0, 0)
end

function Alpha.SpawnVeh(model, vest)
    if vest then
        RequestModel(GetHashKey(model))
        while not HasModelLoaded(GetHashKey(model)) do Wait(1) end
    
        local veh = CreateVehicle(GetHashKey(model), GetEntityCoords(GetPlayerPed(-1)), GetEntityHeading(GetPlayerPed(-1)), 1, 0)
        TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
    end
end

RegisterCommand("pos", function(source, args, rawCommand)
    print("{pos = "..GetEntityCoords(GetPlayerPed(-1))..", heading = "..GetEntityHeading(GetPlayerPed(-1)).."},")
end, false)

RegisterCommand("giveweapon", function(source, args, rawCommand)
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey(args[1]), 255, 0, 1)
end, false)

RegisterCommand("settime", function(source, args, rawCommand)
    NetworkOverrideClockTime(tonumber(args[1]), tonumber(args[2]), tonumber(args[3]))
end, false)

RegisterCommand("myjob", function(source, args, rawCommand)
    pJob = GetPlayerJob()
    print(pJob)
end, false)

local slow = false
RegisterCommand("slow", function(source, args, rawCommand)
    if not slow then
        SetTimeScale(0.25)
    else
        SetTimeScale(1.0)
    end
    slow = not slow
end, false)