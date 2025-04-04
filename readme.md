# MD-Jobs 
<div align="center">
  <a href="https://discord.gg/sAMzrB4DDx">
    <img align="center" src="https://i.imgur.com/t65G9Z0.png" width="200">
  </a><br>
  <a href="https://discord.gg/sAMzrB4DDx"><strong>Mustache Scripts Discord</strong></a><br>
</div>

# if you can config, you can have unlimited crafting based jobs
### no im not kidding. if **you** want to make 30 jobs in here, you absolutely can. lets talk basic install then ill get into creation

# Dependancies
  - qb-core or qbx_core or esx
    - esx is experimental. i never used it but it should work
    - if esx ox_inventory and ox_target are required
  - ox_lib


# INSTALLATION 
## step 1
### install the items
  - woah what items there is like 10 folders in the folder named items
     - well what ones do you want to use? if you arent going to use Gabz Vanilla Unicorn, why install it? Use what you need. 

## step 2
### upload images to inventory
- how do i do that?
  - copy and paste

## Step 3
### run the SQL file 
  - how do I do that?
     - There is a lot of REALLY good videos on youtube on how to run SQL files

- But I Dont Wanna.
  - then you dont want to run the script fully

## Step 4
### add these emotes
 - do I need to?
   - No, but like you gotta change a bunch so if you want to change em go ahead


animation for rpemotes

```lua
["cocktail"] = {
        'anim@scripted@freemode@postertag@graffiti_spray@male@',
        "shake_can_male",
        "Shake Cocktail",
        "coupleanim",
        AnimationOptions = {
            Prop = 'prop_bar_cockshaker',
            PropBone = 28422,
            PropPlacement = {
                0, 0, -0.20, 0.0017365, 0, 0
            },
            EmoteMoving = false,
            EmoteLoop = true
        }
    },
```


# How to edit things around

Lets start with a job snippet and ill explain it further 
```lua
Jobs['police'] = {
    CateringEnabled = true,    -- if false catering can be catering = {} or not even there
    closedShopsEnabled = true, -- if false than closedShops and closedShopItems can be {} or not even there
    Blip = { -- Blip Creation (Not Required)
        {sprite = 279, color = 2, scale = 0.5, label = 'Vanilla Unicorn', loc = vector3(129.02, -1283.25, 29.27)},
    },
    closedShops = { -- allows multiple peds with their own inventory label MUST BE UNIQUE
        {ped = 'mp_m_freemode_01', loc = vector4(129.02, -1283.25, 29.27, 120.67), label = 'Vanilla Unicorn Shop'}
    },
    closedShopItems = { -- items allowed in closed shops
        tequila        =   {name = 'tequila',      price = 5},
        whiskey        =   {name = 'whiskey',      price = 5},
        rum            =   {name = 'rum',          price = 5},
        gin            =   {name = 'gin',          price = 5},
        lime           =   {name = 'lime',         price = 5},
        lemon          =   {name = 'lemon',        price = 5},
        orange         =   {name = 'orange',       price = 5},
        sugar          =   {name = 'sugar',        price = 5},
        salt           =   {name = 'salt',         price = 5},
        ice            =   {name = 'ice',          price = 5},
        soda_water     =   {name = 'soda_water',   price = 5},
        tonic_water    =   {name = 'tonic_water',  price = 5},
        ecola          =   {name = 'ecola',        price = 5},
        ginger_ale     =   {name = 'ginger_ale',   price = 5},
        bitters        =   {name = 'bitters',      price = 5},
        grenadine      =   {name = 'grenadine',    price = 5},
        vermouth       =   {name = 'vermouth',     price = 5},
        simple_syrup   =   {name = 'simple_syrup', price = 5}
    },
    craftingStations = { --must match the key value in locations
        cocktail = {
            {anim = 'cocktail', give = {ice = 1, soda_water = 1, vodka = 1},                    take = {vodka_soda = 1},        progtext = 'Making'},
            {anim = 'cocktail', give = {vodka = 1, ginger_ale = 1, lime = 1, ice = 1},          take = {moscow_mule = 1},       progtext = 'Making'},
            {anim = 'cocktail', give = {tequila = 1, orange = 1, grenadine = 1, ice = 1},       take = {tequila_sunrise = 1},   progtext = 'Making'},
            {anim = 'cocktail', give = {whiskey = 1, lemon = 1, sugar = 10, ice = 1},            take = {whiskey_sour = 1},      progtext = 'Making'},
            {anim = 'cocktail', give = {gin = 1, tonic_water = 1, ice = 1, lime = 1},           take = {gin_and_tonic = 1},     progtext = 'Making'},
            {anim = 'cocktail', give = {rum = 1, ecola = 1, ice = 1},                           take = {rum_and_coke = 1},      progtext = 'Making'},
            {anim = 'cocktail', give = {gin = 1, soda_water = 1, lime = 1, sugar = 1, ice = 1}, take = {gin_fizz = 1},          progtext = 'Making'},
            {anim = 'cocktail', give = {rum = 1, lime = 1, orange = 1, grenadine = 1, ice = 1}, take = {rum_punch = 1},         progtext = 'Making'},
            {anim = 'cocktail', give = {vodka = 1, orange = 1, ice = 1},                        take = {screwdriver = 1},       progtext = 'Making'},
            {anim = 'cocktail', give = {rum = 1, lime = 1, sugar = 1, soda_water = 1, ice = 1}, take = {mojito = 1},            progtext = 'Making'},
            {anim = 'cocktail', give = {rum = 1, lime = 1, sugar = 1, ice = 1},                 take = {daiquiri = 1},          progtext = 'Making'}
        },
        coffee = {
            {anim = 'uncuff',give = {}, take = {coffee = 1}, progtext = 'Pouring' }
        },
        ice = {
            {anim = 'uncuff', give = {}, take = {ice = 1}, progtext = 'Scooping' }
        }
    },
    catering = { -- accessible in Till
        commission = 0.2,
        items = {
            {name = 'vodka',        minPrice = 10, maxPrice = 20, maxAmount = 30},
            {name = 'tequila',      minPrice = 10, maxPrice = 20, maxAmount = 30},
        },
        Van = {model = 'burrito', label = 'Burrito', plate = 'policeCATER', loc = vector4(144.72, -1300.25, 28.89, 121.44), heading = 118.78},
    },
    shops = { -- must match the key value in locations
        ingridients = {
            {name = 'vodka',        price = 5, amount = 50},
            {name = 'tequila',      price = 5, amount = 50},
            {name = 'whiskey',      price = 5, amount = 50},
            {name = 'rum',          price = 5, amount = 50},
            {name = 'gin',          price = 5, amount = 50},
            {name = 'lime',         price = 5, amount = 50},
            {name = 'lemon',        price = 5, amount = 50},
            {name = 'orange',       price = 5, amount = 50},
            {name = 'sugar',        price = 5, amount = 50},
            {name = 'salt',         price = 5, amount = 50},
            {name = 'ice',          price = 5, amount = 50},
            {name = 'soda_water',   price = 5, amount = 50},
            {name = 'tonic_water',  price = 5, amount = 50},
            {name = 'ecola',        price = 5, amount = 50},
            {name = 'ginger_ale',   price = 5, amount = 50},
            {name = 'bitters',      price = 5, amount = 50},
            {name = 'grenadine',    price = 5, amount = 50},
            {name = 'vermouth',     price = 5, amount = 50},
            {name = 'simple_syrup', price = 5, amount = 50},
        }
    },
        --- in CraftData/StoreData YOU DO NOT NEED prop or heading as these are not needed for the interaction. If you want to spawn an Object, They ARE needed
    locations = { -- l = length, w = width, lwr = (for target) lower height, upr = (for target)  upper height, r = rotation
        Crafter = { -- CraftData.type MUST MATCH A KEY VALUE IN craftStations ABOVE so type = 'cocktail' will look for cocktail in craftingStations
            {CraftData = {type = 'coffee', targetLabel = 'Make Coffee', menuLabel = 'Make Coffee!',prop = 'prop_coffee_mac_02'},
                loc = vector3(130.66, -1281.72, 29.5), l = 0.5, w = 0.4, lwr = 0.25, upr = 0.25, r = 40, job = 'police'},
            {CraftData = {type = 'ice', targetLabel = 'Grab Ice', menuLabel = 'Grab Ice!' }, 
                loc = vector3(127.95, -1281.9, 28.99), l = 1.25, w = 0.65, lwr = 0.5, upr = 0.5, r = 40, job = 'police'},
            {CraftData = {type = 'cocktail', targetLabel = 'Make Cocktail', menuLabel = 'Make Cocktail!' },
                loc = vector3(128.19, -1282.81, 29.44), l = 0.7, w = 0.6, lwr = 0.25, upr = 0.25, r = 120, job = 'police'},
            {CraftData = {type = 'cocktail', targetLabel = 'Make Cocktail', menuLabel = 'Make Cocktail!'},
                loc = vector3(128.57, -1283.46, 29.42), l = 0.7, w = 0.6, lwr = 0.25, upr = 0.25, r = 120, job = 'police'},
        },
        Stores = { -- prop is only needed if you want to spawn an object | prop = 'prop_bar_fridge_01' for example
            {StoreData = {type = 'ingridients', targetLabel = 'Get Ingredients', menuLabel = 'Get Ingredients!'},
                loc = vector3(132.64, -1286.02, 28.84), l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 40, job = 'police'},
            {StoreData = {type = 'ingridients', targetLabel = 'Get Ingredients', menuLabel = 'Get Ingredients!'},
                loc = vector3(131.99, -1284.91, 28.73), l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 40, job = 'police'},
            {StoreData = {type = 'ingridients', targetLabel = 'Get Ingredients', menuLabel = 'Get Ingredients!'},
                loc = vector3(129.97, -1281.44, 28.74), l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 40, job = 'police'},
            {StoreData = {type = 'ingridients', targetLabel = 'Get Ingredients', menuLabel = 'Get Ingredients!'},
                loc = vector3(129.14, -1279.99, 28.68), l = 0.7, w = 1.0, lwr = 0.50, upr = 0.5, r = 120, job = 'police'},
        },
        Tills = { -- prop is only needed if you want to spawn an object | prop = 'prop_till_03' for example
            {loc = vec3(130.83, -1282.33, 29.42), l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 40,  commission = 0.2, job = 'police'},
            {loc = vec3(129.32, -1284.75, 29.44), l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 40,  commission = 0.2, job = 'police'},
            {loc = vec3(133.31, -1286.82, 29.4),  l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 40,  commission = 0.2, job = 'police'},
        },
        stash = { -- prop is only needed if you want to spawn an object | prop = 'prop_lev_crate_01' for example
            {prop = 'prop_drop_crate_01',loc = vec3(131.6136, -1287.2435, 28.2753), l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 120,slots = 20, weight = 100000, job = 'police'},
        },
        trays = { -- storages to place things for people | prop is only needed if you want to spawn an object | prop = 'prop_bar_fridge_01' for example
            {prop = 'prop_food_tray_01', label = 'Grab Food', loc = vector3(129.6180, -1286.6339, 29.2904), l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 214, slots = 20, weight = 100000, job = 'police'},
        }
    }
}
```

