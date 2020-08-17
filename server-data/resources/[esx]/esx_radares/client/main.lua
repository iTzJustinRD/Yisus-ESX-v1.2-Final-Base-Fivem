-- BELOVE IS YOUR SETTINGS, CHANGE THEM TO WHATEVER YOU'D LIKE & MORE SETTINGS WILL COME IN THE FUTURE! --
local useBilling = true -- OPTIONS: (true/false)
local useCameraSound = false -- OPTIONS: (true/false)
local useFlashingScreen = false -- OPTIONS: (true/false)
local useBlips = false -- OPTIONS: (true/false)
local alertPolice = false -- OPTIONS: (true/false)
local alertSpeed = 80 -- OPTIONS: (1-5000 KMH)

local showBlips = true -- OPTIONS: (true/false)

local defaultPrice70 = 50 -- THIS IS THE DEFAULT PRICE WITHOUT EXTRA COST FOR 60 ZONES
local defaultPrice120 = 50 -- THIS IS THE DEFAULT PRICE WITHOUT EXTRA COST FOR 120 ZONES

local extraZonePrice10 = 20 -- THIS IS THE EXTRA COST IF 10 KM/H ABOVE LIMIT (REQUIRES "useBilling" to be set to true)
local extraZonePrice20 = 30 -- THIS IS THE EXTRA COST IF 20 KM/H ABOVE LIMIT (REQUIRES "useBilling" to be set to true)
local extraZonePrice30 = 50 -- THIS IS THE EXTRA COST IF 30 KM/H ABOVE LIMIT (REQUIRES "useBilling" to be set to true)
-- ABOVE IS YOUR SETTINGS, CHANGE THEM TO WHATEVER YOU'D LIKE & MORE SETTINGS WILL COME IN THE FUTURE!  --

ESX = nil
local hasBeenCaught = false
local finalBillingPrice = 0;

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

