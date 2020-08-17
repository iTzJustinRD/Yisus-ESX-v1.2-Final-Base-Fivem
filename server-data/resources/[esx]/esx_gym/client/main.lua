local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil
local PlayerData              = {}
local training = false
local resting = false
local membership = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
		
		PlayerData = ESX.GetPlayerData()
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

function hintToDisplay(text)
	ESX.ShowHelpNotification(text)
end

local blips = {
	{title="Gimnasio", colour=7, id=311, x = -1201.2257, y = -1568.8670, z = 4.6101},
	{title="Alquiler de bicis", colour=58, id=106, x = -282.18, y = -891.13, z = 30.07},
}
	
Citizen.CreateThread(function()
	for _, info in pairs(blips) do
		info.blip = AddBlipForCoord(info.x, info.y, info.z)
		SetBlipSprite(info.blip, info.id)
		SetBlipDisplay(info.blip, 4)
		SetBlipScale(info.blip, 0.8)
		SetBlipColour(info.blip, info.colour)
		SetBlipAsShortRange(info.blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(info.title)
		EndTextCommandSetBlipName(info.blip)
	end
end)

RegisterNetEvent('esx_gym:trueMembership')
AddEventHandler('esx_gym:trueMembership', function()
	membership = true
end)

RegisterNetEvent('esx_gym:falseMembership')
AddEventHandler('esx_gym:falseMembership', function()
	membership = false
end)

-- LOCATION (START)

local arms = { --Hacer brazos (pesas)
    {x = -1202.9837,y = -1565.1718,z = 3.63115}
}

local pushup = { -- Flexiones
    {x = -1203.3242,y = -1570.6184,z = 3.631155}
}

local yoga = { -- Hacer yoga
    {x = -1204.7958,y = -1560.1906,z = 3.63115}
}

local situps = { -- Abdominales
    {x = -1206.1055,y = -1565.1589,z = 3.63115}
}

local chins = { -- Dominadas
    {x = -1200.1284,y = -1570.9903,z = 3.63115}
}

local gym = {
    {x = -1195.6551,y = -1577.7689,z = 3.631155}
}

local rentbike = {
    {x = -1199.1164,y = -1584.5972,z = 3.371159},
    {x = -156.44, y = -1274.12, z = -100.28},
    {x = -282.18, y = -891.13, z = 30.07}
}

-- LOCATION (END)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        for k in pairs(rentbike) do
            DrawMarker(27, rentbike[k].x, rentbike[k].y, rentbike[k].z, 0, 0, 0, 0, 0, 0, 1.00, 1.001, 1.001, 148, 148, 184, 100, 0, 0, 0, 0)
		end

		for k in pairs(arms) do
            DrawMarker(27, arms[k].x, arms[k].y, arms[k].z, 0, 0, 0, 0, 0, 0, 1.01, 1.01, 1.001, 148, 148, 184, 100, 0, 0, 0, 0)
		end

		for k in pairs(pushup) do
            DrawMarker(27, pushup[k].x, pushup[k].y, pushup[k].z, 0, 0, 0, 0, 0, 0, 1.01, 1.01, 1.001,148, 148, 184, 100, 0, 0, 0, 0)
		end

		for k in pairs(yoga) do
            DrawMarker(27, yoga[k].x, yoga[k].y, yoga[k].z, 0, 0, 0, 0, 0, 0, 1.01, 1.01, 1.001, 148, 148, 184, 100, 0, 0, 0, 0)
		end

		for k in pairs(situps) do
            DrawMarker(27, situps[k].x, situps[k].y, situps[k].z, 0, 0, 0, 0, 0, 0, 1.01, 1.01, 1.001, 148, 148, 184, 100, 0, 0, 0, 0)
		end

		for k in pairs(gym) do
            DrawMarker(27, gym[k].x, gym[k].y, gym[k].z, 0, 0, 0, 0, 0, 0, 1.01, 1.01, 1.001,148, 148, 184, 100, 0, 0, 0, 0)
		end

		for k in pairs(chins) do
            DrawMarker(27, chins[k].x, chins[k].y, chins[k].z, 0, 0, 0, 0, 0, 0, 1.01, 1.01, 1.001, 148, 148, 184, 100, 0, 0, 0, 0)
		end
		
		for k in pairs(rentbike) do
		
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, rentbike[k].x, rentbike[k].y, rentbike[k].z)

            if dist <= 1.5 then
				hintToDisplay('Presiona ~INPUT_CONTEXT~ para alquilar una ~b~bicicleta')
				
				if IsControlJustPressed(0, Keys['E']) then -- "E"
					if IsPedInAnyVehicle(GetPlayerPed(-1)) then
						ESX.ShowNotification("No puedes alquilar desde dentro de un ~r~vehículo")
					else
						OpenBikeMenu()
					end
				end			
            end
		end
		
		for k in pairs(gym) do
		
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, gym[k].x, gym[k].y, gym[k].z)

            if dist <= 1.5 then
				hintToDisplay('Presiona ~INPUT_CONTEXT~ para abrir el menu del ~b~gimnasio')
				
				if IsControlJustPressed(0, Keys['E']) then
					OpenGymMenu()
				end			
            end
		end
		
		for k in pairs(arms) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, arms[k].x, arms[k].y, arms[k].z)

            if dist <= 1.5 then
				hintToDisplay('Presiona ~INPUT_CONTEXT~ para ejercitar tus ~g~brazos')
				
				if IsControlJustPressed(0, Keys['E']) then
					if training == false then
					
						TriggerServerEvent('esx_gym:checkChip')
						ESX.ShowNotification("Preparando ~g~ejercicio~w~...")
						Citizen.Wait(1000)					
					
						if membership == true then
							local playerPed = GetPlayerPed(-1)
							TaskStartScenarioInPlace(playerPed, "world_human_muscle_free_weights", 0, true)
							Citizen.Wait(30000)
							ClearPedTasksImmediately(playerPed)
							exports["esx_yisus_skillsystem"]:UpdateSkill("Fuerza", 1)
							ESX.ShowNotification("Necesitas descansar ~r~60 segundos ~w~antes de realizar otro.")
							training = true
						elseif membership == false then
							ESX.ShowNotification("Necesitas ser socio para hacer este ~r~ejercicio")
						end
					elseif training == true then
						ESX.ShowNotification("Necesitas un descanso...")
						resting = true
						CheckTraining()
					end
				end			
            end
		end
		
		for k in pairs(chins) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, chins[k].x, chins[k].y, chins[k].z)

            if dist <= 1.5 then
				hintToDisplay('Presiona ~INPUT_CONTEXT~ para hacer ~g~dominadas')
				
				if IsControlJustPressed(0, Keys['E']) then
					if training == false then
					
						TriggerServerEvent('esx_gym:checkChip')
						ESX.ShowNotification("Preparando ~g~ejercicio~w~...")
						Citizen.Wait(1000)					
					
						if membership == true then
							local playerPed = GetPlayerPed(-1)
							TaskStartScenarioInPlace(playerPed, "prop_human_muscle_chin_ups", 0, true)
							Citizen.Wait(30000)
							ClearPedTasksImmediately(playerPed)
							exports["esx_yisus_skillsystem"]:UpdateSkill("Resistencia", 1)
							ESX.ShowNotification("Necesitas descansar ~r~60 segundos ~w~antes de realizar otro.")
							training = true
						elseif membership == false then
							ESX.ShowNotification("Necesitas ser socio para poder hacer ~r~ejercicio")
						end
					elseif training == true then
						ESX.ShowNotification("Necesitas un descanso...")
						resting = true
						CheckTraining()
					end
				end			
            end
		end
		
		for k in pairs(pushup) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pushup[k].x, pushup[k].y, pushup[k].z)

            if dist <= 1.5 then
				hintToDisplay('Presiona ~INPUT_CONTEXT~ para hacer ~g~flexiones')
				
				if IsControlJustPressed(0, Keys['E']) then
					if training == false then
					
						TriggerServerEvent('esx_gym:checkChip')
						ESX.ShowNotification("Preparando ~g~ejercicio~w~...")
						Citizen.Wait(1000)					
					
						if membership == true then				
							local playerPed = GetPlayerPed(-1)
							TaskStartScenarioInPlace(playerPed, "world_human_push_ups", 0, true)
							Citizen.Wait(30000)
							ClearPedTasksImmediately(playerPed)
							exports["esx_yisus_skillsystem"]:UpdateSkill("Fuerza", 2)
							ESX.ShowNotification("Necesitas descansar ~r~60 segundos ~w~antes de realizar otro.")
							training = true
						elseif membership == false then
							ESX.ShowNotification("Necesitas ser socio para hacer este ~r~ejercicio")
						end							
					elseif training == true then
						ESX.ShowNotification("Necesitas un descanso...")
						resting = true
						CheckTraining()
					end
				end			
            end
		end
		
		for k in pairs(yoga) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, yoga[k].x, yoga[k].y, yoga[k].z)

            if dist <= 1.5 then
				hintToDisplay('Presiona ~INPUT_CONTEXT~ para hacer ~g~yoga')
				
				if IsControlJustPressed(0, Keys['E']) then
					if training == false then
					
						TriggerServerEvent('esx_gym:checkChip')
						ESX.ShowNotification("Preparando ~g~ejercicio~w~...")
						Citizen.Wait(1000)					
					
						if membership == true then	
							local playerPed = GetPlayerPed(-1)
							TaskStartScenarioInPlace(playerPed, "world_human_yoga", 0, true)
							Citizen.Wait(30000)
							ClearPedTasksImmediately(playerPed)
							exports["esx_yisus_skillsystem"]:UpdateSkill("Resistencia", 1)
							ESX.ShowNotification("Necesitas descansar ~r~60 segundos ~w~antes de realizar otro.")
							training = true
						elseif membership == false then
							ESX.ShowNotification("Necesitas ser socio para hacer este ~r~ejercicio")
						end
					elseif training == true then
						ESX.ShowNotification("Necesitas un descanso...")
						resting = true
						CheckTraining()
					end
				end			
            end
		end
		
		for k in pairs(situps) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, situps[k].x, situps[k].y, situps[k].z)

            if dist <= 1.5 then
				hintToDisplay('Presiona ~INPUT_CONTEXT~ para hacer ~g~abdominales')
				
				if IsControlJustPressed(0, Keys['E']) then
					if training == false then

						TriggerServerEvent('esx_gym:checkChip')
						ESX.ShowNotification("Preparando ~g~ejercicio~w~...")
						Citizen.Wait(1000)					
					
						if membership == true then	
							local playerPed = GetPlayerPed(-1)
							TaskStartScenarioInPlace(playerPed, "world_human_sit_ups", 0, true)
							Citizen.Wait(30000)
							ClearPedTasksImmediately(playerPed)
							exports["esx_yisus_skillsystem"]:UpdateSkill("Resistencia", 1)
							ESX.ShowNotification("Necesitas descansar ~r~60 segundos ~w~antes de realizar otro.")
							training = true
						elseif membership == false then
							ESX.ShowNotification("Necesitas ser socio para hacer este ~r~ejercicio")
						end
					elseif training == true then
						ESX.ShowNotification("Necesitas un descanso...")
						resting = true
						CheckTraining()
					end
				end			
            end
		end
    end