so these have comments on everything that you should get what you can do, but lets say you dont and go line by line 

## making a job
 - in order to make the job you need to add it to the Jobs table. its very simple
   ```lua
     Jobs['police'] = {

     }
    ```
     - now it **needs** to be the job <big><bold> NAME </bold></big> not job label

## enable catering or closed shop
  - this is very simple as well, you are simply going to put the bools in the table you just make
       ```lua
          Jobs['police'] = {
              CateringEnabled = true,    
              closedShopsEnabled = true, 
          }
      ```

## making a blip
 - lets make a blip for this job
    ```lua
        Jobs['police'] = {
            CateringEnabled = true,    
            closedShopsEnabled = true,
            Blip = { 
                {sprite = 279, color = 2, scale = 0.5, label = 'Vanilla Unicorn', loc = vector3(129.02, -1283.25, 29.27)},
            },
          }
    ```
    - what is a sprite? 
      - its the logo
    - why is color a number, 2 isn't a color?
      - its a number code to translate to color using Fivem Natives
    - what is scale?
      - smol number, smol blip. big number, big blip
    - can this label be anything?
      - yep! it could be Pee Pee Poo Poo Palace ( Thats the name for my cats Litter Robot 4)
    - why do i need to have a loc? 
      - if code could read minds, we would be living in AI hellscape

## Making A closed shop
  - sweet, now we need to add where the peds will be!
    ```lua
          Jobs['police'] = {
            CateringEnabled = true,    
            closedShopsEnabled = true,
            Blip = { 
                {sprite = 279, color = 2, scale = 0.5, label = 'Vanilla Unicorn', loc = vector3(129.02, -1283.25, 29.27)},
            },
            closedShops = { -- allows multiple peds with their own inventory label MUST BE UNIQUE
                {ped = 'mp_m_freemode_01', loc = vector4(129.02, -1283.25, 29.27, 120.67), label = 'Vanilla Unicorn Shop'},
                {ped = 'mp_m_freemode_01', loc = vector4(523.02, 421.25, 65.27, 120.67), label = 'Vanilla Unicorn Beach Shop'},
            },
          }
    ```
  - so with this table you can have multiple shops. it just needs the label = to be different
    - how do i change what ped spawns
      - change ped = to whatever ped you want
    - how can i change the where they spawn
      - change loc = 
  - or you can have it blank if closedShopsEnabled = false
    ```lua
        Jobs['police'] = {
            CateringEnabled = true,    
            closedShopsEnabled = false,
            Blip = { 
                {sprite = 279, color = 2, scale = 0.5, label = 'Vanilla Unicorn', loc = vector3(129.02, -1283.25, 29.27)},
            },
            closedShops = {},
        }
    ```
    or 
    ```lua
      Jobs['police'] = {
            CateringEnabled = true,    
            closedShopsEnabled = false,
            Blip = { 
                {sprite = 279, color = 2, scale = 0.5, label = 'Vanilla Unicorn', loc = vector3(129.02, -1283.25, 29.27)},
            },
        }
    ```
