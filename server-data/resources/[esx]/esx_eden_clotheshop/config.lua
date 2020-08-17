Config = {}
Config.Locale = 'es'

Config.Price = 50

Config.DrawDistance = 100.0
Config.MarkerSize   = {x = 1.5, y = 1.5, z = 1.0}
Config.MarkerColor  = {r = 102, g = 102, b = 204}
Config.MarkerType   = 25

Config.Zones = {}

Config.Shops = {
  {x=72.254,    y=-1399.102, z=28.386},
  {x=-703.776,  y=-152.258,  z=36.425},
  {x=-167.863,  y=-298.969,  z=38.743},
  {x=428.694,   y=-800.106,  z=28.499},
  {x=-829.413,  y=-1073.710, z=10.338},
  {x=-1447.797, y=-242.461,  z=48.830},
  {x=11.632,    y=6514.224,  z=30.887},
  {x=123.646,   y=-219.440,  z=53.567},
  {x=1696.291,  y=4829.312,  z=41.073},
  {x=618.093,   y=2759.629,  z=41.098},
  {x=1190.550,  y=2713.441,  z=37.232},
  {x=-1193.429, y=-772.262,  z=16.334},
  {x=-3172.496, y=1048.133,  z=19.873},
  {x=-1108.441, y=2708.923,  z=18.117},
}

for i=1, #Config.Shops, 1 do

	Config.Zones['Shop_' .. i] = {
	 	Pos   = Config.Shops[i],
	 	Size  = Config.MarkerSize,
	 	Color = Config.MarkerColor,
	 	Type  = Config.MarkerType
  }

end
