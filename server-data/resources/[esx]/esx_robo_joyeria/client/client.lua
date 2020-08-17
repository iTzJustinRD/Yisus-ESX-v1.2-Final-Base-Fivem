ESX = nil

local holdingup = false
local store = ""
local blipRobbery = nil
local isRobbing = false
local canceltimer = GetGameTimer()
local copsOnline = false
local sendedAlarm = false


Citizen.CreateThread(
	function()
		if Config.policecontrol == true then
			while true do
				Citizen.Wait(3000)
				local playerId = PlayerId()
				if isRobbing == false then
					if GetPlayerWantedLevel(playerId) ~= 0 then
						SetPlayerWantedLevel(playerId, 0, false)
						SetPlayerWantedLevelNow(playerId, false)
					end
				else
					if GetGameTimer() - canceltimer > Config.policereset * 1000 * 60 then
						isRobbing = false
					end
				end
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while ESX == nil do
			TriggerEvent(
				"esx:getSharedObject",
				function(obj)
					ESX = obj
				end
			)
			PlayerData = ESX.GetPlayerData()
			Citizen.Wait(0)
		end
	end
)
RegisterNetEvent("esx:setJob")
AddEventHandler(
	"esx:setJob",
	function(job)
		PlayerData.job = job
	end
)

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function drawTxt(x, y, width, height, scale, text, r, g, b, a, outline)
	SetTextFont(0)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	if (outline) then
		SetTextOutline()
	end
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x - width / 2, y - height / 2 + 0.005)
end

