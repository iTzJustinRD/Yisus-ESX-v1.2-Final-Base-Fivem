--[[ ############################################ --]]
--[[ ######## SISTEMA DE STATS PARA ESX ######### --]]
--[[ ########   CREADO POR Yisus#6342  ######### --]]
--[[ ############################################ --]]
--[[ ########  RENOMBRAR O MODIFICAR ESTE SCRIPT PUEDE ROMPERLO POR COMPLETO  ######### --]]
Config = {}

Config.UpdateFrequency = 3600 -- Segundos que pasan para borrar un stat. (Por defecto 1 hora)
Config.DeleteStats = true -- True = borramos un poco de las stats cada vez que el tiempo especificado (Config.UpdateFrequency) pase.

Config.WinStatsByDefault = true -- Si esta en true, ganarás stats realizando tareas como correr por defecto, conducir y demás. (Recomendado en true... y dejar el deletestats en true)
Config.Notifications = true --  notificamos cuando pierdes/ganas stats?

Config.Skills = {
    ["Resistencia"] = { -- Nombre del skill
        ["Current"] = 20, -- Valor por defecto
        ["RemoveAmount"] = -0.3, -- % a remover en caso de que Config.DeleteStats sea = true
        ["Stat"] = "MP0_STAMINA" -- Nombre del stat (nativo)
    },

    ["Fuerza"] = {
        ["Current"] = 10,
        ["RemoveAmount"] = -0.3,
        ["Stat"] = "MP0_STRENGTH"
    },

    ["Buceo"] = {
        ["Current"] = 0,
        ["RemoveAmount"] = -0.3,
        ["Stat"] = "MP0_LUNG_CAPACITY"
    },

    ["Disparo"] = {
        ["Current"] = 0,
        ["RemoveAmount"] = -0.1,
        ["Stat"] = "MP0_SHOOTING_ABILITY"
    },

    ["Conduccion"] = {
        ["Current"] = 0,
        ["RemoveAmount"] = -0.5,
        ["Stat"] = "MP0_DRIVING_ABILITY"
    },

    ["Levantar rueda delantera"] = {
        ["Current"] = 0,
        ["RemoveAmount"] = -0.2,
        ["Stat"] = "MP0_WHEELIE_ABILITY"
    }
}
