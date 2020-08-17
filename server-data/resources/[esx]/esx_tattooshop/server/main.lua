ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_tattooshop:requestPlayerTattoos', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        MySQL.Async.fetchAll('SELECT tattoos FROM users WHERE identifier = @identifier', {
            ['@identifier'] = xPlayer.identifier
        }, function(result)
            if result[1].tattoos then
                cb(json.decode(result[1].tattoos))
            else
                cb()
            end
        end)
    else
        cb()
    end
end)

RegisterServerEvent('esx_tattooshop:save')
AddEventHandler('esx_tattooshop:save', function(tattoosList, price, tattoo)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)
		table.insert(tattoosList, tattoo)

		MySQL.Async.execute('UPDATE users SET tattoos = @tattoos WHERE identifier = @identifier',
		{
			['@tattoos'] = json.encode(tattoosList),
			['@identifier'] = xPlayer.identifier
		}, function(rowsChanged)
			TriggerClientEvent('esx_tattooshop:buySuccess', _source, tattoo)
			TriggerClientEvent('esx:showNotification', _source, _U('bought_tattoo', price))
		end)
	else
		local missingMoney = price - xPlayer.getMoney()
		TriggerClientEvent('esx_tattooshop:cleanPlayer', _source)
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money', missingMoney))
	end
end)

RegisterServerEvent('esx_tattooshop:delete')
AddEventHandler('esx_tattooshop:delete', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getMoney() >= 50000 then
		xPlayer.removeMoney(50000)
		MySQL.Async.execute('UPDATE users SET tattoos = "{}" WHERE identifier = @identifier',
		{
			['@identifier'] = xPlayer.identifier
		}, function(rowsChanged)
			TriggerClientEvent('esx_tattooshop:reloadTattoos', _source)
			xPlayer.showNotification("~b~Usunięto wszystkie tatuaże")
		end)
	else
		xPlayer.showNotification("~r~Nie masz wystarczająco gotówki")
	end
end)