## Adding What Can Be In a Closed Shop
  - this part is simple, add the items you want to sell and the price for them
     ```lua
      Jobs['police'] = {
            CateringEnabled = true,    
            closedShopsEnabled = true,
            Blip = { 
                {sprite = 279, color = 2, scale = 0.5, label = 'Vanilla Unicorn', loc = vector3(129.02, -1283.25, 29.27)},
            },
            closedShops = { -- allows multiple peds with their own inventory label MUST BE UNIQUE
                {ped = 'mp_m_freemode_01', loc = vector4(129.02, -1283.25, 29.27, 120.67), label = 'Vanilla Unicorn Shop'},
                {ped = 'mp_m_freemode_01', loc = vector4(523.02, 421.25, 65.27, 120.67), label = 'Vanilla Unicorn Beach Shop'},
            },
            closedShopItems = { -- items allowed in closed shops
                tequila        =   {name = 'tequila',      price = 5},
                whiskey        =   {name = 'whiskey',      price = 5},
                rum            =   {name = 'rum',          price = 5},
                gin            =   {name = 'gin',          price = 5},
                lime           =   {name = 'lime',         price = 5},
                lemon          =   {name = 'lemon',        price = 5},
                orange         =   {name = 'orange',       price = 5},
                sugar          =   {name = 'sugar',        price = 5},
                salt           =   {name = 'salt',         price = 5},
                ice            =   {name = 'ice',          price = 5},
                soda_water     =   {name = 'soda_water',   price = 5},
                tonic_water    =   {name = 'tonic_water',  price = 5},
                ecola          =   {name = 'ecola',        price = 5},
                ginger_ale     =   {name = 'ginger_ale',   price = 5},
                bitters        =   {name = 'bitters',      price = 5},
                grenadine      =   {name = 'grenadine',    price = 5},
                vermouth       =   {name = 'vermouth',     price = 5},
                simple_syrup   =   {name = 'simple_syrup', price = 5}
            },
          }
      ```
      -  now this is assuming you have closedShops enabled. but now the script will check for these items to add/remove and sell to players and at those prices!
      - how Can I change the price?
        - change the number.

        
### doing good so far! now you can see how to start a job and enable closedShops and blips. Lets get further in!

