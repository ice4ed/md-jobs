local notify   = Config.Notify -- qb or ox
local logs     = false
local logapi   = GetConvar("fivemerrLogs", "")
local endpoint = 'https://api.fivemerr.com/v1/logs'
local headers  = {
    ['Authorization'] = logapi,
    ['Content-Type']  = 'application/json',
}

--------------------------
---- Global Functions ----
--------------------------

--- Spawn server-sided closed shop ped
--- @param model string - the ped model to spawn
--- @param loc vector4 - the location to spawn at
--- @return number | nil - the network ID of the spawned ped or nil if it fails
function SpawnPed(model, loc)
    if not Config.UseClientPeds and model and loc then
        local timeout = 5000
        local startTime = GetGameTimer()
        local ped = CreatePed(4, model, loc.x, loc.y, loc.z, loc.w, true, true)
        while not DoesEntityExist(ped) do
            Wait(100)
            if GetGameTimer() - startTime > timeout then
                if Config.Debug then print("Timeout: Ped creation failed.") end
                return
            end
        end
        FreezeEntityPosition(ped, true)
        return NetworkGetNetworkIdFromEntity(ped)
    end
end

--- Get all players
--- @return table - the players
function GetPlayers()
    if Config.Framework == 'qb' then
        return QBCore.Functions.GetQBPlayers()
    elseif Config.Framework == 'qbx' then
        return QBOX:GetQBPlayers()
    elseif Config.Framework == 'esx' then
        return ESX.GetPlayers()
    end
    return {}
end

--- Log a message
--- @param message string the message to log
--- @param type string the type of log
--- @return nil
function Log(message, type)
    if not logs then return end
    local payload = {
        level    = "info",
        message  = message,
        resource = GetCurrentResourceName(),
        metadata = { md_jobs = type },
    }
    SetTimeout(500, function()
        PerformHttpRequest(endpoint, function(status, _, _, response)
            if status ~= 200 and type(response) == 'string' then
                response = json.decode(response) or response
            end
        end, 'POST', json.encode(payload), headers)
        payload = nil
    end)
end

--- Notify a player
--- @param source number the player ID
--- @param text string the message to notify
--- @param type string the type of notification
--- @return nil
function Notifys(source, text, type)
    if notify == 'qb' then
        TriggerClientEvent("QBCore:Notify", source, text, type)
    elseif notify == 'ox' then
        lib.notify(source, { title = text, type = type })
    elseif notify == 'okok' then
        TriggerClientEvent('okokNotify:Alert', source, '', text, 4000, type, false)
    else
        print "dude, it literally tells you what to put in the config"
    end
end

--- Get player data by player id
--- @param source number the player ID
--- @return table - the player data
function GetPlayer(source)
    if Config.Framework == 'qb' then
        return QBCore.Functions.GetPlayer(source)
    elseif Config.Framework == 'qbx' then
        return QBOX:GetPlayer(source)
    elseif Config.Framework == 'esx' then
        return ESX.GetPlayerFromId(source) or {}
    else
        print('You need to set the framework in the config')
        return {}
    end
end

--- Attempt to get player source by citizen id
--- @param cid string the citizen id
--- @return number  the player source, or -1 if not found/offline
function GetSource(cid)
    if Config.Framework == 'qb' then
        local ply = QBCore.Functions.GetPlayerByCitizenId(cid)
        if ply and ply.PlayerData then
            return ply.PlayerData.source
        end
    elseif Config.Framework == 'qbx' then
        local ply = QBOX:GetPlayerByCitizenId(cid)
        if ply and ply.PlayerData then
            return ply.PlayerData.source
        end
    elseif Config.Framework == 'esx' then
        local xPlayer = ESX.GetPlayerFromIdentifier(cid)
        if xPlayer then
            return xPlayer.source
        end
    end
    return -1
end

--- Get player name by source
--- @param source number the player ID
--- @return string - the player name
function GetName(source)
    local Player = GetPlayer(source)
    if Config.Framework == 'esx' then
        return Player.getName()
    else
        local info = Player.PlayerData.charinfo
        return info.firstname .. ' ' .. info.lastname
    end
end

--- Get the name of the player's job
--- @param source number the player ID
--- @return string - the job name
function GetJobName(source)
    local Player = GetPlayer(source)
    if Config.Framework == 'esx' then
        return Player.getJob().name
    else
        return Player.PlayerData.job.name
    end
