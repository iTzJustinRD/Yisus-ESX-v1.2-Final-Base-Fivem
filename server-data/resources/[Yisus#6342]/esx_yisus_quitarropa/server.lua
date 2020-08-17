ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_yisus_quitarropa:actualizarPeso')
AddEventHandler('esx_yisus_quitarropa:actualizarPeso', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.setMaxWeight(ESX.GetConfig().MaxWeight)
end)