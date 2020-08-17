local dbReady = false
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('onMySQLReady', function ()
	print("Executed esx_police_cad queries table query")
	Wait(100)
	dbReady = true
end)

RegisterServerEvent('esx_police_cad:search-plate')
AddEventHandler('esx_police_cad:search-plate', function(plate)
    _source = source
    MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE plate = @plate", {['@plate'] = plate},
        function (result)
            if (result[1] ~= nil) then
                local vehicle = json.decode(result[1].vehicle)
                MySQL.Async.fetchAll('SELECT identifier,firstname,lastname FROM users WHERE identifier = @identifier', {['@identifier'] = result[1].owner},
                       function (result2)
                           if (result2[1] ~= nil) then
                              TriggerClientEvent('esx_police_cad:showdataplate', _source, result[1].plate,vehicle.model,result2[1].firstname,result2[1].lastname)
                           else
                               TriggerClientEvent('esx_police_cad:showdateplateNotFound', _source)
                           end
                   end)
            else
                TriggerClientEvent('esx_police_cad:showdateplateNotFound', _source)
            end
    end)
end)

RegisterServerEvent('esx_police_cad:search-players')
AddEventHandler('esx_police_cad:search-players', function(search)
        _source = source
        MySQL.Async.fetchAll("SELECT * FROM users WHERE CONCAT(firstname, ' ', lastname) LIKE @search", {['@search'] = '%'..search..'%'},
               function (result)
                   if (result ~= nil) then
                      TriggerClientEvent('esx_police_cad:returnsearch', _source, result)
                   else
                       TriggerClientEvent('esx_police_cad:noresults', _source)
                   end
           end)
end)


RegisterServerEvent('esx_police_cad:add-cr')
AddEventHandler('esx_police_cad:add-cr', function(data, officer)
    MySQL.Async.execute("INSERT INTO criminal_records SET reason = @reason, fine = @fine, time = @time, user_id = @user_id, officer_id = @officer_id", {
        ['@reason'] = data.reason,
        ['@fine'] = data.fine,
        ['@time'] = data.time,
        ['@user_id'] = data.playerid,
        ['@officer_id'] = officer,
    },
        function (result)
            if (result ~= nil) then
               --TriggerClientEvent('esx_police_cad:returnsearch', -1, result) 
            end
    end)
    
    local amultar = ESX.GetPlayerFromIdentifier(data.playerid)
            MySQL.Async.execute('INSERT INTO billing (identifier, sender, target_type, target, label, amount) VALUES (@identifier, @sender, @target_type, @target, @label, @amount)', {
                ['@identifier'] = data.playerid,
                ['@sender'] = officer,
                ['@target_type'] = 'society',
                ['@target'] = 'society_police',
                ['@label'] = data.reason,
                ['@amount'] = data.fine,
            }, function(rowsChanged)
                amultar.showNotification('Has sido multado por ~r~'..data.reason)
            end)
end)

RegisterServerEvent('esx_police_cad:add-note')
AddEventHandler('esx_police_cad:add-note', function(data)
    MySQL.Async.execute("INSERT INTO epc_notes SET title = @title, content = @content, user_id = @user_id", {
        ['@title'] = data.title,
        ['@content'] = data.content,
        ['@user_id'] = data.playerid,
    },
        function (result)
            if (result ~= nil) then

            end
    end)
end)

RegisterServerEvent('esx_police_cad:delete_note')
AddEventHandler('esx_police_cad:delete_note', function(note)
    noteId = note.id
    _source = source
    MySQL.Async.execute("DELETE FROM epc_notes WHERE id = @id", {
        ['@id'] = note.id,
    },
        function (result)
            MySQL.Async.fetchAll("SELECT id FROM epc_notes WHERE id = @id", {
                ['@id'] = noteId,
            },
            function (result2)
                if result2[1] == nil then
                    TriggerClientEvent('esx_police_cad:note_deleted', _source)
                else
                    TriggerClientEvent('esx_police_cad:note_not_deleted', _source)
                end
            end)
    end)
end)

