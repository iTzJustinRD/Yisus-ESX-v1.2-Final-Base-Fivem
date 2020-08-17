------------------------------------------
------------TECLAS RÁPIDAS----------------
------------------------------------------

-- FACEPALM
function facepalm()
	local animDict = 'anim@mp_player_intupperface_palm'
    local animName = 'idle_a'
    local ped = PlayerPedId()
    if not IsEntityPlayingAnim(ped, animDict, animName, 3) and not IsPedInAnyVehicle(PlayerPedId()) then
        ESX.Streaming.RequestAnimDict(animDict, function()
            TaskPlayAnim(ped, animDict, animName, 6.0, -6.0, -1, 49, 0, 0, 0, 0)
        end)
    else
        ClearPedTasks(ped)
    end
end

--CRUZAR BRAZOS
function crossarms()
	local animDict = 'anim@heists@heist_corona@single_team'
    local animName = 'single_team_loop_boss'
    local ped = PlayerPedId()
    if not IsEntityPlayingAnim(ped, animDict, animName, 3) and not IsPedInAnyVehicle(PlayerPedId()) then
        ESX.Streaming.RequestAnimDict(animDict, function()
            TaskPlayAnim(ped, animDict, animName, 6.0, -6.0, -1, 49, 0, 0, 0, 0)
        end)
    else
        ClearPedTasks(ped)
    end
end

-- LEVANTAR LAS MANOS

function handsup()
	local animDict = 'random@mugging3'
    local animName = 'handsup_standing_base'
    local ped = PlayerPedId()
    if not IsEntityPlayingAnim(ped, animDict, animName, 3) and not IsPedInAnyVehicle(PlayerPedId()) then
        ESX.Streaming.RequestAnimDict(animDict, function()
            TaskPlayAnim(ped, animDict, animName, 6.0, -6.0, -1, 49, 0, 0, 0, 0)
        end)
    else
        ClearPedTasks(ped)
    end
end

-- SEÑALAR
local mp_pointing = false
local keyPressed = false

local function startPointing()
    local ped = PlayerPedId()
    LoadDict("anim@mp_point")
    SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
    SetPedConfigFlag(ped, 36, 1)
    TaskMoveNetworkByName(ped, "task_mp_pointing", 0.5, 0, "anim@mp_point", 24)
    RemoveAnimDict("anim@mp_point")
end

local function stopPointing()
    local ped = PlayerPedId()
    RequestTaskMoveNetworkStateTransition(ped, "Stop")
    if not IsPedInjured(ped) then
        ClearPedSecondaryTask(ped)
    end
    if not IsPedInAnyVehicle(ped, 1) then
        SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
    end
    SetPedConfigFlag(ped, 36, 0)
    ClearPedSecondaryTask(PlayerPedId())
end

local once = true
local oldval = false
local oldvalped = false

Citizen.CreateThread(function()
    while true do
        Wait(0)
        if once then
            once = false
        end

        if not keyPressed then
            if IsControlPressed(0, 29) and not mp_pointing and IsPedOnFoot(PlayerPedId()) then
                Wait(200)
                if not IsControlPressed(0, 29) then
                    keyPressed = true
                    startPointing()
                    mp_pointing = true
                else
                    keyPressed = true
                    while IsControlPressed(0, 29) do
                        Wait(50)
                    end
                end
            elseif (IsControlPressed(0, 29) and mp_pointing) or (not IsPedOnFoot(PlayerPedId()) and mp_pointing) then
                keyPressed = true
                mp_pointing = false
                stopPointing()
            end
        end

        if keyPressed then
            if not IsControlPressed(0, 29) then
                keyPressed = false
            end
        end
        if IsTaskMoveNetworkActive(PlayerPedId()) and not mp_pointing then
            stopPointing()
        end
        if IsTaskMoveNetworkActive(PlayerPedId()) then
            if not IsPedOnFoot(PlayerPedId()) then
                stopPointing()
            else
                local ped = PlayerPedId()
                local camPitch = GetGameplayCamRelativePitch()
                if camPitch < -70.0 then
                    camPitch = -70.0
                elseif camPitch > 42.0 then
                    camPitch = 42.0
                end
                camPitch = (camPitch + 70.0) / 112.0

                local camHeading = GetGameplayCamRelativeHeading()
                local cosCamHeading = Cos(camHeading)
                local sinCamHeading = Sin(camHeading)
                if camHeading < -180.0 then
                    camHeading = -180.0
                elseif camHeading > 180.0 then
                    camHeading = 180.0
                end
                camHeading = (camHeading + 180.0) / 360.0

                local blocked = 0
                local nn = 0

                local coords = GetOffsetFromEntityInWorldCoords(ped, (cosCamHeading * -0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)), (sinCamHeading * -0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)), 0.6)
                local ray = Cast_3dRayPointToPoint(coords.x, coords.y, coords.z - 0.2, coords.x, coords.y, coords.z + 0.2, 0.4, 95, ped, 7);
                nn,blocked,coords,coords = GetRaycastResult(ray)

                SetTaskMoveNetworkSignalFloat(ped, "Pitch", camPitch)
                SetTaskMoveNetworkSignalFloat(ped, "Heading", camHeading * -1.0 + 1.0)
                SetTaskMoveNetworkSignalBool(ped, "isBlocked", blocked)
                SetTaskMoveNetworkSignalBool(ped, "isFirstPerson", Citizen.InvokeNative(0xEE778F8C7E1142E2, Citizen.InvokeNative(0x19CAFA3C87F7C2FF)) == 4)

            end
        end
    end
end)

-- CROUCH
local crouched = false
Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1)

        if (DoesEntityExist(PlayerPedId()) and not IsEntityDead(PlayerPedId())) then 
            DisableControlAction(0, 36, true) 

            if (not IsPauseMenuActive()) then 
                if (IsDisabledControlJustPressed(0, 36)) then 
                    if (crouched == true) then 
                        ResetPedMovementClipset(PlayerPedId(), 0)
                        crouched = false 
                    elseif (crouched == false) then
                        ESX.Streaming.RequestAnimSet("move_ped_crouched", function()
                            SetPedMovementClipset(PlayerPedId(), "move_ped_crouched", 0.25)
                        end)
                        crouched = true 
                    end 
                end
            end 
        end 
    end
end)

--RAGDOLL
local isInRagdoll = false

Citizen.CreateThread(function()
 while true do
    Citizen.Wait(1)
    if isInRagdoll then
      SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
    end

    if IsControlJustPressed(2, 304) and IsPedOnFoot(PlayerPedId()) then -- tecla h ragdoll
        if isInRagdoll then
            isInRagdoll = false
        else
            isInRagdoll = true
            Wait(500)
        end
    end
  end
end)

-- COMANDOS
--[[]]
RegisterCommand('xhandsup', function() handsup() end, false)
RegisterCommand('gcrossarms', function() crossarms() end, false)
RegisterCommand('zfacepalm', function() facepalm() end, false)

-- KEY BINDING (Cambiables en Ajustes/Teclas/FiveM)
RegisterKeyMapping('xhandsup', 'Levantar manos', 'keyboard', 'x') --tecla x levantar manos
RegisterKeyMapping('gcrossarms', 'Cruzar los brazos', 'keyboard', 'g') -- g cruzar los brazos 
RegisterKeyMapping('zfacepalm', 'Facepalm', 'keyboard', 'z') -- z facepalm