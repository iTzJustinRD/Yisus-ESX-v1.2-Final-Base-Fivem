ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

-- BILLS WITHOUT ESX_BILLING (START)
RegisterServerEvent('esx_speedcamera:PayBill60Zone')
AddEventHandler('esx_speedcamera:PayBill60Zone', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeMoney(100)
end)

RegisterServerEvent('esx_speedcamera:PayBill80Zone')
AddEventHandler('esx_speedcamera:PayBill80Zone', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeMoney(300)	
end)

RegisterServerEvent('esx_speedcamera:PayBill120Zone')
AddEventHandler('esx_speedcamera:PayBill120Zone', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeMoney(500)
end)
-- BILLS WITHOUT ESX_BILLING (END)

RegisterServerEvent('esx_speedcamera:sendBill')
AddEventHandler('esx_speedcamera:sendBill', function(plate, model, maxspeed, speed, price)
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE @plate = plate', {
		['@plate'] = plate
	}, function(result)
		if result[1] then -- does the owner match?
			for i = 1, #result do
				local vehicle = json.decode(result[i].vehicle)
				if vehicle.model == model then
					local xPlayer = ESX.GetPlayerFromIdentifier(result[i].owner)

					if xPlayer then
						xPlayer.showNotification("Tu vehículo con matrícula "..plate.." ha sido pillado por un radar")
						TriggerClientEvent("esx_speedcamera:sendBill",xPlayer.source,xPlayer.playerId,"society_police","Radar ("..maxspeed.."KM/H) - Tu velocidad: " .. speed .. " KM/H",price)
						break
					else
						break
					end
				end
			end
		end
	end)
end)