ESX = nil
TriggerEvent('esx:getSharedObject', function(obj)ESX = obj end)

local instances = {}
local houses = {}

RegisterServerEvent('esx_yisus_casas:enterHouse')
AddEventHandler('esx_yisus_casas:enterHouse', function(id)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.Async.fetchAll("SELECT house, bought_furniture FROM users WHERE identifier = @identifier", {['@identifier'] = xPlayer.identifier}, function(result)
        local house = json.decode(result[1].house)
        local furniture = '{}'
        if result[1]['bought_furniture'] then
            furniture = result[1]['bought_furniture']
        end
        if house.houseId == id then
            for k, v in pairs(Config.HouseSpawns) do
                if not v['taken'] then
                    TriggerClientEvent('esx_yisus_casas:spawnHouse', xPlayer.source, v['coords'], json.decode(furniture))
                    instances[src] = {['id'] = id, ['owner'] = src, ['coords'] = v['coords'], ['housespawn'] = k, ['players'] = {}}
                    instances[src]['players'][src] = src
                    houses[id] = src
                    v['taken'] = true
                    return
                end
            end
        else
            print('Ha ocurrido un error en el script, contacta con: Yisus#6342')
        end
    end)
end)

RegisterServerEvent('esx_yisus_casas:buy_furniture')
AddEventHandler('esx_yisus_casas:buy_furniture', function(category, id)
    local xPlayer = ESX.GetPlayerFromId(source)
    local hadMoney = false
    if Config.Furniture[Config.Furniture['Categories'][category][1]][id] then
        if xPlayer.getAccount('bank').money >= Config.Furniture[Config.Furniture['Categories'][category][1]][id][3] then
            xPlayer.removeAccountMoney('bank', Config.Furniture[Config.Furniture['Categories'][category][1]][id][3])
            hadMoney = true
        else
            if xPlayer.getMoney() >= Config.Furniture[Config.Furniture['Categories'][category][1]][id][3] then
                xPlayer.removeMoney(Config.Furniture[Config.Furniture['Categories'][category][1]][id][3])
                hadMoney = true
            else
                TriggerClientEvent('esx:showNotifciation', xPlayer.source, Strings['no_money'])
            end
        end
    else
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Ha ocurrido un problema en la tienda, no se ha podido comprar el/los mueble(s).')
    end
    
    if hadMoney then
        MySQL.Async.fetchAll("SELECT house, bought_furniture FROM users WHERE identifier = @identifier", {['@identifier'] = xPlayer.identifier}, function(result)
            local furniture = {}
            if result[1]['bought_furniture'] then
                furniture = json.decode(result[1]['bought_furniture'])
            end
            if furniture[Config.Furniture[Config.Furniture['Categories'][category][1]][id][2]] then
                furniture[Config.Furniture[Config.Furniture['Categories'][category][1]][id][2]]['amount'] = furniture[Config.Furniture[Config.Furniture['Categories'][category][1]][id][2]]['amount'] + 1
            else
                furniture[Config.Furniture[Config.Furniture['Categories'][category][1]][id][2]] = {['amount'] = 1, ['name'] = Config.Furniture[Config.Furniture['Categories'][category][1]][id][1]}
            end
            MySQL.Async.execute("UPDATE users SET bought_furniture=@bought_furniture WHERE identifier=@identifier", {['@identifier'] = xPlayer.identifier, ['@bought_furniture'] = json.encode(furniture)})
            TriggerClientEvent('esx:showNotification', xPlayer.source, (Strings['Bought_Furniture']):format(Config.Furniture[Config.Furniture['Categories'][category][1]][id][1], Config.Furniture[Config.Furniture['Categories'][category][1]][id][3]))
        end)
    end
end)

RegisterServerEvent('esx_yisus_casas:leaveHouse')
AddEventHandler('esx_yisus_casas:leaveHouse', function(house)
    local src = source
    if instances[houses[house]]['players'][src] then
        local oldPlayers = instances[houses[house]]['players']
        local newPlayers = {}
        for k, v in pairs(oldPlayers) do
            if v ~= src then
                newPlayers[k] = v
            end
        end
        instances[houses[house]]['players'] = newPlayers
    end
end)

RegisterServerEvent('esx_yisus_casas:deleteInstance')
AddEventHandler('esx_yisus_casas:deleteInstance', function()
    local src = source
    if instances[src] then
        Config.HouseSpawns[instances[src]['housespawn']]['taken'] = false
        for k, v in pairs(instances[src]['players']) do
            TriggerClientEvent('esx_yisus_casas:leaveHouse', v, instances[src]['id'])
        end
        instances[src] = {}
    end
end)

