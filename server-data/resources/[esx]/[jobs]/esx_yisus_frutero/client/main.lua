ESX = nil

local Keys = {
    ["ESC"] = 322,
    ["F1"] = 288,
    ["F2"] = 289,
    ["F3"] = 170,
    ["F5"] = 166,
    ["F6"] = 167,
    ["F7"] = 168,
    ["F8"] = 169,
    ["F9"] = 56,
    ["F10"] = 57,
    ["~"] = 243,
    ["1"] = 157,
    ["2"] = 158,
    ["3"] = 160,
    ["4"] = 164,
    ["5"] = 165,
    ["6"] = 159,
    ["7"] = 161,
    ["8"] = 162,
    ["9"] = 163,
    ["-"] = 84,
    ["="] = 83,
    ["BACKSPACE"] = 177,
    ["TAB"] = 37,
    ["Q"] = 44,
    ["W"] = 32,
    ["E"] = 38,
    ["R"] = 45,
    ["T"] = 245,
    ["Y"] = 246,
    ["U"] = 303,
    ["P"] = 199,
    ["["] = 39,
    ["]"] = 40,
    ["ENTER"] = 18,
    ["CAPS"] = 137,
    ["A"] = 34,
    ["S"] = 8,
    ["D"] = 9,
    ["F"] = 23,
    ["G"] = 47,
    ["H"] = 74,
    ["K"] = 311,
    ["L"] = 182,
    ["LEFTSHIFT"] = 21,
    ["Z"] = 20,
    ["X"] = 73,
    ["C"] = 26,
    ["V"] = 0,
    ["B"] = 29,
    ["N"] = 249,
    ["M"] = 244,
    [","] = 82,
    ["."] = 81,
    ["LEFTCTRL"] = 36,
    ["LEFTALT"] = 19,
    ["SPACE"] = 22,
    ["RIGHTCTRL"] = 70,
    ["HOME"] = 213,
    ["PAGEUP"] = 10,
    ["PAGEDOWN"] = 11,
    ["DELETE"] = 178,
    ["LEFT"] = 174,
    ["RIGHT"] = 175,
    ["TOP"] = 27,
    ["DOWN"] = 173,
    ["NENTER"] = 201,
    ["N4"] = 108,
    ["N5"] = 60,
    ["N6"] = 107,
    ["N+"] = 96,
    ["N-"] = 97,
    ["N7"] = 117,
    ["N8"] = 61,
    ["N9"] = 118
}

local fruteroBlip = false
local HasAlreadyEnteredMarker = false
local LastZone = nil
local CurrentAction = nil
local CurrentActionMsg = ''
local CurrentActionData = {}
local onDuty = false
local IsDead = false
local showPro = false
local cajafruta = nil
local fruta = nil
local zumo = nil
local isHoldingFruit = false
local JobBlips = {}
local BlipsAdded = false
local cooldownclick = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do Citizen.Wait(10) end

    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer) 
    ESX.PlayerData = xPlayer 
    mainBlip()
                
end)
                

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
    offduty()
    mainBlip()
end)

function DrawSub(msg, time)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(msg)
    DrawSubtitleTimed(time, 1)
end

function ShowLoadingPromt(msg, time, type)
    Citizen.CreateThread(function()
        Citizen.Wait(0)
        BeginTextCommandBusyString("STRING")
        AddTextComponentString(msg)
        EndTextCommandBusyString(type)
        Citizen.Wait(time)

        RemoveLoadingPrompt()
    end)
end

function OpenCloakroom()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'orchard_cloakroom',
                     {
        title = 'Vestuario',
        align = 'bottom-right',
        elements = {
            {label = 'Ropa Civil', value = 'wear_citizen'},
            {label = 'Vestimenta de Trabajo', value = 'wear_work'}
        }
    }, function(data, menu)
        if data.current.value == 'wear_citizen' then
            offduty()
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                TriggerEvent('skinchanger:loadSkin', skin)
            end)
        elseif data.current.value == 'wear_work' then
            onduty()
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin',
                                      function(skin, jobSkin)
                if skin.sex == 0 then
                    TriggerEvent('skinchanger:loadClothes', skin,
                                 jobSkin.skin_male)
                else
                    TriggerEvent('skinchanger:loadClothes', skin,
                                 jobSkin.skin_female)
                end
            end)
        end
    end, function(data, menu)
        menu.close()

        CurrentAction = 'cloakroom'
        CurrentActionMsg = 'Presiona E para acceder al vestuario'
        CurrentActionData = {}
    end)
