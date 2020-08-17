fx_version 'adamant'
games { 'gta5' }

name 'vMenu'
description 'Server sided trainer for FiveM with custom permissions, using a custom MenuAPI.'
author 'Tom Grobbe (www.vespura.com)'
version 'v3.1.2' -- Final official version (v3.1.2), any future updates will be from the community.
url 'https://github.com/TomGrobbe/vMenu/'
client_debug_mode 'false'
server_debug_mode 'false'
experimental_features_enabled '0' -- leave this set to '0' to prevent compatibility issues and to keep the save files your users.

files {
    'Newtonsoft.Json.dll',
    'MenuAPI.dll',
    'config/locations.json',
    'config/addons.json',
}

client_script 'vMenuClient.net.dll'
server_script 'vMenuServer.net.dll'
