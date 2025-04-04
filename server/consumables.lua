local consumables = {
    -- Bean Machine
    coffee =             {anim = 'drink', label = 'Drinking', add = {thirst = 10}},
    espresso =           {anim = 'drink', label = 'Drinking', add = {thirst = 10}},
    americano =          {anim = 'drink', label = 'Drinking', add = {thirst = 10}},
    cappuccino =         {anim = 'drink', label = 'Drinking', add = {thirst = 10}},
    caramelmacchiato =   {anim = 'drink', label = 'Drinking', add = {thirst = 10}},
    mochalatte =         {anim = 'drink', label = 'Drinking', add = {thirst = 10}},
    hazelnutlatte =      {anim = 'drink', label = 'Drinking', add = {thirst = 10}},
    vanillafrappe =      {anim = 'drink', label = 'Drinking', add = {thirst = 10}},
    tiramisucoffee =     {anim = 'drink', label = 'Drinking', add = {thirst = 10}},
    almond_croissant =   {anim = 'eat', label = 'Eating', add = {hunger = 5}},
    butter_croissant =   {anim = 'eat', label = 'Eating', add = {hunger = 5}},
    -- burgershot 
 
    ecola =              {anim = 'drink', label = 'Drinking', add = {thirst = 10}},
    sprunk =             {anim = 'drink', label = 'Drinking', add = {thirst = 10}},
    --coffee =             {anim = 'drink', label = 'Drinking', add = {thirst = 10}},
    heartstopper =       {anim = 'eat', label = 'Eating', add = {hunger = 20}}, 
    bleeder =            {anim = 'eat', label = 'Eating', add = {hunger = 20}}, 
    torpedo =            {anim = 'eat', label = 'Eating', add = {hunger = 20}}, 
    moneyshot =          {anim = 'eat', label = 'Eating', add = {hunger = 20}}, 
    bs_nuggets  =        {anim = 'eat', label = 'Eating', add = {hunger = 10}}, 
    bs_fries    =        {anim = 'eat', label = 'Eating', add = {hunger = 10}}, 
   -- hornys

    --ecola =             {anim = 'drink', label = 'Drinking', add = {thirst = 10}},
    --sprunk =            {anim = 'drink', label = 'Drinking', add = {thirst = 10}},
    --coffee =            {anim = 'drink', label = 'Drinking', add = {thirst = 10}},
    bacon_cheese_fries = {anim = 'eat', label = 'Eating', add = {hunger = 15}},
    bacon_cheeseburger = {anim = 'eat', label = 'Eating', add = {hunger = 15}},
    cheese_fries =       {anim = 'eat', label = 'Eating', add = {hunger = 15}},
    sirloin_burger =     {anim = 'eat', label = 'Eating', add = {hunger = 25}},
    basket_fries =       {anim = 'eat', label = 'Eating', add = {hunger = 10}},
    wings =              {anim = 'eat', label = 'Eating', add = {hunger = 15}},
    friedpick =          {anim = 'eat', label = 'Eating', add = {hunger = 10}},

    -- pizzeria

    -- ecola =            {anim = 'drink', label = 'Drinking', add = {thirst = 10}},
    -- sprunk =           {anim = 'drink', label = 'Drinking', add = {thirst = 10}},)
    -- coffee =           {anim = 'drink', label = 'Drinking', add = {thirst = 10}},)
    pepperoni_pizza =    {anim = 'eat', label = 'Eating', add = {hunger = 20}},
    pvegpizza =          {anim = 'eat', label = 'Eating', add = {hunger = 20}},
    sausage_pizza =      {anim = 'eat', label = 'Eating', add = {hunger = 20}},
    pmushroompizza =     {anim = 'eat', label = 'Eating', add = {hunger = 20}},
    pmargharita =        {anim = 'eat', label = 'Eating', add = {hunger = 20}},
    meatlovers_pizza =   {anim = 'eat', label = 'Eating', add = {hunger = 20}},
    caprese_proscuitto = {anim = 'eat', label = 'Eating', add = {hunger = 20}},

    -- pops diner
    --ecola =              {anim = 'drink', label = 'Drinking', add = {thirst = 10}},
    --sprunk =             {anim = 'drink', label = 'Drinking', add = {thirst = 10}},
    --coffee =             {anim = 'drink', label = 'Drinking', add = {thirst = 10}},
    chicken_soup =      {anim = 'eat', label = 'Eating', add = {hunger = 15}},
    chili =             {anim = 'eat', label = 'Eating', add = {hunger = 15}},
    hotdog =            {anim = 'eat', label = 'Eating', add = {hunger = 10}},
    baked_potato =      {anim = 'eat', label = 'Eating', add = {hunger = 15}},
    bacon_eggs =        {anim = 'eat', label = 'Eating', add = {hunger = 20}},
    popsburger =        {anim = 'eat', label = 'Eating', add = {hunger = 25}},
    steak_potato =      {anim = 'eat', label = 'Eating', add = {hunger = 30}},

    -- morpheous pub
    ambeer =            {anim = 'drink', label = 'Drinking', add = {thirst = 10}},
    beer =              {anim = 'drink', label = 'Drinking', add = {thirst = 10}},
    dusche =            {anim = 'drink', label = 'Drinking', add = {thirst = 10}},
    logger =            {anim = 'drink', label = 'Drinking', add = {thirst = 10}},
    patochebeer =       {anim = 'drink', label = 'Drinking', add = {thirst = 10}},
    pisswasser =        {anim = 'drink', label = 'Drinking', add = {thirst = 10}},
    pisswaser_light =   {anim = 'drink', label = 'Drinking', add = {thirst = 10}},
    pisswaser_dark =    {anim = 'drink', label = 'Drinking', add = {thirst = 10}},
   -- coffee =            {anim = 'drink', label = 'Drinking', add = {thirst = 10}},
    onion_rings =       {anim = 'eat',   label = 'Eating', add = {hunger = 10}},
    mozzarella_stick =  {anim = 'eat',   label = 'Eating', add = {hunger = 10}},
    fried_pickles =     {anim = 'eat',   label = 'Eating', add = {hunger = 10}},
    buffalo_wings =     {anim = 'eat',   label = 'Eating', add = {hunger = 15}},
    hamburger =         {anim = 'eat',   label = 'Eating', add = {hunger = 20}},
    veggie_burger =     {anim = 'eat',   label = 'Eating', add = {hunger = 20}},
    vegan_burger =      {anim = 'eat',   label = 'Eating', add = {hunger = 20}},
    chicken_burger =    {anim = 'eat',   label = 'Eating', add = {hunger = 25}},
    steak_sandwich =    {anim = 'eat',   label = 'Eating', add = {hunger = 30}},
    vodka_soda =        {anim = 'drink', label = 'Drinking', add = {thirst = 10}},
    moscow_mule =       {anim = 'drink', label = 'Drinking', add = {thirst = 10}},
    tequila_sunrise =   {anim = 'drink', label = 'Drinking', add = {thirst = 10}},
    whiskey_sour =      {anim = 'drink', label = 'Drinking', add = {thirst = 10}},
    gin_and_tonic =     {anim = 'drink', label = 'Drinking', add = {thirst = 10}},
    rum_and_coke =      {anim = 'drink', label = 'Drinking', add = {thirst = 10}},
    gin_fizz =          {anim = 'drink', label = 'Drinking', add = {thirst = 10}},
    rum_punch =         {anim = 'drink', label = 'Drinking', add = {thirst = 10}},
    mojito =            {anim = 'drink', label = 'Drinking', add = {thirst = 10}},
    daiquiri =          {anim = 'drink', label = 'Drinking', add = {thirst = 10}},

    -- uwu cafe
    -- coffee =            {anim = 'drink', label = 'Drinking', add = {thirst = 10}},
    blueberryuwutea   = {anim = 'drink', label = 'Drinking', add = {thirst = 10}},
    chocouwutea       = {anim = 'drink', label = 'Drinking', add = {thirst = 10}},
    classicuwutea     = {anim = 'drink', label = 'Drinking', add = {thirst = 10}},
    uwuicedcoffee     = {anim = 'drink', label = 'Drinking', add = {thirst = 10}},
    matchTea          = {anim = 'drink', label = 'Drinking', add = {thirst = 10}},
    peachicedtea      = {anim = 'drink', label = 'Drinking', add = {thirst = 10}},
    strawberryuwutea  = {anim = 'drink', label = 'Drinking', add = {thirst = 10}},
    uwukarecurry      = {anim = 'eat', label = 'Eating', add = {hunger = 20}},
    uwuomurice        = {anim = 'eat', label = 'Eating', add = {hunger = 20}},
    uwubentobox       = {anim = 'eat', label = 'Eating', add = {hunger = 20}},
    uwuanpan          = {anim = 'eat', label = 'Eating', add = {hunger = 20}},
    uwudoughnut       = {anim = 'eat', label = 'Eating', add = {hunger = 10}},
    uwucookie         = {anim = 'eat', label = 'Eating', add = {hunger = 10}},
    uwucremecaramel   = {anim = 'eat', label = 'Eating', add = {hunger = 10}},
}