end

function OpenSell()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'orchard_sell', {
        title = 'Venta',
        align = 'bottom-right',
        elements = {
            {label = 'Vender manzanas', value = 'sell_apple'},
            {label = 'Vender naranjas', value = 'sell_orange'}
        }
    }, function(data, menu)
        if data.current.value == 'sell_apple' then
            if cooldownclick == false then
                cooldownclick = true
                animationShow()
                porcentaje(30)
                TriggerServerEvent('frutero:job3apple')
                ClearPedTasks(PlayerPedId())
            end
        elseif data.current.value == 'sell_orange' then
            if cooldownclick == false then
                cooldownclick = true
                animationShow()
                porcentaje(30)
                TriggerServerEvent('frutero:job3orange')
                ClearPedTasks(PlayerPedId())
            end
        end
    end, function(data, menu)
        menu.close()

        CurrentAction = 'orchard_sell'
        CurrentActionMsg = 'Venta'
        CurrentActionData = {}
    end)
end

function OpenVehicleSpawnerMenu()
    ESX.UI.Menu.CloseAll()
    local elements = {}
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner', {
        title = 'Sacar vehículo',
        align = 'bottom-right',
        elements = Config.AuthorizedVehicles
    }, function(data, menu)
        if not ESX.Game.IsSpawnPointClear(Config.Zones.VehicleSpawnPoint.Pos,
                                          5.0) then
            ESX.ShowNotification('Punto de spawn bloqueado')
            return
        end

        menu.close()
        ESX.Game.SpawnVehicle(data.current.model,
                              Config.Zones.VehicleSpawnPoint.Pos,
                              Config.Zones.VehicleSpawnPoint.Heading,
                              function(vehicle)
            local playerPed = PlayerPedId()
            TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
            Wait(200)
            -- DAR LLAVE
        end)
    end, function(data, menu)
        CurrentAction = 'vehicle_spawner'
        CurrentActionMsg = 'Pulsa ~INPUT_CONTEXT~ para sacar un vehículo'
        CurrentActionData = {}

        menu.close()
    end)
end

function DeleteJobVehicle()
    local playerPed = PlayerPedId()

    if IsInAuthorizedVehicle() then

        local vehicleProps = ESX.Game.GetVehicleProperties(
                                 CurrentActionData.vehicle)
        ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
    else
        ESX.ShowNotification('Solo sirve para vehículos de la compañia')
    end
end

function IsInAuthorizedVehicle()
    local playerPed = PlayerPedId()
    local vehModel = GetEntityModel(GetVehiclePedIsIn(playerPed, false))

    for i = 1, #Config.AuthorizedVehicles, 1 do
        if vehModel == GetHashKey(Config.AuthorizedVehicles[i].model) then
            return true
        end
    end

    return false
end

AddEventHandler('frutero:hasEnteredMarker', function(zone)
    if zone == 'VehicleSpawner' then
        CurrentAction = 'vehicle_spawner'
        CurrentActionMsg =
            'Presiona ~INPUT_CONTEXT~ para sacar tu vehículo de trabajo'
        CurrentActionData = {}
    elseif zone == 'VehicleDeleter' then
        local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(playerPed, false)

        if IsPedInAnyVehicle(playerPed, false) and
            GetPedInVehicleSeat(vehicle, -1) == playerPed then
            CurrentAction = 'delete_vehicle'
            CurrentActionMsg =
                'Presiona ~INPUT_CONTEXT~ para devolver tu vehículo'
            CurrentActionData = {vehicle = vehicle}
        end
    elseif zone == 'Cloakroom' then
        CurrentAction = 'cloakroom'
        CurrentActionMsg = 'Presiona ~INPUT_CONTEXT~ para acceder al vestuario'
        CurrentActionData = {}

    elseif zone == 'Help' then
        CurrentAction = 'help'
        CurrentActionMsg = ('Presiona ~g~~INPUT_CONTEXT~~s~ para leer la ayuda')
        CurrentActionData = {}

    elseif zone == 'Job1' then
        CurrentAction = 'Job1'
        CurrentActionMsg = 'Presiona ~INPUT_CONTEXT~ para recoger fruta'
        CurrentActionData = {}

    elseif zone == 'Job1b' then
        CurrentAction = 'Job1b'
        CurrentActionMsg = 'Presiona ~INPUT_CONTEXT~ para recoger fruta'
        CurrentActionData = {}

    elseif zone == 'Job1c' then
        CurrentAction = 'Job1c'
        CurrentActionMsg = 'Presiona ~INPUT_CONTEXT~ para recoger fruta'
        CurrentActionData = {}

    elseif zone == 'Job2' then
        CurrentAction = 'Job2'
        CurrentActionMsg = 'Presiona ~INPUT_CONTEXT~ para hacer zumo'
        CurrentActionData = {}

    elseif zone == 'Job3' then
        CurrentAction = 'Job3'
        CurrentActionMsg =
            'Presiona ~INPUT_CONTEXT~ para sacar los zumos refrigerados'
        CurrentActionData = {}

    elseif zone == 'Job3a' then
        CurrentAction = 'Job3a'
        CurrentActionMsg = 'Presiona ~INPUT_CONTEXT~ para vender'
        CurrentActionData = {}

    end
end)

