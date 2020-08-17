local a = nil
local b = {}
TriggerEvent(
    "esx:getSharedObject",
    function(c)
        a = c
    end
)
a.RegisterServerCallback(
    "if_esx_fleeca:getCurrentRobbery",
    function(source, d)
        d(b)
    end
)
a.RegisterServerCallback(
    "if_esx_fleeca:fetchCops",
    function(source, d)
        local e = a.GetPlayers()
        local f = 0
        for g, h in ipairs(e) do
            local h = a.GetPlayerFromId(h)
            if h then
                if h["job"]["name"] == "police" then
                    f = f + 1
                end
            end
        end
        d(f >= Config.CopsNeeded)
    end
)
RegisterServerEvent("if_esx_fleeca:globalEvent")
AddEventHandler(
    "if_esx_fleeca:globalEvent",
    function(i)
        if type(i["data"]) == "table" then
            if i["data"]["save"] then
                b[i["data"]["bank"]] = {
                    ["started"] = os.time(),
                    ["robber"] = source,
                    ["trolleys"] = i["data"]["trolleys"]
                }
            end
        end
        TriggerClientEvent("if_esx_fleeca:eventHandler", -1, i["event"] or "none", i["data"] or nil)
    end
)
RegisterServerEvent("if_esx_fleeca:receiveCash")
AddEventHandler(
    "if_esx_fleeca:receiveCash",
    function()
        local h = a.GetPlayerFromId(source)
        if h then
            local j = math.random(Config.Trolley["cash"][1], Config.Trolley["cash"][2])
            if Config.BlackMoney then
                h.addAccountMoney("black_money", j)
                TriggerClientEvent("esx:showNotification", source, "Has conseguido~r~~n~" .. j .. "~s~$ ~r~en negro")
            else
                h.addMoney(j)
                TriggerClientEvent("esx:showNotification", source, "Has conseguido~g~ " .. j .. "~s~$")
            end
        end
    end
)
RegisterServerEvent("if_esx_fleeca:bazsho")
AddEventHandler(
    "if_esx_fleeca:bazsho",
    function(k, l, m, n)
        TriggerClientEvent("if_esx_fleeca:bazshodan", -1, k, l, m, n)
    end
)
