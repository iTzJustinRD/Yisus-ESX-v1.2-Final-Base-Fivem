local shopData = nil
local msgCoords = nil
ESX = nil



Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

--local Licenses = {}
local Licenses = {['weapon'] = true}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while not ESX.GetPlayerData().job do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job) ESX.PlayerData.job = job end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(250)
        player = GetPlayerPed(-1)
        coords = GetEntityCoords(player)
        if IsInRegularShopZone(coords) or IsInPrisonShopZone(coords) or IsInWeaponShopZone(coords) then
            if IsInRegularShopZone(coords) then
                if IsControlPressed(0, Keys["E"]) then
                    ESX.TriggerServerCallback('OnlineJobs:getConnectedPlayers', function(connectedPlayers)
                        if TenderosConnected(connectedPlayers) == true then
                            OpenShopInv("regular")
                            TriggerScreenblurFadeIn(0)
                            Citizen.Wait(2000)
                        else
                            ESX.ShowNotification('Hay tenderos, las máquinas expendedoras no funcionan.')
                        end 
                    end)
                end
            end

            if IsInPrisonShopZone(coords) then
                if IsControlPressed(0, Keys["E"]) then
                    OpenShopInv("prison")
                    TriggerScreenblurFadeIn(0)
                    Citizen.Wait(2000)
                end
            end
            
            if IsInWeaponShopZone(coords) then
                if IsControlPressed(0, Keys["E"]) then
                    if Licenses['weapon'] ~= nil then
                        OpenShopInv("weaponshop")
                        TriggerScreenblurFadeIn(0)
                        Citizen.Wait(2000)
                    else
                       ESX.ShowNotification('Necesitas una licencia de armas')
                    end
                end
            end
        else
            if msgCoords ~= nil then
                msgCoords = nil
            end
        end
    end
end)

RegisterNetEvent('esx_mechanicjob:onFixkit')
AddEventHandler('esx_mechanicjob:onFixkit', function()
	ESX.TriggerServerCallback('OnlineJobs:getConnectedPlayers', function(connectedPlayers)
		if MecanicosConnected(connectedPlayers) == true then
			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)
			if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
				local vehicle

				if IsPedInAnyVehicle(playerPed, false) then
					vehicle = GetVehiclePedIsIn(playerPed, false)
				else
					vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
				end

				if DoesEntityExist(vehicle) then
					TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
					Citizen.CreateThread(function()
						Citizen.Wait(20000)
						SetVehicleFixed(vehicle)
						SetVehicleDeformationFixed(vehicle)
						SetVehicleUndriveable(vehicle, false)
						ClearPedTasksImmediately(playerPed)
						ESX.ShowNotification(_U('veh_repaired'))
					end)
				end
			end
		else
			ESX.ShowNotification('No puedes usar esta herramienta cuando hay mec�nicos disponibles.')
			TriggerServerEvent('esx_mechanicjob:devolverKit')
		end 
	end)
end)

function TenderosConnected(connectedPlayers)
	local tendero = 0

	for k,v in pairs(connectedPlayers) do
		if v.job == 'tendero' then
			tendero = tendero + 1
		end
	end

	if tendero <= 0 then
		return true
	else
		return false
	end
end

function OpenShopInv(shoptype)
    text = "Tienda"
    data = {text = text}
    inventory = {}
    ESX.TriggerServerCallback("suku:getShopItems", function(shopInv)
        for i = 1, #shopInv, 1 do
            table.insert(inventory, shopInv[i])
        end
        TriggerEvent("esx_inventoryhud:openShopInventory", data, inventory)
    end, shoptype)  
end

RegisterNetEvent("suku:OpenCustomShopInventory")
AddEventHandler("suku:OpenCustomShopInventory", function(type, shopinventory)
    text = "shop"
    data = {text = text}
    inventory = {}

    ESX.TriggerServerCallback("suku:getCustomShopItems", function(shopInv)
        for i = 1, #shopInv, 1 do
            table.insert(inventory, shopInv[i])
        end
        TriggerEvent("esx_inventoryhud:openShopInventory", data, inventory)
    end, type, shopinventory)    
end)

RegisterNetEvent("esx_inventoryhud:openShopInventory")
AddEventHandler("esx_inventoryhud:openShopInventory", function(data, inventory)
        setShopInventoryData(data, inventory, weapons)
        openShopInventory()
end)

function setShopInventoryData(data, inventory)
    shopData = data

    SendNUIMessage(
        {
            action = "setInfoText",
            text = data.text
        }
    )

    items = {}

    SendNUIMessage(
        {
            action = "setShopInventoryItems",
            itemList = inventory
        }
    )
end

function openShopInventory()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "display",
            type = "shop"
        }
    )

    SetNuiFocus(true, true)
end

RegisterNUICallback("TakeFromShop", function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
            TriggerServerEvent("suku:SellItemToPlayer", GetPlayerServerId(PlayerId()), data.item.type, data.item.name, tonumber(data.number))
        end

        Wait(150)
        loadPlayerInventory()

        cb("ok")
    end
)