AddEventHandler('frutero:hasExitedMarker', function(zone)
    ESX.UI.Menu.CloseAll()
    CurrentAction = nil
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'frutero' and
            not onDuty then
            local coords = GetEntityCoords(PlayerPedId())
            local distance = GetDistanceBetweenCoords(coords, Config.Zones
                                                          .Cloakroom.Pos.x,
                                                      Config.Zones.Cloakroom.Pos
                                                          .y, Config.Zones
                                                          .Cloakroom.Pos.z, true)
            local isInMarker, currentZone = false

            if distance < Config.DrawDistance then
                DrawMarker(Config.Zones.Cloakroom.Type,
                           Config.Zones.Cloakroom.Pos.x,
                           Config.Zones.Cloakroom.Pos.y,
                           Config.Zones.Cloakroom.Pos.z, 0.0, 0.0, 0.0, 0.0,
                           0.0, 0.0, Config.Zones.Cloakroom.Size.x,
                           Config.Zones.Cloakroom.Size.y,
                           Config.Zones.Cloakroom.Size.z,
                           Config.Zones.Cloakroom.Color.r,
                           Config.Zones.Cloakroom.Color.g,
                           Config.Zones.Cloakroom.Color.b, 100, false, false, 2,
                           Config.Zones.Cloakroom.Rotate, nil, nil, false)
                
                if distance < Config.Zones.Cloakroom.Size.x then
                    isInMarker, currentZone = true, 'Cloakroom'
                    ESX.ShowHelpNotification(Config.Zones.Cloakroom.Text)
                end

                if (isInMarker and not HasAlreadyEnteredMarker) or
                    (isInMarker and LastZone ~= currentZone) then
                    HasAlreadyEnteredMarker, LastZone = true, currentZone
                    TriggerEvent('frutero:hasEnteredMarker', currentZone)
                end

                if not isInMarker and HasAlreadyEnteredMarker then
                    HasAlreadyEnteredMarker = false
                    TriggerEvent('frutero:hasExitedMarker', LastZone)
                end

                if isInMarker and IsControlJustReleased(0, Keys['E']) then
                    OpenCloakroom()
                    CurrentAction = nil
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    mainBlip()
    while true do
        Citizen.Wait(0)
        if onDuty then
            local coords = GetEntityCoords(PlayerPedId())
            local isInMarker, currentZone = false

            for k, v in pairs(Config.Zones) do
                local distance = GetDistanceBetweenCoords(coords, v.Pos.x,
                                                          v.Pos.y, v.Pos.z, true)

                if v.Type ~= -1 then
                    if distance > 5 and distance < Config.DrawDistance then
                        DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0,
                                   0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y,
                                   v.Size.z, v.Color.r, v.Color.g, v.Color.b,
                                   100, false, false, 2, v.Rotate, nil, nil,
                                   false)
                    elseif distance < 5 and distance < Config.DrawDistance then
                        DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0,
                                   0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y,
                                   v.Size.z, v.Color.r, v.Color.g, v.Color.b,
                                   100, false, false, 2, v.Rotate, nil, nil,
                                   false)
                        ESX.ShowHelpNotification(v.Text)
                    end
                end

                if distance < v.Size.x then
                    isInMarker, currentZone = true, k
                end
            end

            if (isInMarker and not HasAlreadyEnteredMarker) or
                (isInMarker and LastZone ~= currentZone) then
                HasAlreadyEnteredMarker, LastZone = true, currentZone
                TriggerEvent('frutero:hasEnteredMarker', currentZone)
            end

            if not isInMarker and HasAlreadyEnteredMarker then
                HasAlreadyEnteredMarker = false
                TriggerEvent('frutero:hasExitedMarker', LastZone)
            end
        else
            Citizen.Wait(10000)
        end

        if CurrentAction and not IsDead then

            if IsControlJustReleased(0, Keys['E']) and ESX.PlayerData.job and
                ESX.PlayerData.job.name == 'frutero' then
                if CurrentAction == 'cloakroom' then
                    OpenCloakroom()
                elseif CurrentAction == 'vehicle_spawner' then
                    OpenVehicleSpawnerMenu()
                elseif CurrentAction == 'delete_vehicle' then
                    DeleteJobVehicle()

                elseif CurrentAction == 'Job1' then
                    WorkJob1()
                elseif CurrentAction == 'Job1b' then
                    WorkJob1b()
                elseif CurrentAction == 'Job1c' then
                    WorkJob1c()
                elseif CurrentAction == 'Job3a' then
                    WorkJob3a()
                end

                CurrentAction = nil
            end
        end
    end