## Adding Crafting Stations
 - Sweet now lets look at making some crafting stations and recipes
   ```lua
      Jobs['police'] = {
        CateringEnabled = true,    -- if false catering can be catering = {} or not even there
        closedShopsEnabled = true, -- if false than closedShops and closedShopItems can be {} or not even there
        Blip = { -- Blip Creation (Not Required)
            {sprite = 279, color = 2, scale = 0.5, label = 'Vanilla Unicorn', loc = vector3(129.02, -1283.25, 29.27)},
        },
        closedShops = { -- allows multiple peds with their own inventory label MUST BE UNIQUE
            {ped = 'mp_m_freemode_01', loc = vector4(129.02, -1283.25, 29.27, 120.67), label = 'Vanilla Unicorn Shop'}
        },
        closedShopItems = { -- items allowed in closed shops
            tequila        =   {name = 'tequila',      price = 5},
            whiskey        =   {name = 'whiskey',      price = 5},
            rum            =   {name = 'rum',          price = 5},
            gin            =   {name = 'gin',          price = 5},
            lime           =   {name = 'lime',         price = 5},
            lemon          =   {name = 'lemon',        price = 5},
            orange         =   {name = 'orange',       price = 5},
            sugar          =   {name = 'sugar',        price = 5},
            salt           =   {name = 'salt',         price = 5},
            ice            =   {name = 'ice',          price = 5},
            soda_water     =   {name = 'soda_water',   price = 5},
            tonic_water    =   {name = 'tonic_water',  price = 5},
            ecola          =   {name = 'ecola',        price = 5},
            ginger_ale     =   {name = 'ginger_ale',   price = 5},
            bitters        =   {name = 'bitters',      price = 5},
            grenadine      =   {name = 'grenadine',    price = 5},
            vermouth       =   {name = 'vermouth',     price = 5},
            simple_syrup   =   {name = 'simple_syrup', price = 5}
        },
        craftingStations = { --must match the key value in locations
            cocktail = {
                {anim = 'cocktail', give = {ice = 1, soda_water = 1, vodka = 1},                    take = {vodka_soda = 1},        progtext = 'Making'},
                {anim = 'cocktail', give = {vodka = 1, ginger_ale = 1, lime = 1, ice = 1},          take = {moscow_mule = 1},       progtext = 'Making'},
                {anim = 'cocktail', give = {tequila = 1, orange = 1, grenadine = 1, ice = 1},       take = {tequila_sunrise = 1},   progtext = 'Making'},
                {anim = 'cocktail', give = {whiskey = 1, lemon = 1, sugar = 10, ice = 1},            take = {whiskey_sour = 1},      progtext = 'Making'},
                {anim = 'cocktail', give = {gin = 1, tonic_water = 1, ice = 1, lime = 1},           take = {gin_and_tonic = 1},     progtext = 'Making'},
                {anim = 'cocktail', give = {rum = 1, ecola = 1, ice = 1},                           take = {rum_and_coke = 1},      progtext = 'Making'},
                {anim = 'cocktail', give = {gin = 1, soda_water = 1, lime = 1, sugar = 1, ice = 1}, take = {gin_fizz = 1},          progtext = 'Making'},
                {anim = 'cocktail', give = {rum = 1, lime = 1, orange = 1, grenadine = 1, ice = 1}, take = {rum_punch = 1},         progtext = 'Making'},
                {anim = 'cocktail', give = {vodka = 1, orange = 1, ice = 1},                        take = {screwdriver = 1},       progtext = 'Making'},
                {anim = 'cocktail', give = {rum = 1, lime = 1, sugar = 1, soda_water = 1, ice = 1}, take = {mojito = 1},            progtext = 'Making'},
                {anim = 'cocktail', give = {rum = 1, lime = 1, sugar = 1, ice = 1},                 take = {daiquiri = 1},          progtext = 'Making'}
            },
            coffee = {
                {anim = 'uncuff',give = {}, take = {coffee = 1}, progtext = 'Pouring' }
            },
            ice = {
                {anim = 'uncuff', give = {}, take = {ice = 1}, progtext = 'Scooping' }
            }
        },
      }
    ```
    - ok i admit thats a lot of changes really quick. lets break it down 

    - so we are making three crafting stations.
      ```lua
          cocktail = {},
          coffee = {},
          ice = {},
      ```
    - so the tables above are what type of crafting it is. lets add data
         ```lua
             cocktail = {
                {anim = 'cocktail', give = {ice = 1, soda_water = 1, vodka = 1}, take = {vodka_soda = 1}, progtext = 'Making', time = 5000},
             },
           coffee = {
                {anim = 'uncuff',give = {}, take = {coffee = 1}, progtext = 'Pouring' }
            },
            ice = {
                {anim = 'uncuff', give = {}, take = {ice = 1}, progtext = 'Scooping' }
            }
        ```
      - so now when people are at a cocktail crafter it will show the cocktail crafting options above.
      - now lets break down what the options are and what they mean
         - anim = 'cocktail'
            - this is the emote you want to play when doing the crafting!
         - give = {ice = 1, soda_water = 1, vodka = 1}
            - give is what is required to make an item. so think of it like this 
               - if RemoveItem(ice, 1) and RemoveItem(soda_water, 1) and RemoveItem(vodka, 1) then
            - Do I need To Remove an Item? 
              - nope just leave it like this 
                 ```lua
                    give = {},
                 ```
          - take = {vodka_soda = 1}
            - this is what you are taking after removing the items so think of it like 
              - AddItem(vodka_soda = 1)
          - progtext = 'Making'
             - I use this so the progressbar can change what it says 
               - if progtext = 'Making' then the progressbar will say 
                 - Making Vodka Soda!
          - time = 5000 
             - how long the progressbar should be in ms
               - you can leave blank and it defaults to Config.DefaultCraftTime or change to be different here
          - max  = 100
            - Now there is Config.MultiCraftDefault this will overwrite this! 
               - it is **NOT** required, but if you want them to only make 2 at a time do 
                  - max = 2
                - or if you want them to do endless do 
                  - max = 9999999999

 - Now all you need to do is fill out as many crafting things as you want!

 ## Setting Up Catering!
  - going off assuming you want to use catering for this job lets add it in
    ```lua
       Jobs['police'] = {
        CateringEnabled = true,    -- if false catering can be catering = {} or not even there
        closedShopsEnabled = true, -- if false than closedShops and closedShopItems can be {} or not even there
        Blip = { -- Blip Creation (Not Required)
            {sprite = 279, color = 2, scale = 0.5, label = 'Vanilla Unicorn', loc = vector3(129.02, -1283.25, 29.27)},
        },
        closedShops = { -- allows multiple peds with their own inventory label MUST BE UNIQUE
            {ped = 'mp_m_freemode_01', loc = vector4(129.02, -1283.25, 29.27, 120.67), label = 'Vanilla Unicorn Shop'}
        },
        closedShopItems = { -- items allowed in closed shops
            tequila        =   {name = 'tequila',      price = 5},
            whiskey        =   {name = 'whiskey',      price = 5},
            rum            =   {name = 'rum',          price = 5},
            gin            =   {name = 'gin',          price = 5},
            lime           =   {name = 'lime',         price = 5},
            lemon          =   {name = 'lemon',        price = 5},
            orange         =   {name = 'orange',       price = 5},
            sugar          =   {name = 'sugar',        price = 5},
            salt           =   {name = 'salt',         price = 5},
            ice            =   {name = 'ice',          price = 5},
            soda_water     =   {name = 'soda_water',   price = 5},
            tonic_water    =   {name = 'tonic_water',  price = 5},
            ecola          =   {name = 'ecola',        price = 5},
            ginger_ale     =   {name = 'ginger_ale',   price = 5},
            bitters        =   {name = 'bitters',      price = 5},
            grenadine      =   {name = 'grenadine',    price = 5},
            vermouth       =   {name = 'vermouth',     price = 5},
            simple_syrup   =   {name = 'simple_syrup', price = 5}
        },
        craftingStations = { --must match the key value in locations
            cocktail = {
                {anim = 'cocktail', give = {ice = 1, soda_water = 1, vodka = 1},                    take = {vodka_soda = 1},        progtext = 'Making'},
                {anim = 'cocktail', give = {vodka = 1, ginger_ale = 1, lime = 1, ice = 1},          take = {moscow_mule = 1},       progtext = 'Making'},
                {anim = 'cocktail', give = {tequila = 1, orange = 1, grenadine = 1, ice = 1},       take = {tequila_sunrise = 1},   progtext = 'Making'},
                {anim = 'cocktail', give = {whiskey = 1, lemon = 1, sugar = 10, ice = 1},            take = {whiskey_sour = 1},      progtext = 'Making'},
                {anim = 'cocktail', give = {gin = 1, tonic_water = 1, ice = 1, lime = 1},           take = {gin_and_tonic = 1},     progtext = 'Making'},
                {anim = 'cocktail', give = {rum = 1, ecola = 1, ice = 1},                           take = {rum_and_coke = 1},      progtext = 'Making'},
                {anim = 'cocktail', give = {gin = 1, soda_water = 1, lime = 1, sugar = 1, ice = 1}, take = {gin_fizz = 1},          progtext = 'Making'},
                {anim = 'cocktail', give = {rum = 1, lime = 1, orange = 1, grenadine = 1, ice = 1}, take = {rum_punch = 1},         progtext = 'Making'},
                {anim = 'cocktail', give = {vodka = 1, orange = 1, ice = 1},                        take = {screwdriver = 1},       progtext = 'Making'},
                {anim = 'cocktail', give = {rum = 1, lime = 1, sugar = 1, soda_water = 1, ice = 1}, take = {mojito = 1},            progtext = 'Making'},
                {anim = 'cocktail', give = {rum = 1, lime = 1, sugar = 1, ice = 1},                 take = {daiquiri = 1},          progtext = 'Making'}
            },
            coffee = {
                {anim = 'uncuff',give = {}, take = {coffee = 1}, progtext = 'Pouring' }
            },
            ice = {
                {anim = 'uncuff', give = {}, take = {ice = 1}, progtext = 'Scooping' }
            }
        },
        catering = { -- accessible in Till
            commission = 0.2,
            items = {
                {name = 'vodka',        minPrice = 10, maxPrice = 20, maxAmount = 30},
                {name = 'tequila',      minPrice = 10, maxPrice = 20, maxAmount = 30},
            },
            Van = {model = 'burrito', label = 'Burrito', plate = 'policeCATER', loc = vector4(144.72, -1300.25, 28.89, 121.44), heading = 118.78},
        },
    }
    ```
  - commission = 0.2 means 20% of the sales will go to the people attached to the catering order
    - if 3 people are attached ( they can add themselves in the catering menu) it will take total sales * 0.2 / # of people
       - if 1200 is the total sales it will take 240 from 1200 and divide it by 3
         - each person gets 80 bucks
  - items = {}
    - this is where you put in items you want to be having for catering
       - name = item
       - min/maxprice is the random price range
       - maxAmount = number
    -  How does catering generate a list?
      - it does a math.random(1, Config.CateringRolls)
        - then it will randomize X amount of times the amount of items to be sold and which are required
    - Will it allow you to have an order bigger than your inventory? 
      - nope, if you Set Up the config correctly, it will check how much you can carry and if it exceeds, it will force it to be that weight
  - Van = {}
     - model = what model of car
     - label = Car Display Name
     - plate = license plate for catering vehicle
     - loc = where it spawns
     - heading = which way it faces


