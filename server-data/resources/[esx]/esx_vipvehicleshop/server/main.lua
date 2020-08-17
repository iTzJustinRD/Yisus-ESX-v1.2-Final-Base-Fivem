ESX = nil
local categories, vehicles = {}, {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()
	local char = Config.PlateLetters
	char = char + Config.PlateNumbers + Config.PlateLetters2
	if Config.PlateUseSpace then char = char + 1 end

	if char > 8 then
		print(('[esx_vehicleshop] [^3WARNING^7] Plate character count reached, %s/8 characters!'):format(char))
	end
end)

MySQL.ready(function()
	MySQL.Async.fetchAll('SELECT * FROM vehiclevip_categories WHERE name = "vip" ', {}, function(_categories)
		categories = _categories

		MySQL.Async.fetchAll('SELECT * FROM vipvehicles WHERE category = "vip" ', {}, function(_vehicles)
			vehicles = _vehicles

			for k,v in ipairs(vehicles) do
				for k2,v2 in ipairs(categories) do
					if v2.name == v.category then
						vehicles[k].categoryLabel = v2.label
						break
					end
				end
			end

			TriggerClientEvent('esx_vipvehicleshop:sendCategories', -1, categories)
			TriggerClientEvent('esx_vipvehicleshop:sendVehicles', -1, vehicles)
		end)
	end)
end)

function getVehicleLabelFromModel(model)
	for k,v in ipairs(vehicles) do
		if v.model == model then
			return v.name
		end
	end

	return
end

ESX.RegisterServerCallback('esx_vipvehicleshop:getCategories', function(source, cb)
	cb(categories)
end)

ESX.RegisterServerCallback('esx_vipvehicleshop:getVehicles', function(source, cb)
	cb(vehicles)
end)

ESX.RegisterServerCallback('esx_vipvehicleshop:buyVehicle', function(source, cb, model, plate)
	local xPlayer = ESX.GetPlayerFromId(source)
	local modelPrice
	local isVip = false

	for k,v in ipairs(vehicles) do
		if model == v.model then
			if v.category == 'vip' then
				isVip = true
			end
				modelPrice = v.price
				break
		end
	end

	if isVip then
		local identifier = GetPlayerIdentifiers(source)[2]
    	if string.match(identifier, 'license:') then identifier = string.sub(identifier, 9) end
		local resultvip = MySQL.Sync.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
			['@identifier'] = identifier
		})
		if resultvip[1] and resultvip[1].vip == false then
			xPlayer.showNotification('No eres usuario VIP del concesionario.')
			cb(false)
			return
		end

	end

	if modelPrice and xPlayer.getMoney() >= modelPrice then
		xPlayer.removeMoney(modelPrice)

		MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)', {
			['@owner']   = xPlayer.identifier,
			['@plate']   = plate,
			['@vehicle'] = json.encode({model = GetHashKey(model), plate = plate})
		}, function(rowsChanged)
			xPlayer.showNotification(_U('vehicle_belongs', plate))
			cb(true)
		end)
	else
		xPlayer.showNotification(_U('not_enough_money'))
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_vipvehicleshop:isPlateTaken', function(source, cb, plate)
	MySQL.Async.fetchAll('SELECT 1 FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)
		cb(result[1] ~= nil)
	end)
end)

