--[[ ############################################ --]]
--[[ ######## SISTEMA DE STATS PARA ESX ######### --]]
--[[ ########   CREADO POR Yisus#6342  ######### --]]
--[[ ############################################ --]]
--[[ ########  RENOMBRAR O MODIFICAR ESTE SCRIPT PUEDE ROMPERLO POR COMPLETO  ######### --]]

-- Librería ESX
local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj 
end)

--Callback de obtener las stats actuales
ESX.RegisterServerCallback("yisus_skillsystem:fetchStatus", function(source, cb)
     local src = source
     local user = ESX.GetPlayerFromId(src)


     local fetch = [[
          SELECT
               skills
          FROM
               users
          WHERE
               identifier = @identifier
     ]]

     MySQL.Async.fetchScalar(fetch, {
          ["@identifier"] = user.identifier

     }, function(status)
          
          if status ~= nil then
               cb(json.decode(status))
          else
               cb(nil)
          end
     
     end)
end)

--Actualizar stats
RegisterServerEvent("yisus_skillsystem:update")
AddEventHandler("yisus_skillsystem:update", function(data)
     local src = source
     local user = ESX.GetPlayerFromId(src)

     local insert = [[
          UPDATE
               users
          SET
               skills = @skills
          WHERE
               identifier = @identifier
     ]]

     MySQL.Async.execute(insert, {
          ["@skills"] = data,
          ["@identifier"] = user.identifier
     })

end)
