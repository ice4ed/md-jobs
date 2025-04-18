
CreateThread(function()
if Config.ClosedShopAlwaysActive then return end
    local ClosedShopPlayers = {}
    for k, v in pairs (getAllJobs()) do 
        ClosedShopPlayers[k] = 0
    end
    repeat
        for k, v in pairs (ClosedShopPlayers) do
            ClosedShopPlayers[k] = 0
        end
        local players = GetPlayers()
        for k, v in pairs (players) do
            local src = v
            local job = getJobName(src)
            if Config.Framework == 'qb' then
                if job and getPlayer(src).PlayerData.job.onduty == true then
                    ClosedShopPlayers[job] = ClosedShopPlayers[job] + 1 or 0
                end
            elseif Config.Framework == 'qbx' then
                if job and getPlayer(src).PlayerData.job.onduty == true then
                    ClosedShopPlayers[job] = ClosedShopPlayers[job] + 1 or 0
                end
            elseif Config.Framework == 'esx' then
                if job then 
                    ClosedShopPlayers[job] = ClosedShopPlayers[job] + 1 or 0
                end
            end
        end
        GlobalState.MDJobsCount = ClosedShopPlayers
        Wait(1000 * 60 * Config.ClosedShopLoop)
    until false
end)

function initializePeds()
    for k, v in pairs (Jobs) do
        if v.closedShopsEnabled then
            for m, d in pairs (Jobs[k].closedShops) do
                local items = MySQL.query.await('SELECT * FROM mdjobs_closedshop WHERE label = ?', {d.label})
                if #items == 0 then
                    local itemPrices = {}
                    for i, j in pairs (Jobs[k].closedShopItems) do
                        if j.price == nil then j.price = 5 end
                        itemPrices[i] = j.price
                    end
                    MySQL.insert('INSERT INTO mdjobs_closedshop (job, label, items, prices) VALUES (?, ?, ?,?)', {k, d.label, json.encode({}), json.encode(itemPrices)})
                end
            end
        end
    end
end
initializePeds()

lib.callback.register('md-jobs:server:getPeds', function()
    local peds = {}
    for k, v in pairs (Jobs) do
        if v.closedShopsEnabled then
            if v.closedShops then
                for m, d in pairs (Jobs[k].closedShops) do
                    if d.ped then
                        table.insert(peds, {model = d.ped, loc = d.loc, job = k, num = m})
                    end
                end
            end
        end
    end
    return peds
end)


lib.callback.register('md-jobs:server:getClosedShops', function(source, job, loc)
    local src = source
    local location = GetEntityCoords(GetPlayerPed(src))
    local d = Jobs[job]['closedShops'][loc].loc
    if #(location - vector3(d.x, d.y, d.z)) < 5.0 then
        local items = MySQL.query.await('SELECT * FROM mdjobs_closedshop WHERE job = ? and label = ?', {job, Jobs[job]['closedShops'][loc].label})
        local data = {}
        local has = json.decode(items[1].items)
        local prices = json.decode(items[1].prices)
        for k, v in pairs (has) do
           table.insert(data, {name = k, amount = v or 0, price = prices[k] or 999999})
        end
        sorter(data, 'name')
        Log('Opened Closed Shop: ' .. job .. ' Name:' .. getName(src), 'closedshop')
        return data
    end
    return false
end)

lib.callback.register('md-jobs:server:addItemsToClosed', function(source, job, num)
    local src = source
    local location = GetEntityCoords(GetPlayerPed(src))
    if getJobName(src) ~= job then return end
    if #(location - vector3(Jobs[job]['closedShops'][num].loc.x,Jobs[job]['closedShops'][num].loc.y,Jobs[job]['closedShops'][num].loc.z)) < 5.0 then
        local data = {}
        for k, v in pairs (Jobs[job].closedShopItems) do
            local has = getItemCount(src, k)
            if has > 0 then
                table.insert(data, {item = k, type = 'number', placeholder = has, min = 0, max = has, label = GetLabels(v.name), default = has})
            end
        end
        sorter(data, 'label')
        local items = lib.callback.await('md-jobs:client:addItemsToClosed', src, data)
        if items == nil then return end
        local git = MySQL.query.await('SELECT * FROM mdjobs_closedshop WHERE job = ? AND label = ?', {job, Jobs[job]['closedShops'][num].label})
        local alreadyin = json.decode(git[1].items) or json.encode(git.items)

        if not items then return end
        for k , v in pairs (data) do
            if items[k] >= 1 then
                if RemoveItem(src, v.item, items[k]) then
                    if alreadyin[v.item] ~= nil then 
                        alreadyin[v.item] = alreadyin[v.item] + items[k]
                    else
                        alreadyin[v.item] = items[k]
                    end
                end
            end
        end

        MySQL.update('UPDATE mdjobs_closedshop SET items = ? WHERE job = ? and label = ?', {json.encode(alreadyin), job,Jobs[job]['closedShops'][num].label})
        Log('Added Items to Closed Shop: ' .. job .. ' Name:' .. getName(src), 'closedshop')
    end
end)

