GlobalFunction = function(a, b)
    local c = {event = a, data = b}
    TriggerServerEvent("if_esx_fleeca:globalEvent", c)
end
TryHackingDevice = function(d)
    ESX.TriggerServerCallback(
        "if_esx_fleeca:fetchCops",
        function(e)
            if e then
                StartHackingDevice(d)
            else
                ESX.ShowNotification("No hay la cantidad de policias necesarios.")
            end
        end
    )
end
StartHackingDevice = function(d)
    Citizen.CreateThread(
        function()
            cachedData["hacking"] = true
            local f = Config.Bank[d]
            if #Config.ItemNeeded > 0 then
                if not HasItem() then
                    return ESX.ShowNotification("No tienes~h~~r~ " .. Config.ItemNeeded)
                end
            end
            local g, h = ESX.Game.GetClosestPlayer()
            if g ~= -1 and h <= 3.0 then
                if
                    IsEntityPlayingAnim(GetPlayerPed(g), "anim@heists@ornate_bank@hack", "hack_loop", 3) or
                        IsEntityPlayingAnim(GetPlayerPed(g), "anim@heists@ornate_bank@hack", "hack_enter", 3) or
                        IsEntityPlayingAnim(GetPlayerPed(g), "anim@heists@ornate_bank@hack", "hack_exit", 3)
                 then
                    return ESX.ShowNotification("Ya hay alguien trasteando el dispositivo.")
                end
            end
            local i = GetClosestObjectOfType(f["start"]["pos"], 5.0, f["device"]["model"], false)
            if not DoesEntityExist(i) then
                return
            end
            cachedData["bank"] = d
            LoadModels(
                {
                    GetHashKey("hei_p_m_bag_var22_arm_s"),
                    GetHashKey("hei_prop_hst_laptop"),
                    "anim@heists@ornate_bank@hack"
                }
            )
            GlobalFunction("alarm_police", d)
            cachedData["bag"] =
                CreateObject(
                GetHashKey("hei_p_m_bag_var22_arm_s"),
                f["start"]["pos"] - vector3(0.0, 0.0, 5.0),
                true,
                false,
                false
            )
            cachedData["laptop"] =
                CreateObject(
                GetHashKey("hei_prop_hst_laptop"),
                f["start"]["pos"] - vector3(0.0, 0.0, 5.0),
                true,
                false,
                false
            )
            local j = GetOffsetFromEntityInWorldCoords(i, 0.1, 0.8, 0.4)
            local k =
                GetAnimInitialOffsetPosition(
                "anim@heists@ornate_bank@hack",
                "hack_enter",
                j,
                0.0,
                0.0,
                GetEntityHeading(i),
                0,
                2
            )
            local l = vector3(k["x"], k["y"], k["z"] + 0.2)
            ToggleBag(false)
            cachedData["scene"] =
                NetworkCreateSynchronisedScene(l, 0.0, 0.0, GetEntityHeading(i), 2, false, false, 1065353216, 0, 1.3)
            NetworkAddPedToSynchronisedScene(
                PlayerPedId(),
                cachedData["scene"],
                "anim@heists@ornate_bank@hack",
                "hack_enter",
                1.5,
                -4.0,
                1,
                16,
                1148846080,
                0
            )
            NetworkAddEntityToSynchronisedScene(
                cachedData["bag"],
                cachedData["scene"],
                "anim@heists@ornate_bank@hack",
                "hack_enter_suit_bag",
                4.0,
                -8.0,
                1
            )
            NetworkAddEntityToSynchronisedScene(
                cachedData["laptop"],
                cachedData["scene"],
                "anim@heists@ornate_bank@hack",
                "hack_enter_laptop",
                4.0,
                -8.0,
                1
            )
            NetworkStartSynchronisedScene(cachedData["scene"])
            Citizen.Wait(6000)
            cachedData["scene"] =
                NetworkCreateSynchronisedScene(l, 0.0, 0.0, GetEntityHeading(i), 2, false, false, 1065353216, 0, 1.3)
            NetworkAddPedToSynchronisedScene(
                PlayerPedId(),
                cachedData["scene"],
                "anim@heists@ornate_bank@hack",
                "hack_loop",
                1.5,
                -4.0,
                1,
                16,
                1148846080,
                0
            )
            NetworkAddEntityToSynchronisedScene(
                cachedData["bag"],
                cachedData["scene"],
                "anim@heists@ornate_bank@hack",
                "hack_loop_suit_bag",
                4.0,
                -8.0,
                1
            )
            NetworkAddEntityToSynchronisedScene(
                cachedData["laptop"],
                cachedData["scene"],
                "anim@heists@ornate_bank@hack",
                "hack_loop_laptop",
                4.0,
                -8.0,
                1
            )
            NetworkStartSynchronisedScene(cachedData["scene"])
            Citizen.Wait(2500)
            StartComputer()
            Citizen.Wait(4200)
            cachedData["scene"] =
                NetworkCreateSynchronisedScene(l, 0.0, 0.0, GetEntityHeading(i), 2, false, false, 1065353216, 0, 1.3)
            NetworkAddPedToSynchronisedScene(
                PlayerPedId(),
                cachedData["scene"],
                "anim@heists@ornate_bank@hack",
                "hack_exit",
                1.5,
                -4.0,
                1,
                16,
                1148846080,
                0
            )
            NetworkAddEntityToSynchronisedScene(
                cachedData["bag"],
                cachedData["scene"],
                "anim@heists@ornate_bank@hack",
                "hack_exit_suit_bag",
                4.0,
                -8.0,
                1
            )
            NetworkAddEntityToSynchronisedScene(
                cachedData["laptop"],
                cachedData["scene"],
                "anim@heists@ornate_bank@hack",
                "hack_exit_laptop",
                4.0,
                -8.0,
                1
            )
            NetworkStartSynchronisedScene(cachedData["scene"])
            Citizen.Wait(4500)
            ToggleBag(true)
            DeleteObject(cachedData["bag"])
            DeleteObject(cachedData["laptop"])
            cachedData["hacking"] = false
        end
    )