end)

function CheckTraining()
	if resting == true then
		ESX.ShowNotification("Estás descansando...")
		
		resting = false
		Citizen.Wait(60000)
		training = false
	end
	
	if resting == false then
		ESX.ShowNotification("Ya puedes volver a hacer ejercicio")
	end
end

function OpenGymMenu()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'gym_menu',
        {
            title    = 'Gym',
            elements = {
				{label = 'Tienda', value = 'shop'},
				{label = 'Membresía', value = 'ship'}
            }
        },
        function(data, menu)
            if data.current.value == 'shop' then
				OpenGymShopMenu()
            elseif data.current.value == 'ship' then
				OpenGymShipMenu()
            end
        end,
        function(data, menu)
            menu.close()
        end
    )
end

function OpenGymShopMenu()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'gym_shop_menu',
        {
            title    = 'Gym - Tienda',
            elements = {
				{label = 'Batido de proteínas ($10)', value = 'protein_shake'},
				{label = 'Agua ($6)', value = 'water'},
				{label = 'Barrita energética ($4)', value = 'sportlunch'},
				{label = 'Powerade ($6)', value = 'powerade'},
            }
        },
        function(data, menu)
            if data.current.value == 'protein_shake' then
				TriggerServerEvent('esx_gym:buyProteinshake')
            elseif data.current.value == 'water' then
				TriggerServerEvent('esx_gym:buyWater')
            elseif data.current.value == 'sportlunch' then
				TriggerServerEvent('esx_gym:buySportlunch')
            elseif data.current.value == 'powerade' then
				TriggerServerEvent('esx_gym:buyPowerade')
            end
        end,
        function(data, menu)
            menu.close()
        end
    )