function hintToDisplay(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

-- BLIP FOR SPEEDCAMERAS
local blips = {
	-- 60KM/H ZONES
	--{title="Radar (70KM/H)", colour=1, id=1, x = -524.2645, y = -1776.3569, z = 21.3384}, -- 70KM/H ZONE
}

Citizen.CreateThread(function()
	if showBlips then
		for _, info in pairs(blips) do
			if useBlips == true then
				info.blip = AddBlipForCoord(info.x, info.y, info.z)
				SetBlipSprite(info.blip, info.id)
				SetBlipDisplay(info.blip, 4)
				SetBlipScale(info.blip, 0.5)
				SetBlipColour(info.blip, info.colour)
				SetBlipAsShortRange(info.blip, true)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(info.title)
				EndTextCommandSetBlipName(info.blip)
			end
		end
	end
end)

-- AREAS
local Speedcamera70Zone = {
	{x = -284.8915, y = -234.9913, z = 35.83762},
	{x = -44.95995, y = 35.3874, z = 72.219},
	{x = -539.5859, y = 254.4337, z = 83.05677},
	{x = -1302.66, y = -346.6588, z = 36.7158},
	{x = -1082.229, y = -764.1137, z = 19.36631},
	{x = -500.5944, y = -838.2059, z = 30.48364},
	{x = -106.2789, y = -1001.392, z = 29.3995}
}

local Speedcamera120Zone = {
	{x = -2751.179, y = -13.56364, z = 15.38042},
	{x = -2368.886, y = 3990.725, z = 25.97275},
	{x = 1204.17, y = 6489.119, z = 20.9264},
	{x = 1654.187, y = 1232.487, z = 85.2092},
	{x = 2386.291, y = -278.2809, z = 84.78828}
}

-- ZONES
Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(10)
			local playerPed = GetPlayerPed(-1)
			if IsPedInAnyVehicle(playerPed, false) then
				-- 70 zone
				for k in pairs(Speedcamera70Zone) do
					local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
					local dist =
						Vdist(
						plyCoords.x,
						plyCoords.y,
						plyCoords.z,
						Speedcamera70Zone[k].x,
						Speedcamera70Zone[k].y,
						Speedcamera70Zone[k].z
					)

					if dist <= 20.0 then
						
						local playerCar = GetVehiclePedIsIn(playerPed, false)
						local veh = GetVehiclePedIsIn(playerPed)
						local SpeedKM = GetEntitySpeed(playerPed) * 3.6
						local maxSpeed = 80.0 -- THIS IS THE MAX SPEED IN KM/H

						if SpeedKM > maxSpeed then
							if IsPedInAnyVehicle(playerPed, false) then
								if (GetPedInVehicleSeat(playerCar, -1) == playerPed) then
									if hasBeenCaught == false then
										if GetVehicleClass(veh) ~= 18 then
											local plate = GetVehicleNumberPlateText(veh)
											local model = GetEntityModel(veh)
											-- ALERT POLICE (START)
											if alertPolice == true then
												if SpeedKM > (maxSpeed + alertSpeed) then
													local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
													
													TriggerServerEvent(
														"esx_phone:send",
														"police",
														" Hay un aviso de radar por ir a  " .. alertSpeed .. " KMH en zona de 70 Km/h. Matrícula: " .. plate,
														true,
														{x = x, y = y, z = z}
													)
												end
											end
											-- ALERT POLICE (END)

											-- FLASHING EFFECT (START)
											if useFlashingScreen == true then
												TriggerEvent("esx_speedcamera:openGUI")
											end

											if useCameraSound == true then
												TriggerServerEvent("InteractSound_SV:PlayOnSource", "speedcamera", 0.5)
											end

											if useFlashingScreen == true then
												Citizen.Wait(200)
												TriggerEvent("esx_speedcamera:closeGUI")
											end
											-- FLASHING EFFECT (END)

											if useBilling == true then
												if SpeedKM >= maxSpeed + 30 then
													finalBillingPrice = defaultPrice70 + extraZonePrice30
												elseif SpeedKM >= maxSpeed + 20 then
													finalBillingPrice = defaultPrice70 + extraZonePrice20
												elseif SpeedKM >= maxSpeed + 10 then
													finalBillingPrice = defaultPrice70 + extraZonePrice10
												else
													finalBillingPrice = defaultPrice70
												end

												if isJobPlate(plate) then
													TriggerServerEvent("esx_billing:sendBill",  GetPlayerServerId(PlayerId()),"society_police","Radar (70KM/H) - Tu velocidad: " .. math.floor(SpeedKM) .. " KM/H", finalBillingPrice)
												else
													TriggerServerEvent("esx_speedcamera:sendBill",plate,model,70,math.floor(SpeedKM),finalBillingPrice)
												end
											else
												TriggerServerEvent("esx_speedcamera:PayBill60Zone")
											end

											hasBeenCaught = true
											Citizen.Wait(5000) -- This is here to make sure the player won't get fined over and over again by the same camera!
										end
									end
								end
							end

							hasBeenCaught = false
						end
						break
					end
				end
				-- 120 zone
				for k in pairs(Speedcamera120Zone) do
					local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
					local dist =
						Vdist(
						plyCoords.x,
						plyCoords.y,
						plyCoords.z,
						Speedcamera120Zone[k].x,
						Speedcamera120Zone[k].y,
						Speedcamera120Zone[k].z
					)

					if dist <= 20.0 then
						local playerCar = GetVehiclePedIsIn(playerPed, false)
						local veh = GetVehiclePedIsIn(playerPed)
						local SpeedKM = GetEntitySpeed(playerPed) * 3.6
						local maxSpeed = 130.0 -- THIS IS THE MAX SPEED IN KM/H

						if SpeedKM > maxSpeed then
							if IsPedInAnyVehicle(playerPed, false) then
								if (GetPedInVehicleSeat(playerCar, -1) == playerPed) then
									if hasBeenCaught == false then
										if GetVehicleClass(veh) ~= 18 then
											local plate = GetVehicleNumberPlateText(veh)
											local model = GetEntityModel(veh)
											-- ALERT POLICE (START)
											if alertPolice == true then
												if SpeedKM > (maxSpeed + alertSpeed) then
													local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
													
													TriggerServerEvent(
														"esx_phone:send",
														"police",
														" Hay un aviso de radar por ir a  " .. alertSpeed .. " KMH en zona de 120 Km/h. Matrícula: " .. plate,
														true,
														{x = x, y = y, z = z}
													)
												end
											end
											-- ALERT POLICE (END)

											-- FLASHING EFFECT (START)
											if useFlashingScreen == true then
												TriggerEvent("esx_speedcamera:openGUI")
											end

											if useCameraSound == true then
												TriggerServerEvent("InteractSound_SV:PlayOnSource", "speedcamera", 0.5)
											end

											if useFlashingScreen == true then
												Citizen.Wait(200)
												TriggerEvent("esx_speedcamera:closeGUI")
											end
											-- FLASHING EFFECT (END)

											if useBilling == true then
												if SpeedKM >= maxSpeed + 30 then
													finalBillingPrice = defaultPrice120 + extraZonePrice30
												elseif SpeedKM >= maxSpeed + 20 then
													finalBillingPrice = defaultPrice120 + extraZonePrice20
												elseif SpeedKM >= maxSpeed + 10 then
													finalBillingPrice = defaultPrice120 + extraZonePrice10
												else
													finalBillingPrice = defaultPrice120
												end 
												
												if isJobPlate(plate) == true then
													TriggerServerEvent("esx_billing:sendBill", GetPlayerServerId(PlayerId()),"society_police","Radar (120 KM/H) - Tu velocidad: " .. math.floor(SpeedKM) .. " KM/H", finalBillingPrice)
												else
													TriggerServerEvent("esx_speedcamera:sendBill",plate,model,120,math.floor(SpeedKM),finalBillingPrice)
												end
											else
												TriggerServerEvent("esx_speedcamera:PayBill120Zone")
											end

											hasBeenCaught = true
											Citizen.Wait(5000) -- This is here to make sure the player won't get fined over and over again by the same camera!
										end
									end
								end
							end

							hasBeenCaught = false
						end
						break
					end
				end
			end
		end
	end
)

function isJobPlate(plate)
	return string.match(plate,"JOB")
end

RegisterNetEvent('esx_speedcamera:openGUI')
AddEventHandler('esx_speedcamera:openGUI', function()
    SetNuiFocus(false,false)
    SendNUIMessage({type = 'openSpeedcamera'})
end)   

RegisterNetEvent('esx_speedcamera:closeGUI')
AddEventHandler('esx_speedcamera:closeGUI', function()
    SendNUIMessage({type = 'closeSpeedcamera'})
end)

RegisterNetEvent('esx_speedcamera:sendBill')
AddEventHandler('esx_speedcamera:sendBill', function(id,society,text,price)
    TriggerServerEvent("esx_billing:sendBill",id,society,text,price)
end)