end

--- Get the player citizen ID by source
--- @param source number the player ID
--- @return string - the citizen ID
function GetCid(source)
    local Player = GetPlayer(source)
    if Config.Framework == 'esx' then
        return Player.getIdentifier()
    else
        return Player.PlayerData.citizenid
    end
end

--- Check if the player has an item
--- @param source number the player ID
--- @param item string the item name
--- @param amount number the amount required
--- @return boolean - true if the player has enough, false otherwise
function HasItem(source, item, amount)
    if Config.Inv == 'ox' then
        return exports.ox_inventory:GetItemCount(source, item) >= amount
    else
        local Player = GetPlayer(source)
        local entry = Player.Functions.GetItemByName(item)
        return entry and entry.amount >= amount
    end
end

--- Get the count of an item in the player's inventory
--- @param source number the player ID
--- @param item string the item name
--- @return number - the count of the item
function GetItemCount(source, item)
    if Config.Inv == 'ox' then
        return exports.ox_inventory:GetItemCount(source, item)
    else
        local Player = GetPlayer(source)
        local entry  = Player.Functions.GetItemByName(item)
        return (entry and entry.amount) or 0
    end
end

--- Get the label of an item
--- @param item string the item name
--- @return string - the label of the item
function GetLabels(item)
    if Config.Inv == 'ox' then
        local allItems = exports.ox_inventory:Items()
        if not allItems[item] then return 'missing item' end
        return allItems[item].label
    else
        local shared = QBCore.Shared.Items[item]
        if not shared then
            print(item)
            return 'missing item'
        end
        return shared.label or 'missing item'
    end
end

--- Remove an item from the player's inventory
--- @param source number the player ID
--- @param item string the item name
--- @param amount number the amount to remove
--- @return boolean - true if removed, false otherwise
function RemoveItem(source, item, amount)
    if Config.Inv == 'ox' then
        if exports.ox_inventory:RemoveItem(source, item, amount) then
            return true
        end
    else
        local Player = GetPlayer(source)
        if Player.Functions.RemoveItem(item, amount) then
            TriggerClientEvent("qb-inventory:client:ItemBox", source, QBCore.Shared.Items[item], "remove", amount)
            TriggerClientEvent("ps-inventory:client:ItemBox", source, QBCore.Shared.Items[item], "remove", amount)
            TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[item], "remove", amount)
            return true
        end
    end
    Notifys(source, Format(L.Error.need_item_count, amount, GetLabels(item)), 'error')
    return false
end

--- Add an item to the player's inventory
--- @param source number the player ID
--- @param item string the item name
--- @param amount number the amount to add
--- @return boolean - true if added, false otherwise
function AddItem(source, item, amount)
    if Config.Inv == 'ox' then
        if not exports.ox_inventory:CanCarryItem(source, item, amount) then
            Notifys(source, L.Error.cant_carry, 'error')
            return false
        end
        return exports.ox_inventory:AddItem(source, item, amount)
    else
        local Player = GetPlayer(source)
        if Player.Functions.AddItem(item, amount) then
            TriggerClientEvent("qb-inventory:client:ItemBox", source, QBCore.Shared.Items[item], "add", amount)
            TriggerClientEvent("ps-inventory:client:ItemBox", source, QBCore.Shared.Items[item], "add", amount)
            TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[item], "add", amount)
            return true
        end
        print(Format(L.devError.not_item, item, 'qb'))
        return false
    end
end

--- Add money to a job's account
--- @param job string the job name
--- @param amount number the amount to add
--- @return nil
function AddJobMoney(job, amount)
    if Config.Banking == 'qb' then
        exports['qb-banking']:AddMoney(job, amount, 'Services Rendered At ' .. job)
    elseif Config.Banking == 'renewed' then
        exports['Renewed-Banking']:addAccountMoney(job, amount)
    elseif Config.Banking == 'fd' then
        exports.fd_banking:AddMoney(job, amount, 'Services Rendered At ' .. job)
    elseif Config.Banking == 'qb-management' then
        exports['qb-management']:AddMoney(job, amount, 'Services Rendered At ' .. job)
    elseif Config.Banking == 'tgg' then
        exports['tgg-banking']:AddSocietyMoney(job, amount)
    elseif Config.Banking == 'okok' then
        exports['okokBanking']:AddMoney(job, amount)
    end
end