end)

function WorkJob1()
    if onDuty == true then
        if not ESX.Game.IsSpawnPointClear(Config.Zones.Job1.Pos, 20.0) then
            exports['mythic_notify']:SendAlert('error', "Deja el vehículo en el camino, estas destrozando la huerta")
            Citizen.Wait(2000)
            HasAlreadyEnteredMarker, LastZone = true, currentZone
            TriggerEvent('frutero:hasEnteredMarker', currentZone)
        else
            if IsPedInAnyVehicle(PlayerPedId()) then
                exports['mythic_notify']:SendAlert('error', "No puedes hacer el trabajo montado en un vehículo.")
                Citizen.Wait(2000)
                HasAlreadyEnteredMarker, LastZone = true, currentZone
                TriggerEvent('frutero:hasEnteredMarker', currentZone)
            else
                local tree = controlArboles()
                if tree ~= 0 then
                    if isHoldingFruit == true then
                        exports['mythic_notify']:SendAlert('error', "Primero, coloca la fruta en tu vehículo")
                    else
                        animRecolectando()
                        FreezeEntityPosition(PlayerPedId(), true)
                        porcentaje(150)
                        FreezeEntityPosition(PlayerPedId(), false)
                        TriggerServerEvent('frutero:job1a')
                        exports['mythic_notify']:SendAlert('success', "Pon la fruta en el vehículo de trabajo.")
                        Citizen.Wait(3000)
                        HasAlreadyEnteredMarker, LastZone = true, currentZone
                        TriggerEvent('frutero:hasEnteredMarker', currentZone)
                    end
                else
                    exports['mythic_notify']:SendAlert('error', "Tienes que acercarte al árbol para recoger algo de él.")
                    Citizen.Wait(2000)
                    HasAlreadyEnteredMarker, LastZone = true, currentZone
                    TriggerEvent('frutero:hasEnteredMarker', currentZone)
                end
            end
        end
    else
        ESX.ShowHelpNotification('¡Ponte la ropa de trabajo!')
    end
end

