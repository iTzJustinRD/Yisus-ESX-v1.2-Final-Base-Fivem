---- Made BY TheStonedRaider for DOJSRC
----
ConfigSellPos = {}
Config = {}
Config.Locale = 'es'
--- Alarm / refresh timer 
Config.smashtimer = 4000    ------ In MS how long it takes to smash and rob each cabinet

Config.alarmchance = 100  --------- 0 - %100 How likely the alarm will go off for EACH broken cabinet 

Config.resettimer = 45 ----------- In Minuets how long until the shop is refilled after being robbed.


-- police 
Config.sendpolicealert = true     ---   give blip for "police" job when alarm is triggerd 

Config.AIpoliceon = false   ------- Sets you as wanted when alarm is tripped 

Config.Policeamount = 0    ------- if there is less than this amont of "real" police on the server it will call AI police/set perp wanted 

Config.Wantedlevel = 3     ------- wanted level given when alarm 

Config.policecontrol = true ------   Disable wanted level --- deactivates police when you are not robbing the store

Config.policereset = 5 		----- In Minuets how long until police are called off
 --Selling 
ConfigSellPos.x,ConfigSellPos.y,ConfigSellPos.z =  707.39,-965.23,30.41         ------ Coords of sell circle

Config.SellPrice = 500     ----------- Price for 10 Jewles 

Config.mopolicemomoney = true ------ If police are online you will get more money 

Config.Copextra = 20 ------ How much $ more is added per police online

Config.SellBlip = false  ---- Is a blip placed at the sell location

Config.Blip = 77 ---  Sell Blip style

Config.Colour = 1 ---  Sell Blip Colour

-- blip 

Config.ShowshopBlip = true ----- show a blip at the shop....
