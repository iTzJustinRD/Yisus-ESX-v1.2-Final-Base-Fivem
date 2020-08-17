--[[ ############################################ --]]
--[[ ######## SISTEMA DE STATS PARA ESX ######### --]]
--[[ ########   CREADO POR Yisus#6342  ######### --]]
--[[ ############################################ --]]
--[[ ########  RENOMBRAR O MODIFICAR ESTE SCRIPT PUEDE ROMPERLO POR COMPLETO  ######### --]]

--Obtener skills (stats)
FetchSkills = function()
    ESX.TriggerServerCallback("yisus_skillsystem:fetchStatus", function(data)
		if data then
            for status, value in pairs(data) do
                if Config.Skills[status] then
                    Config.Skills[status]["Current"] = value["Current"]
                else
                    print("Removing: " .. status) 
                end
            end
		end
        RefreshSkills()
    end)
end

--Menú (Se necesita hacer un export o trigger)
SkillMenu = function()
    ESX.UI.Menu.CloseAll()
    local skills = {}

	for type, value in pairs(Config.Skills) do
		table.insert(skills, {
			["label"] = type .. ': <span style="color:#0d7ec0">' .. value["Current"] .. "</span> %"
		})
	end

	ESX.UI.Menu.Open("default", GetCurrentResourceName(), "skill_menu",
	{
		["title"] = "Habilidades",
		["align"] = "bottom-right",
		["elements"] = skills

	}, function(data, menu)
	
        
	end, function(data, menu)
		menu.close()
	end)
end

--Funcion obtener una stat
GetCurrentSkill = function(skill)
    return Config.Skills[skill]
end

-- Actualizar/Modificar una stat
UpdateSkill = function(skill, amount)

    if not Config.Skills[skill] then
        print("Skill " .. skill .. " doesn't exist")
        return
    end

    local SkillAmount = Config.Skills[skill]["Current"]
    
    if SkillAmount + tonumber(amount) < 0 then
        Config.Skills[skill]["Current"] = 0
    elseif SkillAmount + tonumber(amount) > 100 then
        Config.Skills[skill]["Current"] = 100
    else
        Config.Skills[skill]["Current"] = SkillAmount + tonumber(amount)
    end
    
    RefreshSkills()

    if Config.Notifications then
        if tonumber(amount) > 0 then
            Notification("~g~+" .. amount .. "% ~s~" .. skill)
        end
    end
	TriggerServerEvent("yisus_skillsystem:update", json.encode(Config.Skills))
end


function round(num) 
    return math.floor(num+.5) 
end

-- Refrescar un skill/stat
RefreshSkills = function()
    for type, value in pairs(Config.Skills) do
        
        if value["Stat"] then
            StatSetInt(value["Stat"], round(value["Current"]), true)
        end
        
        if ESX.UI.Menu.IsOpen("default", GetCurrentResourceName(), "skill_menu") then
            SkillMenu()
        end
    end
end

-- Notificación (a mejorar)
Notification = function(message)
    ESX.ShowNotification(message)
end
