--[[ ############################################ --]]
--[[ ######## SISTEMA DE STATS PARA ESX ######### --]]
--[[ ########   CREADO POR Yisus#6342  ######### --]]
--[[ ############################################ --]]
--[[ ########  RENOMBRAR O MODIFICAR ESTE SCRIPT PUEDE ROMPERLO POR COMPLETO  ######### --]]


ESX = nil
-- ES_EXTENDED FETCH + DELETE STATS THREAD
Citizen.CreateThread(function()
	while ESX == nil do
		Citizen.Wait(20)
		
		ESX = exports["es_extended"]:getSharedObject()
	end

	while not ESX.IsPlayerLoaded() do
		Citizen.Wait(5)
	end

	FetchSkills()

	if Config.DeleteStats == true then
		while true do
			local seconds = Config.UpdateFrequency * 1000
			Citizen.Wait(seconds)

			for skill, value in pairs(Config.Skills) do
				UpdateSkill(skill, value["RemoveAmount"])
			end

			TriggerServerEvent("yisus_skillsystem:update", json.encode(Config.Skills))
		end
	end
end)

-- Ganar stats realizando cosas del juego :)
Citizen.CreateThread(function()
	if Config.WinStatsByDefault == true then
		while true do
			Citizen.Wait(60000)
			local ped = PlayerPedId()
			local vehicle = GetVehiclePedIsUsing(ped)

			if IsPedRunning(ped) then
				UpdateSkill("Resistencia", 0.2)
			elseif IsPedInMeleeCombat(ped) then
				UpdateSkill("Fuerza", 0.5)
			elseif IsPedSwimmingUnderWater(ped) then
				UpdateSkill("Buceo", 0.5)
			elseif IsPedShooting(ped) then
				UpdateSkill("Disparo", 0.5)
			elseif DoesEntityExist(vehicle) then
				local speed = GetEntitySpeed(vehicle) * 3.6

				if GetVehicleClass(vehicle) == 8 or GetVehicleClass(vehicle) == 13 and speed >= 5 then
					local rotation = GetEntityRotation(vehicle)
					if IsControlPressed(0, 210) then
						if rotation.x >= 25.0 then
							UpdateSkill("Levantar rueda delantera", 0.5)
						end 
					end
				end
				if speed >= 140 then
					UpdateSkill("Conduccion", 0.2)
				end
			end
		end
	end
end)

--Comando ver stat
RegisterCommand('habilidades', function() 
	SkillMenu()
end, false)