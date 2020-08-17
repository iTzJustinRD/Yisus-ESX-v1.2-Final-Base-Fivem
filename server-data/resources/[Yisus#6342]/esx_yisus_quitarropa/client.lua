ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)
RegisterNetEvent('esx_yisus_quitarropa:camiseta')
AddEventHandler('esx_yisus_quitarropa:camiseta', function()
    TriggerEvent('skinchanger:getSkin', function(skin)
        if (skin.sex == 0) then
            local clothesSkin = {
                ['tshirt_1'] = 15,
                ['tshirt_2'] = 0,
                ['torso_1'] = 15,
                ['torso_2'] = 0,
                ['arms'] = 15,
                ['arms_2'] = 0
            }
            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
        else
            local clothesSkin = {
                ['tshirt_1'] = 34,
                ['tshirt_2'] = 0,
                ['torso_1'] = 15,
                ['torso_2'] = 0,
                ['arms'] = 15,
                ['arms_2'] = 0
            }
            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
        end
    end)
end)
RegisterNetEvent('esx_yisus_quitarropa:pantalones')
AddEventHandler('esx_yisus_quitarropa:pantalones', function()
    TriggerEvent('skinchanger:getSkin', function(skin)
        if (skin.sex == 0) then
            local clothesSkin = {['pants_1'] = 21, ['pants_2'] = 0}
            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
        else
            local clothesSkin = {['pants_1'] = 15, ['pants_2'] = 0}
            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
        end
    end)
end)

RegisterNetEvent('esx_yisus_quitarropa:zapatos')
AddEventHandler('esx_yisus_quitarropa:zapatos', function()
    TriggerEvent('skinchanger:getSkin', function(skin)
        if (skin.sex == 0) then
            local clothesSkin = {['shoes_1'] = 34, ['shoes_2'] = 0}
            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
        else
            local clothesSkin = {['shoes_1'] = 35, ['shoes_2'] = 0}
            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
        end
    end)
end)

RegisterNetEvent('esx_yisus_quitarropa:mochila')
AddEventHandler('esx_yisus_quitarropa:mochila', function()
    local PlayerData = ESX.GetPlayerData()
    local currentWeight = 0
    for k,v in ipairs(PlayerData.inventory) do
        if v.count > 0 then
            currentWeight = currentWeight + (v.weight * v.count)
        end
    end
    
    if currentWeight <= ESX.GetConfig().MaxWeight then
        TriggerEvent('skinchanger:getSkin', function(skin)

            local clothesSkin = {['bags_1'] = 0, ['bags_2'] = 0}
            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
            TriggerServerEvent('esx_yisus_quitarropa:actualizarPeso')
            
        end)
    else
        ESX.ShowNotification('¡Tienes la mochila llena!')
    end
end)

RegisterNetEvent('esx_yisus_quitarropa:menuropa')
AddEventHandler('esx_yisus_quitarropa:menuropa',
                function() OpenActionMenuInteraction() end)

function OpenActionMenuInteraction(target)

    local elements = {}

    table.insert(elements, {label = ('Vestirse | Poner todo'), value = 'vestirse'})
    table.insert(elements, {label = ('Quitar camiseta'), value = 'camiseta'})
    table.insert(elements, {label = ('Quitar pantalones'), value = 'pantalones'})
    table.insert(elements, {label = ('Quitar zapatos'), value = 'zapatos'})
    table.insert(elements, {label = ('Quitar Mochila'), value = 'mochila'})
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'action_menu', {
        title = ('Ropa'),
        align = 'bottom-right',
        elements = elements
    }, function(data, menu)

        if data.current.value == 'vestirse' then
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                TriggerEvent('skinchanger:loadSkin', skin)
            end)
            ESX.UI.Menu.CloseAll()
        elseif data.current.value == 'camiseta' then
            TriggerEvent('esx_yisus_quitarropa:camiseta')
            ESX.UI.Menu.CloseAll()
        elseif data.current.value == 'pantalones' then
            TriggerEvent('esx_yisus_quitarropa:pantalones')
            ESX.UI.Menu.CloseAll()
        elseif data.current.value == 'zapatos' then
            TriggerEvent('esx_yisus_quitarropa:zapatos')
            ESX.UI.Menu.CloseAll()
        elseif data.current.value == 'mochila' then
            TriggerEvent('esx_yisus_quitarropa:mochila')
            ESX.UI.Menu.CloseAll()
		end
		
	end, function(data, menu)
		menu.close()
	end)
end