RegisterServerEvent('esx_yisus_casas:letIn')
AddEventHandler('esx_yisus_casas:letIn', function(plr, storage)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if instances[src] then
        if not instances[src]['players'][plr] then
            instances[src]['players'][plr] = plr
            
            local spawnpos = instances[src]['housecoords']
            local furniture = instances[src]['furniture']
            TriggerClientEvent('esx_yisus_casas:knockAccept', plr, instances[src]['coords'], instances[src]['id'], storage, spawnpos, furniture, src)
        end
    end
end)

RegisterServerEvent('esx_yisus_casas:unKnockDoor')
AddEventHandler('esx_yisus_casas:unKnockDoor', function(id)
    local src = source
    if instances[houses[id]] then
        TriggerClientEvent('esx_yisus_casas:removeDoorKnock', instances[houses[id]]['owner'], src)
    end
end)

RegisterServerEvent('esx_yisus_casas:knockDoor')
AddEventHandler('esx_yisus_casas:knockDoor', function(id)
    local src = source
    if instances[houses[id]] then
        TriggerClientEvent('esx_yisus_casas:knockedDoor', instances[houses[id]]['owner'], src)
    else
        TriggerClientEvent('esx:showNotification', src, Strings['Noone_Home'])
    end
end)

RegisterServerEvent('esx_yisus_casas:policeRaid')
AddEventHandler('esx_yisus_casas:policeRaid', function(id)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    
    if Config.PoliceRaid['Enabled'] then
        if Config.PoliceRaid['Jobs'][xPlayer.job.name] then
            if instances[houses[id]] then
                
                
                
                else
                
                for k, v in pairs(Config.HouseSpawns) do
                    if not v['taken'] then
                        instances[src] = {['id'] = id, ['owner'] = src, ['coords'] = v['coords'], ['housespawn'] = k, ['players'] = {}}
                        instances[src]['players'][src] = src
                        houses[id] = src
                        v['taken'] = true
                        return
                    end
                end
            
            
            end
        end
    end

end)


RegisterServerEvent('esx_yisus_casas:setInstanceCoords')
AddEventHandler('esx_yisus_casas:setInstanceCoords', function(coords, housecoords, prop, placedfurniture)
    local src = source
    if instances[src] then
        instances[src]['coords'] = coords
        instances[src]['housecoords'] = housecoords
        instances[src]['furniture'] = placedfurniture
    end
end)

RegisterServerEvent('esx_yisus_casas:exitHouse')
AddEventHandler('esx_yisus_casas:exitHouse', function(id)
    local src = source
    if instances[src] then
        for k, v in pairs(instances['players']) do
            TriggerClientEvent('esx_yisus_casas:exitHouse', v, id)
            table.remove(instances, src)
            table.remove(houses, id)
        end
    else
        for k, v in pairs(instances) do
            if v['players'][src] then
                table.remove(v['players'], src)
            end
        end
    end
end)

RegisterServerEvent('esx_yisus_casas:buyHouse')
AddEventHandler('esx_yisus_casas:buyHouse', function(id)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.Async.fetchAll("SELECT house, bought_furniture FROM users WHERE identifier = @identifier", {['@identifier'] = xPlayer.identifier}, function(result)
        local house = json.decode(result[1].house)
        if house.houseId == 0 then
            MySQL.Async.fetchAll("SELECT * FROM bought_houses WHERE houseid=@houseid", {['@houseid'] = id}, function(result)
                local newHouse = ('{"owns":false,"furniture":[],"houseId":%s}'):format(id)
                if not result[1] then
                    if xPlayer.getAccount('bank').money >= Config.Houses[id]['price'] then
                        xPlayer.removeAccountMoney('bank', Config.Houses[id]['price'])
                        MySQL.Async.execute("UPDATE users SET house=@house WHERE identifier=@identifier", {['@identifier'] = xPlayer.identifier, ['@house'] = newHouse})
                        MySQL.Sync.execute("INSERT INTO bought_houses (houseid) VALUES (@houseid)", {['houseid'] = id})
                    else
                        if xPlayer.getMoney() >= Config.Houses[id]['price'] then
                            xPlayer.removeMoney(Config.Houses[id]['price'])
                            MySQL.Async.execute("UPDATE users SET house=@house WHERE identifier=@identifier", {['@identifier'] = xPlayer.identifier, ['@house'] = newHouse})
                            MySQL.Sync.execute("INSERT INTO bought_houses (houseid) VALUES (@houseid)", {['houseid'] = id})
                        else
                            TriggerClientEvent('esx:showNotification', xPlayer.source, Strings['No_Money'])
                        end
                    end
                end
            end)
        end
    end)
    Wait(1500)
    TriggerClientEvent('esx_yisus_casas:reloadHouses', -1)
end)

