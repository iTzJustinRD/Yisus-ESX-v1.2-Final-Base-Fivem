Config                            = {}

Config.DrawDistance               = 100.0

Config.Marker                     = {type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false}

Config.ReviveReward               = 700  -- revive reward, set to 0 if you don't want it enabled
Config.AntiCombatLog              = true -- enable anti-combat logging?
Config.LoadIpl                    = true -- disable if you're using fivem-ipl or other IPL loaders

Config.Locale                     = 'es'

Config.EarlyRespawnTimer          = 60000 * 1  -- time til respawn is available
Config.BleedoutTimer              = 60000 * 10 -- time til the player bleeds out

Config.EnablePlayerManagement     = true

Config.RemoveWeaponsAfterRPDeath  = true
Config.RemoveCashAfterRPDeath     = true
Config.RemoveItemsAfterRPDeath    = true

-- Let the player pay for respawning early, only if he can afford it.
Config.EarlyRespawnFine           = false
Config.EarlyRespawnFineAmount     = 5000

Config.RespawnPoint = {coords = vector3(341.0, -1397.3, 32.5), heading = 48.5}

Config.Hospitals = {

	CentralLosSantos = {

		Blip = {
			coords = vector3(336.86, -589.59, 42.29),
			sprite = 61,
			scale  = 1.0,
			color  = 2
		},

		AmbulanceActions = {
			vector3(301.1, -600, 43.3)
		},

		Pharmacies = {
			vector3(309.12, -562.53, 42.29)
		}, 
		

		Vehicles = {
			{
				Spawner = vector3(330.46, -555.02, 27.75),
				InsideShop = vector3(320.69, -546.88, 28.74),
				Marker = {type = 27, x = 1.5, y = 1.5, z = 2.0, r = 100, g = 50, b = 200, a = 100, rotate = false},
				SpawnPoints = {
					{coords = vector3(317.66, -553.37, 28.75), heading = 269.1, radius = 2.0},
					{coords = vector3(316.35, -547.14, 28.75), heading = 269.1, radius = 2.0},
					{coords = vector3(317.67, -541.24, 28.75), heading = 269.1, radius = 2.0},
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(341.8, -581.1, 73.9),
				InsideShop = vector3(305.6, -1419.7, 41.5),
				Marker = {type = 27, x = 1.5, y = 1.5, z = 1.5, r = 100, g = 150, b = 150, a = 100, rotate = true},
				SpawnPoints = {
					{coords = vector3(352.1, -588.4 , 74.2), heading = 142.7, radius = 10.0},
					
				}
			}
		},
	}
}

Config.AuthorizedVehicles = {
	car = {
		ambulance = {
			{model = 'lguard', price = 500},
			{model = 'ambulance', price = 500}
		},

		doctor = {
			{model = 'lguard', price = 500},
			{model = 'ambulance', price = 450}
		},

		chief_doctor = {
			{model = 'lguard', price = 500},
			{model = 'ambulance', price = 300}
		},

		boss = {
			{model = 'lguard', price = 500},
			{model = 'ambulance', price = 200}
		}
	},

	helicopter = {
		ambulance = {},

		doctor = {
			{model = 'buzzard2', price = 1000}
		},

		chief_doctor = {
			{model = 'buzzard2', price = 1000},
			{model = 'seasparrow', price = 3000}
		},

		boss = {
			{model = 'buzzard2', price = 1000},
			{model = 'seasparrow', price = 200}
		}
	}
}