local function handleConsumablePerks(source, type, amount)
    if Config.Framework == 'qb' then 
        local Player = getPlayer(source)
        if type == 'thirst' then
           local meta = Player.PlayerData.metadata
           local old = meta['thirst'] or 0
            local new = old + amount
            if new > 100.0 then new = 100.0 end
            Player.Functions.SetMetaData(type, new)
           -- TriggerClientEvent('hud:client:UpdateNeeds', source, meta.hunger, new)
        elseif type == 'hunger' then
            local Player = getPlayer(source)
            local meta = Player.PlayerData.metadata
            local old = meta['hunger'] or 0
            local new = old + amount
            if new > 100.0 then new = 100.0 end
            Player.Functions.SetMetaData(type, new)
           -- TriggerClientEvent('hud:client:UpdateNeeds', source, new, meta.thirst)
        elseif type == 'stress' then
            local Player = getPlayer(source)
            local meta = Player.PlayerData.metadata
            local old = meta['stress'] or 0
            local new = old + amount
            if new > 100.0 then new = 0.0 end
            Player.Functions.SetMetaData(type, new)
           -- TriggerClientEvent('hud:client:UpdateStress', source, new)
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

for k, v in pairs (consumables) do
    CUI(k, function(source, item)
        local Player = getPlayer(source)
        if not consumables[k] then return end
        local progressbar = lib.callback.await('md-jobs:client:consume', source, k, v)
        if not progressbar then return end
        if RemoveItem(source, k, 1) then
            for m, d in pairs (v.add) do
               handleConsumablePerks(source, m, d)
            end
        end
    end)
end