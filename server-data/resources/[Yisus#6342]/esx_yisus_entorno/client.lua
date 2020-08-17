displayTime = 300 

ESX = nil

blip = nil
blips = {}
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(0)
	end
	PlayerData = ESX.GetPlayerData()
end)

function loadESX()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(0)
	end
end

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

RegisterNetEvent('esx_yisus_entorno:setBlip')
AddEventHandler('esx_yisus_entorno:setBlip', function(x, y, z)
	loadESX()
	blip = AddBlipForCoord(x, y, z)
	SetBlipSprite(blip, 66)
	SetBlipScale(blip, 1.0)
	SetBlipColour(blip, 3)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Aviso')
	EndTextCommandSetBlipName(blip)
	table.insert(blips, blip)
	Wait(displayTime * 1000)
	for i, blip in pairs(blips) do 
		RemoveBlip(blip)
	end
end)

RegisterNetEvent('esx_yisus_entorno:sendMugshot')
AddEventHandler('esx_yisus_entorno:sendMugshot', function(msg, type, robber)
	loadESX()
	local mugshot, mugshotStr = ESX.Game.GetPedMugshot(GetPlayerPed(GetPlayerFromServerId(robber)))

	UnregisterPedheadshot(mugshot)
	ESX.ShowAdvancedNotification("Alarma de robo", "Robo de coche", msg, mugshotStr, 4)
end)

RegisterCommand('entorno', function(source, args)
    local name = GetPlayerName(PlayerId())
    local ped = GetPlayerPed(PlayerId())
    local x, y, z = table.unpack(GetEntityCoords(ped, true))
    local street = GetStreetNameAtCoord(x, y, z)
    local location = GetStreetNameFromHashKey(street)
	local msg = table.concat(args, ' ')
	local tipo = 'entorno'
    if args[1] == nil then
        TriggerEvent('chatMessage', '^5entorno', {255,255,255}, ' ^7Por favor indica el ^1entorno.')
	else
		TriggerEvent('chatMessage', '', {255,255,255}, '^8 [OOC] Has envíado un entorno a la policía')
		TriggerServerEvent('esx_yisus_entorno:aviso', location, msg, x, y, z, tipo)
    end
end)


RegisterCommand("forzar", function(source, args, rawCommand)
	local playerPed = GetPlayerPed(-1)

    if IsPedInAnyVehicle(playerPed, false) then
        local vehicle = GetVehiclePedIsIn(playerPed, false)
		if (vehicle ~= nil and vehicle ~= 0) then
			local vehicleLabel = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
            vehicleLabel = GetLabelText(vehicleLabel)
			local r, g, b = GetVehicleColor(vehicle)

			local name = GetPlayerName(PlayerId())
			local ped = GetPlayerPed(PlayerId())
			local x, y, z = table.unpack(GetEntityCoords(ped, true))
			local street = GetStreetNameAtCoord(x, y, z)
			local location = GetStreetNameFromHashKey(street)
			local msg = 'Se veria un individuo robando un '.. vehicleLabel..' '
			local tipo = 'forzar'
			
			TriggerEvent('chatMessage', '', {255,255,255}, '^8 [OOC] Has envíado un entorno a la policía')
			TriggerServerEvent('esx_yisus_entorno:aviso', location, msg, x, y, z, tipo)

            Citizen.Wait(10000)
        end
    end
end, false)