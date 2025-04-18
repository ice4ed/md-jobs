
Jobs = Jobs or {}

--debug jobs
for k, v in pairs (Jobs) do
    if Config.Framework == 'qb' then
        if not QBCore.Shared.Jobs[k] then 
            print('MD-Jobs: Job ' .. k .. ' does not exist in qb-core jobs.lua')
            print('Removing job from table')
            Jobs[k] = nil
        end
    elseif Config.Framework == 'qbx' then
        local jobs = QBOX:GetJobs()
        if not jobs[k] then 
            print('MD-Jobs: Job ' .. k .. ' does not exist in qbx-core jobs.lua')
            print('Removing job from table')
            Jobs[k] = nil
        end
    elseif Config.Framework == 'esx' then
        if not ESX.GetJobs()[k] then 
            print('MD-Jobs: Job ' .. k .. ' does not exist in es_extended jobs.lua')
            print('Removing job from table')
            Jobs[k] = nil
        end
    end

end

lib.callback.register('md-jobs:server:getLocations', function(source)
    local data = {}
    for k,v in pairs (Jobs) do
        data[k] = v.locations
    end
    return data
end)

function getlocData(job, event,num)
    return Jobs[job]['locations'][event][num]
end

local function oxPrep() -- initializing trays and stashes for ox
    if GetResourceState('ox_inventory') == 'started' then
        for m, d in pairs (Jobs) do 
            if Jobs[m].locations.trays then 
                for k, v in pairs (Jobs[m].locations.trays) do
                    exports.ox_inventory:RegisterStash(m .. ' Tray '.. k, m .. ' Tray '.. k, v.slots, v.weight)
                end
            end
            if Jobs[m].locations.stash then 
                for k, v in pairs (Jobs[m].locations.stash) do
                    exports.ox_inventory:RegisterStash(m .. ' stash '.. k, m .. ' stash '.. k, v.slots, v.weight)
                end
            end
        end
    end
end
oxPrep()

function getLocsOx(job, shop) -- only used if Config.UseShops is true
    local loc = {}
    for k, v in pairs (Jobs[job]['locations']['Stores']) do
        if v.job == job then
            table.insert(loc, v.loc)
        end
    end
    return loc
end

-- end location stuff


--- start crafting stuff
lib.callback.register('md-jobs:server:getRecipes', function(source, job, loc)
    local Player = getPlayer(source)
    local Job = getJobName(source)
    if job ~= Job then return false end

    if Jobs[job]['craftingStations'][loc] then
        return Jobs[job]['craftingStations'][loc]
    end
    return false
end)

local function checkCraftDist(source, job, loc)
    local locs = {}
    for k, v in pairs (Jobs[job]['locations']['Crafter']) do
        if v.job == job then
            if v.CraftData.type == loc then
                table.insert(locs, v.loc)
            end
        end
    end
    local low = 100.0
    for k, v in pairs (locs) do
        local dist = #(GetEntityCoords(GetPlayerPed(source)) - vector3(v.x, v.y, v.z))
        if dist < low then
            low = dist
        end
        if low <= 5.0 then break end
    end
    if low < 5.0 then
        return true
    else
        Notifys(source, L.T.toofar, 'error')
        return false
    end
end

lib.callback.register('md-jobs:server:canCraft', function(source, job, loc, num, locs)
    local Job = getJobName(source)
    if job ~= Job then return false end
    if not checkCraftDist(source, job, loc) then return end
    local need, have = 0, 0
    for k, v in pairs (Jobs[job]['craftingStations'][loc][num].give) do
        if k == nil then break end
        local needs = hasItem(source, k, v)
        if needs then
            have = have + 1
        end
        need = need + 1
    end
    if need == have then
        for k, v in pairs(Jobs[job]['craftingStations'][loc][num].take) do
            AddItem(source, k, v)
        end
        for k, v in pairs(Jobs[job]['craftingStations'][loc][num].give) do
            RemoveItem(source, k, v)
        end
    end
    Log('Crafted: ' .. job .. ' Name:' .. getName(source), 'crafting')
    return true
end)