function WorkJob1b()
    if onDuty == true then
        if not ESX.Game.IsSpawnPointClear(Config.Zones.Job1.Pos, 20.0) then
            exports['mythic_notify']:SendAlert('error', "¡Alguien dejó el vehículo en el huerto...!")
            Citizen.Wait(2000)
            HasAlreadyEnteredMarker, LastZone = true, currentZone
            TriggerEvent('frutero:hasEnteredMarker', currentZone)
        else
            if IsPedInAnyVehicle(PlayerPedId()) then
                ESX.ShowHelpNotification(
                    "~r~¡No puedes hacer este trabajo mientras estás en la carretera!")
                Citizen.Wait(2000)
                HasAlreadyEnteredMarker, LastZone = true, currentZone
                TriggerEvent('frutero:hasEnteredMarker', currentZone)
            else
                local tree = controlArboles()
                if tree ~= 0 then
                    if isHoldingFruit == true then
                        exports['mythic_notify']:SendAlert('error', "Primero, coloca la fruta en tu vehículo")
                    else
                        animRecolectando()
                        FreezeEntityPosition(PlayerPedId(), true)
                        porcentaje(150)
                        FreezeEntityPosition(PlayerPedId(), false)
                        TriggerServerEvent('frutero:job1b')
                        ESX.ShowHelpNotification("Pon la fruta en el coche")
                        Citizen.Wait(3000)
                        HasAlreadyEnteredMarker, LastZone = true, currentZone
                        TriggerEvent('frutero:hasEnteredMarker', currentZone)
                    end
                else
                    ESX.ShowHelpNotification(
                        'Necesitas acercarte al árbol para sacar algo de él')
                    Citizen.Wait(2000)
                    HasAlreadyEnteredMarker, LastZone = true, currentZone
                    TriggerEvent('frutero:hasEnteredMarker', currentZone)
                end
            end
        end
    else
        ESX.ShowHelpNotification('¡Ponte la ropa de trabajo!')
    end
end

function WorkJob3a()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if IsPedInAnyVehicle(PlayerPedId(), false) and IsInAuthorizedVehicle() then
        TaskLeaveVehicle(PlayerPedId(), vehicle, 0)
        porcentaje(2)
        TriggerEvent('frutero:darcajafruta')
        exports['mythic_notify']:SendAlert('success', "Lleva la fruta a la tienda y vendela")
    else
        ESX.ShowNotification('Debes estar en el coche')
    end
end

RegisterNetEvent('frutero:anim')
AddEventHandler('frutero:anim', function()
    ClearPedTasks(PlayerPedId())
    Wait(750)
    animacionFrutaa()
    TriggerEvent('frutero:meterCoche')
end)

RegisterNetEvent('frutero:anim2')
AddEventHandler('frutero:anim2', function()
    ESX.ShowHelpNotification('Mete los zumos en el vehículo.')
    animZumo()
    TriggerEvent('frutero:meterCoche')
end)

RegisterNetEvent('frutero:toomuch')
AddEventHandler('frutero:toomuch', function()
    exports['mythic_notify']:SendAlert('error', "Llevas demasiada fruta, no seas avaricioso")
    ClearPedTasks(PlayerPedId())
end)

RegisterNetEvent('frutero:toomuchj')
AddEventHandler('frutero:toomuchj', function()
    ESX.ShowHelpNotification("~r~Llevas demasiado zumo")
    ClearPedSecondaryTask(PlayerPedId())
end)

RegisterNetEvent('frutero:insuficiente')
AddEventHandler('frutero:insuficiente', function()
    exports['mythic_notify']:SendAlert('error', "No tienes la cantidad necesaria de fruta.")
    ClearPedSecondaryTask(PlayerPedId())
end)

AddEventHandler('esx:onPlayerDeath', function()
    IsDead = true
    quitarcaja()
end)

AddEventHandler('playerSpawned', function(spawn) IsDead = false end)

function animRecolectando()
    local ad = "amb@prop_human_movie_bulb@base"
    local anim = "base"
    local player = PlayerPedId()

    if (DoesEntityExist(player) and not IsEntityDead(player)) then
        loadAnimDict(ad)
        if (IsEntityPlayingAnim(player, ad, anim, 8)) then
            TaskPlayAnim(player, ad, "exit", 8.0, 8.0, 1.0, 1, 1, 0, 0, 0)
            ClearPedSecondaryTask(player)
        else
            SetCurrentPedWeapon(player, GetHashKey("WEAPON_UNARMED"), equipNow)
            Citizen.Wait(50)
            TaskPlayAnim(player, ad, anim, 8.0, 8.0, 1.0, 1, 1, 0, 0, 0)
        end
    end
end

