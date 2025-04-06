
local notify = Config.Notify -- qb or ox
local logs = true 
local logapi = GetConvar("fivemerrLogs", "")
local endpoint = 'https://api.fivemerr.com/v1/logs'
local headers = {
    ['Authorization'] = logapi,
    ['Content-Type'] = 'application/json',
}

CreateThread(function()
if logs then 
    print'^2 Logs Enabled for md-jobs'
    if logapi == 'insert string here' then 
        print'^1 homie you gotta set your api on line 4'
    else
        print'^2 API Key Looks Good, Dont Trust Me Though, Im Not Smart'
    end
else
    print'^1 logs disabled for md-jobs'
end
end)

function Log(message, type)
if logs == false then return end	
    local buffer = {
        level = "info",
        message = message,
        resource = GetCurrentResourceName(),
        metadata = {
            md_jobs = type,
        }
    }
    SetTimeout(500, function()
         PerformHttpRequest(endpoint, function(status, _, _, response)
             if status ~= 200 then 
                 if type(response) == 'string' then
                     response = json.decode(response) or response
                 end
             end
         end, 'POST', json.encode(buffer), headers)
         buffer = nil
     end)
end

function s(str, ...)
    local args = {...}
    return string.format(str, table.unpack(args))
end

function Notifys(source, text, type)
    if notify == 'qb' then
        TriggerClientEvent("QBCore:Notify", source, text, type)
    elseif notify == 'ox' then
        lib.notify(source, { title = text, type = type})
    elseif notify == 'okok' then
        TriggerClientEvent('okokNotify:Alert', source, '', text, 4000, type, false)
    else
        print"dude, it literally tells you what to put in the config"    
    end
end

function getPlayer(source)
    local src = source
    if Config.Framework == 'qb' then 
        return QBCore.Functions.GetPlayer(src)
    elseif Config.Framework == 'esx' then
        return ESX.GetPlayerFromId(src)
    end
end

function getPlayers()
    if Config.Framework == 'qb' then 
        return QBCore.Functions.GetQBPlayers()
    elseif Config.Framework == 'esx' then
        return ESX.GetPlayers()
    end
end

function getSource(cid)
    if Config.Framework == 'qb' then
        return QBCore.Functions.GetPlayerByCitizenId(cid).PlayerData.source
    elseif Config.Framework == 'esx' then
        return ESX.GetPlayerFromIdentifier(cid).source
    end
end

function getPlayerByCid(cid)
    if Config.Framework == 'qb' then 
        return QBCore.Functions.GetPlayerByCitizenId(cid)
    elseif Config.Framework == 'esx' then
        return ESX.GetPlayerFromIdentifier(cid)
    end
end

function getJobName(source)
    if Config.Framework == 'qb' then 
        local Player = getPlayer(source)
        return Player.PlayerData.job.name
    elseif Config.Framework == 'esx' then
        local Player = getPlayer(source)
        return Player.getJob().name
    end
end

function getCid(source)
    if Config.Framework == 'qb' then 
        local Player = getPlayer(source)
        return Player.PlayerData.citizenid
    elseif Config.Framework == 'esx' then
        local Player = getPlayer(source)
        return Player.getIdentifier()
    end
end

function Itemcheck(source, item, amount, notify)
    if type(item) == 'table' then 
        if Config.Inv == 'ox' then
            for k, v in pairs (item) do 
                if  exports.ox_inventory:GetItemCount(source, k) < amount then return false end
            end
            return true
        else
            local Player = getPlayer(source)
            for k, v in pairs (item) do 
                local has = Player.Functions.GetItemByName(k)
                if not has then return false end
                if has and has.amount < amount then return false end
            end
            return true
        end
    elseif type(item) == 'string' then 
        if Config.Inv == 'ox' then
            if exports.ox_inventory:GetItemCount(source, item) < amount then return false end
            return true
        else
            local Player = getPlayer(source)
            local has = Player.Functions.GetItemByName(item)
            if not has then return false end
            if has and has.amount < amount then return false end
            return true
        end
    end
end

function hasItem(source, item, amount)
    if Config.Inv == 'ox' then
        if exports.ox_inventory:GetItemCount(source, item) >= amount then return true end
    else
        local Player = getPlayer(source)
        local has = Player.Functions.GetItemByName(item)
        if has and has.amount >= amount then return true end
    end
    return false
