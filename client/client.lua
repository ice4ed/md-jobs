local props = {}
local blips = {}
local peds = {}

--- Spawn peds
--- @return nil
local function spawnPeds()
    local pedConfigs = lib.callback.await('md-jobs:server:getPeds', false)
    for pedIndex, pedInfo in pairs(pedConfigs) do
        lib.requestModel(pedInfo.model, 30000)
        local pedEntity = CreatePed(0, pedInfo.model, pedInfo.loc.x, pedInfo.loc.y, pedInfo.loc.z, pedInfo.loc.w, false,
            false)
        peds[pedIndex] = pedEntity
        FreezeEntityPosition(peds[pedIndex], true)
        SetEntityInvincible(peds[pedIndex], true)
        SetBlockingOfNonTemporaryEvents(peds[pedIndex], true)
        AddTargModel(peds[pedIndex], {
            { icon = Icons.shop, label = L.T.shop,        action = function() OpenClosedShop(pedInfo.job, pedInfo.num) end, canInteract = function() return
                CanOpenClosed(pedInfo.job) end },
            { icon = Icons.shop, label = L.T.manage,      action = function() ManageClosed(pedInfo.job, pedInfo.num) end,   canInteract = function() return
                HasJob(pedInfo.job) end },
            { icon = Icons.shop, label = "Adjust Prices", action = function() AdjustPrices(pedInfo.job, pedInfo.num) end,   canInteract = function() return
                IsBoss() and HasJob(pedInfo.job) end }
        })
    end
end

--- Create blips
--- @return nil
local function spawnBlips()
    local blipConfigs = lib.callback.await('md-jobs:server:getBlips', false)
    for blipIndex, blipInfo in pairs(blipConfigs) do
        blips[blipIndex] = AddBlipForCoord(blipInfo.loc.x, blipInfo.loc.y, blipInfo.loc.z)
        SetBlipSprite(blips[blipIndex], blipInfo.sprite or 52)
        SetBlipDisplay(blips[blipIndex], 4)
        SetBlipScale(blips[blipIndex], blipInfo.scale or 0.8)
        SetBlipColour(blips[blipIndex], blipInfo.color or 2)
        SetBlipAsShortRange(blips[blipIndex], true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(blipInfo.label or 'Lazy Ass')
        EndTextCommandSetBlipName(blips[blipIndex])
    end
end

------------------------
---- Event Handlers ----
------------------------

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    spawnBlips()
    spawnPeds()
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    spawnBlips()
    spawnPeds()
end)

AddEventHandler('onResourceStop', function(resource)
    if resource ~= GetCurrentResourceName() then return end
    for _, prop in pairs(props) do DeleteEntity(prop) end
    for _, blip in pairs(blips) do RemoveBlip(blip) end
    for _, ped in pairs(peds) do DeleteEntity(ped) end
    props = {}
    blips = {}
    peds = {}
end)

-----------------
---- Threads ----
-----------------

