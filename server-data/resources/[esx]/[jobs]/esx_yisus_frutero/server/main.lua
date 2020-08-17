ESX = nil
local PlayersTransforming = {}
local PlayersSelling = {}
local PlayersHarvesting = {}
local zumo = 10
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('frutero:job1a')
AddEventHandler('frutero:job1a', function(count)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local itemQuantity = xPlayer.getInventoryItem('apple').count

    if itemQuantity >= 40 then
        TriggerClientEvent('frutero:toomuch', source)
    else
        if xPlayer.canCarryItem('apple', 10) then
            xPlayer.addInventoryItem('apple', 10)
            TriggerClientEvent('frutero:anim', source)
        else
            TriggerClientEvent('esx:showNotification', source,
                               'No tienes suficiente espacio')
        end
    end
end)

RegisterServerEvent('frutero:job1b')
AddEventHandler('frutero:job1b', function(count)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local itemQuantity = xPlayer.getInventoryItem('orange').count

    if itemQuantity >= 40 then
        TriggerClientEvent('frutero:toomuch', source)
    else
        if xPlayer.canCarryItem('orange', 10) then
            xPlayer.addInventoryItem('orange', 10)
            TriggerClientEvent('frutero:anim', source)
        else
            TriggerClientEvent('esx:showNotification', source, 'No tienes suficiente espacio')
        end
    end
end)

RegisterServerEvent('frutero:job3apple')
AddEventHandler('frutero:job3apple', function(zone)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local manzanas = xPlayer.getInventoryItem('apple').count

    if manzanas >= 1 then
        xPlayer.removeInventoryItem('apple', manzanas)
        Citizen.Wait(1000)
        xPlayer.addMoney(manzanas * Config.AppleSellEarnings)
    else
        TriggerClientEvent('frutero:insuficiente', source)
    end
end)

RegisterServerEvent('frutero:job3orange')
AddEventHandler('frutero:job3orange', function(zone)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local naranjas = xPlayer.getInventoryItem('orange').count
    if naranjas >= 1 then
        xPlayer.removeInventoryItem('orange', naranjas)
        Citizen.Wait(1000)
        xPlayer.addMoney(naranjas * Config.OrangeSellEarnings)
    else
        TriggerClientEvent('frutero:insuficiente', source)
    end
end)
