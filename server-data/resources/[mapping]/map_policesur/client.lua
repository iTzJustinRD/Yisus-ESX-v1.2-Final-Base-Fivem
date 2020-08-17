-- This mod has been made by Bobo Boss 
-- My discord: https://discord.gg/jH2aZqw
-- This small code removes all the NPC's at the PD

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
    local myCoords = GetEntityCoords(GetPlayerPed(-1))
    if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 975.76763916016,-120.56567382813,74.223541259766, true ) < 80 then
      ClearAreaOfPeds(975.76763916016,-120.56567382813,74.223541259766, 58.0, 0)
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 471.90618896484,-989.65802001953,24.914854049683, true ) < 20 then
      ClearAreaOfPeds(471.90618896484,-989.65802001953,24.914854049683, 20.0, 0)
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 243.72465515137,-1096.3624267578,29.30615234375, true ) < 30 then
      ClearAreaOfPeds(243.72465515137,-1096.3624267578,29.30615234375, 20.0, 0)
    end
  end
end)

-- This samll code loads the entire interior, and makes it possible to spawn inside the pd now

Citizen.CreateThread(function()
  PinInteriorInMemory(GetInteriorAtCoords(440.84, -983.14, 30.69))
end)