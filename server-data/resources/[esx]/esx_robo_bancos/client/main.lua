ESX = nil
cachedData = {["banks"] = {}}
Citizen.CreateThread(
    function()
        while ESX == nil do
            TriggerEvent(
                "esx:getSharedObject",
                function(a)
                    ESX = a
                end
            )
            Citizen.Wait(0)
        end
        ClearPedTasks(PlayerPedId())
    end
)
RegisterNetEvent("esx:playerLoaded")
AddEventHandler(
    "esx:playerLoaded",
    function(b)
        ESX.PlayerData = b
        ESX.TriggerServerCallback(
            "if_esx_fleeca:getCurrentRobbery",
            function(c)
                if c then
                    for d, e in pairs(c) do
                        cachedData["banks"][d] = e["trolleys"]
                        RobberyThread({["bank"] = d, ["trolleys"] = e["trolleys"]})
                    end
                end
            end
        )
    end
)
RegisterNetEvent("esx:setJob")
AddEventHandler(
    "esx:setJob",
    function(f)
        ESX.PlayerData["job"] = f
    end
)
RegisterNetEvent("if_esx_fleeca:eventHandler")
AddEventHandler(
    "if_esx_fleeca:eventHandler",
    function(g, h)
        if g == "start_robbery" then
            RobberyThread(h)
        elseif g == "alarm_police" then
            if ESX.PlayerData["job"] and ESX.PlayerData["job"]["name"] == "police" then
                SetAudioFlag("LoadMPData", true)
                PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")
                ESX.ShowNotification(
                    "Alguien esta intentando ~r~descifrar ~s~la clave de seguridad del banco - ~g~ " ..
                        h .. " ~s~Punto de referencia GPS marcado."
                )
                local i = Config.Bank[h]
                SetNewWaypoint(i["start"]["pos"]["x"], i["start"]["pos"]["y"])
                local j = AddBlipForCoord(i["start"]["pos"])
                SetBlipSprite(j, 161)
                SetBlipScale(j, 2.0)
                SetBlipColour(j, 8)
                Citizen.CreateThread(
                    function()
                        local k = GetGameTimer()
                        while GetGameTimer() - k < 60000 * 5 do
                            Citizen.Wait(0)
                        end
                        RemoveBlip(j)
                    end
                )
            end
        else
        end
    end
)
Citizen.CreateThread(
    function()
        Citizen.Wait(100)
        while true do
            local l = 500
            local m = PlayerPedId()
            local n = GetEntityCoords(m)
            for d, o in pairs(Config.Bank) do
                local p = GetDistanceBetweenCoords(n, o["start"]["pos"], true)
                if p <= 5.0 then
                    l = 5
                    if p <= 1.0 then
                        local q, r =
                            not cachedData["banks"][d],
                            cachedData["hacking"] and "~r~Hackear..." or
                                cachedData["banks"][d] and "~r~Robo~s~ en progreso..." or
                                "~INPUT_CONTEXT~ Comenzar ~r~hackeo~s~ del banco"
                        ESX.ShowHelpNotification(r)
                        if IsControlJustPressed(0, 38) then
                            if q then
                                TryHackingDevice(d)
                            end
                        end
                    end
                    DrawScriptMarker(
                        {
                            ["type"] = 6,
                            ["pos"] = o["start"]["pos"] - vector3(0.0, 0.0, 0.985),
                            ["r"] = 255,
                            ["g"] = 0,
                            ["b"] = 0
                        }
                    )
                end
            end
            Citizen.Wait(l)
        end
    end
)

local x = 0
RegisterNetEvent("if_esx_fleeca:terkidan")
AddEventHandler(
    "if_esx_fleeca:terkidan",
    function(y, z)
        x = z
        terkidan(y)
    end
)
RegisterNetEvent("if_esx_fleeca:bazshodan")
AddEventHandler(
    "if_esx_fleeca:bazshodan",
    function(A, B, C, D)
        local w = {A, B, C}
        local E, F = ESX.Game.GetClosestObject("hei_v_ilev_bk_gate2_pris", w)
        local G = GetEntityCoords(E)
        local H = GetEntityHeading(E) + 70
        globalcoords = w
        globalrotation = H
        globalDoortype = D
        Citizen.CreateThread(
            function()
                Wait(2000)
                SetEntityHeading(E, globalrotation)
            end
        )
    end
)
