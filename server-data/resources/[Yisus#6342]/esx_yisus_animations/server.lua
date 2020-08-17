ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX['RegisterServerCallback']('esx_yisus_animations:get_favorites', function(source, cb)
    local xPlayer = ESX['GetPlayerFromId'](source)

    MySQL['Async']['fetchScalar']("SELECT animations FROM users WHERE identifier=@identifier", {['@identifier'] = xPlayer['identifier']}, function(result)
        if not result then
            MySQL['Async']['execute']([[
                UPDATE `users` SET animations=@animations WHERE identifier=@identifier
            ]], {
                ['@animations'] = '{}',
                ['@identifier'] = xPlayer['identifier'],
            })
            cb('{}')
        else
            cb(result or '{}')
        end
    end)
end)

RegisterServerEvent('esx_yisus_animations:update_favorites')
AddEventHandler('esx_yisus_animations:update_favorites', function(animations)
    local xPlayer = ESX['GetPlayerFromId'](source)

    MySQL['Async']['execute']([[
        UPDATE `users` SET animations=@animations WHERE identifier=@identifier
    ]], {
        ['@animations'] = animations,
        ['@identifier'] = xPlayer['identifier'],
    })
    
    TriggerClientEvent('esx:showNotification', xPlayer['source'], Strings['Updated_Favorites'])

end)

RegisterServerEvent('esx_yisus_animations:syncAccepted')
AddEventHandler('esx_yisus_animations:syncAccepted', function(requester, id)
    local accepted = source
    
    TriggerClientEvent('esx_yisus_animations:playSynced', accepted, requester, id, 'Accepter')
    TriggerClientEvent('esx_yisus_animations:playSynced', requester, accepted, id, 'Requester')
end)

RegisterServerEvent('esx_yisus_animations:requestSynced')
AddEventHandler('esx_yisus_animations:requestSynced', function(target, id)
    local requester = source
    local xPlayer = ESX['GetPlayerFromId'](requester)
    
    MySQL['Async']['fetchScalar']("SELECT firstname FROM users WHERE identifier=@identifier", {['@identifier'] = xPlayer['identifier']}, function(firstname)
        TriggerClientEvent('esx_yisus_animations:syncRequest', target, requester, id, firstname)
    end)
end)