## Setting up Shops!
### is this closed shops? we did this already? nope. this is to get ingridients

- lets start with adding the types of shops and what items it goes in 
  ```lua
    Jobs['police'] = {
      CateringEnabled = true,    -- if false catering can be catering = {} or not even there
      closedShopsEnabled = true, -- if false than closedShops and closedShopItems can be {} or not even there
      Blip = { -- Blip Creation (Not Required)
          {sprite = 279, color = 2, scale = 0.5, label = 'Vanilla Unicorn', loc = vector3(129.02, -1283.25, 29.27)},
      },
      closedShops = { -- allows multiple peds with their own inventory label MUST BE UNIQUE
          {ped = 'mp_m_freemode_01', loc = vector4(129.02, -1283.25, 29.27, 120.67), label = 'Vanilla Unicorn Shop'}
      },
      closedShopItems = { -- items allowed in closed shops
          tequila        =   {name = 'tequila',      price = 5},
          whiskey        =   {name = 'whiskey',      price = 5},
          rum            =   {name = 'rum',          price = 5},
          gin            =   {name = 'gin',          price = 5},
          lime           =   {name = 'lime',         price = 5},
          lemon          =   {name = 'lemon',        price = 5},
          orange         =   {name = 'orange',       price = 5},
          sugar          =   {name = 'sugar',        price = 5},
          salt           =   {name = 'salt',         price = 5},
          ice            =   {name = 'ice',          price = 5},
          soda_water     =   {name = 'soda_water',   price = 5},
          tonic_water    =   {name = 'tonic_water',  price = 5},
          ecola          =   {name = 'ecola',        price = 5},
          ginger_ale     =   {name = 'ginger_ale',   price = 5},
          bitters        =   {name = 'bitters',      price = 5},
          grenadine      =   {name = 'grenadine',    price = 5},
          vermouth       =   {name = 'vermouth',     price = 5},
          simple_syrup   =   {name = 'simple_syrup', price = 5}
      },
      craftingStations = { --must match the key value in locations
          cocktail = {
              {anim = 'cocktail', give = {ice = 1, soda_water = 1, vodka = 1},                    take = {vodka_soda = 1},        progtext = 'Making'},
              {anim = 'cocktail', give = {vodka = 1, ginger_ale = 1, lime = 1, ice = 1},          take = {moscow_mule = 1},       progtext = 'Making'},
              {anim = 'cocktail', give = {tequila = 1, orange = 1, grenadine = 1, ice = 1},       take = {tequila_sunrise = 1},   progtext = 'Making'},
              {anim = 'cocktail', give = {whiskey = 1, lemon = 1, sugar = 10, ice = 1},            take = {whiskey_sour = 1},      progtext = 'Making'},
              {anim = 'cocktail', give = {gin = 1, tonic_water = 1, ice = 1, lime = 1},           take = {gin_and_tonic = 1},     progtext = 'Making'},
              {anim = 'cocktail', give = {rum = 1, ecola = 1, ice = 1},                           take = {rum_and_coke = 1},      progtext = 'Making'},
              {anim = 'cocktail', give = {gin = 1, soda_water = 1, lime = 1, sugar = 1, ice = 1}, take = {gin_fizz = 1},          progtext = 'Making'},
              {anim = 'cocktail', give = {rum = 1, lime = 1, orange = 1, grenadine = 1, ice = 1}, take = {rum_punch = 1},         progtext = 'Making'},
              {anim = 'cocktail', give = {vodka = 1, orange = 1, ice = 1},                        take = {screwdriver = 1},       progtext = 'Making'},
              {anim = 'cocktail', give = {rum = 1, lime = 1, sugar = 1, soda_water = 1, ice = 1}, take = {mojito = 1},            progtext = 'Making'},
              {anim = 'cocktail', give = {rum = 1, lime = 1, sugar = 1, ice = 1},                 take = {daiquiri = 1},          progtext = 'Making'}
          },
          coffee = {
              {anim = 'uncuff',give = {}, take = {coffee = 1}, progtext = 'Pouring' }
          },
          ice = {
              {anim = 'uncuff', give = {}, take = {ice = 1}, progtext = 'Scooping' }
          }
      },
      catering = { -- accessible in Till
          commission = 0.2,
          items = {
              {name = 'vodka',        minPrice = 10, maxPrice = 20, maxAmount = 30},
              {name = 'tequila',      minPrice = 10, maxPrice = 20, maxAmount = 30},
          },
          Van = {model = 'burrito', label = 'Burrito', plate = 'policeCATER', loc = vector4(144.72, -1300.25, 28.89, 121.44), heading = 118.78},
      },
      shops = { -- must match the key value in locations
          ingridients = {
              {name = 'vodka',        price = 5, amount = 50},
              {name = 'tequila',      price = 5, amount = 50},
              {name = 'whiskey',      price = 5, amount = 50},
              {name = 'rum',          price = 5, amount = 50},
              {name = 'gin',          price = 5, amount = 50},
              {name = 'lime',         price = 5, amount = 50},
              {name = 'lemon',        price = 5, amount = 50},
              {name = 'orange',       price = 5, amount = 50},
              {name = 'sugar',        price = 5, amount = 50},
              {name = 'salt',         price = 5, amount = 50},
              {name = 'ice',          price = 5, amount = 50},
              {name = 'soda_water',   price = 5, amount = 50},
              {name = 'tonic_water',  price = 5, amount = 50},
              {name = 'ecola',        price = 5, amount = 50},
              {name = 'ginger_ale',   price = 5, amount = 50},
              {name = 'bitters',      price = 5, amount = 50},
              {name = 'grenadine',    price = 5, amount = 50},
              {name = 'vermouth',     price = 5, amount = 50},
              {name = 'simple_syrup', price = 5, amount = 50},
          }
      },
    }
    ```