lib.callback.register('md-jobs:server:removeItemsFromClosed', function(source, job, loc)
    local src = source
    local location = GetEntityCoords(GetPlayerPed(src))
    if getJobName(src) ~= job then return end
    if #(location - vector3(Jobs[job]['closedShops'][loc].loc.x,Jobs[job]['closedShops'][loc].loc.y,Jobs[job]['closedShops'][loc].loc.z)) < 5.0 then
        local has = MySQL.query.await('SELECT * FROM mdjobs_closedshop WHERE job = ? and label = ?', {job, Jobs[job]['closedShops'][loc].label})
        local data = {}
        local has = json.decode(has[1].items)
        for k, v in pairs (has) do
            table.insert(data, {type = 'number', max = v, min = 0, default = v, item = k, label = GetLabels(k), amount = v})
        end
        sorter(data, 'item')
        local items = lib.callback.await('md-jobs:client:removeItemsFromClosed', src, data)
        if items == nil then return end
        for k, v in pairs (data) do
           if items[k] <= 0 then
                has[v.item] = nil
           else
                if has[v.item] ~= nil then
                    has[v.item] = has[v.item] - items[k]
                    if has[v.item] <= 0 then 
                        has[v.item] = nil
                    end
                    AddItem(src, v.item, items[k])
                end
            end
        end
        MySQL.update('UPDATE mdjobs_closedshop SET items = ? WHERE job = ? and label = ?', {json.encode(has), job, Jobs[job]['closedShops'][loc].label})
        Log('Removed Items from Closed Shop: ' .. job .. ' Name:' .. getName(src), 'closedshop')
    end
end)

lib.callback.register('md-jobs:server:purchaseClosedShops', function(source, job, item, amount, loc, type )
    local src = source
    local location = GetEntityCoords(GetPlayerPed(src))
    local data = Jobs[job]['closedShops']

    if #(location - vector3(data[loc].loc.x, data[loc].loc.y, data[loc].loc.z)) < 5.0 then
        local items = MySQL.query.await('SELECT * FROM mdjobs_closedshop WHERE job = ? and label = ?', {job, data[loc].label})
        local has = json.decode(items[1].items)
        local prices = json.decode(items[1].prices)
        if has[item] >= amount then
            local totalPrice = amount * prices[item]
            if billPlayer(src, type, totalPrice) then
                has[item] = has[item] - amount
                if has[item] <= 0 then has[item] = nil end
                MySQL.update('UPDATE mdjobs_closedshop SET items = ? WHERE job = ? and label = ?', {json.encode(has), job, data[loc].label})
                AddItem(src, item, amount)
                AddJobMoney(job, math.floor(totalPrice * (1 - Config.ClosedShopFee)))
                Notifys(src, s(L.closed.bought, amount, GetLabels(item), totalPrice), 'success')
                Log('Purchased from Closed Shop: ' .. job .. ' Name:' .. getName(src), 'closedshop')
                return true
            else
                Notifys(src, L.Error.too_poor, 'error')
            end
        else
            Notifys(src, L.closed.not_enough_stock 'error')
        end
    end
    return true
end)

lib.callback.register('md-jobs:server:adjustPrices', function(source, job, num)
    local src = source
    local Player = getPlayer(src)
    if not isBoss() then return end
    if getJobName(source) ~= job then return end
    local location = GetEntityCoords(GetPlayerPed(src))
    if #(location - vector3(Jobs[job]['closedShops'][num].loc.x,Jobs[job]['closedShops'][num].loc.y,Jobs[job]['closedShops'][num].loc.z)) < 5.0 then
        local items = MySQL.query.await('SELECT * FROM mdjobs_closedshop WHERE job = ? and label = ?', {job, Jobs[job]['closedShops'][num].label})
        local data = {}
        local has = json.decode(items[1].prices)
        for k, v in pairs (has) do
           table.insert(data, {name = k, amount = v, type = 'number', placeholder = v, min = 0, max = 999999, label = GetLabels(k), default = v})
        end
        sort(data, 'name')
        local updated =  lib.callback.await('md-jobs:client:adjustPrices', src, data)
        if updated == nil then return end
        for k, v in pairs (data) do
            if updated[k] ~= nil then
                has[v.name] = updated[k]
            end
        end
        local update = MySQL.update('UPDATE mdjobs_closedshop SET prices = ? WHERE job = ? and label = ?', {json.encode(has), job, Jobs[job]['closedShops'][num].label})
    end
end)