end

function getItemCount(src, item)
    if Config.Inv == 'ox' then
        return exports.ox_inventory:GetItemCount(src, item)
    else
        local Player = getPlayer(src)
        local has = Player.Functions.GetItemByName(item)
        if has and has.amount then 
            return has.amount
        else
            return 0
        end
    end
    return 0
end

function GetLabels(item)
    if Config.Inv == 'ox' then
        local items = exports.ox_inventory:Items()
        if items[item] == nil then return 'missing item' end
        return items[item].label
    else
        return QBCore.Shared.Items[item].label
    end
end

function RemoveItem(source, item, amount) 
    if Config.Inv == 'ox' then
        if exports.ox_inventory:RemoveItem(source, item, amount) then
            return true
        else
            Notifys(source, s(L.Error.need_item_count, amount, GetLabels(item)) , 'error')
        end
    else
        local Player = getPlayer(source)
        if Player.Functions.RemoveItem(item, amount) then 
            TriggerClientEvent("qb-inventory:client:ItemBox", source, QBCore.Shared.Items[item], "remove", amount)
            TriggerClientEvent("ps-inventory:client:ItemBox", source, QBCore.Shared.Items[item], "remove", amount)
            TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[item], "remove", amount)
            return true
        else
            Notifys(source, s(L.Error.need_item_count, amount, GetLabels(item)) , 'error')
        end
    end
end

function AddItem(source, item, amount) 
    if Config.Inv == 'ox' then
        local carry = exports.ox_inventory:CanCarryItem(source, item, amount)
        if not carry then Notifys(source, L.Error.cant_carry, 'error') return false end
        if exports.ox_inventory:AddItem(source, item, amount) then
            return true
        else
            print(s(L.devError.not_item, item, 'ox'))
            return false
        end
    else
        local Player = getPlayer(source)
        if Player.Functions.AddItem(item, amount) then 
            TriggerClientEvent("qb-inventory:client:ItemBox", source, QBCore.Shared.Items[item], "add", amount)  
            TriggerClientEvent("ps-inventory:client:ItemBox", source, QBCore.Shared.Items[item], "add", amount)  
            TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[item], "add", amount)  
            return true
         else
            print(s(L.devError.not_item, item, 'qb'))
            return false
        end
    end
end

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
   end
end

function sorter(tbl, key)
    table.sort(tbl, function(a, b)
        return a[key] < b[key]
    end)
end
function getName(source)
    if Config.Framework == 'qb' then 
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        return Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
    elseif Config.Framework == 'esx' then
        local src = source
        local Player = ESX.GetPlayerFromId(src)
        return Player.getName()
    end
end

function getSRC(player)
    if Config.Framework == 'qb' then
        return player.PlayerData.source
    elseif Config.Framework == 'esx' then
        return player.source
    end
end

function billPlayer(src, type, amount)
    if Config.Framework == 'qb' then 
        local Player = getPlayer(src)
        if Player.Functions.RemoveMoney(type, amount) then
            return true
        else
            Notifys(src, L.Error.too_poor, 'error')
            return false
        end
    elseif Config.Framework == 'esx' then
        local Player = getPlayer(src)
        if type == 'bank' then  
            if Player.getAccount('bank').money >= amount then
                Player.removeAccountMoney('bank', amount)
                return true
            else
                Notifys(src, L.Error.too_poor, 'error')
                return false
            end
        else
            if Player.getMoney() >= amount then
                Player.removeMoney(amount)
                return true
            else
                Notifys(src, L.Error.too_poor, 'error')
                return false
            end
        end
    end
end

function removeMoney(source, amount, type) 
    local Player = getPlayer(source)
    if Config.Framework == 'qb' then 
        if Player.Functions.RemoveMoney(type, amount) then
            return true
        else
            Notifys(source, L.Error.too_poor, 'error')
            return false
        end
    elseif Config.Framework == 'esx' then
        if type == 'bank' then  
            if Player.getAccount('bank').money >= amount then
                Player.removeAccountMoney('bank', amount)
                return true
            else
                Notifys(source, L.Error.too_poor, 'error')
                return false
            end
        else
            if Player.getMoney() >= amount then
                Player.removeMoney(amount)
                return true
            else
                Notifys(source, L.Error.too_poor, 'error')
                return false
            end
        end
    end
