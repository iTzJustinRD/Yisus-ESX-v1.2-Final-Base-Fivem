Config = {}
--Puntos
Config.Base = {
	coords  = {x = -1285.8394775391, y = -1387.5504150391, z = 4.4498672485352},
	scooter = {x = -1285.8394775391, y = -1387.5504150391, z = 4.4498672485352},
	retveh  = {x =  -1288.3156738281, y = -1392.4390869141, z = 4.3659410476685},
	deleter = {x = -1291.4326171875, y = -1395.4713134766, z = 4.4703178405762},
	heading = 286.56
}

--No toque
Config.DecorCode = 0

--Cantidad de entregas
Config.Deliveries = {
	min = 5,
	max = 6
}

-- Dinero por cada entrega
Config.Rewards = {
	scooter = 100
}

-- Modelo del vehiculo a spawnear
Config.Models = {
	scooter = 'faggio3'
}

--Escala de los blips indicadores
Config.Scales = {
	scooter = 0.6
}

--Dinero de seguridad (se cobra al sacar la moto, se recupera si completas la entrega)
Config.Safe = {
	scooter = 50
}

--Zonas de spawn de la motillo
Config.ParkingSpawns = {
	{x = -1257.1123046875, y = -1406.1759033203, z = 4.2552642822266, h = 299.24},
	{x = -1255.4324951172, y = -1408.4532470703, z = 4.2742795944214, h = 299.24},
	{x = -1253.6544189453, y = -1410.6287841797, z = 4.2948570251465, h = 299.24},
}

--Entregas
Config.DeliveryLocationsScooter = {
	{Item1 = {x = -153.19, y = -838.31, z = 30.12},		Item2 = {x = -143.85, y = -846.3, z = 30.6}},
	{Item1 = {x = 37.72, y = -795.71, z = 30.93},		Item2 = {x = 44.94, y = -803.24, z = 31.52}},
	{Item1 = {x = 111.7, y = -809.56, z = 30.71},		Item2 = {x = 102.19, y = -818.22, z = 31.35}},
	{Item1 = {x = 132.61, y = -889.41, z = 29.71},		Item2 = {x = 121.25, y = -879.82, z = 31.12}},
	{Item1 = {x = 54.41, y = -994.86, z = 28.7},		Item2 = {x = 43.89, y = -997.98, z = 29.34}},
	{Item1 = {x = 54.41, y = -994.86, z = 28.7},		Item2 = {x = 57.65, y = -1003.72, z = 29.36}},
	{Item1 = {x = 142.87, y = -1026.78, z = 28.67},		Item2 = {x = 135.44, y = -1031.19, z = 29.35}},
	{Item1 = {x = 248.03, y = -1005.49, z = 28.61},		Item2 = {x = 254.83, y = -1013.25, z = 29.27}},
	{Item1 = {x = 275.68, y = -929.64, z = 28.47},		Item2 = {x = 285.55, y = -937.26, z = 29.39}},
	{Item1 = {x = 294.29, y = -877.33, z = 28.61},		Item2 = {x = 301.12, y = -883.47, z = 29.28}},
	{Item1 = {x = 247.68, y = -832.03, z = 29.16},		Item2 = {x = 258.66, y = -830.44, z = 29.58}},
	{Item1 = {x = 227.21, y = -705.26, z = 35.07},		Item2 = {x = 232.2, y = -714.55, z = 35.78}},
	{Item1 = {x = 241.06, y = -667.74, z = 37.44},		Item2 = {x = 245.5, y = -677.7, z = 37.75}},
	{Item1 = {x = 257.05, y = -628.21, z = 40.59},		Item2 = {x = 268.54, y = -640.44, z = 42.02}},
	{Item1 = {x = 211.33, y = -605.63, z = 41.42},		Item2 = {x = 222.32, y = -596.71, z = 43.87}},
	{Item1 = {x = 126.27, y = -555.46, z = 42.66},		Item2 = {x = 168.11, y = -567.17, z = 43.87}},
	{Item1 = {x = 254.2, y = -377.17, z = 43.96},		Item2 = {x = 239.06, y = -409.27, z = 47.92}},
	{Item1 = {x = 244.49, y = 349.05, z = 105.46},		Item2 = {x = 252.86, y = 357.13, z = 105.53}},
	{Item1 = {x = 130.77, y = -307.27, z = 44.58},		Item2 = {x = 138.67, y = -285.45, z = 50.45}},
	{Item1 = {x = 54.44, y = -280.4, z = 46.9},			Item2 = {x = 61.86, y = -260.86, z = 52.35}},
	{Item1 = {x = 55.15, y = -225.54, z = 50.44},		Item2 = {x = 76.29, y = -233.15, z = 51.4}},
	{Item1 = {x = 44.6, y = -138.99, z = 54.66},		Item2 = {x = 50.78, y = -136.23, z = 55.2}},
	{Item1 = {x = 32.51, y = -162.61, z = 54.86},		Item2 = {x = 26.84, y = -168.84, z = 55.54}},
	{Item1 = {x = -29.6, y = -110.84, z = 56.51},		Item2 = {x = -23.5, y = -106.74, z = 57.04}},
	{Item1 = {x = -96.86, y = -86.84, z = 57.44},		Item2 = {x = -87.82, y = -83.55, z = 57.82}},
	{Item1 = {x = -146.26, y = -71.46, z = 53.9},		Item2 = {x = -132.92, y = -69.02, z = 55.42}},
	{Item1 = {x = -238.41, y = 91.97, z = 68.11},		Item2 = {x = -263.61, y = 98.88, z = 69.3}},
	{Item1 = {x = -251.45, y = 20.43, z = 53.9},		Item2 = {x = -273.35, y = 28.21, z = 54.75}},
	{Item1 = {x = -322.4, y = -10.06, z = 47.42},		Item2 = {x = -315.48, y = -3.76, z = 48.2}},
	{Item1 = {x = -431.22, y = 14.6, z = 45.5},			Item2 = {x = -424.83, y = 21.74, z = 46.27}},
	{Item1 = {x = -497.33, y = -8.38, z = 44.33},		Item2 = {x = -500.95, y = -18.65, z = 45.13}},
	{Item1 = {x = -406.69, y = -44.87, z = 45.13},		Item2 = {x = -429.07, y = -24.12, z = 46.23}},
	{Item1 = {x = -433.94, y = -76.33, z = 40.93},		Item2 = {x = -437.89, y = -66.91, z = 43.01}},
	{Item1 = {x = -583.22, y = -154.84, z = 37.51},		Item2 = {x = -582.8, y = -146.8, z = 38.23}},
	{Item1 = {x = -613.68, y = -213.46, z = 36.51},		Item2 = {x = -622.23, y = -210.97, z = 37.33}},
	{Item1 = {x = -582.44, y = -322.69, z = 34.33},		Item2 = {x = -583.02, y = -330.38, z = 34.97}},
	{Item1 = {x = -658.25, y = -329, z = 34.2},			Item2 = {x = -666.69, y = -329.06, z = 35.2}},
	{Item1 = {x = -645.84, y = -419.67, z = 34.1},		Item2 = {x = -654.84, y = -414.21, z = 35.45}},
	{Item1 = {x = -712.7, y = -668.08, z = 29.81},		Item2 = {x = -714.58, y = -675.37, z = 30.63}},
	{Item1 = {x = -648.24, y = -681.53, z = 30.61},		Item2 = {x = -656.77, y = -678.12, z = 31.46}},
	{Item1 = {x = -648.87, y = -904.3, z = 23.8},		Item2 = {x = -660.88, y = -900.72, z = 24.61}},
	{Item1 = {x = -529.01, y = -848.03, z = 29.26},		Item2 = {x = -531.0, y = -854.04, z = 29.79}}
}

