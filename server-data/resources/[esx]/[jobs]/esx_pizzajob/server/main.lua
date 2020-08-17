ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_pizzajob:returnSafe:server')
RegisterServerEvent('esx_pizzajob:finishDelivery:server')
RegisterServerEvent('esx_pizzajob:removeSafeMoney:server')
RegisterServerEvent('esx_pizzajob:getPlayerJob:server')

AddEventHandler('esx_pizzajob:returnSafe:server', function(deliveryType, safeReturn)
	local xPlayer = ESX.GetPlayerFromId(source)
	if safeReturn then
		local SafeMoney = 100
		for k, v in pairs(Config.Safe) do
			if k == deliveryType then
				SafeMoney = v
				break
			end
		end
		xPlayer.addAccountMoney("bank", SafeMoney)
		xPlayer.showNotification(Config.Locales["safe_deposit_returned"])
	else
		xPlayer.showNotification(Config.Locales["safe_deposit_withheld"])
	end
end)

AddEventHandler('esx_pizzajob:finishDelivery:server', function(deliveryType)
    local xPlayer = ESX.GetPlayerFromId(source)
	local deliveryMoney = 25
	for k, v in pairs(Config.Rewards) do
		if k == deliveryType then
			deliveryMoney = v
			break
		end
	end
    xPlayer.addMoney(deliveryMoney)
	xPlayer.showNotification(Config.Locales["delivery_point_reward"] .. tostring(deliveryMoney))
end)

AddEventHandler('esx_pizzajob:removeSafeMoney:server', function(deliveryType)
    local xPlayer = ESX.GetPlayerFromId(source)
	local SafeMoney = 100
	for k, v in pairs(Config.Safe) do
		if k == deliveryType then
			SafeMoney = v
			break
		end
	end
	local PlayerMoney = xPlayer.getAccount('bank')
	if PlayerMoney.money >= SafeMoney then
		xPlayer.removeAccountMoney("bank", SafeMoney)
		xPlayer.showNotification(Config.Locales["safe_deposit_received"])
		TriggerClientEvent('esx_pizzajob:startJob:client', source, deliveryType)
	else
		xPlayer.showNotification(Config.Locales["not_enough_money"])
	end
end)