- so lets break this down more
  ```lua
      shops = { -- must match the key value in locations
          ingridients = {
              {name = 'vodka',        price = 5, amount = 50},
          }
      },
  ```
  - we need to make a table for the type of shop it is 
    - so the key is the type and the value is the items
    ```lua
      shops = {
         -- KEY      | Value
         ingridients = {}
      }
    ```
  - and now we just add the items that go inside the ingridients shop
    ```lua
       shops = { -- must match the key value in locations
          ingridients = {
              {name = 'vodka',        price = 5, amount = 50},
              {name = 'tequila',      price = 5, amount = 50},
              {name = 'whiskey',      price = 5, amount = 50},
              {name = 'rum',          price = 5, amount = 50},
              {name = 'gin',          price = 5, amount = 50},
              {name = 'lime',         price = 5, amount = 50},
              {name = 'lemon',        price = 5, amount = 50},
              {name = 'orange',       price = 5, amount = 50},
              {name = 'sugar',        price = 5, amount = 50},
              {name = 'salt',         price = 5, amount = 50},
              {name = 'ice',          price = 5, amount = 50},
              {name = 'soda_water',   price = 5, amount = 50},
              {name = 'tonic_water',  price = 5, amount = 50},
              {name = 'ecola',        price = 5, amount = 50},
              {name = 'ginger_ale',   price = 5, amount = 50},
              {name = 'bitters',      price = 5, amount = 50},
              {name = 'grenadine',    price = 5, amount = 50},
              {name = 'vermouth',     price = 5, amount = 50},
              {name = 'simple_syrup', price = 5, amount = 50},
          }
      },
    ```
  - but what if you want more shops
    ```lua
        shops = {
           ingridients = {},
           drystorage = {},
        }
    ```
    - we just use the same logic

## Adding Locations!
- so this is the hardest part since there is multiple formats here. ill break them down one by one but here is the way it should look
```lua
Jobs['police'] = {
    CateringEnabled = true,    -- if false catering can be catering = {} or not even there
    closedShopsEnabled = true, -- if false than closedShops and closedShopItems can be {} or not even there
    Blip = { -- Blip Creation (Not Required)
        {sprite = 279, color = 2, scale = 0.5, label = 'Vanilla Unicorn', loc = vector3(129.02, -1283.25, 29.27)},
    },
    closedShops = { -- allows multiple peds with their own inventory label MUST BE UNIQUE
        {ped = 'mp_m_freemode_01', loc = vector4(129.02, -1283.25, 29.27, 120.67), label = 'Vanilla Unicorn Shop'}
    },
    closedShopItems = { -- items allowed in closed shops
        tequila        =   {name = 'tequila',      price = 5},
        whiskey        =   {name = 'whiskey',      price = 5},
        rum            =   {name = 'rum',          price = 5},
        gin            =   {name = 'gin',          price = 5},
        lime           =   {name = 'lime',         price = 5},
        lemon          =   {name = 'lemon',        price = 5},
        orange         =   {name = 'orange',       price = 5},
        sugar          =   {name = 'sugar',        price = 5},
        salt           =   {name = 'salt',         price = 5},
        ice            =   {name = 'ice',          price = 5},
        soda_water     =   {name = 'soda_water',   price = 5},
        tonic_water    =   {name = 'tonic_water',  price = 5},
        ecola          =   {name = 'ecola',        price = 5},
        ginger_ale     =   {name = 'ginger_ale',   price = 5},
        bitters        =   {name = 'bitters',      price = 5},
        grenadine      =   {name = 'grenadine',    price = 5},
        vermouth       =   {name = 'vermouth',     price = 5},
        simple_syrup   =   {name = 'simple_syrup', price = 5}
    },
    craftingStations = { --must match the key value in locations
        cocktail = {
            {anim = 'cocktail', give = {ice = 1, soda_water = 1, vodka = 1},                    take = {vodka_soda = 1},        progtext = 'Making'},
            {anim = 'cocktail', give = {vodka = 1, ginger_ale = 1, lime = 1, ice = 1},          take = {moscow_mule = 1},       progtext = 'Making'},
            {anim = 'cocktail', give = {tequila = 1, orange = 1, grenadine = 1, ice = 1},       take = {tequila_sunrise = 1},   progtext = 'Making'},
            {anim = 'cocktail', give = {whiskey = 1, lemon = 1, sugar = 10, ice = 1},            take = {whiskey_sour = 1},      progtext = 'Making'},
            {anim = 'cocktail', give = {gin = 1, tonic_water = 1, ice = 1, lime = 1},           take = {gin_and_tonic = 1},     progtext = 'Making'},
            {anim = 'cocktail', give = {rum = 1, ecola = 1, ice = 1},                           take = {rum_and_coke = 1},      progtext = 'Making'},
            {anim = 'cocktail', give = {gin = 1, soda_water = 1, lime = 1, sugar = 1, ice = 1}, take = {gin_fizz = 1},          progtext = 'Making'},
            {anim = 'cocktail', give = {rum = 1, lime = 1, orange = 1, grenadine = 1, ice = 1}, take = {rum_punch = 1},         progtext = 'Making'},
            {anim = 'cocktail', give = {vodka = 1, orange = 1, ice = 1},                        take = {screwdriver = 1},       progtext = 'Making'},
            {anim = 'cocktail', give = {rum = 1, lime = 1, sugar = 1, soda_water = 1, ice = 1}, take = {mojito = 1},            progtext = 'Making'},
            {anim = 'cocktail', give = {rum = 1, lime = 1, sugar = 1, ice = 1},                 take = {daiquiri = 1},          progtext = 'Making'}
        },
        coffee = {
            {anim = 'uncuff',give = {}, take = {coffee = 1}, progtext = 'Pouring' }
        },
        ice = {
            {anim = 'uncuff', give = {}, take = {ice = 1}, progtext = 'Scooping' }
        }
    },
    catering = { -- accessible in Till
        commission = 0.2,
        items = {
            {name = 'vodka',        minPrice = 10, maxPrice = 20, maxAmount = 30},
            {name = 'tequila',      minPrice = 10, maxPrice = 20, maxAmount = 30},
        },
        Van = {model = 'burrito', label = 'Burrito', plate = 'policeCATER', loc = vector4(144.72, -1300.25, 28.89, 121.44), heading = 118.78},
    },
    shops = { -- must match the key value in locations
        ingridients = {
            {name = 'vodka',        price = 5, amount = 50},
            {name = 'tequila',      price = 5, amount = 50},
            {name = 'whiskey',      price = 5, amount = 50},
            {name = 'rum',          price = 5, amount = 50},
            {name = 'gin',          price = 5, amount = 50},
            {name = 'lime',         price = 5, amount = 50},
            {name = 'lemon',        price = 5, amount = 50},
            {name = 'orange',       price = 5, amount = 50},
            {name = 'sugar',        price = 5, amount = 50},
            {name = 'salt',         price = 5, amount = 50},
            {name = 'ice',          price = 5, amount = 50},
            {name = 'soda_water',   price = 5, amount = 50},
            {name = 'tonic_water',  price = 5, amount = 50},
            {name = 'ecola',        price = 5, amount = 50},
            {name = 'ginger_ale',   price = 5, amount = 50},
            {name = 'bitters',      price = 5, amount = 50},
            {name = 'grenadine',    price = 5, amount = 50},
            {name = 'vermouth',     price = 5, amount = 50},
            {name = 'simple_syrup', price = 5, amount = 50},
        }
    },
        --- in CraftData/StoreData YOU DO NOT NEED prop or heading as these are not needed for the interaction. If you want to spawn an Object, They ARE needed
    locations = { -- l = length, w = width, lwr = (for target) lower height, upr = (for target)  upper height, r = rotation
        Crafter = { -- CraftData.type MUST MATCH A KEY VALUE IN craftStations ABOVE so type = 'cocktail' will look for cocktail in craftingStations
            {CraftData = {type = 'coffee', targetLabel = 'Make Coffee', menuLabel = 'Make Coffee!',prop = 'prop_coffee_mac_02'},
                loc = vector3(130.66, -1281.72, 29.5), l = 0.5, w = 0.4, lwr = 0.25, upr = 0.25, r = 40, job = 'police'},
            {CraftData = {type = 'ice', targetLabel = 'Grab Ice', menuLabel = 'Grab Ice!' }, 
                loc = vector3(127.95, -1281.9, 28.99), l = 1.25, w = 0.65, lwr = 0.5, upr = 0.5, r = 40, job = 'police'},
            {CraftData = {type = 'cocktail', targetLabel = 'Make Cocktail', menuLabel = 'Make Cocktail!' },
                loc = vector3(128.19, -1282.81, 29.44), l = 0.7, w = 0.6, lwr = 0.25, upr = 0.25, r = 120, job = 'police'},
            {CraftData = {type = 'cocktail', targetLabel = 'Make Cocktail', menuLabel = 'Make Cocktail!'},
                loc = vector3(128.57, -1283.46, 29.42), l = 0.7, w = 0.6, lwr = 0.25, upr = 0.25, r = 120, job = 'police'},
        },
        Stores = { -- prop is only needed if you want to spawn an object | prop = 'prop_bar_fridge_01' for example
            {StoreData = {type = 'ingridients', targetLabel = 'Get Ingredients', menuLabel = 'Get Ingredients!'},
                loc = vector3(132.64, -1286.02, 28.84), l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 40, job = 'police'},
            {StoreData = {type = 'ingridients', targetLabel = 'Get Ingredients', menuLabel = 'Get Ingredients!'},
                loc = vector3(131.99, -1284.91, 28.73), l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 40, job = 'police'},
            {StoreData = {type = 'ingridients', targetLabel = 'Get Ingredients', menuLabel = 'Get Ingredients!'},
                loc = vector3(129.97, -1281.44, 28.74), l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 40, job = 'police'},
            {StoreData = {type = 'ingridients', targetLabel = 'Get Ingredients', menuLabel = 'Get Ingredients!'},
                loc = vector3(129.14, -1279.99, 28.68), l = 0.7, w = 1.0, lwr = 0.50, upr = 0.5, r = 120, job = 'police'},
        },
        Tills = { -- prop is only needed if you want to spawn an object | prop = 'prop_till_03' for example
            {loc = vec3(130.83, -1282.33, 29.42), l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 40,  commission = 0.2, job = 'police'},
            {loc = vec3(129.32, -1284.75, 29.44), l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 40,  commission = 0.2, job = 'police'},
            {loc = vec3(133.31, -1286.82, 29.4),  l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 40,  commission = 0.2, job = 'police'},
        },
        stash = { -- prop is only needed if you want to spawn an object | prop = 'prop_lev_crate_01' for example
            {prop = 'prop_drop_crate_01',loc = vec3(131.6136, -1287.2435, 28.2753), l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 120,slots = 20, weight = 100000, job = 'police'},
        },
        trays = { -- storages to place things for people | prop is only needed if you want to spawn an object | prop = 'prop_bar_fridge_01' for example
            {prop = 'prop_food_tray_01', label = 'Grab Food', loc = vector3(129.6180, -1286.6339, 29.2904), l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 214, slots = 20, weight = 100000, job = 'police'},
        }
    }
}
```

