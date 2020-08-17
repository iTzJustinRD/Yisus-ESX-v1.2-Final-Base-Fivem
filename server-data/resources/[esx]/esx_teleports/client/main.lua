ESX = nil

local PlayerData = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(1)
    end

    while ESX.GetPlayerData() == nil do Citizen.Wait(10) end

    PlayerData = ESX.GetPlayerData()

    LoadMarkers()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer) PlayerData = xPlayer end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job) PlayerData.job = job end)

function LoadMarkers()
    Citizen.CreateThread(function()

        while true do
            Citizen.Wait(5)

            local plyCoords = GetEntityCoords(PlayerPedId())

            for location, val in pairs(Config.Teleporters) do

                local Enter = val['Enter']
                local Exit = val['Exit']
                local JobNeeded = val['Job']

                local dstCheckEnter, dstCheckExit =
                    GetDistanceBetweenCoords(plyCoords, Enter['x'], Enter['y'],
                                             Enter['z'], true),
                    GetDistanceBetweenCoords(plyCoords, Exit['x'], Exit['y'],
                                             Exit['z'], true)

                if dstCheckEnter <= 10 then
                    if JobNeeded ~= 'none' then
                        if PlayerData.job.name == JobNeeded then

                            DrawM(Enter['Information'], 23, Enter['x'],
                                  Enter['y'], Enter['z'])

                            if dstCheckEnter <= 1.2 then
                                ESX.ShowHelpNotification(Enter['Information'])
                                if IsControlJustPressed(0, 38) then
                                    Teleport(val, 'enter')
                                end
                            end

                        end
                    else
                        DrawM(Enter['Information'], 27, Enter['x'], Enter['y'],
                              Enter['z'])

                        if dstCheckEnter <= 2.3 then
                            ESX.ShowHelpNotification(Enter['Information'])
                            if IsControlJustPressed(0, 38) then
                                Teleport(val, 'enter')
                            end

                        end

                    end
                end

                if dstCheckExit <= 10 then
                    if JobNeeded ~= 'none' then
                        if PlayerData.job.name == JobNeeded then

                            DrawM(Exit['Information'], 27, Exit['x'], Exit['y'],Exit['z'])

                            if dstCheckExit <= 1.2 then
                                ESX.ShowHelpNotification(Exit['Information'])
                                if IsControlJustPressed(0, 38) then
                                    Teleport(val, 'exit')
                                end
                            end

                        end
                    else

                        DrawM(Exit['Information'], 27, Exit['x'], Exit['y'],
                              Exit['z'])

                        if dstCheckExit <= 1.2 then
                            ESX.ShowHelpNotification(Exit['Information'])
                            if IsControlJustPressed(0, 38) then
                                Teleport(val, 'exit')
                            end

                        end
                    end
                end

            end

        end

    end)
end

function Teleport(table, location)
    if location == 'enter' then
        DoScreenFadeOut(100)

        Citizen.Wait(750)

        ESX.Game.Teleport(PlayerPedId(), table['Exit'])

        DoScreenFadeIn(100)
    else
        DoScreenFadeOut(100)

        Citizen.Wait(750)

        ESX.Game.Teleport(PlayerPedId(), table['Enter'])

        DoScreenFadeIn(100)
    end
end

function DrawM(hint, type, x, y, z)
    -- ESX.Game.Utils.DrawText3D({x = x, y = y, z = z + 1.0}, hint, 0.4)
    -- ESX.ShowHelpNotification(hint)
    DrawMarker(type, x, y, z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 255,
               255, 255, 100, false, false, 2, false, false, false, false)
end
