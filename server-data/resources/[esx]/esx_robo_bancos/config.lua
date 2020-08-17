Config = {}

Config.ItemNeeded = "net_cracker"
Config.MaxLives = 3 -- this is the max lives in hacking thing don't set more than 5. thank you
Config.CopsNeeded = 0 -- number of cops required to start the robbery
Config.BlackMoney = true -- true for black_money and false for cash

Config.Trolley = {
    ["cash"] = { 200, 500 }, -- this is what you receive every cash stack math.random(1, 2)
    ["model"] = GetHashKey("hei_prop_hei_cash_trolly_01")
}

Config.EmptyTrolley = {
    ["model"] = GetHashKey("hei_prop_hei_cash_trolly_03")
}

Config.Bank = {
    ["Main Fleeca"] = {
        ["start"] = { 
            ["pos"] = vector3(-2956.5498046875, 481.62054443359, 15.697087287903), 
            ["heading"] = 359.48452758789 
        },
        ["door"] = { 
            ["pos"] = vector3(-2957.7080078125, 481.89660644531, 15.697031974792),
            ["model"] = -63539571
        },
        ["device"] = {
            ["model"] = -160937700
        },
        ["trolleys"] = {
            ["left"] = { 
                ["pos"] = vector3(-2952.837890625, 485.85018920898, 15.675424575806), 
                ["heading"] = 315.0 + 180.0
            },
            ["right"] = { 
                ["pos"] = vector3(-2952.984375, 482.74969482422, 15.675343513489), 
                ["heading"] = 220.0 + 180.0
            },
        }
    },
    ["Fleeca2"] = {
        ["start"] = { 
            ["pos"] = vector3(311.0, -284.42, 54.16), 
            ["heading"] = 241.81 
        },
        ["door"] = { 
            ["pos"] = vector3(312.358, -282.73010, 54.30365),
            ["model"] = -63539571
        },
        ["device"] = {
            ["model"] = -160937700
        },
        ["trolleys"] = {
            ["left"] = { 
                ["pos"] = vector3(311.12, -287.93, 54.14), 
                ["heading"] = 121.20 + 180.0
            },
            ["right"] = { 
                ["pos"] = vector3(314.04, -289.07, 54.14), 
                ["heading"] = 202.61 + 180.0
            },
        }
    },
	["Fleeca3"] = {
        ["start"] = { 
            ["pos"] = vector3(-354.10, -55.31, 49.04),
            ["heading"] = 245.13 
        },
        ["door"] = { 
            ["pos"] = vector3(-352.73650, -53.57248, 49.17543),
            ["model"] = -63539571
        },
        ["device"] = {
            ["model"] = -160937700
        },
        ["trolleys"] = {
            ["left"] = { 
                ["pos"] = vector3(-353.86, -58.84, 49.01), 
                ["heading"] = 119.10 + 180.0
            },
            ["right"] = { 
                ["pos"] = vector3(-351.07, -60.0, 49.01), 
                ["heading"] = 200.72 + 180.0
            },
        }
    },
	["Fleeca4"] = {
        ["start"] = { 
            ["pos"] = vector3(-1211.04, -336.70, 37.78),
            ["heading"] = 294.29 
        },
        ["door"] = { 
            ["pos"] = vector3(-1211.261, -334.5596, 37.91989),
            ["model"] = -63539571
        },
        ["device"] = {
            ["model"] = -160937700
        },
        ["trolleys"] = {
            ["left"] = { 
                ["pos"] = vector3(-1208.29, -339.07, 37.76), 
                ["heading"] = 160.57 + 180.0
            },
            ["right"] = { 
                ["pos"] = vector3(-1205.47, -337.73, 37.76), 
                ["heading"] = 254.74 + 180.0
            },
        }
    },
	["Fleeca5"] = {
        ["start"] = { 
            ["pos"] = vector3(146.60, -1046.07, 29.37),
            ["heading"] = 249.49 
        },
        ["door"] = { 
            ["pos"] = vector3(148.0266, -1044.364, 29.50693),
            ["model"] = -63539571
        },
        ["device"] = {
            ["model"] = -160937700
        },
        ["trolleys"] = {
            ["left"] = { 
                ["pos"] = vector3(146.96, -1049.56, 29.35), 
                ["heading"] = 114.15 + 180.0
            },
            ["right"] = { 
                ["pos"] = vector3(149.65, -1050.70, 29.35), 
                ["heading"] = 205.79 + 180.0
            },
        }
    },
	["Fleeca6"] = {
        ["start"] = { 
            ["pos"] = vector3(1176.29, 2712.94, 38.09),
            ["heading"] = 91.10
        },
        ["door"] = { 
            ["pos"] = vector3(1175.542, 2710.861, 38.22),
            ["model"] = -63539571
        },
        ["device"] = {
            ["model"] = -160937700
        },
        ["trolleys"] = {
            ["left"] = { 
                ["pos"] = vector3(1174.83, 2716.08, 38.07), 
                ["heading"] = 319.22 + 180.0
            },
            ["right"] = { 
                ["pos"] = vector3(1171.88, 2716.33, 38.07), 
                ["heading"] = 47.54 + 180.0
            },
        }
    },
}