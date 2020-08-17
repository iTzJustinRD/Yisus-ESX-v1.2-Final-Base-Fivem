ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_outlawalert:gunshotInProgress')
AddEventHandler('esx_outlawalert:gunshotInProgress', function(targetCoords, streetName, playerGender)
	local src = source
	if playerGender == 0 then
		playerGender = "Hombre"
	else
		playerGender = "Mujer"
	end

	TriggerClientEvent("esx_rpchat:entornoSend", src, "un(a) "..playerGender.." ha disparado un arma en "..streetName, "disparos") 

	--TriggerClientEvent('esx_outlawalert:outlawNotify', -1, "~o~Tiroteo~s~: un(a) ~r~"..playerGender.."~s~ ha disparado un arma en ~y~"..streetName.."~s~")
	TriggerClientEvent('esx_outlawalert:gunshotInProgress', -1, targetCoords)
end)