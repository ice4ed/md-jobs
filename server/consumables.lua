local consumables = {}

local function handleConsumablePerks(source, type, amount)
    if Config.Framework == 'qb' or Config.Framework == 'qbx' then 
        local Player = getPlayer(source)
        if type == 'thirst' then
           local meta = Player.PlayerData.metadata
           local old = meta['thirst'] or 0
            local new = old + amount
            if new > 100.0 then new = 100.0 end
            Player.Functions.SetMetaData(type, new)
            TriggerClientEvent('hud:client:UpdateNeeds', source, meta.hunger, new)
        elseif type == 'hunger' then
            local Player = getPlayer(source)
            local meta = Player.PlayerData.metadata
            local old = meta['hunger'] or 0
            local new = old + amount
            if new > 100.0 then new = 100.0 end
            Player.Functions.SetMetaData(type, new)
            TriggerClientEvent('hud:client:UpdateNeeds', source, new, meta.thirst)
        elseif type == 'stress' then
            local Player = getPlayer(source)
            local meta = Player.PlayerData.metadata
            local old = meta['stress'] or 0
            local new = old + amount
            if new > 100.0 then new = 0.0 end
            Player.Functions.SetMetaData(type, new)
            TriggerClientEvent('hud:client:UpdateStress', source, new)
        end
    elseif Config.Framework  == 'esx' then 
        if type == 'thirst' then
            TriggerClientEvent('esx_status:add', source, 'thirst', amount)
        elseif type == 'hunger' then
            TriggerClientEvent('esx_status:add', source, 'hunger', amount)
        elseif type == 'stress' then
           if amount < 0 then
                TriggerClientEvent('esx_status:remove', source, 'stress', amount)
            else
                TriggerClientEvent('esx_status:add', source, 'stress', amount)
            end
        end
    end
end

for k, v in pairs (Jobs) do
    if v.consumables then
        for m, d in pairs (v.consumables) do
            consumables[m] = d
        end
    end
end
for k, v in pairs (consumables) do
    CUI(k, function(source, item)
        if not consumables[k] then return end
        local progressbar = lib.callback.await('md-jobs:client:consume', source, k, v)
        if not progressbar then return end
        if RemoveItem(source, k, 1) then
            if next(v.add) then
                for m, d in pairs (v.add) do
                   handleConsumablePerks(source, m, d)
                end
            end
            if v.action then
                v.action(source, k)
            end
        end
    end)
end