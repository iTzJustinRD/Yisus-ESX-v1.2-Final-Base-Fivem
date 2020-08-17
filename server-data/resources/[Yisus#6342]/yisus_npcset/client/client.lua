function Clients()
	local Count = 0
	Config.iPlayers = Count
	for _,v in ipairs(GetActivePlayers()) do
		Count = Count + 1
	end
	if (Count ~= nil) then
		Config.iPlayers = (Count * Config.Static)
	end
end

Citizen.CreateThread(function()
	local iPlayer = GetEntityCoords(PlayerPedId())
	DisablePlayerVehicleRewards(PlayerId())
	SetAudioFlag("PoliceScannerDisabled", true)

	while true do
		Citizen.Wait(0)

		--for i = 0, 20 do -- This do engage with the last end on this lines
			--EnableDispatchService(i, Config.Dispatch) -- Enables or Disables services on server (OUTDATED)
			Citizen.InvokeNative(0xDC0F817884CDD856, 1, Config.Dispatch)
			Citizen.InvokeNative(0xDC0F817884CDD856, 2, Config.Dispatch)
			Citizen.InvokeNative(0xDC0F817884CDD856, 3, Config.Dispatch)
			Citizen.InvokeNative(0xDC0F817884CDD856, 4, Config.Dispatch)
			Citizen.InvokeNative(0xDC0F817884CDD856, 5, Config.Dispatch)
			Citizen.InvokeNative(0xDC0F817884CDD856, 6, Config.Dispatch)
			Citizen.InvokeNative(0xDC0F817884CDD856, 7, Config.Dispatch)
			Citizen.InvokeNative(0xDC0F817884CDD856, 8, Config.Dispatch)
			Citizen.InvokeNative(0xDC0F817884CDD856, 9, Config.Dispatch)
			Citizen.InvokeNative(0xDC0F817884CDD856, 10, Config.Dispatch)
			Citizen.InvokeNative(0xDC0F817884CDD856, 11, Config.Dispatch)
			Citizen.InvokeNative(0xDC0F817884CDD856, 12, Config.Dispatch)
			Citizen.InvokeNative(0xDC0F817884CDD856, 13, Config.Dispatch)
			Citizen.InvokeNative(0xDC0F817884CDD856, 14, Config.Dispatch)
			Citizen.InvokeNative(0xDC0F817884CDD856, 15, Config.Dispatch)
			Citizen.InvokeNative(0xDC0F817884CDD856, 16, Config.Dispatch)
			Citizen.InvokeNative(0xDC0F817884CDD856, 17, Config.Dispatch)
			Citizen.InvokeNative(0xDC0F817884CDD856, 18, Config.Dispatch)
			Citizen.InvokeNative(0xDC0F817884CDD856, 19, Config.Dispatch)
			Citizen.InvokeNative(0xDC0F817884CDD856, 20, Config.Dispatch)
		--end -- This end is from for i = 0, 20 do with EnableDispatchService(i, Config.Dispatch)

		if (Config.Wanted and GetPlayerWantedLevel(PlayerId()) > 0) then
            SetPlayerWantedLevel(PlayerId(), 0, false)
            SetPlayerWantedLevelNow(PlayerId(), false)
        end

		SetVehicleDensityMultiplierThisFrame((Config.TrafficX - Config.iPlayers) / Config.Divider)
		SetPedDensityMultiplierThisFrame((Config.PedestrianX - Config.iPlayers) / Config.Divider)
		SetRandomVehicleDensityMultiplierThisFrame((Config.TrafficX - Config.iPlayers) / Config.Divider)
		SetParkedVehicleDensityMultiplierThisFrame((Config.ParkedX - Config.iPlayers) / Config.Divider)
		SetScenarioPedDensityMultiplierThisFrame((Config.PedestrianX - Config.iPlayers) / Config.Divider, (Config.PedestrianX - Config.iPlayers) / Config.Divider)

		RemoveVehiclesFromGeneratorsInArea(iPlayer.x - 52.0, iPlayer.y - 52.0, iPlayer.z - 15.0, iPlayer.x + 52.0, iPlayer.y + 52.0, iPlayer.z + 15.0);
		ClearAreaOfCops(iPlayer.x, iPlayer.y, iPlayer.z, 5000.0)
		
		SetGarbageTrucks(false)
		SetRandomBoats(true)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000)
		Clients()
	end
end)

Citizen.CreateThread(function()
  SwitchTrainTrack(0, true)
  SwitchTrainTrack(3, true)
  N_0x21973bbf8d17edfa(0, 120000)
  SetRandomTrains(true)
end)