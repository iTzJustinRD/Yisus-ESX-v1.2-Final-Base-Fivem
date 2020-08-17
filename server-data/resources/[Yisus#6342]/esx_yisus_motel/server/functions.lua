CreateMotel = function(source, motelRoom, callback)
    local player = ESX.GetPlayerFromId(source)

    local characterNames = cachedData["names"][player["identifier"]]

    if player then
        local motelData = {
            ["displayLabel"] = characterNames["firstname"] .. " " .. characterNames["lastname"],
            ["owner"] = player["identifier"],
            ["room"] = motelRoom or 1,
            ["uniqueId"] = Config.GenerateUniqueId()
        }

        local sqlQuery = [[
            INSERT
                INTO
            characters_motels
                (userIdentifier, motelData)
            VALUES
                (@identifier, @data)
        ]]

        MySQL.Async.execute(sqlQuery, {
            ["@identifier"] = player["identifier"],
            ["@data"] = json.encode(motelData)
        }, function(rowsChanged)
            if rowsChanged > 0 then
                if not cachedData["motels"][motelRoom or 1] then
                    cachedData["motels"][motelRoom or 1] = {}
                    cachedData["motels"][motelRoom or 1]["rooms"] = {}
                end
    
                table.insert(cachedData["motels"][motelRoom or 1]["rooms"], {
                    ["motelData"] = motelData
                })

                TriggerClientEvent("esx_yisus_motel:eventHandler", -1, "update_motels", cachedData["motels"])

                if callback then
                    callback(true)
                end
            else
                if callback then
                    callback(false)
                end
            end
        end)
    end
end

UpdateStorageDatabase = function(storageId, newTable)
    local sqlQuery = [[
        INSERT
            INTO
        characters_storages
            (storageId, storageData)
        VALUES
            (@id, @data)
        ON DUPLICATE KEY UPDATE
            storageData = @data
    ]]

    MySQL.Async.execute(sqlQuery, {
        ["@id"] = storageId,
        ["@data"] = json.encode(newTable)
    }, function(rowsChanged)
    end)
end

GetCharacterNames = function()
    local sqlTasks = {}

    local sqlQuery = [[
        SELECT
            firstname, lastname
        FROM
            users
        WHERE
            identifier = @cid
    ]]

    local players = ESX.GetPlayers()

    for playerIndex, player in ipairs(players) do
        local player = ESX.GetPlayerFromId(player)

        table.insert(sqlTasks, function(callback)   
            MySQL.Async.fetchAll(sqlQuery, {
                ["@cid"] = player["identifier"]
            }, function(rowsChanged)
                local fetchedPlayer = rowsChanged[1]
    
                if fetchedPlayer then
                    cachedData["names"][player["identifier"]] = fetchedPlayer
                else
                    cachedData["names"][player["identifier"]] = {
                        ["firstname"] = player["name"],
                        ["lastname"] = ""
                    }
                end
            end)
        end)
    end

    Async.parallel(sqlTasks, function(responses)
        ESX.Trace("Fetched all character names.")
    end)
end

GetCharacterName = function(player)
    local sqlQuery = [[
        SELECT
            firstname, lastname
        FROM
            users
        WHERE
            identifier = @cid
    ]]

    MySQL.Async.fetchAll(sqlQuery, {
        ["@cid"] = player["identifier"]
    }, function(rowsChanged)
        local fetchedPlayer = rowsChanged[1]

        if fetchedPlayer then
            cachedData["names"][player["identifier"]] = fetchedPlayer
        else
            cachedData["names"][player["identifier"]] = {
                ["firstname"] = player["name"],
                ["lastname"] = ""
            }
        end
    end)
end

DeleteMotel = function(identifier, callback)

    local data = nil
    local firstSqlQuery = [[
        SELECT
            motelData
        FROM
            characters_motels
        WHERE
          userIdentifier = @userIdentifier
    ]]
    MySQL.Async.fetchAll(firstSqlQuery,{
        ["@userIdentifier"] = identifier
    }, function(response)
        if response[1] ~= nil then
            data = json.decode(response[1].motelData)
            local uniqueId = "motel-"..data.uniqueId
            local secondSqlQuery = [[ DELETE FROM characters_storages WHERE storageId = @storageId ]]
            MySQL.Async.execute(secondSqlQuery, {
                ["@storageId"] = uniqueId
            }, function(rowsChanged)
            end)

            callback(false)
        end
    end)


    local sqlQuery = [[
        DELETE
            FROM
        characters_motels
            WHERE
         userIdentifier = @userIdentifier
    ]]

    MySQL.Async.execute(sqlQuery, {
        ["@userIdentifier"] = identifier
    }, function(rowsChanged)
        if rowsChanged > 0 then
            RebuildCache()
            callback(true)
        end
    end)
end