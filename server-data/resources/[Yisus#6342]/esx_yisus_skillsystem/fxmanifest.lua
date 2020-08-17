fx_version 'adamant'
game 'gta5'

description 'ESX SkillSystem Recoded by: Yisus#6342  || based on the old: gamz-skillsystem'

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/main.lua',
    'config.lua'
}

client_scripts {
    'client/main.lua',
    'config.lua',
    'client/functions.lua'
}

exports {
    "SkillMenu",
    "UpdateSkill",
    "GetCurrentSkill"
}