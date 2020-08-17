Config = {}
Config.DrawDistance = 100.0

Config.EnablePlayerManagement = true
Config.EnableMoneyWash = true
Config.MaxInService = -1
Config.Locale = 'es'

Config.MissCraft = 15 -- %

Config.Blips = {
    Blip = {
      Pos     = { x = -711.71, y = -915.35, z = 19.22 },
      Sprite  = 52,
      Display = 4,
      Scale   = 1.0,
      Colour  = 3,
    },

    Blip2 = {
        Pos     = { x = 1166.41, y = 2704.32, z = 38.17 },
        Sprite  = 52,
        Display = 4,
        Scale   = 1.0,
        Colour  = 3,
      },
}

Config.Zones = {
    Cloakroom = {
        Pos   = { x = -698.77, y = -911.9, z = 18.24 },
        Size  = { x = 1.5, y = 1.5, z = 1.0 },
        Color = { r = 255, g = 187, b = 255 },
        Type  = 27,
    },

    Cloakroom2 = {
        Pos   = { x = 1166.13, y = 2714.24, z = 37.16 },
        Size  = { x = 1.5, y = 1.5, z = 1.0 },
        Color = { r = 255, g = 187, b = 255 },
        Type  = 27,
    },

    Vaults = {
        Pos   = { x = -705.78735351563, y = -915.30322265625, z = 18.215587615967 },    
        Size  = { x = 1.3, y = 1.3, z = 1.0 },
        Color = { r = 30, g = 144, b = 255 },
        Type  = 23,
    },

    VaultsNorte = {
        Pos   = { x = 1163.6944580078, y = 2711.9562988281, z = 37.157665252686 }, 
        Size  = { x = 1.3, y = 1.3, z = 1.0 },
        Color = { r = 30, g = 144, b = 255 },
        Type  = 23,
    },

    VaultJefe = {
        Pos = { x = -701.54595947266, y = -910.42266845703, z = 18.314126586914},  
        Size  = { x = 1.3, y = 1.3, z = 1.0 },
        Color = { r = 255, g = 144, b = 255 },
        Type  = 23,
    },

    VaultJefeNorte = {
        Pos = { x = 1166.9078369141, y = 2718.7211914063, z = 36.157646179199},
        Size  = { x = 1.3, y = 1.3, z = 1.0 },
        Color = { r = 255, g = 144, b = 255 },
        Type  = 23,
    },

    Tienda = {
        Pos   = { x = -705.62, y = -915.04, z = 18.22 },
        Size  = { x = 1.6, y = 1.6, z = 1.0 },
        Color = { r = 238, g = 0, b = 0 },
        Type  = 23,
        Items = {
            { name = 'water', label = 'Agua', price = 3 },
            { name = 'bread', label = 'Pan', price = 3}
        },
    },

    Tienda2 = {
        Pos   = { x = 1164.35, y = 2711.64, z = 37.16 },
        Size  = { x = 1.6, y = 1.6, z = 1.0 },
        Color = { r = 238, g = 0, b = 0 },
        Type  = 23,
        Items = {
            { name = 'water', label = 'Agua', price = 3 },
            { name = 'bread', label = 'Pan', price = 3}
        },
    },

    BossActions = {
        Pos   = { x = -709.44, y = -907.08, z = 18.25 },
        Size  = { x = 1.5, y = 1.5, z = 1.0 },
        Color = { r = 0, g = 100, b = 0 },
        Type  = 1,
    },

    BossActions2 = {
        Pos   = { x = 1168.63, y = 2717.94, z = 36.16 },
        Size  = { x = 1.5, y = 1.5, z = 1.0 },
        Color = { r = 0, g = 100, b = 0 },
        Type  = 1,
    },
}

Config.Uniforms = {
  empleado_outfit = {
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 83,   ['torso_2'] = 1,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 11,
        ['pants_1'] = 4,   ['pants_2'] = 4,
        ['shoes_1'] = 1,   ['shoes_2'] = 0,
        ['chain_1'] = 0,  ['chain_2'] = 0
    },
    female = {
        ['tshirt_1'] = 14,   ['tshirt_2'] = 0,
        ['torso_1'] = 1,    ['torso_2'] = 1,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 5,
        ['pants_1'] = 0,   ['pants_2'] = 10,
        ['shoes_1'] = 1,    ['shoes_2'] = 0,
        ['chain_1'] = 0,    ['chain_2'] = 0
    },
}}
