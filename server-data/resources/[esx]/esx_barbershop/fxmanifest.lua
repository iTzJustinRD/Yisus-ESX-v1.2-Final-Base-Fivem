fx_version 'adamant'

game 'gta5'

description 'barbershop'

version '1.0.0'

server_scripts{
    '@es_extended/locale.lua',
    'locales/en.lua',
    'locales/es.lua',
    'locales/zh.lua',
    'config.lua',
    'server.lua'
}

client_scripts{
    '@es_extended/locale.lua',
    'locales/en.lua',
    'locales/es.lua',
    'locales/zh.lua',
    'config.lua',
    'client.lua'
}


dependencies{
    'es_extended',
    'esx_skin'
}