--- Bill a player
--- @param source number the player ID
--- @param type string the type of bill (cash or bank)
--- @param amount number the amount to bill
--- @return boolean - true if successful, false otherwise
function BillPlayer(source, type, amount)
    if Config.Framework == 'qb' then
        local Player = GetPlayer(source)
        if Player.Functions.RemoveMoney(type, amount) then return true end
    elseif Config.Framework == 'qbx' then
        if QBOX:RemoveMoney(source, type, amount) then return true end
    elseif Config.Framework == 'esx' then
        local Player = GetPlayer(source)
        if type == 'bank' then
            if Player.getAccount('bank').money >= amount then
                Player.removeAccountMoney('bank', amount)
                return true
            end
        elseif Player.getMoney() >= amount then
            Player.removeMoney(amount)
            return true
        end
    end
    Notifys(source, L.Error.too_poor, 'error')
    return false
end

--- Get nearby players
--- @param source number the player source
--- @return table - a list of nearby players
function GetNear(source)
    local nearbyPlayers = {}
    local allPlayers    = GetPlayers()
    if Config.Framework == 'qb' or Config.Framework == 'qbx' then
        for _, entry in pairs(allPlayers) do
            local srcPed   = GetPlayerPed(source)
            local entPed   = GetPlayerPed(entry.PlayerData.source)
            local srcCoord = GetEntityCoords(srcPed)
            local entCoord = GetEntityCoords(entPed)

            if #(srcCoord - entCoord) < 10 then
                table.insert(nearbyPlayers, {
                    label = GetName(entry.PlayerData.source),
                    value = entry.PlayerData.citizenid,
                })
            end
        end
    elseif Config.Framework == 'esx' then
        for _, playerId in pairs(allPlayers) do
            local srcPed   = GetPlayerPed(source)
            local entPed   = GetPlayerPed(playerId)
            local srcCoord = GetEntityCoords(srcPed)
            local entCoord = GetEntityCoords(entPed)

            if #(srcCoord - entCoord) < 10 then
                table.insert(nearbyPlayers, {
                    label = GetName(playerId),
                    value = GetCid(playerId),
                })
            end
        end
    end
    return nearbyPlayers
end

--- Add money to a player's account
--- @param source number the player ID
--- @param amount number the amount to add
--- @return nil
function AddMoney(source, amount)
    if Config.Framework == 'qb' then
        local Player = GetPlayer(source)
        Player.Functions.AddMoney('cash', amount)
    elseif Config.Framework == 'qbx' then
        QBOX:AddMoney(source, 'cash', amount)
    elseif Config.Framework == 'esx' then
        local Player = GetPlayer(source)
        Player.addMoney(amount)
    end
end

--- Check the location of a player
--- @param source number the player ID
--- @param job string the job name
--- @param event string the event name
--- @param num number the location index
--- @return boolean - true if the player is in the location
function CheckLoc(source, job, event, num)
    local playerPed   = GetPlayerPed(source)
    local playerCoord = GetEntityCoords(playerPed)
    local targetCoord
    if type(num) == 'string' then
        local locData = Jobs[job].locations[event][num].loc
        targetCoord = vector3(locData.x, locData.y, locData.z)
    else
        targetCoord = Jobs[job].locations[event][num].loc
    end
    local distance = #(playerCoord - targetCoord)
    return distance < 5.0
end

--- Create usable items
--- @param item string the item name
--- @param fun function the callback when used
--- @return nil
function CUI(item, fun)
    if Config.Framework == 'qb' then
        QBCore.Functions.CreateUseableItem(item, fun)
    elseif Config.Framework == 'qbx' then
        QBOX:CreateUseableItem(item, fun)
    elseif Config.Framework == 'esx' then
        ESX.RegisterUsableItem(item, fun)
    end
end

--- Spawn server-sided closed shop ped
--- @param model string - the ped model to spawn
--- @param loc vector4 - the location to spawn at
--- @return number | nil - the network ID of the spawned ped or nil if it fails
function SpawnPed(model, loc)
    if not Config.UseClientPeds and model and loc then
        local timeout = 5000
        local startTime = GetGameTimer()
        local ped = CreatePed(4, model, loc.x, loc.y, loc.z, loc.w, true, true)
        while not DoesEntityExist(ped) do
            Wait(100)
            if GetGameTimer() - startTime > timeout then
                if Config.Debug then print("Timeout: Ped creation failed.") end
                return
            end
        end
        FreezeEntityPosition(ped, true)
        SetEntityOrphanMode(ped, 2)
        return NetworkGetNetworkIdFromEntity(ped)
    end