end
HackingCompleted = function(m)
    if m then
        local n = SpawnTrolleys(cachedData["bank"])
        GlobalFunction("start_robbery", {["bank"] = cachedData["bank"], ["trolleys"] = n, ["save"] = true})
    else
    end
end
OpenDoor = function(d)
    RequestScriptAudioBank("vault_door", false)
    while not HasAnimDictLoaded("anim@heists@fleeca_bank@bank_vault_door") do
        Citizen.Wait(0)
        RequestAnimDict("anim@heists@fleeca_bank@bank_vault_door")
    end
    local o = Config.Bank[d]["door"]
    local p = GetClosestObjectOfType(o["pos"], 5.0, o["model"], false)
    if not DoesEntityExist(p) then
        return
    end
    PlaySoundFromCoord(-1, "vault_unlock", o["pos"], "dlc_heist_fleeca_bank_door_sounds", 0, 0, 0)
    PlayEntityAnim(p, "bank_vault_door_opens", "anim@heists@fleeca_bank@bank_vault_door", 4.0, false, 1, 0, 0.0, 8)
    ForceEntityAiAndAnimationUpdate(p)
    Citizen.Wait(5000)
    DeleteEntity(p)
    if IsEntityPlayingAnim(p, "anim@heists@fleeca_bank@bank_vault_door", "bank_vault_door_opens", 3) then
        if GetEntityAnimCurrentTime(p, "anim@heists@fleeca_bank@bank_vault_door", "bank_vault_door_opens") >= 1.0 then
            FreezeEntityPosition(p, true)
            StopEntityAnim(p, "bank_vault_door_opens", "anim@heists@fleeca_bank@bank_vault_door", -1000.0)
            charkhesh = GetEntityRotation(p)["z"] - 85
            SetEntityRotation(p, 0, 0, charkhesh, 2, 1)
            ForceEntityAiAndAnimationUpdate(p)
            RemoveAnimDict("anim@heists@fleeca_bank@bank_vault_door")
        end
    end
