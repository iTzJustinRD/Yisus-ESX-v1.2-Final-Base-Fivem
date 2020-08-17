ESX = nil

cachedData = {
	["motels"] = {},
	["storages"] = {},
	["insideMotel"] = false
}

Citizen.CreateThread(function()
    while ESX == nil do 
        TriggerEvent('esx:getSharedObject', function(obj) 
            ESX = obj 
        end) 
        Wait(0) 
    end

	if ESX.IsPlayerLoaded() then
		Init()
	end

	AddTextEntry("Instructions", Config.HelpTextMessage)
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(playerData)
	ESX.PlayerData = playerData

	Init()
end)


RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(newJob)
	ESX.PlayerData["job"] = newJob
end)

RegisterNetEvent("esx_yisus_motel:eventHandler")
AddEventHandler("esx_yisus_motel:eventHandler", function(response, eventData)
	if response == "update_motels" then
		cachedData["motels"] = eventData
	elseif response == "update_storages" then
		cachedData["storages"][eventData["storageId"]] = eventData["newTable"]

		if ESX.UI.Menu.IsOpen("default", GetCurrentResourceName(), "main_storage_menu_" .. eventData["storageId"]) then
			local openedMenu = ESX.UI.Menu.GetOpened("default", GetCurrentResourceName(), "main_storage_menu_" .. eventData["storageId"])

			if openedMenu then
				openedMenu.close()

				OpenStorage(eventData["storageId"])
			end
		end
	elseif response == "invite_player" then
		if eventData["player"]["source"] == GetPlayerServerId(PlayerId()) then
			Citizen.CreateThread(function()
				local startedInvite = GetGameTimer()

				cachedData["invited"] = true

				while GetGameTimer() - startedInvite < 7500 do
					Citizen.Wait(0)

					ESX.ShowHelpNotification("Has sido invitado a, " .. eventData["motel"]["room"] .. ". ~INPUT_DETONATE~ para entrar.")

					if IsControlJustPressed(0, 47) then
						EnterMotel(eventData["motel"])

						break
					end
				end

				cachedData["invited"] = false
			end)
		end
	elseif response == "knock_motel" then
		local currentInstance = DecorGetInt(PlayerPedId(), "currentInstance")

		if currentInstance and currentInstance == eventData["uniqueId"] then
			ESX.ShowNotification("Alguien esta tocando tu puerta.")
		end
	else
	end
end)

Citizen.CreateThread(function()
	Citizen.Wait(50)

	while ESX.PlayerData == nil do
        Citizen.Wait(50)
	end
	
	cachedData["lastCheck"] = GetGameTimer() - 4750
	for k,v in pairs(Config.LandLord) do
		local pinkCageBlip = AddBlipForCoord(v.Position)

		SetBlipSprite(pinkCageBlip, 475)
		SetBlipScale(pinkCageBlip, 0.8)
		SetBlipColour(pinkCageBlip, 25)
		SetBlipAsShortRange(pinkCageBlip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(k)
		EndTextCommandSetBlipName(pinkCageBlip)
	end
	while true do
		local sleepThread = 500

		local ped = PlayerPedId()
		local pedCoords = GetEntityCoords(ped)

		local yourMotel = GetPlayerMotel()

		for k,v in pairs(Config.LandLord) do
			for motelRoom, motelPos in ipairs(v.MotelsEntrances) do
				local dstCheck = GetDistanceBetweenCoords(pedCoords, motelPos, true)
				local dstRange = yourMotel and (yourMotel["room"] == motelRoom and 35.0 or 3.0) or 3.0

				if dstCheck <= dstRange then
					sleepThread = 5

					DrawScriptMarker({
						["type"] = 2,
						["pos"] = motelPos,
						["r"] = 155,
						["g"] = 155,
						["b"] = 155,
						["sizeX"] = 0.3,
						["sizeY"] = 0.3,
						["sizeZ"] = 0.3,
						["rotate"] = true
					})

					if dstCheck <= 0.9 then
						local displayText = yourMotel and (yourMotel["room"] == motelRoom and "[~g~E~s~] Entrar" or "") or ""; displayText = displayText .. " [~g~H~s~] Menu"

						if not cachedData["invited"] then
							DrawScriptText(motelPos - vector3(0.0, 0.0, 0.20), displayText)
						end

						if IsControlJustPressed(0, 38) then
							if yourMotel then
								if yourMotel["room"] == motelRoom then
									EnterMotel(yourMotel)
								end
							end
						elseif IsControlJustPressed(0, 74) then
							OpenMotelRoomMenu(motelRoom)
						end
					end
				end
			end
	
			local dstCheck = GetDistanceBetweenCoords(pedCoords, v.Position, true)

			if dstCheck <= 3.0 then
				sleepThread = 5

				if dstCheck <= 0.9 then
					local displayText = "[~g~E~s~] Alquilar habitación [~g~H~s~] Cancelar alquiler"
					if not cachedData["purchasing"] then
						DrawScriptText(v.Position, displayText)
					end

					if IsControlJustPressed(0, 38) then
						_G["Open" .. v.Key]()
					end
					if IsControlJustPressed(0, 74) then
						ESX.TriggerServerCallback("esx_yisus_motel:deleteMotel", function (confirmed)
							if confirmed then
								ESX.ShowNotification("~g~Cancelado ~w~alquiler")
							else
								ESX.ShowNotification("~r~No tienes habitación en este motel")
							end
						end)
					end
				end
			end
		end

		Citizen.Wait(sleepThread)
	end
end)