end

function getNear(source)
    local peeps = {}
    if Config.Framework == 'qb' then 
        local src = source
        local Player = getPlayer(src)
        for k, v in pairs (getPlayers()) do
            local ped, ped2 = GetPlayerPed(src), GetPlayerPed(v.PlayerData.source)
            local loc1, loc2 = GetEntityCoords(ped), GetEntityCoords(ped2)
            if #(loc1 - loc2) < 10 then 
                table.insert(peeps, {label =  getName(v.PlayerData.source), value = v.PlayerData.citizenid,})
            end
        end
    elseif Config.Framework == 'esx' then
        local src = source
        local Player = getPlayer(src)
        for k, v in pairs (getPlayers()) do
            local ped, ped2 = GetPlayerPed(src), GetPlayerPed(v)
            local loc1, loc2 = GetEntityCoords(ped), GetEntityCoords(ped2)
            if #(loc1 - loc2) < 10 then 
                table.insert(peeps, {label =  getName(v), value = getCid(v)})
            end
        end
    end
    return peeps
end


function addMoney(source, amount)
    if Config.Framework == 'qb' then 
        local Player = getPlayer(source)
        Player.Functions.AddMoney('cash', amount)
    elseif Config.Framework == 'esx' then
        local Player = getPlayer(source)
        Player.addMoney(amount)
    end
end

function dispenseCommission(source, amount, data)
    local Player = getPlayer(source)
    if data == nil then
        AddJobMoney(getJobName(source), amount)
        return
    end
    local comm = math.floor(amount * data)
    local total = amount - comm
    addMoney(source, comm)
    Notifys(source, s(L.cater.commission, comm), 'success')
    AddJobMoney(getJobName(source), total)
end


function checkLoc(source,job, event, num)
    local ped = source
    local pos = GetPlayerPed(ped)
    local coord = GetEntityCoords(pos)
    local loc
    if type(num) == 'string' then
        loc = vector3(Jobs[job]['locations'][event][num].loc.x, Jobs[job]['locations'][event][num].loc.y, Jobs[job]['locations'][event][num].loc.z )
    else
        loc = Jobs[job]['locations'][event][num].loc
    end
    local dist = #(coord - loc)
    if dist < 5.0 then
        return true
    else
        return false
    end
end

function getAllJobs()
    if Config.Framework == 'qb' then
        return QBCore.Shared.Jobs
    elseif Config.Framework == 'esx' then
        return ESX.Jobs
    end
end

-- events for stashes for qb and ps
RegisterNetEvent('md-jobs:server:openTray', function(name, weight, slot, num,job)
    local src = source
    local Player = getPlayer(src)
    local data = { label = name, maxweight = weight, slots = slot }

    if GetResourceState('qb-inventory') == 'started' then
    	exports['qb-inventory']:OpenInventory(src, name, data)
    elseif GetResourceState('ps-inventory') == 'started' then
	    exports['ps-inventory']:OpenInventory(src, name, data)
    else
      print('^1 You Wouldnt See This If You Had Read The ReadMe.md')
    end
end)

RegisterNetEvent('md-jobs:server:openStash', function(name, weight, slot, num, job)
    local src = source
    local Player = getPlayer(src)

    if not checkLoc(src,job,'stash', num) then return end
    if job ~= Player.PlayerData.job.name then return end
    local data = { label = name, maxweight = weight, slots = slot }
    if GetResourceState('qb-inventory') == 'started' then
    	exports['qb-inventory']:OpenInventory(src, name, data)
   elseif GetResourceState('ps-inventory') == 'started' then
	    exports['ps-inventory']:OpenInventory(src, name, data)
   else
      print('^1 You Wouldnt See This If You Had Read The ReadMe.md')
   end
end)

function CUI(item, fun) 
    if Config.Framework == 'qb' then 
        QBCore.Functions.CreateUseableItem(item, fun) 
    elseif Config.Framework == 'esx' then
        ESX.RegisterUsableItem(item, fun)
    end
end