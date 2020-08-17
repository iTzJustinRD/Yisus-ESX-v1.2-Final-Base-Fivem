local disableShuffle = true
function disablec_conducir(flag)
	disableShuffle = flag
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if IsPedInAnyVehicle(GetPlayerPed(-1), false) and disableShuffle then
			if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0) == GetPlayerPed(-1) then
				if GetIsTaskActive(GetPlayerPed(-1), 165) then
					SetPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
				end
			end
		end
	end
end)

RegisterNetEvent("c_conducir")
AddEventHandler("c_conducir", function()
	if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
		disablec_conducir(false)
		Citizen.Wait(10000)
		disablec_conducir(true)
	else
		CancelEvent()
	end
end)

RegisterCommand("conducir", function(source, args, raw)
	TriggerEvent("c_conducir")
end, false)

RegisterCommand("maletero", function(source, args, raw)
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsUsing(ped)
    local vehLast = GetPlayersLastVehicle()
    local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(vehLast), 1)
    local door = 5

    if IsPedInAnyVehicle(ped, false) then
        if GetVehicleDoorAngleRatio(veh, door) > 0 then
            SetVehicleDoorShut(veh, door, false)
            ESX.ShowNotification("[Vehículo] ~g~Maletero cerrado.")
        else	
            SetVehicleDoorOpen(veh, door, false, false)
            ESX.ShowNotification("[Vehículo] ~g~Maletero abierto.")
        end
    else
        if distanceToVeh < 6 then
            if GetVehicleDoorAngleRatio(vehLast, door) > 0 then
                SetVehicleDoorShut(vehLast, door, false)
                ESX.ShowNotification("[Vehículo] ~g~Maletero cerrado.")
            else
                SetVehicleDoorOpen(vehLast, door, false, false)
                ESX.ShowNotification("[Vehículo] ~g~Maletero abierto.")
            end
        else
            ESX.ShowNotification("[Vehículo] ~y~Muy lejos del vehículo.")
        end
    end
end)

RegisterCommand("capo", function(source, args, raw)
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsUsing(ped)
    local vehLast = GetPlayersLastVehicle()
    local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(vehLast), 1)
    local door = 4

    if IsPedInAnyVehicle(ped, false) then
        if GetVehicleDoorAngleRatio(veh, door) > 0 then
            SetVehicleDoorShut(veh, door, false)
            ESX.ShowNotification("[Vehículo] ~g~Capó cerrado.")
        else	
            SetVehicleDoorOpen(veh, door, false, false)
            ESX.ShowNotification("[Vehículo] ~g~Capó abierto.")
        end
    else
        if distanceToVeh < 4 then
            if GetVehicleDoorAngleRatio(vehLast, door) > 0 then
                SetVehicleDoorShut(vehLast, door, false)
                ESX.ShowNotification("[Vehículo] ~g~Capó cerrado.")
            else	
                SetVehicleDoorOpen(vehLast, door, false, false)
                ESX.ShowNotification("[Vehículo] ~g~Capó abierto.")
            end
        else
            ESX.ShowNotification("[Vehículo] ~y~Muy lejos del vehículo.")
        end
    end
end)

RegisterCommand("puerta", function(source, args, raw)
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsUsing(ped)
    local vehLast = GetPlayersLastVehicle()
    local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(vehLast), 1)
    
    if args[1] == "1" then
        door = 0
    elseif args[1] == "2" then
        door = 1
    elseif args[1] == "3" then
        door = 2
    elseif args[1] == "4" then
        door = 3
    elseif args[1] == "5" then
        door = 4
    elseif args[1] == "6" then
        door = 5
    else
        door = nil
        ESX.ShowNotification("Uso: ~n~~b~/puerta [1,2,3,4]")
        ESX.ShowNotification("~y~Puertas:")
        ESX.ShowNotification("1(Delantera izquierda), 2(Delantera derecha)")
        ESX.ShowNotification("3(Trasera izquierda), 4(Trasera derecha)")
    end

    if door ~= nil then
        if IsPedInAnyVehicle(ped, false) then
            if GetVehicleDoorAngleRatio(veh, door) > 0 then
                SetVehicleDoorShut(veh, door, false)
                TriggerEvent("^*[Vehículo] ~g~Puerta cerrada.")
            else	
                SetVehicleDoorOpen(veh, door, false, false)
                TriggerEvent("^*[Vehículo] ~g~Puerta abierta.")
            end
        else
            if distanceToVeh < 4 then
                if GetVehicleDoorAngleRatio(vehLast, door) > 0 then
                    SetVehicleDoorShut(vehLast, door, false)
                    TriggerEvent("[Vehículo] ~g~Puerta cerrada.")
                else	
                    SetVehicleDoorOpen(vehLast, door, false, false)
                    TriggerEvent("[Vehículo] ~g~Puerta abierta.")
                end
            else
                TriggerEvent("[Vehículo] ~y~Muy lejos del vehículo.")
            end
        end
    end
