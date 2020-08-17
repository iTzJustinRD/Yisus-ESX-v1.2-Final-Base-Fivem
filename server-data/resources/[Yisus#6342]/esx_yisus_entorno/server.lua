ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_yisus_entorno:aviso')
AddEventHandler('esx_yisus_entorno:aviso', function(location, msg, x, y, z, type)
	local _source = source
	--print("Aviso tipo: "..type.." Mandado por: ".._source)

	local xPlayers = ESX.GetPlayers()
	for i = 1, #xPlayers do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			Policias = xPlayer.source
			if type == 'entorno' then
				local playername = GetPlayerName(_source)
				local ped = GetPlayerPed(_source)
				local mensaje = '^*^4Entorno | Steam Name: ^r' .. playername .. '^*^4 | Sitio: ^r' .. location .. '^*^4 | Reporte: ^r' .. msg
				local mensajeNotification = '~r~[Entorno] ~w~Sitio: ' .. location .. '<br>Reporte: ' .. msg
				local type = 'entorno'
				
				TriggerClientEvent('esx_yisus_entorno:setBlip', Policias, x, y, z)
				TriggerClientEvent('chatMessage', Policias, mensaje)
				TriggerClientEvent('esx:showNotification', Policias, mensajeNotification)
			end

			if type == 'forzar' then
				local playername = GetPlayerName(_source)
				local xPlayer = ESX.GetPlayerFromId(_source)
				local mensaje = '^*^4Robo de coche | Steam Name: ^r' .. playername .. '^*^4 | Sitio: ^r' .. location .. '^*^4 | Reporte: ^r' .. msg
				local mensajeNotification = '~r~[Robo de coche] ~w~ ' .. msg .. ' en ' .. location
				local type = 'forzar'

				TriggerClientEvent('esx_yisus_entorno:setBlip', Policias, x, y, z)
				TriggerClientEvent('chatMessage', Policias, mensaje)
				TriggerClientEvent('esx_yisus_entorno:sendMugshot', Policias, mensajeNotification, type, _source)
			end
		end
	end	
end)

