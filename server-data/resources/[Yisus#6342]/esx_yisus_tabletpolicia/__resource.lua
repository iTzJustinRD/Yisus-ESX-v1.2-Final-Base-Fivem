client_scripts {
	'config.lua',
	'client/client.lua',
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'config.lua',
    'server/server.lua',
}

ui_page 'ui/index.html'

files {
	'ui/index.html',
	'ui/css/style.css',
	'ui/scripts/app.js',
	'ui/scripts/jquery.js',
	'ui/images/LSPD_logo_GTA_V.png',
}