RegisterServerEvent('esx_yisus_casas:visit')
AddEventHandler('esx_yisus_casas:visit', function(id)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    
    for k, v in pairs(Config.HouseSpawns) do
        if not v['taken'] then
            TriggerClientEvent('esx_yisus_casas:visitHouse', xPlayer.source, v['coords'], Config.Houses[id]['prop'], Config.Houses[id]['door'], k)
            v['taken'] = true
            return
        end
    end

end)

RegisterServerEvent('esx_yisus_casas:leaveVisit')
AddEventHandler('esx_yisus_casas:leaveVisit', function(housespawn)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    
    Config.HouseSpawns[housespawn]['taken'] = false

end)

RegisterServerEvent('esx_yisus_casas:sellHouse')
AddEventHandler('esx_yisus_casas:sellHouse', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.Async.fetchAll("SELECT house, bought_furniture FROM users WHERE identifier = @identifier", {['@identifier'] = xPlayer.identifier}, function(result)
        local house = json.decode(result[1].house)
        if Config.Houses[house.houseId]['price'] then
            xPlayer.addMoney(Config.Houses[house.houseId]['price'] * (Config.SellPercentage / 100))
            TriggerClientEvent('esx:showNotification', xPlayer.source, (Strings['Sold_House']):format(math.floor(Config.Houses[house.houseId]['price'] * (Config.SellPercentage / 100))))
            MySQL.Async.execute("UPDATE users SET house=@house WHERE identifier=@identifier", {['@identifier'] = xPlayer.identifier, ['@house'] = '{"owns":false,"furniture":[],"houseId":0}'})
            MySQL.Async.execute("DELETE FROM bought_houses WHERE houseid=@houseid", {['@houseid'] = house.houseId})
            
            Wait(1500)
            TriggerClientEvent('esx_yisus_casas:reloadHouses', -1)
        end
    end)
end)

RegisterServerEvent('esx_yisus_casas:getOwned')
AddEventHandler('esx_yisus_casas:getOwned', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.Async.fetchAll("SELECT house, bought_furniture FROM users WHERE identifier = @identifier", {['@identifier'] = xPlayer.identifier}, function(result)
        if result[1]['house'] then
            local house = json.decode(result[1].house)
            MySQL.Async.fetchAll("SELECT * FROM bought_houses", {}, function(result)
                TriggerClientEvent('esx_yisus_casas:setHouse', xPlayer.source, house, result)
            end)
        else
            MySQL.Async.execute("UPDATE users SET house=@house WHERE identifier=@identifier", {['@identifier'] = xPlayer.identifier, ['@house'] = '{"owns":false,"furniture":[],"houseId":0}'})
            MySQL.Async.fetchAll("SELECT * FROM bought_houses", {}, function(result)
                TriggerClientEvent('esx_yisus_casas:setHouse', xPlayer.source, json.decode('{"owns":false,"furniture":[],"houseId":0}'), result)
            end)
        end
    end)
end)

RegisterServerEvent('esx_yisus_casas:furnish')
AddEventHandler('esx_yisus_casas:furnish', function(house, furniture)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.Async.execute("UPDATE users SET house=@house WHERE identifier=@identifier", {['@identifier'] = xPlayer.identifier, ['@house'] = json.encode(house)})
    MySQL.Async.execute("UPDATE users SET bought_furniture=@bought_furniture WHERE identifier=@identifier", {['@identifier'] = xPlayer.identifier, ['@bought_furniture'] = json.encode(furniture)})
end)

ESX.RegisterServerCallback('esx_yisus_casas:hasGuests', function(source, cb)
    local hasGuest = false
    for k, v in pairs(instances[source]['players']) do
        local playerlist = GetPlayers()
        for id, src in pairs(playerlist) do
            if v ~= source and v == tonumber(src) then
                hasGuest = true
                break
            end
        end
    end
    cb(hasGuest)
end)

ESX.RegisterServerCallback('esx_yisus_casas:hostOnline', function(source, cb, host)
    local online = false
    if instances[host] then
        local playerlist = GetPlayers()
        for id, src in pairs(playerlist) do
            if host == tonumber(src) then
                online = true
                break
            end
        end
        if not online then
            Config.HouseSpawns[instances[host]['housespawn']]['taken'] = false
            instances[host] = {}
        end
    else
        cb(false)
    end
    cb(online)
end)

ESX.RegisterServerCallback('esx_yisus_casas:getInventory', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    cb({
        ['items'] = xPlayer.inventory, 
        ['black_money'] = xPlayer.getAccount('black_money').money, 
        ['weapons'] = xPlayer.getLoadout()
    })
end)

