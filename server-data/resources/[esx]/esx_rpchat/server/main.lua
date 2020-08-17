ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('chatMessage', function(playerId, playerName, message)
	if string.sub(message, 1, string.len('/')) ~= '/' then
		CancelEvent()
		TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, playerId, "[OOC] "..playerName, message, {128, 128, 128})
		
	end
end)

RegisterCommand('a', function(playerId, args, rawCommand)
	if playerId == 0 then
		print('esx_rpchat: you can\'t use this command from console!')
	else
		args = table.concat(args, ' ')
		local playerName = GetRealPlayerName(playerId)

		TriggerClientEvent('chat:addMessage', -1, {args = {_U('ayuda_prefix', GetPlayerName(playerId)), tostring(args)}, color = {255, 153, 0}})
	end
end, false)

RegisterCommand('me', function(playerId, args, rawCommand)
	if playerId == 0 then
		print('esx_rpchat: you can\'t use this command from console!')
	else
		args = table.concat(args, ' ')
		local playerName = GetRealPlayerName(playerId)
		TriggerClientEvent('esx_rpchat:sendMessageMe', -1, playerId, "ME: " .. playerName .. " " .. args .. "", {255, 0, 0})
		--TriggerClientEvent('esx_rpchat:sendMessageMe', -1, source, ("*" .. playerName .. " " .. args .. "*"), tostring(args), color ){255, 0, 255})
	end
end, false)

RegisterCommand('do', function(playerId, args, rawCommand)
	if playerId == 0 then
		print('esx_rpchat: you can\'t use this command from console!')
	else
		args = table.concat(args, ' ')
		local playerName = GetRealPlayerName(playerId)

		--TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, source, _U('do_prefix', playerName), tostring(args), {255, 255, 0})
		TriggerClientEvent('esx_rpchat:sendMessageDo', -1, playerId, "DO: " .. playerName .. " " .. args .. "", {255, 0, 255})
	end
end, false)

RegisterCommand('msg', function(source, args, user)

	if GetPlayerName(tonumber(args[1])) then
		local player = tonumber(args[1])
		table.remove(args, 1)
		
		TriggerClientEvent('chat:addMessage', player, {args = {"^1MSG de "..GetPlayerName(source).. "[" .. source .. "]: ^7" ..table.concat(args, " ")}, color = {255, 153, 0}})
		TriggerClientEvent('chat:addMessage', source, {args = {"^1MSG enviado a "..GetPlayerName(player).. "[" .. player .. "]: ^7" ..table.concat(args, " ")}, color = {255, 153, 0}})

	else
		TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "ID de jugador incorrecta!")
	end

end,false)
	
 
  --- Trabajo
RegisterCommand('f', function(source, args, user)
	local args = table.concat(args, " ")
	if string.gsub(args, "%s$", "") ~= '' then
		local playerName = GetRealPlayerName(source)

		TriggerClientEvent("sendProximityMessageTeam", -1, source, playerName, args, ESX.GetPlayerFromId(source))
	end
end,false)
  
  
RegisterCommand('dados', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end
	local arg = tonumber(args[1]) 
	local name = GetRealPlayerName(source)
	if arg == 1 then
		
		local dice = math.random(1,6)
		args = 'ha tirado un dado, ha sacado un '..dice
		TriggerClientEvent('esx_rpchat:sendProximityMessageDice', -1, source, name, args, { 87, 69, 255 })

	elseif arg == 2 then 
		
		local dice1 = math.random(1,6)
		local dice2 = math.random(1,6)
		
			args = "ha tirado 2 dados. Ha sacado un "..dice1.." y un "..dice2

		TriggerClientEvent('esx_rpchat:sendProximityMessageDice', -1, source, name, args, { 87, 69, 255 })

	elseif arg == 3 then 

		local dice1 = math.random(1,6)
		local dice2 = math.random(1,6)
		local dice3 = math.random(1,6)		
		args = "ha tirado 3 dados. Ha sacado un "..dice1..", un "..dice2.." y un "..dice3

		TriggerClientEvent('esx_rpchat:sendProximityMessageDice', -1, source, name, args, { 87, 69, 255 })

	end
	  
end, false)

RegisterServerEvent("esx_rpchat:entornoLSPD") 
AddEventHandler("esx_rpchat:entornoLSPD", function(senderID, msg, pPos, tipo)
	TriggerClientEvent("esx_rpchat:entornoLSPD", -1, senderID, msg, pPos, tipo)
end)

function GetRealPlayerName(playerId)
	local xPlayer = ESX.GetPlayerFromId(playerId)

	if xPlayer then
		if Config.EnableESXIdentity then
			if Config.OnlyFirstname then
				return xPlayer.get('firstName')
			else
				return xPlayer.getName()
			end
		else
			return xPlayer.getName()
		end
	else
		return GetPlayerName(playerId)
	end
end

function GetGroup(source)
	local identifier = GetPlayerIdentifiers(source)[2]
	if string.match(identifier, 'license:') then
        identifier = string.sub(identifier, 9)
    end
	local result = MySQL.Sync.fetchAll("SELECT `group` FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			group = identity['group']
		}
	else
		return nil
	end
end

RegisterServerEvent("esx_rpchat:getGroup")
AddEventHandler("esx_rpchat:getGroup", function(toggle)
	TriggerClientEvent("esx_rpchat:getGroup", -1, source, toggle)
end)


ESX.RegisterServerCallback('esx_rpchat:getPlayerData', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source).getGroup()
	cb(xPlayer)
end)