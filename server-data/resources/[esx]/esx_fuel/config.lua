Config = {}

-- Are you using ESX? Turn this to true if you would like fuel & jerry cans to cost something.
Config.UseESX = true

-- What should the price of jerry cans be?
Config.JerryCanCost = 100
Config.RefillCost = 50 -- If it is missing half of it capacity, this amount will be divided in half, and so on.

-- Fuel decor - No need to change this, just leave it.
Config.FuelDecor = "_FUEL_LEVEL"

-- What keys are disabled while you're fueling.
Config.DisableKeys = {0, 22, 23, 24, 29, 30, 31, 37, 44, 56, 82, 140, 166, 167, 168, 170, 288, 289, 311, 323}

-- Want to use the HUD? Turn this to true.
Config.EnableHUD = false

-- Configure blips here. Turn both to false to disable blips all together.
Config.ShowNearestGasStationOnly = true
Config.ShowAllGasStations = false

-- Modify the fuel-cost here, using a multiplier value. Setting the value to 2.0 would cause a doubled increase.
Config.CostMultiplier = 1.0

-- Configure the strings as you wish here.
Config.Strings = {
	ExitVehicle = "Sal del vehículo para repostar",
	EToRefuel = "Presiona ~g~E ~w~para repostar",
	JerryCanEmpty = "El bidón de gasolina está vacío",
	FullTank = "Depósito lleno",
	PurchaseJerryCan = "Presiona ~g~E ~w~para comprar un bidón de gasolina por ~g~$" .. Config.JerryCanCost,
	CancelFuelingPump = "Presiona ~g~E ~w~para cancelar el repostaje",
	CancelFuelingJerryCan = "Presiona ~g~E ~w~para parar de llenar el bidón de gasolina",
	NotEnoughCash = "No tiene suficiente dinero",
	RefillJerryCan = "Presiona ~g~E ~w~ para rellenar tu bidón de gasolina por ",
	NotEnoughCashJerryCan = "No tienes suficiente dinero para rellenar tu bidón de gasolina",
	JerryCanFull = "Bidón de gasolina lleno",
	TotalCost = "Coste",
}

Config.PumpModels = {
	[-2007231801] = true,
	[1339433404] = true,
	[1694452750] = true,
	[1933174915] = true,
	[-462817101] = true,
	[-469694731] = true,
	[-164877493] = true
}

-- Blacklist certain vehicles. Use names or hashes. https://wiki.gtanet.work/index.php?title=Vehicle_Models
Config.Blacklist = {
	--"Adder", --model
	--276773164 -- or hash
}

-- Do you want the HUD removed from showing in blacklisted vehicles?
Config.RemoveHUDForBlacklistedVehicle = true


Config.Classes = {
	[0] = 0.3, -- Compacts
	[1] = 0.3, -- Sedans
	[2] = 0.3, -- SUVs
	[3] = 0.3, -- Coupes
	[4] = 0.3, -- Muscle
	[5] = 0.3, -- Sports Classics
	[6] = 0.3, -- Sports
	[7] = 0.3, -- Super
	[8] = 0.3, -- Motorcycles
	[9] = 0.3, -- Off-road
	[10] = 0.3, -- Industrial
	[11] = 0.3, -- Utility
	[12] = 0.3, -- Vans
	[13] = 0.0, -- Cycles
	[14] = 0.2, -- Boats
	[15] = 0.2, -- Helicopters
	[16] = 0.2, -- Planes
	[17] = 0.3, -- Service
	[18] = 0.3, -- Emergency
	[19] = 0.3, -- Military
	[20] = 0.3, -- Commercial
	[21] = 0.0, -- Trains
}

Config.FuelUsage = {
	[1.0] = 1.4,
	[0.9] = 1.2,
	[0.8] = 1.0,
	[0.7] = 0.9,
	[0.6] = 0.8,
	[0.5] = 0.7,
	[0.4] = 0.5,
	[0.3] = 0.4,
	[0.2] = 0.2,
	[0.1] = 0.1,
	[0.0] = 0.0,
}

Config.GasStations = {
	vector3(49.4187, 2778.793, 58.043),
	vector3(263.894, 2606.463, 44.983),
	vector3(1039.958, 2671.134, 39.550),
	vector3(1207.260, 2660.175, 37.899),
	vector3(2539.685, 2594.192, 37.944),
	vector3(2679.858, 3263.946, 55.240),
	vector3(2005.055, 3773.887, 32.403),
	vector3(1687.156, 4929.392, 42.078),
	vector3(1701.314, 6416.028, 32.763),
	vector3(179.857, 6602.839, 31.868),
	vector3(-94.4619, 6419.594, 31.489),
	vector3(-2554.996, 2334.40, 33.078),
	vector3(-1800.375, 803.661, 138.651),
	vector3(-1437.622, -276.747, 46.207),
	vector3(-2096.243, -320.286, 13.168),
	vector3(-724.619, -935.1631, 19.213),
	vector3(-526.019, -1211.003, 18.184),
	vector3(-70.2148, -1761.792, 29.534),
	vector3(265.648, -1261.309, 29.292),
	vector3(819.653, -1028.846, 26.403),
	vector3(1208.951, -1402.567,35.224),
	vector3(1181.381, -330.847, 69.316),
	vector3(620.843, 269.100, 103.089),
	vector3(2581.321, 362.039, 108.468),
	vector3(176.631, -1562.025, 29.263),
	vector3(176.631, -1562.025, 29.263),
	vector3(-319.292, -1471.715, 30.549),
	vector3(1784.324, 3330.55, 41.253)
}