ESX.RegisterServerCallback('esx_yisus_casas:getHouseInv', function(source, cb, owner)
    local xPlayer = ESX.GetPlayerFromId(source)
    local items, weapons = {}, {}
    
    if houses[owner] then
        if instances[houses[owner]] then
            local identifier = ESX.GetPlayerFromId(houses[owner])['identifier']
            
            TriggerEvent('esx_addoninventory:getInventory', 'housing', identifier, function(inventory)
                items = inventory.items
            end)

            TriggerEvent('esx_addonaccount:getAccount', 'housing_black_money', identifier, function(account)
                blackMoney = account.money
            end)
            
            TriggerEvent('esx_datastore:getDataStore', 'housing', identifier, function(storage)
                weapons = storage.get('weapons') or {}
            end)
            
            cb({
                ['items'] = items, 
                ['black_money'] = blackMoney,
                ['weapons'] = weapons
            })
        end
    end
end)

RegisterServerEvent('esx_yisus_casas:withdrawItem')
AddEventHandler('esx_yisus_casas:withdrawItem', function(type, item, amount, owner)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    
    if houses[owner] then
        if instances[houses[owner]] then
            local identifier = ESX.GetPlayerFromId(houses[owner])['identifier']
            if type == 'item' then
                
                TriggerEvent('esx_addoninventory:getInventory', 'housing', identifier, function(inventory)
                    if inventory.getItem(item)['count'] >= amount then
                        TriggerClientEvent('esx:showNotification', src, (Strings['You_Withdrew']):format(amount, inventory.getItem(item)['label']))
                        xPlayer.addInventoryItem(item, amount)
                        inventory.removeItem(item, amount)
                    else
                        TriggerClientEvent('esx:showNotification', src, Strings['Not_Enough_House'])
                    end
                end)

            elseif type == 'item_account' then
                TriggerEvent('esx_addonaccount:getAccount', 'housing_black_money', identifier, function(account)
                    if account.money >= amount then
                        account.removeMoney(amount)
                        xPlayer.addAccountMoney(item, amount)
                    else
                        xPlayer.showNotification(Strings['Invalid_Amount'])
                    end
                end)
            
            elseif type == 'weapon' then
                
                TriggerEvent('esx_datastore:getDataStore', 'housing', identifier, function(weapons)
                    local loadout = weapons.get('weapons') or {}
                    
                    for i = 1, #loadout do
                        if loadout[i]['name'] == item then
                            
                            table.remove(loadout, i)
                            weapons.set('weapons', loadout)
                            xPlayer.addWeapon(item, amount)
                            
                            break
                        end
                    end
                end)
            end
        end
    
    end

end)

RegisterServerEvent('esx_yisus_casas:storeItem')
AddEventHandler('esx_yisus_casas:storeItem', function(type, item, amount, owner)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    
    if houses[owner] then
        if instances[houses[owner]] then
            local identifier = ESX.GetPlayerFromId(houses[owner])['identifier']
            if type == 'item' then
                
                if xPlayer.getInventoryItem(item)['count'] >= amount then
                    TriggerEvent('esx_addoninventory:getInventory', 'housing', identifier, function(inventory)
                        xPlayer.removeInventoryItem(item, amount)
                        inventory.addItem(item, amount)
                        TriggerClientEvent('esx:showNotification', src, (Strings['You_Stored']):format(amount, inventory.getItem(item)['label']))
                    end)
                else
                    TriggerClientEvent('esx:showNotification', src, Strings['Not_Enough'])
                end

            elseif type == 'item_account' then
                local playerAccountMoney = xPlayer.getAccount(item).money

                if playerAccountMoney >= amount and amount > 0 then
                    xPlayer.removeAccountMoney(item, amount)

                    TriggerEvent('esx_addonaccount:getAccount', 'housing_black_money', identifier, function(account)
                        account.addMoney(amount)
                    end)
                else
                    TriggerClientEvent('esx:showNotification', _source, Strings['Invalid_Amount'])
                end
            
            elseif type == 'weapon' then
                
                local loadout, hasweapon = xPlayer.getLoadout(), false
                for k, v in pairs(loadout) do
                    if v['name'] == item then
                        hasweapon = true
                        break
                    end
                end
                
                if hasweapon then
                    TriggerEvent('esx_datastore:getDataStore', 'housing', identifier, function(weapons)
                        local storage = weapons.get('weapons') or {}
                        
                        table.insert(storage, {name = item, ammo = amount})
                        
                        weapons.set('weapons', storage)
                        xPlayer.removeWeapon(item)
                    end)
                else
                    TriggerClientEvent('esx:showNotification', src, Strings['No_Weapon'])
                end
            end
        end
    
    end
end)
