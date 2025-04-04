Jobs['tequilala'] = {
    CateringEnabled = true,
    closedShopsEnabled = true,
    Blip = {
        {sprite = 93, color = 2, scale = 0.5, label = 'Tequila La', loc = vector3(-563.02, 287.51, 82.39)},
    },
    closedShops = {
        {ped = 'mp_m_freemode_01', loc = vector4(-561.38, 274.31, 83.02, 170.65), label = 'Tequila La Shop'}
    },
    closedShopItems = {
        ambeer         =   {name = 'ambeer',       price = 5},
        beer           =   {name = 'beer',         price = 5},
        dusche         =   {name = 'dusche',       price = 5},
        logger         =   {name = 'logger',       price = 5},
        patochebeer    =   {name = 'patochebeer',  price = 5},
        pisswaser     =   {name = 'pisswaser',   price = 5},
        pisswaser_light =   {name = 'pisswaser_light', price = 5},
        pisswaser_dark  =   {name = 'pisswaser_dark',  price = 5},

    },
    craftingStations = {
        beer = {
            {anim = 'uncuff',give = {}, take = {ambeer = 1},          progtext = 'Pouring' },
            {anim = 'uncuff',give = {}, take = {beer = 1},            progtext = 'Pouring' },
            {anim = 'uncuff',give = {}, take = {dusche = 1},          progtext = 'Pouring' },
            {anim = 'uncuff',give = {}, take = {logger = 1},          progtext = 'Pouring' },
            {anim = 'uncuff',give = {}, take = {patochebeer = 1},     progtext = 'Pouring' },
            {anim = 'uncuff',give = {}, take = {pisswaser = 1},      progtext = 'Pouring' },
            {anim = 'uncuff',give = {}, take = {pisswaser_light = 1}, progtext = 'Pouring' },
            {anim = 'uncuff',give = {}, take = {pisswaser_dark = 1},  progtext = 'Pouring' },
        },
        
    },
    catering = {
        commission = 0.2,
        items = {
            {name = 'ambeer',           minPrice = 10, maxPrice = 20, maxAmount = 30},
            {name = 'beer',             minPrice = 10, maxPrice = 20, maxAmount = 30},
            {name = 'dusche',           minPrice = 10, maxPrice = 20, maxAmount = 30},
            {name = 'logger',           minPrice = 10, maxPrice = 20, maxAmount = 30},
            {name = 'patochebeer',      minPrice = 10, maxPrice = 20, maxAmount = 30},
            {name = 'pisswaser',       minPrice = 10, maxPrice = 20, maxAmount = 30},
            {name = 'pisswaser_light',  minPrice = 10, maxPrice = 20, maxAmount = 30},
            {name = 'pisswaser_dark',   minPrice = 10, maxPrice = 20, maxAmount = 30},
        },
        Van = {
            vu = {model = 'burrito', label = 'Burrito', plate = 'TEQCATER', loc = vector4(-563.02, 287.51, 82.39, 180.0), heading = 28.78},
        }

    },
    shops = {},
    locations = {
        Crafter = {
            {CraftData = {type = 'beer', targetLabel = 'Pour Beer', menuLabel = 'Pour Beer!'},
                loc = vector3(-561.25, 285.47, 82.67), l = 0.65, w = 0.5, lwr = 0.25, upr = 0.25, r = 180, job = 'tequilala'},
            {CraftData = {type = 'beer', targetLabel = 'Pour Beer', menuLabel = 'Pour Beer!'},
                loc = vector3(-561.03, 288.0, 82.72),   l = 0.65, w = 0.5, lwr = 0.25, upr = 0.25, r = 180, job = 'tequilala'},
            {CraftData = {type = 'beer', targetLabel = 'Pour Beer', menuLabel = 'Pour Beer!'},
                loc = vector3(-564.31, 286.23, 85.87),  l = 0.65, w = 0.5, lwr = 0.25, upr = 0.25, r = 180, job = 'tequilala'},
        },
        Stores = {},
        till = {
            {loc = vector3(-563.02, 287.51, 82.39), l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 180,  commission = 0.2, job = 'tequilala'},
            {loc = vector3(-566.25, 284.71, 85.58), l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 180,  commission = 0.2, job = 'tequilala'},
        },
        stash = {
            {loc = vector3(-561.68, 290.17, 82.41), l = 0.5, w = 1.0, lwr = 1.0, upr = 1.0, r = 180, slots = 20, weight = 100000, job = 'tequilala'},
            {loc = vector3(-568.64, 290.78, 79.61), l = 0.5, w = 1.0, lwr = 1.0, upr = 1.0, r = 180, slots = 20, weight = 100000, job = 'tequilala'},
        },
        
    }
}