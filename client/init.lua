local PlayerLoaded = false
local player = {}

Citizen.CreateThread(function()
    ShowLoadingMessage("Loading player data ...", 2, 10000)
    TriggerServerEvent("Alpha:InitPlayer")
end)

RegisterNetEvent("Alpha:PlayerLoaded")
AddEventHandler("Alpha:PlayerLoaded", function(playersInfo, items)
    ShowLoadingMessage("Spawning player", 2, 5000)
    player = playersInfo
    items_sys.items_config = items
    Wait(3500)
    SetEntityCoords(GetPlayerPed(-1), player.pos, 0.0, 0.0, 0.0, 0)
    if player.skin == nil then
        TriggerEvent("OpenSkinCreator")
        LoadDefaultModel(true, function()
            TriggerEvent("skinchanger:change", "face", 0)
        end)
    else
        TriggerEvent("skinchanger:loadSkin", playersInfo.skin)
    end
    InitPosLoop()
    LoadPickups()
    PlayerLoaded = true
end)

RegisterNetEvent("Alpha:OnJobChange")
AddEventHandler("Alpha:OnJobChange", function(job, grade)
    player.job = job
    player.job_grade = grade

    TriggerEvent("Alpha:JobChange", job, grade)
end)

RegisterNetEvent("Alpha:OnInvRefresh")
AddEventHandler("Alpha:OnInvRefresh", function(inv, weight)
    player.inv = inv
    player.weight = weight
    TriggerEvent("Alpha:InvRefresh", player.inv, player.weight)
end)

RegisterNetEvent("Alpha:OnAccountsRefresh")
AddEventHandler("Alpha:OnAccountsRefresh", function(money, bank)
    player.money = money
    player.bank = bank
    TriggerEvent("Alpha:AccountsRefresh", player.money, player.bank)
end)

function IsPlayerLoaded()
    return PlayerLoaded
end

function GetPlayerJob()
    return player.job
end

function GetPlayerJobGrade()
    return player.job_grade
end

function GetPlayerMoney()
    return player.money
end

function GetPlayerBank()
    return player.bank
end

function GetPlayerUniqueId()
    return player.id
end

function GetPlayerInv()
    return {inv = player.inv, weight = player.weight}
end

function GetPlayerPermLevel()
    return player.perm
end

function GetPlayerIdentity()
    return player.identity
end

function GetPlayerSkin()
    return player.skin
end