CreateThread(function()
    local jobLocations = lib.callback.await('md-jobs:server:getLocations', false)
    for jobName, locationData in pairs(jobLocations) do
        if locationData.Crafter then
            for crafterIndex, crafterEntry in pairs(locationData.Crafter) do
                local craftData = crafterEntry.CraftData
                craftData.targetLabel = craftData.targetLabel or 'Craft'
                craftData.menuLabel = craftData.menuLabel or 'Craft'
                local interactionOptions = {
                    { icon = Icons.crafter, label = craftData.targetLabel, action = function() MakeCrafter(
                        craftData.type, craftData.menuLabel, jobName, crafterIndex) end, canInteract = function() return
                        HasJob(jobName) end }
                }
                if craftData.prop then
                    local propIndex = #props + 1
                    lib.requestModel(craftData.prop)
                    props[propIndex] = CreateObject(craftData.prop, crafterEntry.loc.x, crafterEntry.loc.y,
                        crafterEntry.loc.z, false, false, false)
                    PropsSpawn(props[propIndex], craftData.r or 180.0, interactionOptions)
                else
                    AddBoxZone('craft' .. jobName .. crafterIndex, crafterEntry, interactionOptions)
                end
            end
        end
        if locationData.Stores then
            for storeIndex, storeEntry in pairs(locationData.Stores) do
                local storeData = storeEntry.StoreData
                storeData.targetLabel = storeData.targetLabel or 'Open Shop'
                storeData.menuLabel = storeData.menuLabel or 'Open Shop'
                local interactionOptions = {
                    { icon = Icons.store, label = storeData.targetLabel, action = function() MakeStore(storeData.type,
                            jobName, storeData.menuLabel, storeIndex) end, canInteract = function() return HasJob(
                        jobName) end }
                }
                if storeData.prop then
                    local propIndex = #props + 1
                    lib.requestModel(storeData.prop)
                    props[propIndex] = CreateObject(storeData.prop, storeEntry.loc.x, storeEntry.loc.y, storeEntry.loc.z,
                        false, false, false)
                    PropsSpawn(props[propIndex], storeData.r or 180.0, interactionOptions)
                else
                    AddBoxZone('store' .. jobName .. storeIndex, storeEntry, interactionOptions)
                end
            end
        end
        if locationData.Tills then
            for tillIndex, tillConfig in pairs(locationData.Tills) do
                local interactionOptions = {
                    { icon = Icons.till, label = L.T.till,      action = function() TriggerServerEvent(
                        'md-jobs:server:billPlayer', jobName, tillIndex) end,                                                                                canInteract = function() return
                        HasJob(jobName) end },
                    { icon = Icons.till, label = L.T.managecat, action = function() ManageCatering(jobName) end,                                             canInteract = function() return
                        HasJob(jobName) and GlobalState.Cater[jobName] end },
                    { icon = Icons.till, label = L.T.boss,      action = function() OpenBossMenu(jobName) end,                                               canInteract = function() return
                        IsBoss() and HasJob(jobName) end },
                    { icon = Icons.till, label = 'Toggle Duty', action = function() ToggleDuty() end,                                                        canInteract = function() return
                        HasJob(jobName) end }
                }
                if tillConfig.prop then
                    lib.requestModel(tillConfig.prop)
                    local propIndex = #props + 1
                    props[propIndex] = CreateObject(tillConfig.prop, tillConfig.loc.x, tillConfig.loc.y, tillConfig.loc
                    .z, false, false, false)
                    PropsSpawn(props[propIndex], tillConfig.r or 180.0, interactionOptions)
                else
                    AddBoxZone('till' .. jobName .. tillIndex, tillConfig, interactionOptions)
                end
            end
        end
        if locationData.stash then
            for stashIndex, stashEntry in pairs(locationData.stash) do
                stashEntry.label = stashEntry.label or 'Open Stash'
                local interactionOptions = {
                    { icon = Icons.stash, label = stashEntry.label, action = function() OpenStash(
                        jobName .. ' stash ' .. stashIndex, stashEntry.weight, stashEntry.slot, stashIndex, jobName) end, canInteract = function() return
                        HasJob(jobName) end }
                }
                if stashEntry.prop then
                    lib.requestModel(stashEntry.prop)
                    local propIndex = #props + 1
                    props[propIndex] = CreateObject(stashEntry.prop, stashEntry.loc.x, stashEntry.loc.y, stashEntry.loc
                    .z, false, false, false)
                    PropsSpawn(props[propIndex], stashEntry.r or 180.0, interactionOptions)
                else
                    AddBoxZone('stash' .. jobName .. stashIndex, stashEntry, interactionOptions)
                end
            end
        end
        if locationData.trays then
            for trayIndex, trayConfig in pairs(locationData.trays) do
                trayConfig.label = trayConfig.label or 'Grab Items'
                local interactionOptions = {
                    { icon = Icons.trays, label = trayConfig.label, action = function() OpenTray(
                        jobName .. ' Tray ' .. trayIndex, trayConfig.weight, trayConfig.slot, trayIndex, jobName) end }
                }
                if trayConfig.prop then
                    lib.requestModel(trayConfig.prop)
                    local propIndex = #props + 1
                    props[propIndex] = CreateObject(trayConfig.prop, trayConfig.loc.x, trayConfig.loc.y, trayConfig.loc
                    .z, false, false, false)
                    PropsSpawn(props[propIndex], trayConfig.r or 180.0, interactionOptions)
                else
                    AddBoxZone('trays' .. jobName .. trayIndex, trayConfig, interactionOptions)
                end
            end
        end
    end
end)
