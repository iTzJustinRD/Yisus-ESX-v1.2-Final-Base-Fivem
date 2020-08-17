ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('ALERTAROBO')
AddEventHandler('ALERTAROBO', function(source)
xPlayer.showNotification('Alguien acaba de robarte')

	
end)


RegisterServerEvent('robo:jugador')
AddEventHandler('robo:jugador', function(targetid, playerheading, playerCoords,  playerlocation)
	_source = source



TriggerClientEvent('robo:getarrested', targetid, playerheading, playerCoords, playerlocation)
TriggerClientEvent('robo:doarrested', _source)


end)
