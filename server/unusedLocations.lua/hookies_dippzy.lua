-- https://dipzzy.tebex.io/category/free
Jobs['hookies'] = {
    CateringEnabled = true,
    closedShopsEnabled = true,
    Blip = {
        {sprite = 214, color = 2, scale = 0.5, label = 'Hookies', loc = vector3(-2187.99, 4290.71, 49.17)},
    },
    closedShops = {
        {ped = 'mp_m_freemode_01', loc = vector4(-2191.84, 4285.16, 49.18, 154.88), label = 'Hookies Shop'}
    },
    closedShopItems = {
        coffee         =   {name = 'coffee',            price = 5},
        banana_smoothie = {name = 'banana_smoothie',   price = 5},
        blueberry_smoothie = {name = 'blueberry_smoothie', price = 5},
        strawberry_smoothie = {name = 'strawberry_smoothie', price = 5},
        mango_smoothie  = {name = 'mango_smoothie',    price = 5},
        pomegranate_smoothie = {name = 'pomegranate_smoothie', price = 5},
        lemonade       = {name = 'lemonade',          price = 5},
        limeade        = {name = 'limeade',           price = 5},
    },
    catering = {
        commission = 0.2,
        items = {

        },
        Van = {
            hookies = {model = 'burrito', label = 'Burrito', plate = 'Hookies', loc = vector4(-2178.88, 4266.74, 49.02, 125.58), heading = 125.0},
        }
    },
    craftingStations = {
        coffee = {
            {anim = 'uncuff',give = {}, take = {coffee=1}, progtext = 'Pouring' },
        },
        soda = {
            {anim = 'uncuff', give = {}, take = {ecola=1}, progtext = 'Pouring' },
            {anim = 'uncuff', give = {}, take = {sprunk=1}, progtext = 'Pouring' },
        },
        beer = {
            {anim = 'uncuff',give = {}, take = {ambeer = 1}, progtext = 'Pouring' },
            {anim = 'uncuff',give = {}, take = {beer = 1}, progtext = 'Pouring' },
            {anim = 'uncuff',give = {}, take = {dusche = 1}, progtext = 'Pouring' },
            {anim = 'uncuff',give = {}, take = {logger = 1}, progtext = 'Pouring' },
            {anim = 'uncuff',give = {}, take = {patochebeer = 1}, progtext = 'Pouring' },
            {anim = 'uncuff',give = {}, take = {pisswaser = 1}, progtext = 'Pouring' },
            {anim = 'uncuff',give = {}, take = {pisswaser_light = 1}, progtext = 'Pouring' },
            {anim = 'uncuff',give = {}, take = {pisswaser_dark = 1}, progtext = 'Pouring' },
        },
        cuttingboard = {
            {anim = 'uncuff', give = {onion = 1}, take = {sliced_onion = 1}, progtext = 'Chopping' },
            {anim = 'uncuff', give = {tomato = 1}, take = {sliced_tomato = 1}, progtext = 'Chopping' },
            {anim = 'uncuff', give = {potato = 1}, take = {uncooked_fries = 1}, progtext = 'Chopping'},
            {anim = 'uncuff', give = {fish = 1}, take = {fish_fillet = 1}, progtext = 'Chopping' },
        },
        grill = {
            {anim = 'uncuff', give = {fish_fillet = 1}, take = {grilled_fish = 1}, progtext = 'Grilling' },
            {anim = 'uncuff', give = {lobster = 1}, take = {seafood_lobster_plate = 1}, progtext = 'Grilling' },
            {anim = 'uncuff', give = {bread = 1, snowcrab = 1}, take = {seafood_crabcakes = 1}, progtext = 'Grilling' },
        },
        stove = {
            {anim = 'uncuff', give = {sliced_onion = 1, sliced_tomato = 1, cooked_fish = 1, tortilla = 1}, take = {fish_taco = 1}, progtext = 'Cooking' },
            {anim = 'uncuff', give = {uncooked_fries = 1,  fish = 1}, take = {fishchips = 1}, progtext = 'Cooking' },
            {anim = 'uncuff', give = {fish_fillet = 1, uncooked_fries = 1}, take = {seafood_batter_fish = 1}, progtext = 'Cooking' },
        },
        wine = {
            {anim = 'uncuff', give = {}, take = {pinot_grigio = 1}, progtext = 'Pouring' },
            {anim = 'uncuff', give = {}, take = {chardoney = 1}, progtext = 'Pouring' },
           
        }
    },
    shops = {
        ingridients={
            {name = 'fish',            price = 2, amount = 50},
            {name = 'lobster',         price = 10, amount = 50},
            {name = 'bread',           price = 1, amount = 50},
            {name = 'tortilla',       price = 1, amount = 50},
            {name = 'onion',          price = 1, amount = 50},
            {name = 'tomato',         price = 1, amount = 50},
            {name = 'potato',         price = 1, amount = 50},
            {name = 'snowcrab',      price = 15, amount = 50},
        },
    },
    locations = {
        Crafter = {
            {CraftData = {type = 'beer', targetLabel = 'Pour Beer', menuLabel = 'Pour Beer!'},
            loc = vector3(-2181.93, 4288.56, 49.68),  l = 0.5, w = 0.7, lwr = 0.10, upr = 0.35, r = 160, job = 'hookies'},
            {CraftData = {type = 'soda', targetLabel = 'Pour Soda', menuLabel = 'Pour Soda!'},
            loc = vector3(-2187.25, 4284.09, 49.48),  l = 0.5, w = 0.7, lwr = 0.10, upr = 0.35, r = 160, job = 'hookies'},
            {CraftData = {type = 'cuttingboard', targetLabel = 'Chop Food', menuLabel = 'Chop Food!'},
            loc = vector3(-2177.39, 4278.91, 49.28),  l = 0.5, w = 0.5, lwr = 0.10, upr = 0.35, r = 150, job = 'hookies'},
            {CraftData = {type = 'coffee', targetLabel = 'Pour Coffee', menuLabel = 'Pour Coffee!'},
                loc = vector3(-2180.06, 4286.7, 49.23),l = 0.5, w = 0.5, lwr = 0.10, upr = 0.35, r = 150, job = 'hookies'},
            {CraftData = {type = 'grill', targetLabel = 'Grill Food', menuLabel = 'Grill Food!'},
                loc = vector3(-2177.01, 4280.08, 49.28),l = 0.5, w = 0.5, lwr = 0.10, upr = 0.35, r = 150, job = 'hookies'},
            {CraftData = {type = 'stove', targetLabel = 'Cook Food', menuLabel = 'Cook Food!'},
                loc = vector3(-2178.51, 4286.02, 49.11),l = 1.0, w = 1.0, lwr = 0.10, upr = 0.35, r = 150, job = 'hookies'},
            {CraftData = {type = 'wine', targetLabel = 'Pour Wine', menuLabel = 'Pour Wine!'},
                loc = vector3(-2186.62, 4284.59, 48.72),l = 1.0, w = 1.0, lwr = 0.10, upr = 0.35, r = 150, job = 'hookies'},
        },
        Stores = {
            {StoreData = {type = 'ingridients', targetLabel = 'Ingridient Shop', menuLabel = 'Ingridient Shop'},
                loc =  vector3(-2180.54, 4279.42, 49.32),l = 0.5, w = 1.0, lwr = 0.5, upr = 1.0, r = 150, job = 'hookies'},
        },
        Tills = {
            {loc = vector3(-2184.21, 4289.11, 49.59), l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 150,  commission = 0.2, job = 'limeys'},
            {loc = vector3(-2185.37, 4287.15, 49.59), l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 150,  commission = 0.2, job = 'limeys'},
            {loc = vector3(-2186.56, 4285.18, 49.59), l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 150,  commission = 0.2, job = 'limeys'},
        },
        stash = {
            {label = 'Open Stash', loc = vector3(-2185.47, 4286.59, 48.76), l = 0.75, w = 2.5, lwr = 0.50, upr = 0.50, r = 150, slots = 20, weight = 100000, job = 'limeys'},
        },
        trays = {
            {prop = 'prop_food_tray_01', label = 'Grab Drinks!', loc = vector3(253.71, -1021.59, 29.5),  l = 0.5, w = 0.5, lwr = 0.25, upr = 0.25, r = 160, slots = 20, weight = 100000, job = 'tequilala'},
        }
    }
}