- yeah this locations table is scary so lets break it down option by option!

## Crafter
 - so we have locations.Crafter now but how do we format it and what is all these numbers. im lost!
 - each crafter location needs a craftdata table like this 
   ```lua
      {CraftData = {type = 'coffee', targetLabel = 'Make Coffee', menuLabel = 'Make Coffee!',prop = 'prop_coffee_mac_02'},
   ```
   - type = type of crafter
      - remember when we did craftStatons and we made crafting types!
      - so here we have type = 'coffee' so it will grab the info from craftStations.coffee !
   - targetLabel 
      - what do you want the third eye target to say?
   - menuLabel
     - What do you want the ox context menu header to say?
   - prop = 'prop_coffee_mac_02'
     - this is **only** if you want to spawn a prop for this location!
       - if you dont need a prop to spawn, you can leave it completely out like this 
         ```lua
             {CraftData = {type = 'coffee', targetLabel = 'Make Coffee', menuLabel = 'Make Coffee!',}
         ```
  
### now that we have the craftdata making sense, lets get to the other part of the location
```lua
    {CraftData = {type = 'coffee', targetLabel = 'Make Coffee', menuLabel = 'Make Coffee!',prop = 'prop_coffee_mac_02'},
        loc = vector3(130.66, -1281.72, 29.5), l = 0.5, w = 0.4, lwr = 0.25, upr = 0.25, r = 40, job = 'police'},
```
- loc = location where this target goes
- l = length of the target zone
- w = width of target zone
- lwr = the lower height of the target zone
- upr = the uppr height of the target zone
- r = the rotation of the target zone
- job = what job this is for

so this doesnt seem to hard! 