function animationShow()
    local ad = "mini@repair"
    local anim = "fixing_a_ped"
    local player = PlayerPedId()

    if (DoesEntityExist(player) and not IsEntityDead(player)) then
        loadAnimDict(ad)
        if (IsEntityPlayingAnim(player, ad, anim, 8)) then
            TaskPlayAnim(player, ad, "exit", 8.0, -8.0, 0.2, 1, 0, 0, 0, 0)
            ClearPedSecondaryTask(player)
        else
            SetCurrentPedWeapon(player, GetHashKey("WEAPON_UNARMED"), equipNow)
            Citizen.Wait(50)
            TaskPlayAnim(player, ad, anim, 8.0, -8.0, 0.2, 1, 0, 0, 0, 0)
        end
    end
end

function animacionFrutaa()
    local ad = "anim@heists@box_carry@"
    local anim = "idle"
    local player = PlayerPedId()

    if (DoesEntityExist(player) and not IsEntityDead(player)) then
        loadAnimDict(ad)
        if (IsEntityPlayingAnim(player, ad, anim, 8)) then
            TaskPlayAnim(player, ad, "exit", 8.0, 8.0, 1.0, 50, 1, 0, 0, 0)
            ClearPedSecondaryTask(player)
        else
            quitarcajaprop()
            SetCurrentPedWeapon(player, GetHashKey("WEAPON_UNARMED"), equipNow)
            cajafruta = CreateObject(GetHashKey("prop_crate_float_1"), 0, 0, 0,
                                     true, true, false)
            fruta = CreateObject(GetHashKey("apa_mp_h_acc_fruitbowl_01"), 0, 0,
                                 0, true, true, false)
            AttachEntityToEntity(cajafruta, GetPlayerPed(-1),
                                 GetPedBoneIndex(GetPlayerPed(-1), 28422), 0.0,
                                 -0.4, -0.2, 0, 0, 0, true, true, false, true,
                                 1, true)
            AttachEntityToEntity(fruta, cajafruta,
                                 GetPedBoneIndex(GetPlayerPed(-1), 28422), 0.0,
                                 0.0, 0.1, 0, 0, 0, true, true, false, true, 1,
                                 true)
            Citizen.Wait(50)
            TaskPlayAnim(player, ad, anim, 8.0, 8.0, 1.0, 50, 1, 0, 0, 0)
        end
    end
end

function quitarcaja()
    DeleteEntity(cajafruta)
    DeleteEntity(fruta)
    DeleteEntity(zumo)
    ClearPedSecondaryTask(PlayerPedId())
    cajafruta = nil
    fruta = nil
    zumo = nil
end

function quitarcajaprop()
    DeleteEntity(cajafruta)
    DeleteEntity(fruta)
    DeleteEntity(zumo)
end

RegisterNetEvent('frutero:meterCoche')
AddEventHandler('frutero:meterCoche', function()
    isHoldingFruit = true
    while (isHoldingFruit) do
        Citizen.Wait(1)
        if IsControlJustPressed(1, 38) then
            local coords = GetEntityCoords(PlayerPedId())
            local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 2.0,
                                              0, 70)
            local dupcia = GetEntityModel(vehicle)
            for i = 1, #Config.AuthorizedVehicles, 1 do
                if dupcia == GetHashKey(Config.AuthorizedVehicles[i].model) then
                    quitarcaja()
                    isHoldingFruit = false
                else
                    ESX.ShowNotification(
                        "Demasiado lejos del vehículo o en un modelo no autorizado.")
                end
            end
        end
    end
end)

RegisterNetEvent('frutero:darcajafruta')
AddEventHandler('frutero:darcajafruta', function()
    darzumo = true
    animacionFrutaa()
    while (darzumo) do
        Citizen.Wait(10)
        local playerPed = PlayerPedId()
        local coordsy = GetEntityCoords(playerPed)
        local distance = GetDistanceBetweenCoords(coordsy.x, coordsy.y, coordsy.z, 1729.6154785156, 6414.13671875, 35.037273406982, true)
        if distance < 1.5 then
            ESX.ShowHelpNotification('Presiona ~INPUT_CONTEXT~ para vender fruta')
        end
            DisableControlAction(0, 73, true) -- X
        if IsControlJustReleased(0, Keys['E']) then
            if distance < 1.5 then
                quitarcaja()
                darzumo = false
                OpenSell()
            end
        end
    end
end)

RegisterNetEvent('frutero:porcentaje')
AddEventHandler('frutero:porcentaje', function()
    showPro = true
    while (showPro) do
        Citizen.Wait(10)
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        DisableControlAction(0, 73, true) -- X
        ESX.ShowHelpNotification(TimeLeft .. '~g~%')
    end
end)

