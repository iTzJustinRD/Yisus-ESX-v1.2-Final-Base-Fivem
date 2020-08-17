fx_version 'adamant'
game 'gta5'

dependency 'es_extended'

client_scripts {
	'@es_extended/locale.lua',
	'locales/es.lua',
	'locales/en.lua',
	'config.lua',
	'client/client.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/es.lua',
	'locales/en.lua',
	'config.lua',
	'server/server.lua'
}