end)


-- false no se enciende cuando te vuelves a montar, true cada vez que te montes se enciende solo si estaba apagado
OnAtEnter = true

local vehicles = {}; RPWorking = true

RegisterNetEvent('EngineToggle:Engine')
AddEventHandler('EngineToggle:Engine', function()
    if IsPedInAnyVehicle(GetPlayerPed(-1), false) then 
        local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
		if (GetPedInVehicleSeat(veh, -1) == GetPlayerPed(-1)) then
             print(veh)
             print( GetIsVehicleEngineRunning(veh))
            if GetIsVehicleEngineRunning(veh) == false then
                SetVehicleEngineOn(veh, true, true, false)
				SetVehicleJetEngineOn(veh, true)
				ESX.ShowNotification("Motor ~g~encendido")
			else
                SetVehicleEngineOn(veh, false, true, true)
				SetVehicleJetEngineOn(veh, false)
				ESX.ShowNotification("Motor ~r~apagado")
			end
		end 
    end 
end)


RegisterCommand("motor", function(Source, Arguments, RawCommand)
	if #Arguments == 0 then
		TriggerEvent('EngineToggle:Engine', Source)
	end
end, false)

--Camillas
local bedNames = { 'v_med_bed1', 'v_med_bed2'} -- Modelos
local bedHashes = {}
local animDict = 'missfbi5ig_0'
local animName = 'lyinginpain_loop_steve'
local isOnBed = false

CreateThread(function()
    for k,v in ipairs(bedNames) do
        table.insert( bedHashes, GetHashKey(v))
    end
end)

RegisterCommand('camilla', function()
    Citizen.CreateThread(function()
        local playerPed = PlayerPedId()
        if isOnBed then
            --ClearPedTasksImmediately(playerPed)
            isOnBed = false
            return
        end

        local playerPos = GetEntityCoords(playerPed, true)

        local bed = nil

        for k,v in ipairs(bedHashes) do
            bed = GetClosestObjectOfType(playerPos.x, playerPos.y, playerPos.z, 4.0, v, false, false, false)
            if bed ~= 0 then
                break
            end
        end

        if bed ~= nil and DoesEntityExist(bed) then
            Citizen.Wait(1000)
            if not HasAnimDictLoaded(animDict) then
                RequestAnimDict(animDict)
            end
            local bedCoords = GetEntityCoords(bed)

            SetEntityCoords(playerPed, bedCoords.x , bedCoords.y, bedCoords.z, 1, 1, 0, 0)
            SetEntityHeading(playerPed, GetEntityHeading(bed) + 180.0)
            TaskPlayAnim(playerPed,animDict, animName, 8.0, 1.0, -1, 45, 1.0, 0, 0, 0)

            isOnBed = true
        end
    end)
end, false)


RegisterCommand("forzar", function(source, args, rawCommand)
    local playerPed = GetPlayerPed(-1)
    if IsPedInAnyVehicle(playerPed, false) then
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        if (vehicle ~= nil and vehicle ~= 0) then
            local vehicleLabel = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
            vehicleLabel = GetLabelText(vehicleLabel)
            local r, g, b = GetVehicleColor(vehicle)
            ExecuteCommand("entorno Se veria un individuo robando un " .. vehicleLabel .." ")
            Citizen.Wait(10000)
        end
    end
end, false)