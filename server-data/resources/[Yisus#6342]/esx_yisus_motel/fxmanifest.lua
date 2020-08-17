fx_version 'adamant'
games { 'gta5' }

description 'Motel ReWritten by Yisus#6342 with more and usefull functions'
--disclaimer 'Do not resell or reupload those scripts.'

client_scripts {
	"config.lua",
	"client/functions.lua",
	"client/instance.lua",
	"client/storage.lua",
	"client/main.lua"
}

server_scripts {
	"@async/async.lua",
	"@mysql-async/lib/MySQL.lua",
	"config.lua",
	"server/main.lua",
	"server/functions.lua"
}