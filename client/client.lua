local props = {}
CreateThread(function()
    local locs = lib.callback.await('md-jobs:server:getLocations', false)
    for k, v in pairs (locs) do
        if v.Crafter then
            for m, d in pairs(v.Crafter) do
                if not d.CraftData.targetLabel then d.CraftData.targetLabel = 'Craft' end
                if not d.CraftData.menuLabel then d.CraftData.menuLabel = 'Craft' end
                local ops = {
                    {icon = Icons.crafter, label = d.CraftData.targetLabel, action = function() makeCrafter(d.CraftData.type, d.CraftData.menuLabel, k, m) end, canInteract = function() return hasJob(k) end},
                }
                if d.CraftData.prop ~= nil then
                    local number = #props + 1
                    lib.requestModel(d.CraftData.prop)
                    props[#props + 1] = CreateObject(d.CraftData.prop, d.loc.x,d.loc.y,d.loc.z, false, false, false)
                    SetEntityHeading(props[number], d.CraftData.heading + 0.0)
                    FreezeEntityPosition(props[number], true)
                    SetEntityInvincible(props[number], true)
                    AddTargModel(props[number], ops)
                else
                    AddBoxZone('craft' .. k .. m, d, ops)
                end
            end
        end
        if v.Stores then
            for m, d in pairs(v.Stores) do
                if not d.StoreData.targetLabel then d.StoreData.targetLabel = 'Open Shop' end
                if not d.StoreData.menuLabel then d.StoreData.menuLabel = 'Open Shop' end
                local ops = {
                    {icon = Icons.store, label = d.StoreData.targetLabel, action = function() makeStore(d.StoreData.type, k, d.StoreData.menuLabel, m) end, canInteract = function() return hasJob(k) end},
                }
                if d.StoreData.prop ~= nil then
                    local number = #props + 1
                    lib.requestModel(d.StoreData.prop)
                    props[number] = CreateObject(d.StoreData.prop, d.loc.x,d.loc.y,d.loc.z, false, false, false)
                    SetEntityHeading(props[number], d.r + 0.0)
                    FreezeEntityPosition(props[number], true)
                    SetEntityInvincible(props[number], true)
                    AddTargModel(props[number], ops)
                else
                    AddBoxZone('store' .. k .. m, d, ops)
                end
            end
        end
        if v.Tills then
            for m, d in pairs(v.Tills) do
                
                local ops = {
                    {icon = Icons.till, label = L.T.till, action = function() TriggerServerEvent('md-jobs:server:billPlayer', k, m) end, canInteract = function() return hasJob(k) end},
                    {icon = Icons.till, label = L.T.managecat, action = function() manageCatering(k) end, canInteract = function() return hasJob(k) and GlobalState.Cater[k] end},
                    {icon = Icons.till, label = L.T.boss, action = function() openBossMenu(k) end, canInteract = function() return isBoss() and hasJob(k) end}
                }
                if d.prop ~= nil then
                    lib.requestModel(d.prop)
                    local number = #props + 1
                    props[number] = CreateObject(d.prop, d.loc.x,d.loc.y,d.loc.z, false, false, false)
                    SetEntityHeading(props[number], d.r + 0.0)
                    FreezeEntityPosition(props[number], true)
                    SetEntityInvincible(props[number], true)
                    AddTargModel(props[number], ops)
                else
                    AddBoxZone('till' .. k .. m, d, ops)
                end
            end
        end
        if v.stash then 
            for m, d in pairs(v.stash) do
                if d.label == nil then d.label = 'Open Stash' end
                local ops = {
                    {icon = Icons.stash, label = d.label, action = function() openStash(k .. ' stash ' .. m, d.weight, d.slot, m, k) end, canInteract = function() return hasJob(k) end}
                }
                if d.prop ~= nil then
                    local number = #props + 1
                    lib.requestModel(d.prop)
                    props[number] = CreateObject(d.prop, d.loc.x,d.loc.y,d.loc.z, false, false, false)
                    SetEntityHeading(props[number], d.r + 0.0)
                    FreezeEntityPosition(props[number], true)
                    SetEntityInvincible(props[number], true)
                    AddTargModel(props[number], ops)
                else
                    AddBoxZone('stash' .. k .. m, d, ops)
                end
            end
        end
        if v.trays then 
            for m, d in pairs(v.trays) do
                if d.label == nil then d.label = 'Grab Items' end
                local ops = {
                    {icon = Icons.trays, label = d.label, action = function() openTray(k .. ' Tray ' .. m, d.weight, d.slot, m, k) end}
                }
                if d.prop ~= nil then
                    lib.requestModel(d.prop)
                    local number = #props + 1
                    props[number] = CreateObject(d.prop, d.loc.x,d.loc.y,d.loc.z, false, false, false)
                    SetEntityHeading(props[number], d.r)
                    FreezeEntityPosition(props[number], true)
                    SetEntityInvincible(props[number], true)
                    AddTargModel(props[number], ops)
                else
                    AddBoxZone('trays' .. k .. m, d, ops)
                end
            end
        end
    end
end)
local blips = {}
local peds = {}
AddEventHandler('onResourceStop', function(resource)
    if resource ~= GetCurrentResourceName() then return end
    for k, v in pairs(props) do
        DeleteEntity(v)
    end
    for k, v in pairs (blips) do
        RemoveBlip(v)
    end
    for k, v in pairs (peds) do
        DeleteEntity(v)
        
    end
    blips = {}
    peds = {}
end)

local function spawnPeds()
    local peds = lib.callback.await('md-jobs:server:getPeds', false)
    for k, v in pairs(peds) do
        lib.requestModel(v.model, 30000)
        peds[k] = CreatePed(0, v.model, v.loc.x, v.loc.y, v.loc.z, v.loc.w, false, false)
        FreezeEntityPosition(peds[k], true)
        SetEntityInvincible(peds[k], true)
        SetBlockingOfNonTemporaryEvents(peds[k], true)
        AddTargModel(peds[k], {
            {icon = Icons.shop, label =  L.T.shop, action = function() openClosedShop(v.job ,v.num) end, canInteract = function() return canOpenClosed(v.job) end,},
            {icon = Icons.shop, label =  L.T.manage, action = function() manageClosed(v.job, v.num) end, canInteract = function() return hasJob(v.job)end,},
        })
    end
end

local function spawnBlips()
    local blipLocs = lib.callback.await('md-jobs:server:getBlips', false)
    for k, v in pairs(blipLocs) do
        blips[k] = AddBlipForCoord(v.loc.x, v.loc.y, v.loc.z)
        SetBlipSprite(blips[k], v.sprite or 52)
        SetBlipDisplay(blips[k], 4)
        SetBlipScale(blips[k], v.scale or 0.8)
        SetBlipColour(blips[k], v.color or 2)
        SetBlipAsShortRange(blips[k], true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.label or 'Lazy Ass')
        EndTextCommandSetBlipName(blips[k])
    end
end

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    spawnBlips()
    spawnPeds()
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
    spawnBlips()
    spawnPeds()
end)