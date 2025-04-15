--https://www.gta5-mods.com/maps/mlo-burgershot-2023-add-on-sp-fivem
local jobloc = 'burgershot'

Jobs['burgershot'] = {
    CateringEnabled = true,
    closedShopsEnabled = true,
    Blip = {
        {sprite = 106, color = 2, scale = 0.5, label = 'Burger Shot', loc = vector3(-1191.14, -897.66, 13.35)},
    },
    closedShops = {
        {ped = 'mp_m_freemode_01', loc = vector4(-1179.12, -890.81, 13.76, 305.83), label = 'Uwu Cafe Shop'}
    },
    closedShopItems = {
        bs_fries = {name = 'bs_fries', price = 5},
        bs_nuggets = {name = 'bs_nuggets', price = 5},
        bs_heartstopper = {name = 'bs_heartstopper', price = 5},
        bs_bleeder = {name = 'bs_bleeder', price = 5},
        bs_torpedo = {name = 'bs_torpedo', price = 5},
        bs_moneyshot = {name = 'bs_moneyshot', price = 5},
        bs_heartstopper_meal = {name = 'bs_heartstopper_meal', price = 5},
        bs_nugget_meal = {name = 'bs_nugget_meal', price = 5},
        bs_torpedo_meal = {name = 'bs_torpedo_meal', price = 5},
        bs_moneyshot_meal = {name = 'bs_moneyshot_meal', price = 5},
        sprunk = {name = 'sprunk', price = 5},
        ecola = {name = 'ecola', price = 5},
    },
    craftingStations = {
        soda = {
            { anim = 'uncuff', give = {}, take = {ecola = 1}, progtext = 'Pouring' },
            { anim = 'uncuff', give = {}, take = { sprunk = 1 }, progtext = 'Pouring' },             
        },
        coffee = {
            { anim = 'uncuff', give = {}, take = { coffee = 1 }, progtext = 'Pouring' } 
        },
        fryer = {            
            { anim = 'uncuff', give = { frozen_fries = 1, cooking_oil = 1 },    take = { bs_fries = 1 }, progtext = 'Cooking' },
            { anim = 'uncuff', give = { frozen_nuggets = 1, cooking_oil = 1 },  take = { bs_nuggets = 1 }, progtext = 'Cooking' }     
        },
        cuttingboard = {
            { anim = 'uncuff', give = { tomato = 1 }, take = { sliced_tomato = 1 }, progtext = 'Chopping' },
            { anim = 'uncuff', give = { onion = 1  }, take = { sliced_onion = 1 },  progtext = 'Chopping' }
        },
        grill = {
            { anim = 'uncuff', give = { burger_patty = 1 }, take = { burger_meat = 1 }, progtext = 'Grilling' },
            { anim = 'uncuff', give = { raw_chicken = 1 }, take = { cooked_chicken = 1 }, progtext = 'Cooking' }
        },
        assembly = {
            { anim = 'uncuff', give = { burger_bun = 1, burger_meat = 1, sliced_tomato = 1, lettuce = 1, sliced_onion = 1, burger_cheese = 1 }, take = { bs_heartstopper = 1 }, progtext = 'Using' },
            { anim = 'uncuff', give = { burger_bun = 1, burger_meat = 1, sliced_tomato = 1, lettuce = 1, sliced_onion = 1, burger_cheese = 1 }, take = { bs_bleeder = 1 }, progtext = 'Using' },
            { anim = 'uncuff', give = { burger_bun = 1, cooked_chicken = 1, sliced_tomato = 1, lettuce = 1, sliced_onion = 1, burger_cheese = 1 }, take = { bs_torpedo = 1 }, progtext = 'Using' },
            { anim = 'uncuff', give = { burger_bun = 1, burger_meat = 1, sliced_tomato = 1, lettuce = 1, sliced_onion = 1, burger_cheese = 1 }, take = { bs_moneyshot = 1 }, progtext = 'Using' },
            { anim = 'uncuff', give = { bs_heartstopper = 1, bs_fries = 1, sprunk = 1 }, take = { bs_heartstopper_meal = 1 }, progtext = 'Using' },
            { anim = 'uncuff', give = { bs_moneyshot = 1, bs_fries = 1, ecola = 1 }, take = { bs_moneyshot_meal = 1 }, progtext = 'Using' },
            { anim = 'uncuff', give = { bs_nuggets = 1, bs_fries = 1, sprunk = 1 }, take = { bs_nugget_meal = 1 }, progtext = 'Using' },
            { anim = 'uncuff', give = { bs_torpedo = 1, bs_fries = 1, ecola = 1 }, take = { bs_torpedo_meal = 1 }, progtext = 'Using' }
        }        
    },
    catering = {
            commission = 0.2,
            items = {
                {name = 'vodka',        minPrice = 10, maxPrice = 20, maxAmount = 30},
                {name = 'tequila',      minPrice = 10, maxPrice = 20, maxAmount = 30},
            },
            Van = {
                vu = {model = 'burrito', label = 'Burrito', plate = 'TEQCATER', loc = vector4(-563.02, 287.51, 82.39, 180.0), heading = 28.78},
            }

    },
    shops = {
        fridge = {
            { name = 'frozen_fries', price = 3,  amount = 50, },
            { name = 'frozen_nuggets', price = 3,  amount = 50, },
            { name = 'burger_patty', price = 2,  amount = 50, },
            { name = 'raw_chicken', price = 1,  amount = 50, },
            { name = 'burger_cheese', price = 1,  amount = 50, },
        },
        ingridients = {

            { name = 'burger_bun', price = 1, amount = 50 },
            {name = 'cooking_oil', price = 2, amount = 50},
            {name = 'lettuce', price = 1, amount = 50},
            {name = 'tomato', price = 1, amount = 50},
            {name = 'onion', price = 1, amount = 50},
        }
    },
    locations = {
        Crafter = {
            {CraftData = {type = 'soda', targetLabel = 'Pour Drinks', menuLabel = 'Pour Drinks'},
                loc = vector3(-1190.71, -898.77, 13.97), l = 0.65, w = 0.5, lwr = 0.25, upr = 0.25, r = 180, job = jobloc},
            {CraftData = { type = 'coffee', targetLabel = 'Pour Coffee', menuLabel = 'Pour Coffee'},
                loc = vector3(-1190.71, -898.77, 13.97), l = 0.7, w = 0.6, lwr = 0.25, upr = 0.25, r = 180, job = jobloc},
            {CraftData = { type = 'fryer', targetLabel = 'Fry', menuLabel = 'Fry'},
                loc = vector3(-1196.42, -899.86, 13.91), l = 0.75, w = 0.5, lwr = 0.5, upr = 0.5, r = 180, job = jobloc},
            {CraftData = { type = 'grill', targetLabel = 'Grill', menuLabel = 'Grill'},
                loc = vector3(-1196.06, -897.27, 14.20), l = 2.0, w = 0.7, lwr = 0.5, upr = 0.5, r = 180, job = jobloc},
            {CraftData = { type = 'cuttingboard', targetLabel = 'Chop', menuLabel = 'Chop'},
                loc = vector3(-1201.40, -894.98, 13.80), l = 2.5, w = 2.5, lwr = 0.10, upr = 0.25, r = 180, job = jobloc},
            {CraftData = { type = 'assembly', targetLabel = 'Assemble', menuLabel = 'Assemble'},
                loc = vector3(-1201.40, -894.98, 13.80), l = 2.7, w = 1.4, lwr = 0.5, upr = 0.5, r = 180, job = jobloc},
        },
        Stores = {
            {StoreData = {type = 'fridge', targetLabel = 'Fridge', menuLabel = 'Fridge'},
                loc = vector3(-1196.06, -897.27, 14.20), l = 0.7, w = 0.5, lwr = 0.75, upr = 1.25, r = 180, job = jobloc},
            {StoreData = {type = 'ingridients', targetLabel = 'Ingridients', menuLabel = 'Ingridients'},
                loc = vector3(-1196.06, -897.27, 14.20), l = 0.7, w = 0.5, lwr = 0.75, upr = 1.25, r = 180, job = jobloc},
        },
       Tills = {
            { loc = vector3(-1197.47, -892.64, 14.0), l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 168.27, commission = 0.2, job = jobloc },
            { loc = vector3(-1195.57, -893.16, 14.0), l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 163.01, commission = 0.2, job = jobloc },
            { loc = vector3(-1193.41, -893.74, 14.0), l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 165.65, commission = 0.2, job = jobloc },
            { loc = vector3(-1191.62, -894.18, 14.0), l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 162.22, commission = 0.2, job = jobloc }  
       },
        trays = { -- storages to place things for people
            {label = 'Grab Food',loc = vec3(-1190.78, -894.45, 14.0), l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 180, slots = 6, weight = 30000, job = jobloc},
            {label = 'Grab Food',loc = vec3(-1192.97, -893.81, 14.0), l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 180, slots = 6, weight = 30000, job = jobloc},
            {label = 'Grab Food',loc = vec3(-1194.93, -893.41, 14.0), l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 180, slots = 6, weight = 30000, job = jobloc},
            {label = 'Grab Food',loc = vec3(-1196.44, -892.81, 14.0), l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 180, slots = 6, weight = 30000, job = jobloc},
            },
        stash = { -- storages to place things
            {label = 'Store Products', loc = vector3(-1194.99, -896.28, 14.13), l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 180, slots = 100, weight = 600000, job = jobloc},  
            {label = 'Store Products', loc = vector3(-1195.96, -902.59, 13.85), l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 180, slots = 100, weight = 600000, job = jobloc},
        },
 
    },
    consumables = {
        bs_bleeder = {anim = 'eat', label = 'Eating', add = {hunger = 10}},
        bs_fries = {anim = 'eat', label = 'Eating', add = {hunger = 5}},
        bs_heartstopper = {anim = 'eat', label = 'Eating', add = {hunger = 10}},
        bs_heartstopper_meal = {anim = 'eat', label = 'Consuming', add = {hunger = 25, thirst = 10}},
        bs_moneyshot = {anim = 'eat', label = 'Eating', add = {hunger = 10}},
        bs_moneyshot_meal = {anim = 'eat', label = 'Eating', add = {hunger = 25, thirst = 10}},
        bs_nuggets = {anim = 'eat', label = 'Eating', add = {hunger = 10}},
        bs_nugget_meal = {anim = 'eat', label = 'Eating', add = {hunger = 25, thirst = 10}},
        bs_torpedo = {anim = 'eat', label = 'Eating', add = {hunger = 10}},
        bs_torpedo_meal = {anim = 'eat', label = 'Eating', add = {hunger = 25, thirst = 10}},
        ecola = {anim = 'drink', label = 'Drinking', add = {thirst = 10}},
        sprunk = {anim = 'drink', label = 'Drinking', add = {thirst = 10}},
    },
}