-- https://morpheus-construction.tebex.io/package/5517754

Jobs['pub'] = {
    CateringEnabled = true,
    closedShopsEnabled = true,
    Blip = {
        {sprite = 93, color = 2, scale = 0.5, label = 'pub', loc = vector3(-578.47, -695.18, 32.52)},
    },
    closedShops = {
        {ped = 'mp_m_freemode_01', loc = vector4(-578.47, -695.18, 32.52, 180.0), label = 'pub'}
    },
    closedShopItems = {
        ambeer         =   {name = 'ambeer',       price = 5},
        beer           =   {name = 'beer',         price = 5},
        dusche         =   {name = 'dusche',       price = 5},
        logger         =   {name = 'logger',       price = 5},
        patochebeer    =   {name = 'patochebeer',  price = 5},
        pisswasser     =   {name = 'pisswasser',   price = 5},
        pisswaser_light=   {name = 'pisswaser_light',price= 5},
        pisswaser_dark =   {name = 'pisswaser_dark', price= 5}
    },
    craftingStations = {
        beer = {
            {anim = 'uncuff',give = {}, take = {ambeer = 1}, progtext = 'Pouring' },
            {anim = 'uncuff',give = {}, take = {beer = 1}, progtext = 'Pouring' },
            {anim = 'uncuff',give = {}, take = {dusche = 1}, progtext = 'Pouring' },
            {anim = 'uncuff',give = {}, take = {logger = 1}, progtext = 'Pouring' },
            {anim = 'uncuff',give = {}, take = {patochebeer = 1}, progtext = 'Pouring' },
            {anim = 'uncuff',give = {}, take = {pisswsser = 1}, progtext = 'Pouring' },
            {anim = 'uncuff',give = {}, take = {pisswaser_light = 1}, progtext = 'Pouring' },
            {anim = 'uncuff',give = {}, take = {pisswaser_dark = 1}, progtext = 'Pouring' },
        },
        coffee = {
            {anim = 'uncuff',give = {}, take = {coffee = 1}, progtext = 'Pouring' }
        },
        fryer = {
            {anim = 'uncuff', give = {sliced_onion = 1,   batter_mix = 1},    take = {onion_rings = 1}, progtext = 'Frying'},
            {anim = 'uncuff', give = {mozzarella = 1,    batter_mix = 1},    take = {mozzarella_stick = 1}, progtext = 'Frying'},
            {anim = 'uncuff', give = {pickle_slices = 1, batter_mix = 1},    take = {fried_pickles = 1}, progtext = 'Frying'},
            {anim = 'uncuff', give = {raw_chicken_wing = 6,  batter_mix = 2},    take = {buffalo_wings = 1}, progtext = 'Frying'}
        },
        cuttingboard = {
            {anim = 'uncuff',give = {onion = 1},  take = {sliced_onion = 1}, progtext = 'Chopping'},
            {anim = 'uncuff',give = {pickle = 1}, take = {pickle_slices = 1}, progtext = 'Chopping'},
        },
        hotplate = {
            {anim = 'uncuff',give = {burger_patty = 1}, take = {burger_meat = 1}, progtext = 'Grilling'},
            {anim = 'uncuff',give = {veggie_patty = 1}, take = {veggie_meat = 1}, progtext = 'Grilling'},
            {anim = 'uncuff',give = {vegan_patty = 1}, take = {vegan_meat = 1}, progtext = 'Grilling'},
            {anim = 'uncuff',give = {raw_chicken = 1}, take = {cooked_chicken = 1}, progtext = 'Grilling'},
            {anim = 'uncuff',give = {raw_steak = 1}, take = {cooked_steak = 1}, progtext = 'Grilling'},
        },
        ice = {
            {anim = 'uncuff',give = {}, take = {ice = 1}, progtext = 'Grabbing'}
        },
        grill = {
            {anim = 'uncuff',give = {burger_patty = 1, burger_bun = 1, sliced_onion = 1 }, take = {pub_burger = 1}, progtext = 'Using'},
            {anim = 'uncuff',give = {veggie_meat = 1, burger_bun = 1, sliced_onion = 1 }, take = {veggie_burger = 1}, progtext = 'Using'},
            {anim = 'uncuff',give = {vegan_meat = 1,  burger_bun = 1, sliced_onion = 1 }, take = {vegan_burger = 1}, progtext = 'Using'},
            {anim = 'uncuff',give = {cooked_chicken = 1, ciabatta = 1, sliced_onion = 1 }, take = {chicken_sandwich = 1}, progtext = 'Using'},
            {anim = 'uncuff',give = {cooked_steak = 1, ciabatta = 1, sliced_onion = 1 }, take = {steak_sandwich = 1}, progtext = 'Using'},
        },
        cocktail = {
            {anim = 'cocktail', give = {vodka = 1, soda_water = 1, ice = 1}, take = {vodka_soda = 1}, progtext = 'Making'},
            {anim = 'cocktail', give = {vodka = 1, ginger_ale = 1, lime = 1, ice = 1}, take = {moscow_mule = 1}, progtext = 'Making'},
            {anim = 'cocktail', give = {tequila = 1, orange = 1, grenadine = 1, ice = 1}, take = {tequila_sunrise = 1}, progtext = 'Making'},
            {anim = 'cocktail', give = {whiskey = 1, lemon = 1, sugar = 1, ice = 1}, take = {whiskey_sour = 1}, progtext = 'Making'},
            {anim = 'cocktail', give = {gin = 1, tonic_water = 1, ice = 1, lime = 1}, take = {gin_and_tonic = 1}, progtext = 'Making'},
            {anim = 'cocktail', give = {rum = 1, ecola = 1, ice = 1}, take = {rum_and_coke = 1}, progtext = 'Making'},
            {anim = 'cocktail', give = {gin = 1, soda_water = 1, lime = 1, sugar = 1, ice = 1}, take = {gin_fizz = 1}, progtext = 'Making'},
            {anim = 'cocktail', give = {rum = 1, lime = 1, orange = 1, grenadine = 1, ice = 1}, take = {rum_punch = 1}, progtext = 'Making'},
            {anim = 'cocktail', give = {vodka = 1, orange = 1, ice = 1}, take = {screwdriver = 1}, progtext = 'Making'},
            {anim = 'cocktail', give = {rum = 1, lime = 1, sugar = 1, soda_water = 1, ice = 1}, take = {mojito = 1}, progtext = 'Making'},
            {anim = 'cocktail', give = {rum = 1, lime = 1, sugar = 1, ice = 1}, take = {daiquiri = 1}, progtext = 'Making'}
        }
    },
    catering = {
        commission = 0.2,
        items = {
            {name = 'onion_rings',      minPrice = 10, maxPrice = 20, maxAmount = 30},
            {name = 'mozzarella_stick', minPrice = 10, maxPrice = 20, maxAmount = 30},
            {name = 'fried_pickles',    minPrice = 10, maxPrice = 20, maxAmount = 30},
            {name = 'buffalo_wings',    minPrice = 10, maxPrice = 20, maxAmount = 30},
        },
        Van = {
            vu = {model = 'burrito', label = 'Burrito', plate = 'pubdel', loc = vector4(-578.47, -695.18, 32.52, 180.0), heading = 28.78},
        }
    },
    shops = {
        fridge = {
            {name = 'mozzarella', price = 5, amount = 50},
            {name = 'batter_mix', price = 5, amount = 50},
            {name = 'pickle', price = 5, amount = 50},
            {name = 'onion', price = 5, amount = 50},
            {name = 'tomato', price = 5, amount = 50},
            {name = 'burger_patty', price = 5, amount = 50},
            {name = 'vegan_patty', price = 5, amount = 50},
            {name = 'veggie_patty', price = 5, amount = 50},
            {name = 'raw_chicken', price = 5, amount = 50},
            {name = 'raw_steak', price = 5, amount = 50},
            {name = 'ciabatta', price = 5, amount = 50},
            {name = 'burger_bun', price = 5, amount = 50},
            {name = 'raw_chicken_wing', price = 5, amount = 50},
        },
        ingridients = {
            {name = 'vodka', price = 5, amount = 50},
            {name = 'tequila', price = 5, amount = 50},
            {name = 'whiskey', price = 5, amount = 50},
            {name = 'rum', price = 5, amount = 50},
            {name = 'gin', price = 5, amount = 50},
            {name = 'lime', price = 5, amount = 50},
            {name = 'lemon', price = 5, amount = 50},
            {name = 'orange', price = 5, amount = 50},
            {name = 'sugar', price = 5, amount = 50},
            {name = 'salt', price = 5, amount = 50},
            {name = 'ice', price = 5, amount = 50},
            {name = 'soda_water', price = 5, amount = 50},
            {name = 'tonic_water', price = 5, amount = 50},
            {name = 'ecola', price = 5, amount = 50},
            {name = 'ginger_ale', price = 5, amount = 50},
            {name = 'bitters', price = 5, amount = 50},
            {name = 'grenadine', price = 5, amount = 50},
            {name = 'vermouth', price = 5, amount = 50},
            {name = 'simple_syrup', price = 5, amount = 50},
        }
    },
    locations = {
        Crafter = {
            {CraftData = {type = 'beer', targetLabel = 'Pour Beer', menuLabel = 'Pour Beer!'},
                loc = vector3(-578.53, -689.56, 32.88), l = 0.65, w = 0.5, lwr = 0.25, upr = 0.25, r = 180, job = 'pub'},
            {CraftData = {type = 'coffee', targetLabel = 'Pour Coffee', menuLabel = 'Pour Coffee!'},
                loc = vector3(-581.49, -698.12, 32.65), l = 0.7, w = 0.6, lwr = 0.25, upr = 0.25, r = 180, job = 'pub'},
            {CraftData = {type = 'fryer', targetLabel = 'Fry Foods', menuLabel = 'Fry Foods!'},
                loc = vector3(-581.49, -699.65, 32.52), l = 0.75, w = 0.5, lwr = 0.5, upr = 0.5, r = 180, job = 'pub'},
            {CraftData = {type = 'grill', targetLabel = 'Use Grill', menuLabel = 'Use Grill!'},
                loc = vector3(-581.49, -701.08, 32.49), l = 2.0, w = 0.7, lwr = 0.5, upr = 0.5, r = 180, job = 'pub'},
            {CraftData = {type = 'cuttingboard', targetLabel = 'Chop Ingredients', menuLabel = 'Chop Ingredients!'},
                loc = vector3(-581.49, -703.05, 32.56), l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 180, job = 'pub'},
            {CraftData = {type = 'hotplate', targetLabel = 'Use Hot Plate', menuLabel = 'Use Hot Plate!'},
                loc = vector3(-580.34, -704.59, 32.55), l = 0.7, w = 1.4, lwr = 0.5, upr = 0.5, r = 180, job = 'pub'},
            {CraftData = {type = 'ice', targetLabel = 'Scoop Ice', menuLabel = 'Scoop Ice!'},
                loc = vector3(-577.67, -703.29, 32.4), l = 1.25, w = 0.65, lwr = 0.5, upr = 0.5, r = 180, job = 'pub'},
            {CraftData = {type = 'cocktail', targetLabel = 'Make Cocktail', menuLabel = 'Make Cocktail!'},
                loc = vector3(-580.34, -704.59, 32.55), l = 0.7, w = 1.4, lwr = 0.5, upr = 0.5, r = 180, job = 'pub'},
        },
        Stores = {
            {StoreData = {type = 'fridge', targetLabel = 'Get Ingredients', menuLabel = 'Get Ingredients!'},
                loc = vector3(-578.68, -692.7, 32.02), l = 0.65, w = 0.5, lwr = 0.25, upr = 0.25, r = 180, job = 'pub'},
            --{StoreData = {type = 'ingridients', targetLabel = 'Get Ingredients', menuLabel = 'Get Ingredients!'},
            --    loc = vector3(-581.49, -698.12, 32.65), l = 0.7, w = 0.6, lwr = 0.25, upr = 0.25, r = 180, job = 'pub'},
        },
        Tills = {
            {loc = vector3(-578.47, -695.18, 32.52), l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 180, commission = 0.2, job = 'pub'},
        },
        trays = {
            {loc = vector3(-580.98, -688.3, 32.7), l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 180, slots = 20, weight = 100000, job = 'pub'},
            {loc = vector3(-579.4, -688.27, 32.7), l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 180, slots = 20, weight = 100000, job = 'pub'},
            {loc = vector3(-578.13, -692.47, 32.7), l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 180, slots = 20, weight = 100000, job = 'pub'},
            {loc = vector3(-578.09, -690.94, 32.7), l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 180, slots = 20, weight = 100000, job = 'pub'},
            {loc = vector3(-578.16, -689.57, 32.7), l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 180, slots = 20, weight = 100000, job = 'pub'},
        },
        stash = {
            {loc = vector3(-581.49, -696.1, 33.03), l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 180, slots = 20, weight = 100000, job = 'pub'},
            {loc = vector3(-581.49, -694.48, 33.03), l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 180, slots = 20, weight = 100000, job = 'pub'},
            {loc = vector3(-581.49, -692.73, 33.03), l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 180, slots = 20, weight = 100000, job = 'pub'},
            {loc = vector3(-581.49, -691.37, 33.03), l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 180, slots = 20, weight = 100000, job = 'pub'},
            {loc = vector3(-581.49, -689.88, 33.03), l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 180, slots = 20, weight = 100000, job = 'pub'},
        },
    }
}