RegisterNetEvent("suku:AddAmmoToWeapon")
AddEventHandler("suku:AddAmmoToWeapon", function(hash, amount)
    AddAmmoToPed(GetPlayerPed(-1), hash, amount)
end)

function IsInRegularShopZone(coords)
    RegularShop = Config.Shops.RegularShop.Locations
    for i = 1, #RegularShop, 1 do
        if GetDistanceBetweenCoords(coords, RegularShop[i].x, RegularShop[i].y, RegularShop[i].z, true) < 2 then
            msgCoords = {x = RegularShop[i].x, y = RegularShop[i].y, z = RegularShop[i].z }
            return true
        end
    end
    return false
end

function IsInPrisonShopZone(coords)
    PrisonShop = Config.Shops.PrisonShop.Locations
    for i = 1, #PrisonShop, 1 do
        if GetDistanceBetweenCoords(coords, PrisonShop[i].x, PrisonShop[i].y, PrisonShop[i].z, true) < 2 then
            msgCoords = {x = PrisonShop[i].x, y = PrisonShop[i].y, z = PrisonShop[i].z }
            return true
        end
    end
    return false
end

function IsInWeaponShopZone(coords)
    WeaponShop = Config.Shops.WeaponShop.Locations
    for i = 1, #WeaponShop, 1 do
        if GetDistanceBetweenCoords(coords, WeaponShop[i].x, WeaponShop[i].y, WeaponShop[i].z, true) < 2 then
            msgCoords = {x = WeaponShop[i].x, y = WeaponShop[i].y, z = WeaponShop[i].z }
            return true
        end
    end
    return false
end

--[[Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        player = GetPlayerPed(-1)
        coords = GetEntityCoords(player)

        if GetDistanceBetweenCoords(coords, Config.WeaponLiscence.x, Config.WeaponLiscence.y, Config.WeaponLiscence.z, true) < 3.0 then
            ESX.Game.Utils.DrawText3D(vector3(Config.WeaponLiscence.x, Config.WeaponLiscence.y, Config.WeaponLiscence.z), "Press ~r~[E]~s~ to open shop", 0.6)

            if IsControlJustReleased(0, Keys["E"]) then
                if Licenses['weapon'] == nil then
                    OpenBuyLicenseMenu()
                else
                    ESX.ShowNotification(Ya tienes licencia de armas!')
                end
                Citizen.Wait(2000)
            end
        end
    end
end)]]

RegisterNetEvent('suku:GetLicenses')
AddEventHandler('suku:GetLicenses', function (licenses)
    for i = 1, #licenses, 1 do
        Licenses[licenses[i].type] = true
    end
end)

function OpenBuyLicenseMenu()
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_license',{
        title = 'Register a License?',
        elements = {
          { label = 'Si' ..' ($' .. Config.LicensePrice ..')', value = 'yes' },
          { label = 'No', value = 'no' },
        }
      },
      function (data, menu)
        if data.current.value == 'yes' then
            TriggerServerEvent('suku:buyLicense')
        end
        menu.close()
    end,
    function (data, menu)
        menu.close()
    end)
end

Citizen.CreateThread(function()

    for k, v in pairs(Config.Shops.RegularShop.Locations) do
        CreateBlip(vector3(Config.Shops.RegularShop.Locations[k].x, Config.Shops.RegularShop.Locations[k].y, Config.Shops.RegularShop.Locations[k].z ), "24/7", 3.0, Config.Color, Config.ShopBlipID)
    end

    for k, v in pairs(Config.Shops.PrisonShop.Locations) do
        CreateBlip(vector3(Config.Shops.PrisonShop.Locations[k].x, Config.Shops.PrisonShop.Locations[k].y, Config.Shops.PrisonShop.Locations[k].z), "Máquinas expendedoras", 3.0, Config.Color, Config.PrisonShopBlipID)
    end

    for k, v in pairs(Config.Shops.WeaponShop.Locations) do
        CreateBlip(vector3(Config.Shops.WeaponShop.Locations[k].x, Config.Shops.WeaponShop.Locations[k].y, Config.Shops.WeaponShop.Locations[k].z), "Armería", 3.0, Config.WeaponColor, Config.WeaponShopBlipID)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        
        if msgCoords ~= nil then
            ESX.Game.Utils.DrawText3D(vector3(msgCoords.x, msgCoords.y, msgCoords.z + 1.0), "Manten presionado ~r~[E]~s~ para acceder a la tienda", 0.6)
        end
    end
end)

function CreateBlip(coords, text, radius, color, sprite)
	local blip = AddBlipForCoord(coords)
	SetBlipSprite(blip, sprite)
	SetBlipColour(blip, color)
	SetBlipScale(blip, 0.8)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(text)
	EndTextCommandSetBlipName(blip)
end