end

function OpenGymShipMenu()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'gym_ship_menu',
        {
            title    = 'Gimnasio - Hazte socio',
            elements = {
				{label = 'Hacerse socio ($100)', value = 'membership'},
            }
        },
        function(data, menu)
            if data.current.value == 'membership' then
				TriggerServerEvent('esx_gym:buyMembership')
				
				ESX.UI.Menu.CloseAll()
            end
        end,
        function(data, menu)
            menu.close()
        end
    )
end

function OpenBikeMenu()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'bike_menu',
        {
			title    = 'Alquilar una bicicleta',
			align	 = 'bottom-right',
            elements = {
				{label = 'BMX ($20)', value = 'bmx'},
				{label = 'Cruiser ($30)', value = 'cruiser'},
				{label = 'Fixter ($40)', value = 'fixter'},
				{label = 'Scorcher ($40)', value = 'scorcher'},
            }
        },
        function(data, menu)
            if data.current.value == 'bmx' then
				TriggerServerEvent('esx_gym:hireBmx')
				TriggerEvent('esx:spawnVehicle', "bmx")
				
				ESX.UI.Menu.CloseAll()
            elseif data.current.value == 'cruiser' then
				TriggerServerEvent('esx_gym:hireCruiser')
				TriggerEvent('esx:spawnVehicle', "cruiser")
				
				ESX.UI.Menu.CloseAll()
            elseif data.current.value == 'fixter' then
				TriggerServerEvent('esx_gym:hireFixter')
				TriggerEvent('esx:spawnVehicle', "fixter")
				
				ESX.UI.Menu.CloseAll()
            elseif data.current.value == 'scorcher' then
				TriggerServerEvent('esx_gym:hireScorcher')
				TriggerEvent('esx:spawnVehicle', "scorcher")
				
				ESX.UI.Menu.CloseAll()
            end
        end,
        function(data, menu)
            menu.close()
        end
    )
end