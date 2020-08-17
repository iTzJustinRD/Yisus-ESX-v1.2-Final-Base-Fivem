# FIRST, VERY IMPORTANT

add this fragment of code into your functions.lua here \resources\es_extended\server\functions.lua or wherever
you have placed your es_extended resource

* Under line 163

```lua
ESX.GetItemWeight = function(item)
	if ESX.Items[item] ~= nil then
		return ESX.Items[item].weight
	end
end
```

# esx_inventoryhud_trunk 1.0



This is an vehicle trunk addon for [esx_inventoryhud](https://github.com/Trsak/esx_inventoryhud/).
Original code was taken from [esx_trunk](https://github.com/schwim0341/esx_trunk) modified by schwim0341.

## Requirements
* [es_extended](https://github.com/ESX-Org/es_extended)
* [pNotify](https://forum.fivem.net/t/release-pnotify-in-game-js-notifications-using-noty/20659)
* [esx_inventoryhud](https://github.com/Trsak/esx_inventoryhud/)

## Features
- Drag and drop
- Black Money support
- Weapons support
- Fully configurable 
- Locale files included
- Weight System Support from essentialmode DB
- Minor Bugs Fixed
- ES Locale Added

## Screens
* [https://i.imgur.com/5jPPBe9.png](https://i.imgur.com/5jPPBe9.png)

## Download & Installation

### Using Git
```
cd resources
git clone https://github.com/GMA950/esx_inventoryhud_trunk [esx]/esx_inventoryhud_trunk
```

### Manually
- Download https://github.com/GMA950/esx_inventoryhud_trunk/archive/master.zip
- Put it in the `[esx]` directory

## Installation
- Add this to your `server.cfg`:

```
start esx_inventoryhud_trunk
```

## Default Open Key is "M"