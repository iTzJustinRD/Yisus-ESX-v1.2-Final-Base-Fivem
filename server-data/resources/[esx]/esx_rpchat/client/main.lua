ESX = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(1)
	end

	PlayerData = ESX.GetPlayerData()
	
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function (xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

RegisterNetEvent('esx_rpchat:sendProximityMessage')
AddEventHandler('esx_rpchat:sendProximityMessage', function(playerId, title, message, color)
	local player = PlayerId()
	local target = GetPlayerFromServerId(playerId)

	local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
	local playerCoords, targetCoords = GetEntityCoords(playerPed), GetEntityCoords(targetPed)

	if target == player or #(playerCoords - targetCoords) < 20 then
		TriggerEvent('chat:addMessage', {args = {title..": "..message}, color = {128,128,128}})

	end
end)

RegisterNetEvent('esx_rpchat:sendMessageMe')
AddEventHandler('esx_rpchat:sendMessageMe', function (playerId,  message, color) 
	local player = PlayerId()
	local target = GetPlayerFromServerId(playerId)

	local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
	local playerCoords, targetCoords = GetEntityCoords(playerPed), GetEntityCoords(targetPed)
	if target == player or #(playerCoords - targetCoords) < 20 then
		TriggerEvent('chat:addMessage', {args = { message}, color = {225, 0, 225}})
	end

end)

RegisterNetEvent('esx_rpchat:sendMessageDo')
AddEventHandler('esx_rpchat:sendMessageDo', function (playerId,  message, color) 
	local player = PlayerId()
	local target = GetPlayerFromServerId(playerId)

	local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
	local playerCoords, targetCoords = GetEntityCoords(playerPed), GetEntityCoords(targetPed)
	if target == player or #(playerCoords - targetCoords) < 20 then
		TriggerEvent('chat:addMessage', {args = {message}, color = {235, 235, 0}})
	end

end)

---Faccion trabajo
RegisterNetEvent('sendProximityMessageTeam')
AddEventHandler('sendProximityMessageTeam', function(id, name, message, xPlayer)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)

	if PlayerData.job.name == 'police' then

		if pid == myId then
			TriggerEvent('chatMessage', "", {255, 0, 0}, "^4[^*^0".. PlayerData.job.label .."^4] ^r^4 " .. name .."  "..": ^0" .. message)
		elseif PlayerData.job.name == xPlayer.job.name then
			TriggerEvent('chatMessage', "", {255, 0, 0}, "^4[^*^0".. xPlayer.job.label .."^4] ^r^4 " .. name .."  "..": ^0" .. message)
		end
	  
	elseif PlayerData.job.name == 'ambulance' then
		if pid == myId then
			TriggerEvent('chatMessage', "", {255, 0, 0}, "^8[^*^0".. PlayerData.job.label .."^8] ^r^8 " .. name .." :^0 " .. message)
		elseif PlayerData.job.name == xPlayer.job.name then
			TriggerEvent('chatMessage', "", {255, 0, 0}, "^8[^*^0".. xPlayer.job.label .."^8] ^r^8 " .. name .." :^0 " .. message)
		end
	elseif PlayerData.job.name == 'taxi' then
		if pid == myId then
			TriggerEvent('chatMessage', "", {255, 0, 0}, "^3[^*^0".. PlayerData.job.label .."^3] ^r^3" .. name .." :^0 " .. message)
		elseif PlayerData.job.name == xPlayer.job.name then
			TriggerEvent('chatMessage', "", {255, 0, 0}, "^3[^*^0".. xPlayer.job.label .."^3] ^r^3" .. name .." :^0 " ..message)
		end
	end
	  
end)

---- Evento entorno
RegisterNetEvent("esx_rpchat:entornoSend")
AddEventHandler("esx_rpchat:entornoSend", function(msg, tipo) 
    local senderID = GetPlayerServerId(PlayerId())
    local pPed = GetPlayerPed(-1)
    local pPos = GetEntityCoords(pPed)
    TriggerServerEvent('esx_addons_gcphone:startCall', 'police', tipo..' - '..msg, pPos, {

        PlayerCoords = { x = pPos.x, y = pPos.y, z = pPos.z },
    })
    
    TriggerServerEvent("esx_rpchat:entornoLSPD", senderID, msg, pPos, tipo)    
end)

RegisterNetEvent("esx_rpchat:entornoLSPD")
AddEventHandler("esx_rpchat:entornoLSPD", function(senderID, msg, coords, tipo) 
    if PlayerData.job.name == 'police' then 
        local notiTxt
        if tipo == "ENTORNO" then 
            notiTxt = "~r~ENTORNO ["..senderID.."] - ~s~ "..msg
            ESX.ShowNotification(notiTxt)
            SetBlip(coords, "~r~ENTORNO ["..senderID.."]", 280)
        elseif tipo == "disparos" then 
            notiTxt = "~r~TIROTEO! ["..senderID.."] - ~s~ "..msg
            ESX.ShowNotification(notiTxt)
        end
    end
end)

---Dados
RegisterNetEvent('esx_rpchat:sendProximityMessageDice')
AddEventHandler('esx_rpchat:sendProximityMessageDice', function(playerId, title, message, color)
	local player = PlayerId()
	local target = GetPlayerFromServerId(playerId)

	local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
	local playerCoords, targetCoords = GetEntityCoords(playerPed), GetEntityCoords(targetPed)
	if target == player or #(playerCoords - targetCoords) < 20 then
		TriggerEvent('chat:addMessage', {args = {"*"..title.." "..message.."*"}, color = {235, 235, 0}})
	end
end)
