local cateringHours = 1 -- how long the catering order is valid for in hours
local cateringDetails = {
    firstname = {'john', 'jane', 'jim', 'jill', 'jack', 'jessie', 'jacob', 'jennifer', 'jason', 'julie', 'mike', 'michelle', 'matt', 'mary', 'mark', 'maria', 'megan', 'mason', 'melissa', 'max', 'molly', 'miles', 'michelle', 'mitch'},
    lastname = {'smith', 'johnson', 'williams', 'jones', 'brown', 'davis', 'miller', 'wilson', 'moore', 'taylor', 'anderson', 'thomas', 'jackson', 'white', 'harris', 'martin', 'thompson', 'garcia', 'martinez', 'robinson', 'clark', 'rodriguez', 'lewis', 'lee', 'walker', 'hall', 'allen', 'young', 'hernandez', 'king', 'wright', 'lopez', 'hill', 'scott', 'green', 'adams', 'baker', 'gonzalez', 'nelson', 'carter', 'mitchell', 'perez', 'roberts', 'turner', 'phillips', 'campbell', 'parker', 'evans', 'edwards', 'collins', 'stewart', 'sanchez', 'morris', 'rogers', 'reed', },
    locations = {
        {loc = vector4(321.72, -559.07, 28.74, 28.78),   label = 'Pillbox Hospital',            model = 's_m_m_doctor_01'},
        {loc = vector4(-4.93, -1107.83, 29.0, 161.55),   label = 'Ammunation',                  model = 's_m_y_ammucity_01' },
        {loc = vector4(-1083.0, -248.0, 37.76, 0.0),     label = 'Weazel News',                 model = 'cs_priest'},
        {loc = vector4(433.9, -977.89, 30.71, 75.57),    label = 'Police Station',              model = 'cs_priest'},
        {loc = vector4(236.56, -409.57, 47.92, 337.28),  label = 'Courthouse',                  model = 's_m_m_janitor'},
        {loc = vector4(-1681.28, -290.94, 51.88, 231.5), label = 'Sister Deloris Gospel Choir', model = 'cs_priest'},
        {loc = vector4(217.99, -1647.05, 29.79, 320.57), label = 'Fire Department',             model = 's_m_y_fireman_01'},
        {loc = vector4(897.7, -174.69, 73.81, 236.47),   label = 'Taxi Depot',                  model = 's_m_m_janitor'},
        {loc = vector4(559.23, 2741.34, 42.2, 186.05),   label = 'Animal Shop',                 model = 's_m_m_janitor'},
        {loc = vector4(1216.86, 2727.55, 38.0, 177.02),  label = 'Larrys Auto Sales',           model = 'csb_cletus'},
        {loc = vector4(-1043.68, 4918.7, 208.32, 277.83),label = 'Children Of The Son',         model = 'a_m_y_acult_01'},
        {loc = vector4(1696.03, 4783.06, 42.0, 100.48),  label = 'Arcade',                      model = 's_m_y_clown_01'},
        {loc = vector4(-50.08, 6361.62, 31.51, 223.2),   label = 'Feed And Supplies',           model = 'a_m_m_salton_02'},
    }
}
-- this helps allow some jobs to have catering while others do not 
local cater = {}
for k, v in pairs (Jobs) do
    if v.CateringEnabled then
        cater[k] = v.catering
    else
        cater[k] = false
    end
end
GlobalState.Cater = cater

