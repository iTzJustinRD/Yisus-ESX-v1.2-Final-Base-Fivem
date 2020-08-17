fx_version 'adamant'

game 'gta5'

description 'ESX RP Chat modified by: Yisus#6342'

version '1.3.1'

server_scripts {
	'@es_extended/locale.lua',

	'locales/sv.lua',
	'locales/en.lua',
	'locales/fi.lua',
	'locales/fr.lua',
	'locales/es.lua',
	'locales/cs.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/sv.lua',
	'locales/en.lua',
	'locales/fi.lua',
	'locales/fr.lua',
	'locales/es.lua',
	'locales/cs.lua',
	'config.lua',
	'client/main.lua',
	'client/custom_client_commands.lua'
}

dependency 'es_extended'