end

--- Spawn server-sided vehicle
--- @param model string the vehicle model to spawn
--- @param coords vector4 the location to spawn at
--- @param plate string the plate to apply to the vehicle
--- @param livery number the livery to apply to the vehicle
--- @return number | nil - the network ID of the spawned vehicle or nil if it fails
function SpawnVehicle(model, coords, plate, livery)
    local timeout = 5000
    local startTime = GetGameTimer()
    local vanEntity = CreateVehicle(
        model,
        coords.x,
        coords.y,
        coords.z,
        coords.w,
        true,
        true
    )
    while not DoesEntityExist(vanEntity) do
        Wait(100)
        if GetGameTimer() - startTime > timeout then
            if Config.Debug then print("Timeout: Van Entity creation failed.") end
            return
        end
    end
    local netId = NetworkGetNetworkIdFromEntity(vanEntity)
    SetVehicleNumberPlateText(vanEntity, plate)
    SetEntityHeading(vanEntity, coords.w)
    SetEntityOrphanMode(vanEntity, 2)
    if livery then
        TriggerClientEvent('md-jobs:client:setVehicleLivery', -1, netId, livery)
    end
    return netId
end

--- Check if a player is on the catering employee list
--- @param src number the player id of the player
--- @param job string the job to check
--- @param employeeList? table (optional) list of employees
--- @return boolean - true if on the list, else false
function IsCateringEmployee(src, job, employeeList)
    if not src or not job or GetJobName(src) ~= job then
        return false
    end
    if not employeeList then
        local result = MySQL.query.await(
            'SELECT * FROM mdjobs_catering WHERE job = ?', { job }
        )
        local info = result[1]
        if not info then
            return false
        end
        info.details  = json.decode(info.details)
        local dueby = info.details.dueby
        if dueby - os.time() < 0 then return false end -- expired
        employeeList = json.decode(info.employees)
    end
    local isOnJob = false
    local srcCid = GetCid(src)
    for _, emp in ipairs(employeeList) do
        if emp.cid == srcCid then isOnJob = true end
    end
    return isOnJob
end

------------------------
---- Event Handlers ----
------------------------

RegisterNetEvent('md-jobs:server:openTray', function(name, weight, slot, num, job)
    local src  = source
    local data = { label = name, maxweight = weight, slots = slot }
    if GetResourceState('qb-inventory') == 'started' then
        exports['qb-inventory']:OpenInventory(src, name, data)
    elseif GetResourceState('ps-inventory') == 'started' then
        exports['ps-inventory']:OpenInventory(src, name, data)
    else
        print('^1You Wouldnt See This If You Had Read The ReadMe.md^0')
    end
end)

RegisterNetEvent('md-jobs:server:openStash', function(name, weight, slot, num, job)
    local src = source
    if not src then return end
    local player = GetPlayer(src)
    if not CheckLoc(src, job, 'stash', num) then return end
    if job ~= player.PlayerData.job.name then return end
    local data = { label = name, maxweight = weight, slots = slot }
    if GetResourceState('qb-inventory') == 'started' then
        exports['qb-inventory']:OpenInventory(src, name, data)
    elseif GetResourceState('ps-inventory') == 'started' then
        exports['ps-inventory']:OpenInventory(src, name, data)
    else
        print('^1You Wouldnt See This If You Had Read The ReadMe.md^0')
    end
end)

-----------------
---- Threads ----
-----------------

CreateThread(function()
    if logs then
        print('^2Logs Enabled for md-jobs^0')
        if logapi == 'insert string here' then
            print('^1Homie you gotta set your api on line 4^0')
        else
            print('^2API Key Looks Good, Dont Trust Me Though, Im Not Smart^0')
        end
    else
        print('^1Logs disabled for md-jobs^0')
    end
end)

CreateThread(function()
    local url     = "https://raw.githubusercontent.com/Mustachedom/md-jobs/main/version.txt"
    local version = GetResourceMetadata('md-jobs', "version", 0)
    PerformHttpRequest(url, function(_, text, _)
        if text then
            print('^2Your Version: ' .. version .. ' | Current Version: ' .. text .. '^0')
        end
    end, "GET", "", {})
end)
