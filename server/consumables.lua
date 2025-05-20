local consumables = {}

local function handleConsumablePerks(playerSrc, statType, changeAmount)
    if Config.Framework == 'qb' or Config.Framework == 'qbx' then
        local player   = GetPlayer(playerSrc)
        if not player then return end
        local metadata = player.PlayerData.metadata
        if statType == 'thirst' then
            local oldValue = metadata.thirst or 0
            local newValue = math.min(oldValue + changeAmount, 100.0)
            player.Functions.SetMetaData('thirst', newValue)
            TriggerClientEvent('hud:client:UpdateNeeds', playerSrc, metadata.hunger, newValue)
        elseif statType == 'hunger' then
            local oldValue = metadata.hunger or 0
            local newValue = math.min(oldValue + changeAmount, 100.0)
            player.Functions.SetMetaData('hunger', newValue)
            TriggerClientEvent('hud:client:UpdateNeeds', playerSrc, newValue, metadata.thirst)
        elseif statType == 'stress' then
            local oldValue = metadata.stress or 0
            local newValue = oldValue + changeAmount
            if newValue > 100.0 then
                newValue = 0.0
            end
            player.Functions.SetMetaData('stress', newValue)
            TriggerClientEvent('hud:client:UpdateStress', playerSrc, newValue)
        end
    elseif Config.Framework == 'esx' then
        if statType == 'thirst' then
            TriggerClientEvent('esx_status:add', playerSrc, 'thirst', changeAmount)
        elseif statType == 'hunger' then
            TriggerClientEvent('esx_status:add', playerSrc, 'hunger', changeAmount)
        elseif statType == 'stress' then
            if changeAmount < 0 then
                TriggerClientEvent('esx_status:remove', playerSrc, 'stress', changeAmount)
            else
                TriggerClientEvent('esx_status:add', playerSrc, 'stress', changeAmount)
            end
        end
    end
end

for _, jobConfig in pairs(Jobs) do
    if jobConfig.consumables then
        for consumableName, consumableData in pairs(jobConfig.consumables) do
            consumables[consumableName] = consumableData
        end
    end
end
for consumableName, consumableData in pairs(consumables) do
    CUI(consumableName, function(playerSrc, _)
        if not consumables[consumableName] then
            return
        end
        local finished = lib.callback.await(
            'md-jobs:client:consume',
            playerSrc,
            consumableName,
            consumableData
        )
        if not finished then
            return
        end
        if not RemoveItem(playerSrc, consumableName, 1) then
            return
        end
        consumableData.add = consumableData.add or {}
        for perkType, perkAmount in pairs(consumableData.add) do
            handleConsumablePerks(playerSrc, perkType, perkAmount)
        end
        if consumableData.action then
            consumableData.action(playerSrc, consumableName)
        end
    end)
end
