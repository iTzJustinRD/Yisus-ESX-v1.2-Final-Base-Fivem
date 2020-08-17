ESX = nil

cachedData = {
    ["motels"] = {},
    ["storages"] = {},
    ["names"] = {}
}

TriggerEvent("esx:getSharedObject", function(library) 
	ESX = library 
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(src)
    local player = ESX.GetPlayerFromId(src)

    GetCharacterName(player)
end)

RegisterNetEvent("esx:playerDropped")
AddEventHandler("esx:playerDropped", function(src)
    local player = ESX.GetPlayerFromId(src)

    if cachedData["names"][player["identifier"]] then
        cachedData["names"][player["identifier"]] = nil
    end
end)

MySQL.ready(function()
    RebuildCache()
end)
RebuildCache = function()
    cachedData = {
        ["motels"] = {},
        ["storages"] = {},
        ["names"] = {}
    }
    
    local sqlTasks = {}
    
    local firstSqlQuery = [[
        SELECT
            userIdentifier, motelData
        FROM
            characters_motels
    ]]

    table.insert(sqlTasks, function(callback)    
        MySQL.Async.fetchAll(firstSqlQuery, {
            
        }, function(response)
            for motelIndex, motelData in ipairs(response) do
                local decodedData = json.decode(motelData["motelData"])
    
                if not cachedData["motels"][decodedData["room"]] then
                    cachedData["motels"][decodedData["room"]] = {}
                    cachedData["motels"][decodedData["room"]]["rooms"] = {}
                end
    
                table.insert(cachedData["motels"][decodedData["room"]]["rooms"], {
                    ["motelData"] = decodedData
                })
            end
            TriggerClientEvent("esx_yisus_motel:eventHandler", -1, "update_motels", cachedData["motels"]) 
            callback(true)
        end)
    end)

    local secondSqlQuery = [[
        SELECT
            storageId, storageData
        FROM
            characters_storages
    ]]

    table.insert(sqlTasks, function(callback)    
        MySQL.Async.fetchAll(secondSqlQuery, {
            
        }, function(response)
            for storageIndex, storageData in ipairs(response) do
                local decodedData = json.decode(storageData["storageData"])

                if not cachedData["storages"][storageData["storageId"]] then
                    cachedData["storages"][storageData["storageId"]] = {}
                    cachedData["storages"][storageData["storageId"]]["items"] = {}
                end

                cachedData["storages"][storageData["storageId"]] = decodedData
            end

            callback(true)
        end)
    end)

    Async.parallel(sqlTasks, function(responses)
    end)

    GetCharacterNames()
end

RegisterServerEvent("esx_yisus_motel:globalEvent")
AddEventHandler("esx_yisus_motel:globalEvent", function(options)
    TriggerClientEvent("esx_yisus_motel:eventHandler", -1, options["event"] or "none", options["data"] or nil)
end)

ESX.RegisterServerCallback("esx_yisus_motel:fetchMotels", function(source, callback)
    local player = ESX.GetPlayerFromId(source)

    if player then
        callback(cachedData["motels"], cachedData["storages"], cachedData["names"][player["identifier"]] or nil)
    else
        callback(false)
    end
end)

ESX.RegisterServerCallback("esx_yisus_motel:addItemToStorage", function(source, callback, newTable, newItem, storageId)
    local player = ESX.GetPlayerFromId(source)

    if player then
        cachedData["storages"][storageId] = newTable

        if newItem["type"] == "item" then
            player.removeInventoryItem(newItem["name"], newItem["count"])
        elseif newItem["type"] == "weapon" then
            player.removeWeapon(newItem["name"], newItem["count"])
        elseif newItem["type"] == "black_money" then
            player.removeAccountMoney("black_money", newItem["count"])
        end

        TriggerClientEvent("esx_yisus_motel:eventHandler", -1, "update_storages", {
            ["newTable"] = newTable,
            ["storageId"] = storageId
        })

        UpdateStorageDatabase(storageId, newTable)

        callback(true)
    else
        callback(false)
    end
end)