lib.callback.register('md-jobs:server:getCraftingMax', function(source, job, loc, item, num)
    local Job = getJobName(source)
    if job ~= Job then return false end
    local tbl = Jobs[job]['craftingStations'][loc][num]
    if next(tbl.give) == nil then
        return Config.MultiCraftDefault
    end
    local lowestValue = 999999999
    for k, v in pairs(tbl.give) do
        local has = getItemCount(source, k) or 0
        local value = math.floor(has / v)

        if value < lowestValue then
            lowestValue = value
        end
    end
    if tbl.max == nil then tbl.max = Config.MultiCraftDefault end
    if tbl.max < lowestValue then
        lowestValue = tbl.max
    end
    return lowestValue
end)
--- end crafting stuff

--- start shop stuff
local function checkDistShops(source,job, loc)
    local locs = {}
    for k, v in pairs (Jobs[job]['locations']['Stores']) do
        if v.job == job then
            if v.StoreData.type == loc then 
                table.insert(locs, v.loc)
            end
        end
    end
    local low = 100.0
    for k, v in pairs (locs) do
        local dist = #(GetEntityCoords(GetPlayerPed(source)) - vector3(v.x, v.y, v.z))
        if dist < low then
            low = dist
        end
    end
    if low < 5.0 then
        return true
    else
        Notifys(source, L.T.toofar, 'error')
        return false
    end
end

lib.callback.register('md-jobs:server:getShops', function(source, job, loc)
    local Player = getPlayer(source)
    local Job = getJobName(source)
    if not checkDistShops(source, job, loc) then return false end 
    if job ~= Job then return false end
    if Config.UseShops then
        if Config.Inv == 'qb' then 
            exports['qb-inventory']:CreateShop({name =  job .. ' ' .. loc,label = loc,slots = #Jobs[job]['shops'][loc],items = Jobs[job]['shops'][loc]})
            exports['qb-inventory']:OpenShop(source, job .. ' ' .. loc)
            return true
        elseif Config.Inv == 'ox' then
            exports.ox_inventory:RegisterShop(job .. ' ' .. loc, {name = job .. ' ' .. loc,inventory = Jobs[job]['shops'][loc],locations = getLocsOx(job, loc)})
            return job .. ' ' .. loc, loc
        end
    end
    if Jobs[job]['shops'][loc] ~= nil then
        return Jobs[job]['shops'][loc]
    else
        return false
    end
end)

lib.callback.register('md-jobs:server:purchaseShops', function(source, job, loc, item, amount, location)
    local Player = getPlayer(source)
    if not checkDistShops(source,job, loc) then return end
    local price = nil
    if not getJobName(source) == job then return end
    for i = 1, #Jobs[job]['shops'][loc] do
        if Jobs[job]['shops'][loc][i].name == item then
            price = Jobs[job]['shops'][loc][i].price * amount
        end
    end
    if price == nil then return end
    if removeMoney(source, price, 'cash') or removeMoney(source, price, 'cash')  then
        Log('Purchased: ' .. job .. ' Name:' .. getName(source), 'purchasing')
        AddItem(source, item, amount)
        return true
    else
        return false
    end
end)

lib.callback.register('md-jobs:server:getBlips', function(source)
    local data = {}
    for k, v in pairs (Jobs) do
        if v.Blip ~= nil then
            for m, d in pairs (v.Blip) do
                table.insert(data, d)
            end
        end
    end
    return data
end)


RegisterNetEvent('md-jobs:server:billPlayer', function(job, num)
    local src = source
    local data = getlocData(job, 'Tills', num)
    if job ~= data.job then return end
    if not checkLoc(source,job, 'Tills', num) then return end
    if getJobName(src) == data.job then
        local peeps = getNear(src)
        local person = lib.callback.await('md-jobs:client:chargePerson', source, peeps)
        if person == nil then return end
        local billed = getPlayerByCid(person.cid)
        local bsrc = getSRC(billed)
        local accept = lib.callback.await('md-jobs:client:acceptCharge', bsrc, person.amount)
        if not accept then Notifys(src, getName(src).. ' Refused To Pay', 'error') return end
        if billPlayer(bsrc, accept.type, person.amount) then
            Notifys(src, s(L.billing.billed, person.amount, getName(bsrc)), 'success')
            Notifys(bsrc,  s(L.billing.paid, person.amount, getName(src)), 'success')
            dispenseCommission(src, person.amount, data.commission)
            Log('Charged: ' .. job .. ' Name:' .. getName(src) .. ' Billed: ' .. getName(bsrc) .. '$' .. person.amount, 'billing')
        else
            Notifys(src, s(L.billing.too_poor, getName(bsrc)),'error')
        end
    end
end)
