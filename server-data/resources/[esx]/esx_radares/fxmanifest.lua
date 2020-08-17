fx_version 'adamant'
games { 'gta5' }

description "Radares"
version "1.0"

ui_page 'html/index.html'

client_scripts {
  'client/main.lua'
}

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  'server/main.lua'
}

files {
    'html/index.html'
}