ESX.RegisterServerCallback("esx_yisus_motel:takeItemFromStorage", function(source, callback, newTable, newItem, storageId)
    local player = ESX.GetPlayerFromId(source)

    if player then
        cachedData["storages"][storageId] = newTable

        if newItem["type"] == "item" then
            player.addInventoryItem(newItem["name"], newItem["count"])
        elseif newItem["type"] == "weapon" then
            player.addWeapon(newItem["name"], newItem["count"])
        elseif newItem["type"] == "black_money" then
            player.addAccountMoney("black_money", newItem["count"])
        end

        TriggerClientEvent("esx_yisus_motel:eventHandler", -1, "update_storages", {
            ["newTable"] = newTable,
            ["storageId"] = storageId
        })

        UpdateStorageDatabase(storageId, newTable)

        callback(true)
    else
        callback(false)
    end
end)

ESX.RegisterServerCallback("esx_yisus_motel:retreivePlayers", function(source, callback, playersSent)
	local player = ESX.GetPlayerFromId(source)

	if #playersSent <= 0 then
		callback(false)

		return
	end

	if player then
		local newPlayers = {}

		for playerIndex = 1, #playersSent do
			local player = ESX.GetPlayerFromId(playersSent[playerIndex])

            local characterNames = cachedData["names"][player["identifier"]]

			if player then
				if player["source"] ~= source then
					table.insert(newPlayers, {
						["firstname"] = characterNames["firstname"] or GetPlayerName(source),
						["lastname"] = characterNames["lastname"] or GetPlayerName(source),
						["source"] = player["source"]
					})
				end
			end
		end

		callback(newPlayers)
	else
		callback(false)
	end
end)

ESX.RegisterServerCallback("esx_yisus_motel:buyMotel", function(source, callback, room)
	local player = ESX.GetPlayerFromId(source)

    if player then
        if player.getMoney() >= Config.MotelPrice then
            player.removeMoney(Config.MotelPrice)
        elseif player.getAccount("bank")["money"] >= Config.MotelPrice then
            player.removeAccountMoney("bank", Config.MotelPrice)
        else
            return callback(false)
        end

        CreateMotel(source, room, function(confirmed)
            if confirmed then
                callback(true)
            else
                callback(false)
            end
        end)
	else
		callback(false)
	end
end)

ESX.RegisterServerCallback("esx_yisus_motel:deleteMotel", function(source, callback)
	local player = ESX.GetPlayerFromId(source)

    if player then
        
        DeleteMotel(player["identifier"], function(confirmed)
            if confirmed then
                callback(true)
            else
                callback(false)
            end
        end)
	else
		callback(false)
	end
end)

function payRent(d, h, m)
	local tasks, timeStart = {}, os.clock()

	MySQL.Async.fetchAll('SELECT * FROM characters_motels', {}, function(result)
		for k,v in ipairs(result) do
			table.insert(tasks, function(cb)
				local xPlayer = ESX.GetPlayerFromIdentifier(v.userIdentifier)

				if xPlayer then
					if xPlayer.getAccount('bank').money >= Config.MotelPrice then
						xPlayer.removeAccountMoney('bank', Config.MotelPrice)
						xPlayer.showNotification("Pink Cage hemos cobrado el alquiler ~g~"..Config.MotelPrice.."$")
					else
						xPlayer.showNotification("Pink Cage ~r~has sido desahuciado~w~ por impago")
						DeleteMotel(v.userIdentifier,cb)
					end
				else
					MySQL.Async.fetchScalar('SELECT accounts FROM users WHERE identifier = @identifier', {
						['@identifier'] = v.userIdentifier
					}, function(accounts)
						if accounts then
							local playerAccounts = json.decode(accounts)

							if playerAccounts and playerAccounts.bank then
								if playerAccounts.bank >= Config.MotelPrice then
									playerAccounts.bank = playerAccounts.bank - Config.MotelPrice

									MySQL.Async.execute('UPDATE users SET accounts = @accounts WHERE identifier = @identifier', {
										['@identifier'] =v.userIdentifier,
										['@accounts'] = json.encode(playerAccounts)
									})
								else
									DeleteMotel(v.userIdentifier,cb)
								end
							end
						end
					end)
				end

				cb()
			end)
		end

		Async.parallelLimit(tasks, 5, function(results) end)

		local elapsedTime = os.clock() - timeStart
		print(('[Motel] [^2INFO^7] El pago de alquileres tardó %s segundos'):format(elapsedTime))
	end)
end

TriggerEvent('cron:runAt', Config.HoraDeCobro.h, Config.HoraDeCobro.m, payRent)

