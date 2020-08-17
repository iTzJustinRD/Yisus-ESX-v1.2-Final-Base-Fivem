Config                            = {}
Config.DrawDistance               = 100
Config.MarkerColor                = {r = 120, g = 120, b = 240}
Config.EnablePlayerManagement     = false -- enables the actual car dealer job. You'll need esx_addonaccount, esx_billing and esx_society
Config.ResellPercentage           = 50

Config.Locale                     = 'en'

Config.LicenseEnable = false
Config.PlateLetters  = 2
Config.PlateNumbers  = 3
Config.PlateLetters2  = 3
Config.PlateUseSpace = false

Config.Zones = {

	ShopEntering = {
		Pos   = vector3(-811.39831542969,-218.68298339844,36.396062469482),
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Type  = 1
	},

	ShopInside = {
		Pos     = vector3(-783.29, -223.92, 36.50),
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Heading = 128.0,
		Type    = -1
	},

	ShopOutside = {
		Pos     = vector3(-771.8, -232.31, 36.50),
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Heading = 206.83,
		Type    = -1
	}
}
