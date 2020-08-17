fx_version 'adamant'
game 'gta5'

description 'loaf_housing edited by Yisus#6342 - With Permission in order to use with my custom edit of esx.'

client_scripts {
	'config.lua',
    'client/client.lua',
    'client/functions.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'config.lua',
	'server/server.lua'
}