Citizen.CreateThread(
	function()
		---for k,v in pairs(Stores)do
		--	local ve = v.position
		if Config.ShowshopBlip then
			local blip = AddBlipForCoord(-624.33, -232.44, 38.6)
			SetBlipSprite(blip, 617)
			SetBlipScale(blip, 0.8)
			SetBlipColour(blip, 46)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(_U("shop_robbery"))
			EndTextCommandSetBlipName(blip)
		end
		if Config.SellBlip == true then
			local blip2 = AddBlipForCoord(ConfigSellPos.x, ConfigSellPos.y, ConfigSellPos.z)
			SetBlipSprite(blip2, Config.Blip)
			SetBlipScale(blip2, 0.8)
			SetBlipColour(blip2, Config.Colour)
			SetBlipAsShortRange(blip2, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(_U("Sell_robbery"))
			EndTextCommandSetBlipName(blip2)
		end
	end
)

incircle = false

cabinet1robbed = false
cabinet2robbed = false
cabinet3robbed = false
cabinet4robbed = false
cabinet5robbed = false
cabinet6robbed = false
cabinet7robbed = false
cabinet8robbed = false
cabinet9robbed = false
cabinet10robbed = false
cabinet11robbed = false
cabinet12robbed = false
cabinet13robbed = false
cabinet14robbed = false
cabinet15robbed = false
cabinet16robbed = false
cabinet17robbed = false
cabinet18robbed = false
cabinet19robbed = false
cabinet20robbed = false

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end

RegisterNetEvent("srvanrob:setcabinate")
AddEventHandler(
	"srvanrob:setcabinate",
	function(cabinetno, cabinetrobbed)
		if cabinetno == 1 then
			cabinet1robbed = cabinetrobbed
		elseif cabinetno == 2 then
			cabinet2robbed = cabinetrobbed
		elseif cabinetno == 3 then
			cabinet3robbed = cabinetrobbed
		elseif cabinetno == 4 then
			cabinet4robbed = cabinetrobbed
		elseif cabinetno == 5 then
			cabinet5robbed = cabinetrobbed
		elseif cabinetno == 6 then
			cabinet6robbed = cabinetrobbed
		elseif cabinetno == 7 then
			cabinet7robbed = cabinetrobbed
		elseif cabinetno == 8 then
			cabinet8robbed = cabinetrobbed
		elseif cabinetno == 9 then
			cabinet9robbed = cabinetrobbed
		elseif cabinetno == 10 then
			cabinet10robbed = cabinetrobbed
		elseif cabinetno == 11 then
			cabinet11robbed = cabinetrobbed
		elseif cabinetno == 12 then
			cabinet12robbed = cabinetrobbed
		elseif cabinetno == 13 then
			cabinet13robbed = cabinetrobbed
		elseif cabinetno == 14 then
			cabinet14robbed = cabinetrobbed
		elseif cabinetno == 15 then
			cabinet15robbed = cabinetrobbed
		elseif cabinetno == 16 then
			cabinet16robbed = cabinetrobbed
		elseif cabinetno == 17 then
			cabinet17robbed = cabinetrobbed
		elseif cabinetno == 18 then
			cabinet18robbed = cabinetrobbed
		elseif cabinetno == 19 then
			cabinet19robbed = cabinetrobbed
		elseif cabinetno == 20 then
			cabinet20robbed = cabinetrobbed
		end
	end
)
RegisterNetEvent("srvanrob:reset")
AddEventHandler(
	"srvanrob:reset",
	function(cabinetno, cabinetrobbed)
		cabinet1robbed = false
		cabinet2robbed = false
		cabinet3robbed = false
		cabinet4robbed = false
		cabinet5robbed = false
		cabinet6robbed = false
		cabinet7robbed = false
		cabinet8robbed = false
		cabinet9robbed = false
		cabinet10robbed = false
		cabinet11robbed = false
		cabinet12robbed = false
		cabinet13robbed = false
		cabinet14robbed = false
		cabinet15robbed = false
		cabinet16robbed = false
		cabinet17robbed = false
		cabinet18robbed = false
		cabinet19robbed = false
		cabinet20robbed = false
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			local pos = GetEntityCoords(GetPlayerPed(-1), true)
			--	print"test1"
			isnear = false
			cabinetno = 0
			if (Vdist(pos.x, pos.y, pos.z, -624.0, -232.47, 38.0) < 30.0) then
				isnear = true
				--print(cabinet1robbed)
				if cabinet1robbed == false then
					DrawMarker(
						1,
						-627.11,
						-234.95,
						37.86,
						0.0,
						0.0,
						0.0,
						0,
						0.0,
						0.0,
						0.2,
						0.2,
						0.2,
						255,
						0,
						0,
						100,
						false,
						true,
						2,
						false,
						false,
						false,
						false
					)
					if (Vdist(pos.x, pos.y, pos.z, -627.11, -234.95, 38.06) < 1.0) then
						cabinetno = 1
						locx, locy, locz = -627.11, -234.95, 37.86
					end
				end
				if cabinet2robbed == false then
					DrawMarker(
						1,
						-627.58,
						-234.36,
						37.86,
						0.0,
						0.0,
						0.0,
						0,
						0.0,
						0.0,
						0.2,
						0.2,
						0.2,
						255,
						0,
						0,
						100,
						false,
						true,
						2,
						false,
						false,
						false,
						false
					)
					if (Vdist(pos.x, pos.y, pos.z, -627.58, -234.36, 37.86) < 1.0) then
						cabinetno = 2
						locx, locy, locz = -627.58, -234.36, 37.86
					end
				end
				if cabinet3robbed == false then
					DrawMarker(
						1,
						-626.51,
						-233.65,
						37.86,
						0.0,
						0.0,
						0.0,
						0,
						0.0,
						0.0,
						0.2,
						0.2,
						0.2,
						255,
						0,
						0,
						100,
						false,
						true,
						2,
						false,
						false,
						false,
						false
					)
					if (Vdist(pos.x, pos.y, pos.z, -626.51, -233.65, 37.86) < 1.0) then
						cabinetno = 3
						locx, locy, locz = -626.51, -233.65, 37.86
					end
				end
				if cabinet4robbed == false then
					DrawMarker(
						1,
						-626.13,
						-234.21,
						37.86,
						0.0,
						0.0,
						0.0,
						0,
						0.0,
						0.0,
						0.2,
						0.2,
						0.2,
						255,
						0,
						0,
						100,
						false,
						true,
						2,
						false,
						false,
						false,
						false
					)
					if (Vdist(pos.x, pos.y, pos.z, -626.13, -234.21, 37.86) < 1.0) then
						cabinetno = 4
						locx, locy, locz = -626.13, -234.21, 37.86
					end
				end
				if cabinet5robbed == false then
					DrawMarker(
						1,
						-625.28,
						-238.27,
						37.86,
						0.0,
						0.0,
						0.0,
						0,
						0.0,
						0.0,
						0.2,
						0.2,
						0.2,
						255,
						0,
						0,
						100,
						false,
						true,
						2,
						false,
						false,
						false,
						false
					)
					if (Vdist(pos.x, pos.y, pos.z, -625.28, -238.27, 37.86) < 1.0) then
						cabinetno = 5
						locx, locy, locz = -625.28, -238.27, 37.86
					end
				end
				if cabinet6robbed == false then
					DrawMarker(
						1,
						-626.32,
						-239.06,
						37.86,
						0.0,
						0.0,
						0.0,
						0,
						0.0,
						0.0,
						0.2,
						0.2,
						0.2,
						255,
						0,
						0,
						100,
						false,
						true,
						2,
						false,
						false,
						false,
						false
					)
					if (Vdist(pos.x, pos.y, pos.z, -626.32, -239.06, 37.86) < 1.0) then
						cabinetno = 6
						locx, locy, locz = -626.32, -239.06, 37.86
					end
				end
				if cabinet7robbed == false then
					DrawMarker(
						1,
						-625.28,
						-227.43,
						37.86,
						0.0,
						0.0,
						0.0,
						0,
						0.0,
						0.0,
						0.2,
						0.2,
						0.2,
						255,
						0,
						0,
						100,
						false,
						true,
						2,
						false,
						false,
						false,
						false
					)
					if (Vdist(pos.x, pos.y, pos.z, -625.28, -227.43, 37.86) < 1.0) then
						cabinetno = 7
						locx, locy, locz = -625.28, -227.43, 37.86
					end
				end
				if cabinet8robbed == false then
					DrawMarker(
						1,
						-624.27,
						-226.62,
						37.86,
						0.0,
						0.0,
						0.0,
						0,
						0.0,
						0.0,
						0.2,
						0.2,
						0.2,
						255,
						0,
						0,
						100,
						false,
						true,
						2,
						false,
						false,
						false,
						false
					)
					if (Vdist(pos.x, pos.y, pos.z, -624.27, -226.62, 37.86) < 1.0) then
						cabinetno = 8
						locx, locy, locz = -624.27, -226.62, 37.86
					end
				end
				if cabinet9robbed == false then
					DrawMarker(
						1,
						-619.96,
						-226.20,
						37.86,
						0.0,
						0.0,
						0.0,
						0,
						0.0,
						0.0,
						0.2,
						0.2,
						0.2,
						255,
						0,
						0,
						100,
						false,
						true,
						2,
						false,
						false,
						false,
						false
					)
					if (Vdist(pos.x, pos.y, pos.z, -619.96, -226.20, 37.86) < 1.0) then
						cabinetno = 9
						locx, locy, locz = -619.96, -226.20, 37.86
					end
				end
				if cabinet10robbed == false then
					DrawMarker(
						1,
						-619.24,
						-227.23,
						37.86,
						0.0,
						0.0,
						0.0,
						0,
						0.0,
						0.0,
						0.2,
						0.2,
						0.2,
						255,
						0,
						0,
						100,
						false,
						true,
						2,
						false,
						false,
						false,
						false
					)
					if (Vdist(pos.x, pos.y, pos.z, -619.24, -227.23, 37.86) < 1.0) then
						cabinetno = 10
						locx, locy, locz = -619.24, -227.23, 37.86
					end
				end
				if cabinet11robbed == false then
					DrawMarker(
						1,
						-617.88,
						-229.12,
						37.86,
						0.0,
						0.0,
						0.0,
						0,
						0.0,
						0.0,
						0.2,
						0.2,
						0.2,
						255,
						0,
						0,
						100,
						false,
						true,
						2,
						false,
						false,
						false,
						false
					)
					if (Vdist(pos.x, pos.y, pos.z, -617.88, -229.12, 37.86) < 1.0) then
						cabinetno = 11
						locx, locy, locz = -617.88, -229.12, 37.86
					end
				end
				if cabinet12robbed == false then
					DrawMarker(
						1,
						-617.1,
						-230.15,
						37.86,
						0.0,
						0.0,
						0.0,
						0,
						0.0,
						0.0,
						0.2,
						0.2,
						0.2,
						255,
						0,
						0,
						100,
						false,
						true,
						2,
						false,
						false,
						false,
						false
					)
					if (Vdist(pos.x, pos.y, pos.z, -617.1, -230.15, 37.86) < 1.0) then
						cabinetno = 12
						locx, locy, locz = -617.1, -230.15, 37.86
					end
				end
				if cabinet13robbed == false then
					DrawMarker(
						1,
						-618.84,
						-234.06,
						37.86,
						0.0,
						0.0,
						0.0,
						0,
						0.0,
						0.0,
						0.2,
						0.2,
						0.2,
						255,
						0,
						0,
						100,
						false,
						true,
						2,
						false,
						false,
						false,
						false
					)
					if (Vdist(pos.x, pos.y, pos.z, -618.84, -234.06, 37.86) < 1.0) then
						cabinetno = 13
						locx, locy, locz = -618.84, -234.06, 37.86
					end
				end
				if cabinet14robbed == false then
					DrawMarker(
						1,
						-619.87,
						-234.88,
						37.86,
						0.0,
						0.0,
						0.0,
						0,
						0.0,
						0.0,
						0.2,
						0.2,
						0.2,
						255,
						0,
						0,
						100,
						false,
						true,
						2,
						false,
						false,
						false,
						false
					)
					if (Vdist(pos.x, pos.y, pos.z, -619.87, -234.88, 37.86) < 1.0) then
						cabinetno = 14
						locx, locy, locz = -619.87, -234.88, 37.86
					end
				end
				if cabinet15robbed == false then
					DrawMarker(
						1,
						-620.54,
						-232.87,
						37.86,
						0.0,
						0.0,
						0.0,
						0,
						0.0,
						0.0,
						0.2,
						0.2,
						0.2,
						255,
						0,
						0,
						100,
						false,
						true,
						2,
						false,
						false,
						false,
						false
					)
					if (Vdist(pos.x, pos.y, pos.z, -620.54, -232.87, 37.86) < 1.0) then
						cabinetno = 15
						locx, locy, locz = -620.54, -232.87, 37.86
					end
				end
				if cabinet16robbed == false then
					DrawMarker(
						1,
						-620.05,
						-230.77,
						37.86,
						0.0,
						0.0,
						0.0,
						0,
						0.0,
						0.0,
						0.2,
						0.2,
						0.2,
						255,
						0,
						0,
						100,
						false,
						true,
						2,
						false,
						false,
						false,
						false
					)
					if (Vdist(pos.x, pos.y, pos.z, -620.05, -230.77, 37.86) < 1.0) then
						cabinetno = 16
						locx, locy, locz = -620.05, -230.77, 37.86
					end
				end
				if cabinet17robbed == false then
					DrawMarker(
						1,
						-621.53,
						-228.95,
						37.86,
						0.0,
						0.0,
						0.0,
						0,
						0.0,
						0.0,
						0.2,
						0.2,
						0.2,
						255,
						0,
						0,
						100,
						false,
						true,
						2,
						false,
						false,
						false,
						false
					)
					if (Vdist(pos.x, pos.y, pos.z, -621.53, -228.95, 37.86) < 1.0) then
						cabinetno = 17
						locx, locy, locz = -621.53, -228.95, 37.86
					end
				end
				if cabinet18robbed == false then
					DrawMarker(
						1,
						-623.68,
						-228.54,
						37.86,
						0.0,
						0.0,
						0.0,
						0,
						0.0,
						0.0,
						0.2,
						0.2,
						0.2,
						255,
						0,
						0,
						100,
						false,
						true,
						2,
						false,
						false,
						false,
						false
					)
					if (Vdist(pos.x, pos.y, pos.z, -623.68, -228.54, 37.86) < 1.0) then
						cabinetno = 18
						locx, locy, locz = -623.68, -228.54, 37.86
					end
				end
				if cabinet19robbed == false then
					DrawMarker(
						1,
						-624.09,
						-230.8,
						37.86,
						0.0,
						0.0,
						0.0,
						0,
						0.0,
						0.0,
						0.2,
						0.2,
						0.2,
						255,
						0,
						0,
						100,
						false,
						true,
						2,
						false,
						false,
						false,
						false
					)
					if (Vdist(pos.x, pos.y, pos.z, -624.09, -230.8, 37.86) < 1.0) then
						cabinetno = 19
						locx, locy, locz = -624.09, -230.8, 37.86
					end
				end
				if cabinet20robbed == false then
					DrawMarker(
						1,
						-622.64,
						-232.55,
						37.86,
						0.0,
						0.0,
						0.0,
						0,
						0.0,
						0.0,
						0.2,
						0.2,
						0.2,
						255,
						0,
						0,
						100,
						false,
						true,
						2,
						false,
						false,
						false,
						false
					)
					if (Vdist(pos.x, pos.y, pos.z, -622.64, -232.55, 37.86) < 1.0) then
						cabinetno = 20
						locx, locy, locz = -622.64, -232.55, 37.86
					end
				end

				if cabinetno ~= 0 and IsPedArmed(PlayerPedId(), 7) then
					DisplayHelpText(_U("press_to_rob"))
					if IsControlJustPressed(0, 38) then
						local canRob = nil
						ESX.TriggerServerCallback('srvanrob:canRob', function(cb)
							canRob = cb
						end)
						while canRob == nil do
							Wait(10)
						end
						if canRob then
							TriggerServerEvent("srvanrob:cabinet", cabinetno)
							if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
								RequestNamedPtfxAsset("scr_jewelheist")
							end
							while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
								Citizen.Wait(0)
							end
							SetPtfxAssetNextCall("scr_jewelheist")
							StartParticleFxLoopedAtCoord(
								"scr_jewel_cab_smash",
								locx,
								locy,
								locz + 0.2,
								0.0,
								0.0,
								0.0,
								1.0,
								false,
								false,
								false,
								false
							)
							loadAnimDict("missheist_jewel")
							TaskPlayAnim(GetPlayerPed(-1), "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0)
							DisplayHelpText(_U("collectinprogress"))
							DrawSubtitleTimed(4000, 1)
							local waiter = GetGameTimer()
							repeat
								Wait(50)
							until GetGameTimer() - waiter > Config.smashtimer
							ClearPedTasks(GetPlayerPed(-1))
							local chance = math.random(1, 100)
							if chance < Config.alarmchance then
								--TriggerEvent("esx:showNotification", _U("alarm_triggered"))

								if Config.AIpoliceon == true then
									TriggerServerEvent("srvanrob:setwanted")
									isRobbing = true
									print("isRobbing", isRobbing)
								end

								if Config.sendpolicealert == true and not sendedAlarm then
									sendedAlarm = true
									local Bpos = {}
									Bpos.x = -624.74
									Bpos.y = -232.45
									Bpos.z = 38.06
									TriggerServerEvent("srvanrob:setblip", Bpos)
								end
							end
							local amount = math.random(1, 3)
							local amount2 = math.random(1, 10)
							if amount2 == 5 then
								amount2 = 1
							else
								amount2 = 0
							end
							TriggerServerEvent("srvanrob:givejewles", amount, amount2)
						else
							TriggerEvent("esx:showNotification","No tiene gracia robar si no hay ~r~Policías suficientes")
						end
					end
				end
			elseif (Vdist(pos.x, pos.y, pos.z, 707.26, -965.63, 30.3) < 20.0) then
				DrawMarker(
					1,
					707.26,
					-965.63,
					29.3,
					0.0,
					0.0,
					0.0,
					0,
					0.0,
					0.0,
					1.2,
					1.2,
					0.2,
					255,
					0,
					0,
					100,
					false,
					true,
					2,
					false,
					false,
					false,
					false
				)
				isnear = true
				if (Vdist(pos.x, pos.y, pos.z, 707.26, -965.63, 30.3) < 2.0) then
					DisplayHelpText("Presiona ~INPUT_CONTEXT~ para vender joyas y diamantes")
					if IsControlJustPressed(0, 38) then
						Wait(300)
						TriggerServerEvent("srvanrob:selljewles")
						Wait(2000)
					end
				end
			end
			if isnear == false then
				Wait(4500)
			end
		end
	end
)

RegisterNetEvent("srvanrob:setblip")
AddEventHandler(
	"srvanrob:setblip",
	function(position)
		if Config.sendpolicealert == true then
			if PlayerData.job ~= nil and PlayerData.job.name == "police" then
				Wait(1000)

				PlaySoundFrontend(-1, "CHALLENGE_UNLOCKED", "HUD_AWARDS", 1)

				RemoveBlip(blipRobbery)
				blipRobbery = AddBlipForCoord(position.x, position.y, position.z)
				SetBlipSprite(blipRobbery, 161)
				SetBlipScale(blipRobbery, 2.0)
				SetBlipColour(blipRobbery, 3)
				PulseBlip(blipRobbery)
				Wait(60000)
				RemoveBlip(blipRobbery)
			end
		end
	end
)

RegisterNetEvent("srvanrob:setwanted")
AddEventHandler(
	"srvanrob:setwanted",
	function()
		if GetPlayerWantedLevel(PlayerId()) < Config.Wantedlevel then
			SetPlayerWantedLevel(PlayerId(), Config.Wantedlevel, false)
			SetPlayerWantedLevelNow(PlayerId(), true)
		end
	end
)


RegisterNetEvent('srvanrob:msgPolice')
AddEventHandler('srvanrob:msgPolice', function(robber)
    local mugshot, mugshotStr = ESX.Game.GetPedMugshot(GetPlayerPed(GetPlayerFromServerId(robber)))
	ESX.ShowAdvancedNotification("Robo Joyería", 'Robo en curso', 'Un individuo está robando las joyas, les envío una foto del ladrón!', mugshotStr, 4)
    UnregisterPedheadshot(mugshot)
    while true do
        local name = GetCurrentResourceName() .. math.random(999)
        AddTextEntry(name, '~INPUT_CONTEXT~ para marcar en GPS \n~INPUT_FRONTEND_RRIGHT~ para cancelar')
        DisplayHelpTextThisFrame(name, false)
        if IsControlPressed(0, 38) then
            SetNewWaypoint(-624.33, -232.44, 38.6)
            return
        elseif IsControlPressed(0, 194) then
            return
        end
        Wait(0)
    end
end)


--[[Citizen.CreateThread(function()  
	while true do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
		if (Vdist(pos.x, pos.y, pos.z, -617.1, -230.15, 37.86) < 100.0) then
			ESX.TriggerServerCallback('srvanrob:canRob', function(cb)
					copsOnline = cb
			end)
		end
		Citizen.Wait(30000)
	end
end)]]
