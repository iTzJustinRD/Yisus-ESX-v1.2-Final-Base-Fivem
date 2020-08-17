Config = {}

Config.DrawDistance = 25.0
Config.JuiceSellEarnings = 10 -- Ganancias x zumos
Config.AppleSellEarnings = 1 -- Ganancias x manzanas
Config.OrangeSellEarnings = 1 -- Ganancias por Naranjas

Config.AuthorizedVehicles = {
    {model = 'tractor2', label = 'Vehículo de trabajo', price = 0}
}

Config.Zones = {

    VehicleSpawner = {
        Pos = {x = 407.87, y = 6498.17, z = 26.8},
        Size = {x = 1.5, y = 1.5, z = 1.5},
        Color = {r = 1, g = 204, b = 0},
        Text = 'Presiona [E] ~s~ para sacar un vehículo',
        Type = 23,
        Rotate = false
    },

    VehicleSpawnPoint = {
        Pos = {x = 397.43, y = 6492.58, z = 27.1},
        Size = {x = 1.5, y = 1.5, z = 1.0},
        Type = -1,
        Rotate = false,
        Heading = 88.33
    },

    VehicleDeleter = {
        Pos = {x = 418.83740234375, y = 6480.482421875, z = 27.90},
        Size = {x = 3.0, y = 3.0, z = 0.25},
        Color = {r = 255, g = 0, b = 0},
        Text = 'Presiona [E] para devolver el vehículo',
        Type = 23,
        Rotate = false
    },

    Cloakroom = {
        Pos = {x = 405.53994750977, y = 6526.32421875, z = 26.70},
        Size = {x = 1.5, y = 1.5, z = 1.5},
        Color = {r = 1, g = 204, b = 0},
        Text = 'Presiona [E] para abrir el vestuario',
        Type = 23,
        Rotate = false
    },

    Job1 = {
        Pos = {x = 354.81, y = 6516.67, z = 27.6},
        Size = {x = 25.0, y = .0, z = .0},
        Color = {r = 211, g = 211, b = 211},
        Text = 'Presiona [E] para empezar a recoger fruta',
        Type = 23,
        Rotate = false
    },

    Job1b = {
        Pos = {x = 247.94, y = 6513.16, z = 28.60},
        Size = {x = 20.0, y = .0, z = .0},
        Color = {r = 211, g = 211, b = 211},
        Text = 'Presiona [E] ~s~para empezar a recoger fruta',
        Type = 23,
        Rotate = false
    },

    Job3a = {
        Pos = {x = 1721.0994873047, y = 6407.4560546875, z = 33.14}, 
        Size = {x = 1.5, y = 1.5, z = 1.5},
        Color = {r = 255, g = 159, b = 0},
        Text = 'Presiona [E] ~s~ para sacar sacar la fruta del vehículo',
        Type = 23,
        Rotate = false
    },
}
