PlayersCache = {}

Citizen.CreateThread(function()
    while true do
        for k,v in pairs(PlayersCache) do
            SavePlayer(v, k)
        end
        Wait(main.savingAllPlayers*1000)
    end
end)

AddEventHandler('playerDropped', function (reason)
    local source = source
    if PlayersCache[source] ~= nil then
        SavePlayerDisconnect(PlayersCache[source], source)
        PlayersCache[source] = nil
    end
end)

function SavePlayerDisconnect(info, id)
    local account = json.encode({money = info.money, bank = info.bank})
    local inv = json.encode(info.inv)
    local pos = json.encode({x = info.pos.x, y = info.pos.y, z = info.pos.z})
    local skin = json.encode(info.skin)
    local identity = json.encode(info.identity)
    MySQL.Sync.execute("UPDATE `players` SET identity = @identity, accounts = @account, skin = @skin, inv = @inv, pos = @pos WHERE players.id = @info_id", {
        ["@identity"] = identity,
        ["@account"] = account,
        ["@skin"] = skin,
        ["@inv"] = inv,
        ["@pos"] = pos,
        ["@info_id"] = info.id,
    })

    MySQL.Sync.execute("UPDATE `jobs` SET job = @info_job, job_grade = @info_job_grade WHERE jobs.id = @info_id", {
        ["@info_job"] = info.job,
        ["@info_job_grade"] = info.job_grade,
        ["@info_id"] = info.id,
    })

    if dev.enable_prints then
        print("^2SAVED: ^7"..id.." saved.")
    end
end

local savingCount = 0

function SavePlayer(info, id)
    local account = json.encode({money = info.money, bank = info.bank})
    local inv = json.encode(info.inv)
    local pos = json.encode({x = info.pos.x, y = info.pos.y, z = info.pos.z})
    local skin = json.encode(info.skin)
    local identity = json.encode(info.identity)

    MySQL.Sync.execute("UPDATE `players` SET identity = @identity, accounts = @account, skin = @skin, inv = @inv, pos = @pos WHERE players.id = @info_id", {
        ["@identity"] = identity,
        ["@account"] = account,
        ["@skin"] = skin,
        ["@inv"] = inv,
        ["@pos"] = pos,
        ["@info_id"] = info.id,
    })

    MySQL.Sync.execute("UPDATE `jobs` SET job = @info_job, job_grade = @info_job_grade WHERE jobs.id = @info_id", {
        ["@info_job"] = info.job,
        ["@info_job_grade"] = info.job_grade,
        ["@info_id"] = info.id,
    })

    savingCount = savingCount + 1

    if dev.enable_prints then
        if success then
            print("^2SAVED: ^7"..savingCount.." players saved.")
        end
    end
end

function CreateUser(license)
    local accounts = json.encode({money = playerconfig.defaultMoney, bank = playerconfig.defaultBank})
    local pos = json.encode({x = playerconfig.defaultPos.x, y = playerconfig.defaultPos.y, z = playerconfig.defaultPos.z})
    MySQL.Sync.execute("INSERT INTO `players` (`license`, `accounts`, `identity`, `inv`, `pos`) VALUES ('"..license.."', '"..accounts.."', '[]', '[]', '"..pos.."')")
    MySQL.Sync.execute("INSERT INTO `jobs` (`perm_level`, `job`, `job_grade`) VALUES ('0', 'Aucun', '0')")

    local id = MySQL.Sync.fetchAll("SELECT id FROM players WHERE license = @identifier", {
        ['@identifier'] = license
    })

    return id[1].id
end

RegisterNetEvent("Alpha:InitPlayer")
AddEventHandler("Alpha:InitPlayer", function()
    local license = GetLicense(source)
    local source = source

    local info = MySQL.Sync.fetchAll("SELECT * FROM players WHERE license = @identifier", {
        ['@identifier'] = license
    })

    PlayersCache[source] = {}

    if info[1] == nil then
        local id = CreateUser(license)
        PlayersCache[source].source = source
        PlayersCache[source].inv = {}
        PlayersCache[source].id = id
        PlayersCache[source].money = playerconfig.defaultMoney
        PlayersCache[source].bank = playerconfig.defaultBank
        PlayersCache[source].pos = playerconfig.defaultPos
        PlayersCache[source].job = "Aucun"
        PlayersCache[source].job_grade = 0
        PlayersCache[source].perm = 0
        PlayersCache[source].skin = playerconfig.defaultsSkin
        PlayersCache[source].identity = {}
    else
        local inv = json.decode(info[1].inv)
        local account = json.decode(info[1].accounts)
        PlayersCache[source].source = source
        PlayersCache[source].inv = inv
        PlayersCache[source].id = info[1].id
        PlayersCache[source].money = account.money
        PlayersCache[source].bank = account.bank
        if info[1].pos == nil then
            PlayersCache[source].pos = playerconfig.defaultPos
        else
            local pos = json.decode(info[1].pos)
            PlayersCache[source].pos = vector3(pos.x, pos.y, pos.z)
        end
        PlayersCache[source].job = info[1].job
        PlayersCache[source].job_grade = info[1].job_grade
        PlayersCache[source].perm = info[1].perm_level
        if info[1].skin == nil then
            PlayersCache[source].skin = playerconfig.defaultsSkin
        else
            PlayersCache[source].skin = json.decode(info[1].skin)
        end
        if info[1].identity == nil then
            PlayersCache[source].identity = nil
        else
            PlayersCache[source].identity = json.decode(info[1].identity)
        end
    end
    if dev.enable_prints then
        print("^2CACHE: ^7Added player "..source.." to cache.")
    end
    TriggerClientEvent("Alpha:PlayerLoaded", source, PlayersCache[source], items_sys.items_config)
    TriggerClientEvent("Alpha:OnInvRefresh", source, PlayersCache[source].inv, GetInvWeight(PlayersCache[source].inv))
end)