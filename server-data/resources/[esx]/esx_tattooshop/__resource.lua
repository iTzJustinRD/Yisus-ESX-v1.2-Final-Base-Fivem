resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX tattoo shop'

version '1.3.0'

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'locales/sv.lua',
	'locales/pl.lua',
	'config.lua',
	'client/tattoosList/list.lua',
	'client/main.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'locales/sv.lua',
	'locales/pl.lua',
	'config.lua',
	'server/main.lua'
}

dependency 'es_extended'