RegisterServerEvent('esx_police_cad:delete_cr')
AddEventHandler('esx_police_cad:delete_cr', function(cr)
    crid = cr
    _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local job = xPlayer.getJob()
    if job.name == "police" and job.grade == 5 then
        MySQL.Async.execute("DELETE FROM criminal_records WHERE id = @id", {
            ['@id'] = crid.id,
        },
            function (result)
                MySQL.Async.fetchAll("SELECT id FROM criminal_records WHERE id = @id", {
                    ['@id'] = crid.id,
                },
                function (result2)
                    if result2[1] == nil then
                        TriggerClientEvent('esx_police_cad:cr_deleted', _source)
                    else
                        TriggerClientEvent('esx_police_cad:cr_not_deleted', _source)
                    end
                end)
        end)
    else
        xPlayer.showNotification("~r~Permisos insuficientes.")
    end
end)

RegisterServerEvent('esx_police_cad:get-note')
AddEventHandler('esx_police_cad:get-note', function(playerid)
    _source = source
    MySQL.Async.fetchAll("SELECT * FROM epc_notes WHERE user_id = @user_id", {['@user_id'] = playerid},
        function (result)
                TriggerClientEvent('esx_police_cad:show-notes', _source, result)
    end)
end)

RegisterServerEvent('esx_police_cad:get-cr')
AddEventHandler('esx_police_cad:get-cr', function(playerid)
    _source = source
    MySQL.Async.fetchAll("SELECT * FROM criminal_records WHERE user_id = @user_id", {['@user_id'] = playerid},
        function (result)
            if (result[1] ~= nil) then
                for key,value in pairs(result) do
                    result[key] = value
                    MySQL.Async.fetchAll("SELECT * FROM criminal_records WHERE user_id = @user_id", {['@user_id'] = playerid},
                            function (result)
--                                result['officer'] = result[1].firstname .. ' ' .. result[1].lastname
                        end)
                end
                TriggerClientEvent('esx_police_cad:show-cr', _source, result)
        end
    end)
end)

RegisterServerEvent('esx_police_cad:get-license')
AddEventHandler('esx_police_cad:get-license', function(playerid)
    _source = source
    MySQL.Async.fetchAll("SELECT * FROM user_licenses WHERE owner = @user_id", {['@user_id'] = playerid},
        function (result)
            if (result[1] ~= nil) then
                TriggerClientEvent('esx_police_cad:show-license', _source, result)
        end
    end)
end)

RegisterServerEvent('esx_police_cad:get-bolos')
AddEventHandler('esx_police_cad:get-bolos', function()
    _source = source
    MySQL.Async.fetchAll("SELECT * FROM epc_bolos order by id", {
    },
        function (result)
            if (result[1] ~= nil) then
                TriggerClientEvent('esx_police_cad:show-bolos', _source, result)
        end
    end)
end)

RegisterServerEvent('esx_police_cad:add-bolo')
AddEventHandler('esx_police_cad:add-bolo', function(data)
    _source = source
    MySQL.Async.execute("INSERT into epc_bolos SET name = @name, lastname = @lastname, apperance = @apperance, type_of_crime = @type_of_crime, fine = @fine ", {
        ['@name'] = data.name,
        ['@lastname'] = data.lastname,
        ['@apperance'] = data.apperance,
        ['@type_of_crime'] = data.type_of_crime,
        ['@fine'] = data.fine,
    },
        function (result)
             MySQL.Async.fetchAll("SELECT * FROM epc_bolos order by id desc", {
                },
                    function (result)
                        if (result[1] ~= nil) then
                            TriggerClientEvent('esx_police_cad:show-bolos', _source, result)
                    end
                end)
    end)
end)

RegisterServerEvent('esx_police_cad:delete-bolo')
AddEventHandler('esx_police_cad:delete-bolo', function(data)
    id = data.id
    _source = source
    MySQL.Async.execute("DELETE FROM epc_bolos WHERE id = @id", {
        ['@id'] = id,
    },
        function (result)
            MySQL.Async.fetchAll("SELECT id FROM epc_bolos WHERE id = @id", {
                ['@id'] = id,
            },
            function (result2)
                if result2[1] == nil then
                    TriggerClientEvent('esx_police_cad:bolo-deleted', _source)
                else
                    TriggerClientEvent('esx_police_cad:bolo-not-deleted', _source)
                end
            end)
    end)
end)