function controlArboles()
    local player = PlayerId()
    local plyPed = GetPlayerPed(player)
    local plyPos = GetEntityCoords(plyPed, false)
    local plyOffset = GetOffsetFromEntityInWorldCoords(plyPed, 0.0, 1.0, 0.0)
    local radius = 0.5
    local rayHandle = StartShapeTestCapsule(plyPos.x, plyPos.y, plyPos.z,
                                            plyOffset.x, plyOffset.y,
                                            plyOffset.z, radius, 1, plyPed, 5)
    local _, _, _, _, tree = GetShapeTestResult(rayHandle)
    return tree
end

function mainBlip()

    if ESX ~= nil and ESX.PlayerData ~= nil and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'frutero' then
        local blipFruterod = AddBlipForCoord(Config.Zones.Cloakroom.Pos.x,
                                            Config.Zones.Cloakroom.Pos.y,
                                            Config.Zones.Cloakroom.Pos.z)

        SetBlipSprite(blipFruterod, 479)
        SetBlipDisplay(blipFruterod, 4)
        SetBlipScale(blipFruterod, 0.8)
        SetBlipColour(blipFruterod, 43)
        SetBlipAsShortRange(blipFruterod, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName('Cosecha')
        EndTextCommandSetBlipName(blipFruterod)
        table.insert(JobBlips, blipFruterod)
    else 
        if blipFruterod ~= nil then RemoveBlip(blipFruterod) end
    end
end

function onduty()
    if not BlipsAdded then
        onDuty = true
        BlipsAdded = true
        local blipFruterod2 = AddBlipForCoord(Config.Zones.Job1.Pos.x,
                                              Config.Zones.Job1.Pos.y,
                                              Config.Zones.Job1.Pos.z)
        local blipFruterod3 = AddBlipForCoord(Config.Zones.Job1b.Pos.x,
                                              Config.Zones.Job1b.Pos.y,
                                              Config.Zones.Job1b.Pos.z)
        local blipFruterod6 = AddBlipForCoord(Config.Zones.Job3a.Pos.x,
                                              Config.Zones.Job3a.Pos.y,
                                              Config.Zones.Job3a.Pos.z)

        SetBlipSprite(blipFruterod2, 479)
        SetBlipDisplay(blipFruterod2, 4)
        SetBlipScale(blipFruterod2, 0.8)
        SetBlipColour(blipFruterod2, 43)
        SetBlipAsShortRange(blipFruterod2, true)

        SetBlipSprite(blipFruterod3, 479)
        SetBlipDisplay(blipFruterod3, 4)
        SetBlipScale(blipFruterod3, 0.8)
        SetBlipColour(blipFruterod3, 43)
        SetBlipAsShortRange(blipFruterod3, true)

        SetBlipSprite(blipFruterod6, 467)
        SetBlipDisplay(blipFruterod6, 4)
        SetBlipScale(blipFruterod6, 1.0)
        SetBlipColour(blipFruterod6, 43)
        SetBlipAsShortRange(blipFruterod6, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName('Recogida de fruta')
        EndTextCommandSetBlipName(blipFruterod2)
        table.insert(JobBlips, blipFruterod2)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName('Recogida de fruta')
        EndTextCommandSetBlipName(blipFruterod3)
        table.insert(JobBlips, blipFruterod3)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName('Venta de fruta')
        EndTextCommandSetBlipName(blipFruterod6)
        table.insert(JobBlips, blipFruterod6)
    else
        ESX.ShowNotification('No tienes tu ropa de trabajo.')
    end
end

function offduty()
    onDuty = false
    BlipsAdded = false
    if JobBlips[1] ~= nil then
        for i = 1, #JobBlips, 1 do
            RemoveBlip(JobBlips[i])
            JobBlips[i] = nil
        end
    end
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

function porcentaje(time)
    TriggerEvent('frutero:porcentaje')
    TimeLeft = 0
    repeat
        TimeLeft = TimeLeft + 1
        Citizen.Wait(time)
    until (TimeLeft == 100)
    showPro = false
    cooldownclick = false
end

--[[AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then mainBlip() end
end)

AddEventHandler('onClientMapStart', function() mainBlip() end)]]
