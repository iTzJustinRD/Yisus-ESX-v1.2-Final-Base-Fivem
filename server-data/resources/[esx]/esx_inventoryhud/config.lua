Config = {}
Config.Locale = "es"
Config.IncludeWeapons = true -- Incluir armas en el inventario
Config.IncludeAccounts = true -- Incluir cuentas (banco, dinero negro...)
Config.ExcludeAccountsList = {"bank"}-- Cuentas a excluir del inventario
Config.OpenControl = 289 -- Tecla abrir inventario. Editar html/js/config.js para cambiar la tecla de cierre

-- Lista de objetos usables (Para cerrar el inventario una vez usados)
Config.CloseUiItems = {"sportlunch", 
                    "protein_shake", 
                    "powerade", 
                    "fixkit", 
                    "blowtorch",
                    "c4_bank",
                    "raspberry",
                    "clip",
                    --drogas
                    "cocaine",
                    "meth", 
                    "coke_streak", 
                    "weedseed",
                    "beer"
                }   

Config.ShopBlipID = 52
Config.LiquorBlipID = 93
Config.PrisonShopBlipID = 52
Config.WeaponShopBlipID = 110

Config.ShopLength = 14
Config.LiquorLength = 10
Config.PrisonShopLength = 2

Config.Color = 2
Config.WeaponColor = 1

Config.WeaponLiscence = {x = 12.47, y = -1105.5, z = 29.8}
Config.LicensePrice = 500

Config.Shops = {
    RegularShop = {
        Locations = {
            {x = 373.875, y = 325.896, z = 102.566},
            {x = 2557.458, y = 382.282, z = 107.622},
            {x = -3038.939, y = 585.954, z = 6.908},
            {x = -3241.927, y = 1001.462, z = 11.830},
            {x = 547.431, y = 2671.710, z = 41.156},
            {x = 1961.464, y = 3740.672, z = 31.343},
            {x = 2678.916, y = 3280.671, z = 54.241},
            {x = 1729.216, y = 6414.131, z = 34.037},
            {x = -48.519, y = -1757.514, z = 28.421},
            {x = 1163.373, y = -323.801, z = 68.205},
            {x = -1820.523, y = 792.518, z = 137.118},
            {x = 1698.388, y = 4924.404, z = 41.063},
            {x = 25.723, y = -1346.966, z = 28.497},
			{x = 464.72,	y = -989.86,  z = 29.69}
        },
        Items = {
            {name = 'water'},
            {name = 'bread'},
            {name = 'beer'},
            {name = 'wine'}
        
        }
    },
    
    PrisonShop = {
        Locations = {
            {x = 1765.63, y = 2576.79, z = 44.92},
        },
        Items = {
            {name = 'water'},
            {name = 'bread'},
            {name = 'beer'},
            {name = 'wine'}
        }
    },
    
    WeaponShop = {
        Locations = {
            {x = -662.180, y = -934.961, z = 20.829}, -- Badulake
            {x = 1693.44, y = 3760.16, z = 33.71}, -- Sandy
            {x = -330.24, y = 6083.88, z = 30.45}, -- Paleto
            {x = 22.09, y = -1107.28, z = 28.80}-- Concesionario
        },
        Weapons = {
            {name = "WEAPON_FIREEXTINGUISHER", ammo = 1},
            {name = "WEAPON_KNIFE", ammo = 1},
            {name = "WEAPON_BAT", ammo = 1},
            {name = "GADGET_PARACHUTE", ammo = 1}
        },
        Ammo = {
        
        },
        Items = {
            {name = 'clip'}
        }
    }
}