--Uniforme
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
	}
}

--Traduccione papi
Config.Locales = {
	["delivery_not_available"]    = "Este modelo no esta disponible, por favor usa scooter o furgoneta.",
	["start_delivery"]            = "Presiona ~INPUT_CONTEXT~ para empezar el reparto dejando una fianza de $",
	["safe_deposit_received"]     = "La fianza fue cobrada de tu cuenta bancaria",
	["safe_deposit_returned"]     = "Has recibido el reembolso de la fianza",
	["safe_deposit_withheld"]     = "Entrega fallida, has perdido la fianza.",
	["delivery_point_reward"]     = "Entrega completa, recibes $",
	["get_back_in_vehicle"]       = "Móntate en el vehículo",
	["remove_goods"]              = "Presiona ~INPUT_CONTEXT~ para sacar la mercancía del vehículo",
	["remove_goods_subtext"]      = "Aparca el vehículo y descarga la mercancía",
	["drive_next_point"]          = "Conduce hasta el siguiente destino",
	["deliver_inside_shop"]       = "Lleva la mercancía al destino",
	["get_back_to_deliveryhub"]   = "Vuelve al almacen y entrega el vehículo",
	["delivery_vehicle_returned"] = "El vehículo has sido devuelto",
	["finish_job"]                = "Estado de la entrega: ",
	["end_delivery"]              = "Presiona ~INPUT_CONTEXT~ para terminar la entrega, sientate en el vehículo o perderas la fianza",
	["blip_name"]                 = "Centro de distribución",
	["dst_blip"]                  = "Entrega",
	["delivery_end"]              = "Entrega finalizada",
	["delivery_failed"]           = "Has perdido la fianza porque el vehículo esta detruido o perdido",
	["delivery_finish"]           = "Has terminado las entregas",
	["delivery_start"]            = "Entrega",
	["delivery_tips"]             = "Conduce con precaución hasta el destino y entrega la mercancía",
	["not_enough_money"]          = "No tienes suficiente dinero para la fianza"
}