local function generateDetail()
    local firstname = cateringDetails.firstname[math.random(1, #cateringDetails.firstname)]
    local lastname = cateringDetails.lastname[math.random(1, #cateringDetails.lastname)]
    local location = cateringDetails.locations[math.random(1, #cateringDetails.locations)]
    local time = (os.time() + 3600) * cateringHours
    return {firstname = firstname, lastname = lastname, location = location, dueby = time}
end

local function getWeight(item)
    if Config.Inv == 'ox' then 
        local Items = exports.ox_inventory:Items()
        if Items[item] then
            return Items[item].weight
        end
    elseif Config.Inv == 'qb' then
        if QBCore.Shared.Items[item] then
            return QBCore.Shared.Items[item].weight
        end
    end
end

function generateCatering(src, job)
    local has = MySQL.query.await('SELECT * FROM mdjobs_catering WHERE job = ?', {job})
    if has[1] then Notifys(src, L.cater.already, 'error') return false end
    local employees = {{name = getName(src), cid = getCid(src)}}
    local items = math.random(1, 5)
    local data, totals = {}, {price = 0, amount = 0}
    local detail = generateDetail()
    local weight = 0
    repeat
        Wait(100)
        local git = Jobs[job].catering.items[math.random(1, #Jobs[job].catering.items)]

        local amount = math.random(1, git.maxAmount)
        weight = weight + (getWeight(git.name) * amount)
        if weight > Config.MaxCateringWeight then items = 0 end
        if items == 0 then break end
        local price = math.random(git.minPrice, git.maxPrice) * amount
        local found = false
        for k, v in ipairs(data) do
            if v.item == git.name then
                v.amount = v.amount + amount
                v.price = v.price + price
                found = true
                break
            end
        end
        if not found then
            table.insert(data, {item = git.name, amount = amount, price = price})
        end
        totals.amount = totals.amount + amount
        totals.price = totals.price + price
        Wait(100)
        items = items - 1
    until items == 0
    MySQL.query.await('INSERT INTO mdjobs_catering (data, job, time,totals, details, employees) VALUES (?, ?, ?, ?, ?, ?)', 
    {json.encode(data), job, os.time(), json.encode(totals), json.encode(detail), json.encode(employees)})
    Log('Catering Order Created: ' .. job .. ' Name:' .. getName(src), 'catering')
    return true
end


lib.callback.register('md-jobs:server:startCatering', function(source,job)
    local Job = getJobName(source)
    if Job ~= job then return false end
    return generateCatering(source, job)
end)

lib.callback.register('md-jobs:server:checkCatering', function(source,job)
    local Job = getJobName(source)
    if Job ~= job then return false end

    local data = MySQL.query.await('SELECT * FROM mdjobs_catering WHERE job = ?', {job})
    if not data then return end
    Log('Catering Order Checked: ' .. job .. ' Name:' .. getName(source), 'catering')
    return data[1], os.time()

end)

lib.callback.register('md-jobs:server:getCateringInfo', function(source, job)
    if getJobName(source) ~= job then return end
    local data = MySQL.query.await('SELECT * FROM mdjobs_catering WHERE job = ?', {job})
    if not data[1] then return end
    Log('Catering Order Checked: ' .. job .. ' Name:' .. getName(source), 'catering')
    return data[1], os.time()
end)

lib.callback.register('md-jobs:server:addtoCatering', function(source, job)
    if getJobName(source) ~= job then return end
    local data = MySQL.query.await('SELECT * FROM mdjobs_catering WHERE job = ?', {job})
    if not data[1] then Notifys(source, L.cater.no_cater, 'error') return false end
    local emp = json.decode(data[1].employees) or json.decode(data.employees)
    local mew = {}
    local already = false
    for i = 1, #emp do
        if emp[i].cid == getCid(source) then
            already = true
            break
        end
    end
    if already then Notifys(source, L.cater.already_on, 'error') return false end
    for i = 1, #emp do
        table.insert(mew, {cid = emp[i].cid, name = emp[i].name})
    end
    table.insert(mew, {cid = getCid(source), name = getName(source)})
    MySQL.query('UPDATE mdjobs_catering SET employees = ? WHERE job = ?', {json.encode(mew), job})
    Log('Catering Order Added Employee: ' .. job .. ' Name:' .. getName(source), 'catering')
    return true
end)

lib.callback.register('md-jobs:server:getCateringHistory', function(source, job)
    if getJobName(source) ~= job then return end
    local data = MySQL.query.await('SELECT * FROM mdjobs_completed_catering WHERE job = ?', {job})
    if not data[1] then return end
    Log('Catering Order History Checked: ' .. job .. ' Name:' .. getName(source), 'catering')
    return data
end)

lib.callback.register('md-jobs:server:cateringVan', function(source, job)
    if getJobName(source) ~= job then return end
    local tb = Jobs[job]['catering'].Van[job]
    local van = CreateVehicle(tb.model, tb.loc.x, tb.loc.y, tb.loc.z, tb.loc.w, true, true)
    SetVehicleNumberPlateText(van, tb.plate)
    SetEntityHeading(van, tb.loc.w)
    Log('Catering Order Van Made: ' .. job .. ' Name:' .. getName(source), 'catering')
    return Jobs[job]['catering'].Van
end)

lib.callback.register('md-jobs:server:stopCatering', function(source, job)
    if getJobName(source) ~= job then return end
    MySQL.query('DELETE FROM mdjobs_catering WHERE job = ?', {job})
    Log('Catering Order Deleted: ' .. job .. ' Name:' .. getName(source), 'catering')
    return true
end)

local function handleMoney(src, price, cids)
    local com = Jobs[getJobName(src)].catering.commission or 0
    local commissionTotal = math.floor(price * com)
    local commissionPer = math.floor(commissionTotal / #cids)
    local total = math.floor(price - commissionTotal)
    for k, v in pairs (cids) do 
        local src = getSource(v.cid)
        addMoney(src, commissionPer)
    end
    Log('Catering Order Commission paid: ' .. getJobName(src) .. ' Name:' .. getName(src), 'catering')
    AddJobMoney(getJobName(src), total)
end

lib.callback.register('md-jobs:server:deliverCatering', function(source, job)
    if getJobName(source) ~= job then return end
    local data = MySQL.query.await('SELECT * FROM mdjobs_catering WHERE job = ?', {job})
    if not data[1] then return end
    local price = json.decode(data[1].totals)
    local employees = json.decode(data[1].employees)
    local items = json.decode(data[1].data)
    local details = json.decode(data[1].details)
    local need, have = 0, 0
    for k, v in pairs (items) do
        local needs = hasItem(source, v.item, v.amount)
        if needs then
            have = have + 1
        end
        need = need + 1
    end
    if need ~= have then
        Notifys(source, L.cater.dontHave, 'error')
        return false
    else
        for k, v in pairs (items) do
            RemoveItem(source, v.item, v.amount)
        end
        handleMoney(source, price.price, employees)
        MySQL.query('DELETE FROM mdjobs_catering WHERE job = ?', {job})
        local customer = {name =details.firstname .. ' ' ..details.lastname, label =details.location.label}
        MySQL.query.await('INSERT INTO mdjobs_completed_catering (job, receipt, employees, totals, customer) VALUES (?, ?, ?, ?, ?)', 
        {job, json.encode(items), data[1].employees, json.encode(price), json.encode(customer)})
        Notifys(source, 'You Have Delivered The Catering Order!', 'success')
        Log('Catering Order Delivered: ' .. job .. ' Name:' .. getName(source), 'catering')
        return true
    end
end)