now lets look again at Crafters 
  ```lua
    Crafter = { -- CraftData.type MUST MATCH A KEY VALUE IN craftStations ABOVE so type = 'cocktail' will look for cocktail in craftingStations
            {CraftData = {type = 'coffee', targetLabel = 'Make Coffee', menuLabel = 'Make Coffee!',prop = 'prop_coffee_mac_02'},
                loc = vector3(130.66, -1281.72, 29.5), l = 0.5, w = 0.4, lwr = 0.25, upr = 0.25, r = 40, job = 'police'},
            {CraftData = {type = 'ice', targetLabel = 'Grab Ice', menuLabel = 'Grab Ice!' }, 
                loc = vector3(127.95, -1281.9, 28.99), l = 1.25, w = 0.65, lwr = 0.5, upr = 0.5, r = 40, job = 'police'},
            {CraftData = {type = 'cocktail', targetLabel = 'Make Cocktail', menuLabel = 'Make Cocktail!' },
                loc = vector3(128.19, -1282.81, 29.44), l = 0.7, w = 0.6, lwr = 0.25, upr = 0.25, r = 120, job = 'police'},
            {CraftData = {type = 'cocktail', targetLabel = 'Make Cocktail', menuLabel = 'Make Cocktail!'},
                loc = vector3(128.57, -1283.46, 29.42), l = 0.7, w = 0.6, lwr = 0.25, upr = 0.25, r = 120, job = 'police'},
        },
  ```
- this means there are 4 locations to craft at
  - 2 cocktails
  - 1 ice
  - 1 coffee
- and if we look back at craftStations we should have 
   ```lua
     craftingStations = { --must match the key value in locations
        cocktail = {
            {anim = 'cocktail', give = {ice = 1, soda_water = 1, vodka = 1},                    take = {vodka_soda = 1},        progtext = 'Making'},
            {anim = 'cocktail', give = {vodka = 1, ginger_ale = 1, lime = 1, ice = 1},          take = {moscow_mule = 1},       progtext = 'Making'},
            {anim = 'cocktail', give = {tequila = 1, orange = 1, grenadine = 1, ice = 1},       take = {tequila_sunrise = 1},   progtext = 'Making'},
            {anim = 'cocktail', give = {whiskey = 1, lemon = 1, sugar = 10, ice = 1},            take = {whiskey_sour = 1},      progtext = 'Making'},
            {anim = 'cocktail', give = {gin = 1, tonic_water = 1, ice = 1, lime = 1},           take = {gin_and_tonic = 1},     progtext = 'Making'},
            {anim = 'cocktail', give = {rum = 1, ecola = 1, ice = 1},                           take = {rum_and_coke = 1},      progtext = 'Making'},
            {anim = 'cocktail', give = {gin = 1, soda_water = 1, lime = 1, sugar = 1, ice = 1}, take = {gin_fizz = 1},          progtext = 'Making'},
            {anim = 'cocktail', give = {rum = 1, lime = 1, orange = 1, grenadine = 1, ice = 1}, take = {rum_punch = 1},         progtext = 'Making'},
            {anim = 'cocktail', give = {vodka = 1, orange = 1, ice = 1},                        take = {screwdriver = 1},       progtext = 'Making'},
            {anim = 'cocktail', give = {rum = 1, lime = 1, sugar = 1, soda_water = 1, ice = 1}, take = {mojito = 1},            progtext = 'Making'},
            {anim = 'cocktail', give = {rum = 1, lime = 1, sugar = 1, ice = 1},                 take = {daiquiri = 1},          progtext = 'Making'}
        },
        coffee = {
            {anim = 'uncuff',give = {}, take = {coffee = 1}, progtext = 'Pouring' }
        },
        ice = {
            {anim = 'uncuff', give = {}, take = {ice = 1}, progtext = 'Scooping' }
        }
    },
  ```
  showing that we have all the types we made!

## Stores
### pretty much the same thing as Crafters!
```lua
  Stores = { -- prop is only needed if you want to spawn an object | prop = 'prop_bar_fridge_01' for example
      {StoreData = {type = 'ingridients', targetLabel = 'Get Ingredients', menuLabel = 'Get Ingredients!'},
          loc = vector3(132.64, -1286.02, 28.84), l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 40, job = 'police'},
      {StoreData = {type = 'ingridients', targetLabel = 'Get Ingredients', menuLabel = 'Get Ingredients!'},
          loc = vector3(131.99, -1284.91, 28.73), l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 40, job = 'police'},
      {StoreData = {type = 'ingridients', targetLabel = 'Get Ingredients', menuLabel = 'Get Ingredients!'},
          loc = vector3(129.97, -1281.44, 28.74), l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 40, job = 'police'},
      {StoreData = {type = 'ingridients', targetLabel = 'Get Ingredients', menuLabel = 'Get Ingredients!'},
          loc = vector3(129.14, -1279.99, 28.68), l = 0.7, w = 1.0, lwr = 0.50, upr = 0.5, r = 120, job = 'police'},
  },
```
but this time we have StoreData instead of CraftData!

Other than that change Everything is the same as Crafter!

It just will look for 
```lua
    shops = { -- must match the key value in locations
        ingridients = {
        }
    }
```

## Tills
### so now its a format change! lets break this down easier
```lua
    Tills = { -- prop is only needed if you want to spawn an object | prop = 'prop_till_03' for example
      {loc = vec3(130.83, -1282.33, 29.42), l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 40,  commission = 0.2, job = 'police'},
      {loc = vec3(129.32, -1284.75, 29.44), l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 40,  commission = 0.2, job = 'police'},
      {loc = vec3(133.31, -1286.82, 29.4),  l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 40,  commission = 0.2, job = 'police'},
    },
```
- loc = where you want it 
- l = length of target box
- w = width of target box
- lwr = lower height of target box
- upr = upper height of target box
- r = rotation of target box
- commission = 0.2 -- 20% of the sale on that till will be commission paid to the biller
- job = job name

this one is fairly straight forward! 

## Stash and Trays!
### Stash and Trays Are the same thing besides one difference, trays anyone can open!
```lua
   stash = { -- prop is only needed if you want to spawn an object | prop = 'prop_lev_crate_01' for example
       {prop = 'prop_drop_crate_01',loc = vec3(131.6136, -1287.2435, 28.2753), l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 120,slots = 20, weight = 100000, job = 'police'},
   },
   trays = { -- storages to place things for people | prop is only needed if you want to spawn an object | prop = 'prop_bar_fridge_01' for example
       {prop = 'prop_food_tray_01', label = 'Grab Food', loc = vector3(129.6180, -1286.6339, 29.2904), l = 0.5, w = 0.5, lwr = 0.10, upr = 0.25, r = 214, slots = 20, weight = 100000, job = 'police'},
   }
```
- prop = if you **want** to spawn a prop, just add which one here 
- label = the target label
- l = length of target
- w = width of target
- lwr = lower height of target
- upr = upper heigh of target
- r = rotation of target
- slots = how many slots the stash or tray will have
- weight = how much weight of the stash or tray can carry

# the hardest part is here
- make sure to add this file into server/locations folder. it will populate all that data you made on the next restart! 