end
SpawnTrolleys = function(d)
    local q = Config.Bank[d]["trolleys"]
    local r = Config.Trolley
    local s = {}
    for t, u in pairs(q) do
        if not HasModelLoaded(r["model"]) then
            LoadModels({r["model"]})
        end
        local v = CreateObject(r["model"], u["pos"], true)
        SetEntityRotation(v, 0.0, 0.0, u["heading"])
        PlaceObjectOnGroundProperly(v)
        SetEntityAsMissionEntity(v, true, true)
        s[t] = {["net"] = ObjToNet(v), ["money"] = Config.Trolley["cash"]}
        SetModelAsNoLongerNeeded(r["model"])
    end
    return s
end
GrabCash = function(s)
    local w = PlayerPedId()
    local x = function()
        local y = GetEntityCoords(w)
        local z = GetHashKey("hei_prop_heist_cash_pile")
        LoadModels({z})
        local A = CreateObject(z, y, true)
        FreezeEntityPosition(A, true)
        SetEntityInvincible(A, true)
        SetEntityNoCollisionEntity(A, w)
        SetEntityVisible(A, false, false)
        AttachEntityToEntity(
            A,
            w,
            GetPedBoneIndex(w, 60309),
            0.0,
            0.0,
            0.0,
            0.0,
            0.0,
            0.0,
            false,
            false,
            false,
            false,
            0,
            true
        )
        local B = GetGameTimer()
        Citizen.CreateThread(
            function()
                while GetGameTimer() - B < 37000 do
                    Citizen.Wait(0)
                    DisableControlAction(0, 73, true)
                    if HasAnimEventFired(w, GetHashKey("CASH_APPEAR")) then
                        if not IsEntityVisible(A) then
                            SetEntityVisible(A, true, false)
                        end
                    end
                    if HasAnimEventFired(w, GetHashKey("RELEASE_CASH_DESTROY")) then
                        if IsEntityVisible(A) then
                            SetEntityVisible(A, false, false)
                            TriggerServerEvent("if_esx_fleeca:receiveCash")
                        end
                    end
                end
                DeleteObject(A)
            end
        )
    end
    local v = NetToObj(s["net"])
    local C = Config.EmptyTrolley
    if IsEntityPlayingAnim(v, "anim@heists@ornate_bank@grab_cash", "cart_cash_dissapear", 3) then
        return ESX.ShowNotification("Somebody is already grabbing.")
    end
    LoadModels({GetHashKey("hei_p_m_bag_var22_arm_s"), "anim@heists@ornate_bank@grab_cash", C["model"]})
    while not NetworkHasControlOfEntity(v) do
        Citizen.Wait(0)
        NetworkRequestControlOfEntity(v)
    end
    cachedData["bag"] =
        CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), GetEntityCoords(PlayerPedId()), true, false, false)
    ToggleBag(false)
    cachedData["scene"] =
        NetworkCreateSynchronisedScene(GetEntityCoords(v), GetEntityRotation(v), 2, false, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(
        w,
        cachedData["scene"],
        "anim@heists@ornate_bank@grab_cash",
        "intro",
        1.5,
        -4.0,
        1,
        16,
        1148846080,
        0
    )
    NetworkAddEntityToSynchronisedScene(
        cachedData["bag"],
        cachedData["scene"],
        "anim@heists@ornate_bank@grab_cash",
        "bag_intro",
        4.0,
        -8.0,
        1
    )
    NetworkStartSynchronisedScene(cachedData["scene"])
    Citizen.Wait(1500)
    x()
    cachedData["scene"] =
        NetworkCreateSynchronisedScene(GetEntityCoords(v), GetEntityRotation(v), 2, false, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(
        w,
        cachedData["scene"],
        "anim@heists@ornate_bank@grab_cash",
        "grab",
        1.5,
        -4.0,
        1,
        16,
        1148846080,
        0
    )
    NetworkAddEntityToSynchronisedScene(
        cachedData["bag"],
        cachedData["scene"],
        "anim@heists@ornate_bank@grab_cash",
        "bag_grab",
        4.0,
        -8.0,
        1
    )
    NetworkAddEntityToSynchronisedScene(
        v,
        cachedData["scene"],
        "anim@heists@ornate_bank@grab_cash",
        "cart_cash_dissapear",
        4.0,
        -8.0,
        1
    )
    NetworkStartSynchronisedScene(cachedData["scene"])
    Citizen.Wait(37000)
    cachedData["scene"] =
        NetworkCreateSynchronisedScene(GetEntityCoords(v), GetEntityRotation(v), 2, false, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(
        w,
        cachedData["scene"],
        "anim@heists@ornate_bank@grab_cash",
        "exit",
        1.5,
        -4.0,
        1,
        16,
        1148846080,
        0
    )
    NetworkAddEntityToSynchronisedScene(
        cachedData["bag"],
        cachedData["scene"],
        "anim@heists@ornate_bank@grab_cash",
        "bag_exit",
        4.0,
        -8.0,
        1
    )
    NetworkStartSynchronisedScene(cachedData["scene"])
    local D = CreateObject(C["model"], GetEntityCoords(v) + vector3(0.0, 0.0, -0.985), true)
    SetEntityRotation(D, GetEntityRotation(v))
    while not NetworkHasControlOfEntity(v) do
        Citizen.Wait(0)
        NetworkRequestControlOfEntity(v)
    end
    DeleteObject(v)
    PlaceObjectOnGroundProperly(D)
    Citizen.Wait(1900)
    DeleteObject(cachedData["bag"])
    ToggleBag(true)
    RemoveAnimDict("anim@heists@ornate_bank@grab_cash")
    SetModelAsNoLongerNeeded(C["model"])
    SetModelAsNoLongerNeeded(GetHashKey("hei_p_m_bag_var22_arm_s"))
end
RobberyThread = function(E)
    Citizen.CreateThread(
        function()
            cachedData["banks"][E["bank"]] = E["trolleys"]
            OpenDoor(E["bank"])
            local o = Config.Bank[E["bank"]]["door"]
            local p = GetClosestObjectOfType(o["pos"], 5.0, o["model"], false)
            while cachedData["banks"][E["bank"]] do
                local F = 500
                local w = PlayerPedId()
                local y = GetEntityCoords(w)
                local G = GetDistanceBetweenCoords(y, Config.Bank[E["bank"]]["start"]["pos"], true)
                if G <= 20.0 then
                    F = 5
                    if not DoesEntityExist(p) then
                        p = GetClosestObjectOfType(o["pos"], 5.0, o["model"], false)
                    end
                    for t, s in pairs(E["trolleys"]) do
                        if NetworkDoesEntityExistWithNetworkId(s["net"]) then
                            local G = #(y - GetEntityCoords(NetToObj(s["net"])))
                            if G <= 1.5 then
                                if Config.BlackMoney then
                                    ESX.ShowHelpNotification("Presiona ~INPUT_DETONATE~ para coger el ~r~dinero")
                                else
                                    ESX.ShowHelpNotification("Presiona ~INPUT_DETONATE~ para coger el ~g~dinero")
                                end
                                if IsControlJustPressed(0, 47) then
                                    GrabCash(s)
                                end
                            end
                        end
                    end
                end
                Citizen.Wait(F)
            end
        end
    )
end
HasItem = function()
    local H = ESX.GetPlayerData()["inventory"]
    for I, J in ipairs(H) do
        if J["name"] == Config.ItemNeeded then
            if J["count"] > 0 then
                return true
            end
        end
    end
    return false
end
ToggleBag = function(K)
    TriggerEvent(
        "skinchanger:getSkin",
        function(L)
            if L.sex == 0 then
                local M = {["bags_1"] = 0, ["bags_2"] = 0}
                if K then
                    M = {["bags_1"] = 45, ["bags_2"] = 0}
                end
                TriggerEvent("skinchanger:loadClothes", L, M)
            else
                local M = {["bags_1"] = 0, ["bags_2"] = 0}
                TriggerEvent("skinchanger:loadClothes", L, M)
            end
        end
    )
end
DrawButtons = function(N)
    Citizen.CreateThread(
        function()
            local O = RequestScaleformMovie("instructional_buttons")
            while not HasScaleformMovieLoaded(O) do
                Wait(0)
            end
            PushScaleformMovieFunction(O, "CLEAR_ALL")
            PushScaleformMovieFunction(O, "TOGGLE_MOUSE_BUTTONS")
            PushScaleformMovieFunctionParameterBool(0)
            PopScaleformMovieFunctionVoid()
            for P, Q in ipairs(N) do
                PushScaleformMovieFunction(O, "SET_DATA_SLOT")
                PushScaleformMovieFunctionParameterInt(P - 1)
                PushScaleformMovieMethodParameterButtonName(Q["button"])
                PushScaleformMovieFunctionParameterString(Q["label"])
                PopScaleformMovieFunctionVoid()
            end
            PushScaleformMovieFunction(O, "DRAW_INSTRUCTIONAL_BUTTONS")
            PushScaleformMovieFunctionParameterInt(-1)
            PopScaleformMovieFunctionVoid()
            DrawScaleformMovieFullscreen(O, 255, 255, 255, 255)
        end
    )
end
DrawScriptMarker = function(R)
    DrawMarker(
        R["type"] or 1,
        R["pos"] or vector3(0.0, 0.0, 0.0),
        0.0,
        0.0,
        0.0,
        R["type"] == 6 and -90.0 or R["rotate"] and -180.0 or 0.0,
        0.0,
        0.0,
        R["sizeX"] or 1.0,
        R["sizeY"] or 1.0,
        R["sizeZ"] or 1.0,
        R["r"] or 1.0,
        R["g"] or 1.0,
        R["b"] or 1.0,
        100,
        false,
        true,
        2,
        false,
        false,
        false,
        false
    )
end
PlayAnimation = function(w, S, T, U)
    if S then
        Citizen.CreateThread(
            function()
                RequestAnimDict(S)
                while not HasAnimDictLoaded(S) do
                    Citizen.Wait(100)
                end
                if U == nil then
                    TaskPlayAnim(w, S, T, 1.0, -1.0, 1.0, 0, 0, 0, 0, 0)
                else
                    local V = 1.0
                    local W = -1.0
                    local X = 1.0
                    local Y = 0
                    local Z = 0
                    if U["speed"] then
                        V = U["speed"]
                    end
                    if U["speedMultiplier"] then
                        W = U["speedMultiplier"]
                    end
                    if U["duration"] then
                        X = U["duration"]
                    end
                    if U["flag"] then
                        Y = U["flag"]
                    end
                    if U["playbackRate"] then
                        Z = U["playbackRate"]
                    end
                    TaskPlayAnim(w, S, T, V, W, X, Y, Z, 0, 0, 0)
                end
                RemoveAnimDict(S)
            end
        )
    else
        TaskStartScenarioInPlace(w, T, 0, true)
    end
end
LoadModels = function(_)
    for I, a0 in ipairs(_) do
        if IsModelValid(a0) then
            while not HasModelLoaded(a0) do
                RequestModel(a0)
                Citizen.Wait(10)
            end
        else
            while not HasAnimDictLoaded(a0) do
                RequestAnimDict(a0)
                Citizen.Wait(10)
            end
        end
    end
end
terkidan = function(a1)
    Citizen.CreateThread(
        function()
            local a2 = NetworkGetEntityFromNetworkId(a1)
            RequestNamedPtfxAsset("scr_ornate_heist")
            while not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
                Citizen.Wait(100)
            end
            UseParticleFxAssetNextCall("scr_ornate_heist")
            StartParticleFxLoopedOnEntity(
                "scr_heist_ornate_thermal_burn",
                a2,
                0,
                1.0,
                0,
                0,
                0,
                0,
                1.0,
                false,
                false,
                false
            )
            StartParticleFxLoopedOnEntity(
                "scr_heist_ornate_thermal_sparks",
                a2,
                0,
                1.0,
                0,
                0,
                0,
                0,
                1.0,
                false,
                false,
                false
            )
            StartParticleFxLoopedOnEntity(
                "scr_heist_ornate_thermal_glow",
                a2,
                0,
                1.0,
                0,
                0,
                0,
                0,
                1.0,
                false,
                false,
                false
            )
            StartParticleFxLoopedOnEntity("sp_fbi_fire_trail_smoke", a2, 0, 1.0, 0, 0, 0, 0, 1.0, false, false, false)
            Citizen.Wait(7000)
            DeleteEntity(a2)
            TriggerServerEvent("if_esx_fleeca:bazsho", 261.58, 222.05, 106.28, 746855201)
        end
    )
end
