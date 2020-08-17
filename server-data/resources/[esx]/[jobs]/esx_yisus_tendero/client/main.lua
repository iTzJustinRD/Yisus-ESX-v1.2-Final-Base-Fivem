local isInMarker, isInPublicMarker, hintIsShowed, HasAlreadyEnteredMarker = false, false, false, false, false
local LastZone, CurrentAction, CurrentActionMsg
local CurrentActionData, Blips, PlayerData = {}, {}, {}
local hintToDisplay = "no hint to display"

ESX = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer   
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

function cleanPlayer(playerPed)
  ClearPedBloodDamage(playerPed)
  ResetPedVisibleDamage(playerPed)
  ClearPedLastWeaponDamage(playerPed)
  ResetPedMovementClipset(playerPed, 0)
end

function setClipset(playerPed, clip)
  RequestAnimSet(clip)
  while not HasAnimSetLoaded(clip) do
    Citizen.Wait(0)
  end
  SetPedMovementClipset(playerPed, clip, true)
end

function setUniform(job, playerPed)
  TriggerEvent('skinchanger:getSkin', function(skin)

    if skin.sex == 0 then
      if Config.Uniforms[job].male ~= nil then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].male)
      else
        ESX.ShowNotification(_U('no_outfit'))
      end
      if job ~= 'citizen_wear' and job ~= 'empleado_outfit' then
      end
    else
      if Config.Uniforms[job].female ~= nil then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].female)
      else
        ESX.ShowNotification(_U('no_outfit'))
      end
      if job ~= 'citizen_wear' and job ~= 'empleado_outfit' then
      end
    end
  end)
end

function OpenCloakroomMenu()
  local playerPed = GetPlayerPed(-1)

  local elements = {
    {label = _U('citizen_wear'), value = 'citizen_wear'},
    {label = _U('empleado_outfit'), value = 'empleado_outfit'},
  }

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom', {
      title    = _U('cloakroom'),
      align    = 'bottom-right',
      elements = elements,
    }, function(data, menu)
      cleanPlayer(playerPed)

      if data.current.value == 'citizen_wear' then
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
          TriggerEvent('skinchanger:loadSkin', skin)
        end)
      end

      if data.current.value == 'empleado_outfit' then
        setUniform(data.current.value, playerPed)
      end

      CurrentAction = 'menu_cloakroom'
      CurrentActionMsg = _U('open_cloackroom')
      CurrentActionData = {}
    end, function(data, menu)
      menu.close()
      CurrentAction = 'menu_cloakroom'
      CurrentActionMsg = _U('open_cloackroom')
      CurrentActionData = {}
    end)
end

function OpenVaultMenu()
    local elements = {
      {label = _U('get_object'), value = 'get_stock'},
      {label = _U('put_object'), value = 'put_stock'}
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vault', {
        title    = _U('vault'),
        align    = 'bottom-right',
        elements = elements,
      }, function(data, menu)

        if data.current.value == 'put_stock' then
           OpenPutStocksMenu()
        end

        if data.current.value == 'get_stock' then
           OpenGetStocksMenu()
        end
      end, function(data, menu)

        menu.close()

        CurrentAction = 'menu_vault'
        CurrentActionMsg = _U('open_vault')
        CurrentActionData = {}
    end)
end

function OpenVaultMenuJefe()
  local elements = {
    {label = _U('get_object'), value = 'get_stock'},
    {label = _U('put_object'), value = 'put_stock'}
  }

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vault', {
      title    = _U('vault'),
      align    = 'bottom-right',
      elements = elements,
    }, function(data, menu)

      if data.current.value == 'put_stock' then
         OpenPutStocksMenuJefe()
      end

      if data.current.value == 'get_stock' then
         OpenGetStocksMenuJefe()
      end
    end, function(data, menu)

      menu.close()

      CurrentAction = 'menu_vault'
      CurrentActionMsg = _U('open_vault')
      CurrentActionData = {}
  end)
end

function OpenVaultMenuNorte()
  local elements = {
    {label = _U('get_object'), value = 'get_stock'},
    {label = _U('put_object'), value = 'put_stock'}
  }

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vault', {
      title    = _U('vault'),
      align    = 'bottom-right',
      elements = elements,
    }, function(data, menu)

      if data.current.value == 'put_stock' then
         OpenPutStocksMenuNorte()
      end

      if data.current.value == 'get_stock' then
         OpenGetStocksMenuNorte()
      end
    end, function(data, menu)

      menu.close()

      CurrentAction = 'menu_vault'
      CurrentActionMsg = _U('open_vault')
      CurrentActionData = {}
  end)
end

function OpenSocietyActionsMenu()
  local elements = {}

  table.insert(elements, {label = _U('billing'), value = 'billing'})
  table.insert(elements, {label = _U('crafting'), value = 'menu_crafting'})

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'tendero_actions', {
      title    = _U('tendero'),
      align    = 'bottom-right',
      elements = elements
    }, function(data, menu)

      if data.current.value == 'billing' then
        OpenBillingMenu()
      end

      if data.current.value == 'menu_crafting' then
          ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menu_crafting', {
                  title = _U('crafting'),
                  align = 'bottom-right',
                  elements = {
                      {label = _U('caldopollo'),     value = 'caldopollo'},
                  }}, function(data2, menu2)

                TriggerServerEvent('esx_yisus_tendero:crafteo', data2.current.value)
                animsAction({ lib = "mini@drinking", anim = "shots_barman_b" })
              end, function(data2, menu2)
                  menu2.close()
              end)
      end
    end, function(data, menu)

      menu.close()
    end)
end

function OpenBillingMenu()
  ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing', {
      title = _U('billing_amount')
    }, function(data, menu)
    
      local amount = tonumber(data.value)
      local player, distance = ESX.Game.GetClosestPlayer()

      if player ~= -1 and distance <= 3.0 then
        menu.close()

        if amount == nil then
            ESX.ShowNotification(_U('amount_invalid'))
        else
            TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_tendero', _U('billing'), amount)
        end
      else
        ESX.ShowNotification(_U('no_players_nearby'))
      end
    end, function(data, menu)
        menu.close()
    end)
end

function OpenGetStocksMenu()
  ESX.TriggerServerCallback('esx_yisus_tendero:getStockItems', function(items)

    print(json.encode(items))

    local elements = {}

    for i=1, #items, 1 do
      table.insert(elements, {label = 'x' .. items[i].count .. ' ' .. items[i].label, value = items[i].name})
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
        title    = _U('tendero_stock'),
        align    = 'bottom-right',
        elements = elements
      }, function(data, menu)

        local itemName = data.current.value

        ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
            title = _U('quantity')
          }, function(data2, menu2)

            local count = tonumber(data2.value)

            if count == nil then
              ESX.ShowNotification(_U('invalid_quantity'))
            else
              menu2.close()
              menu.close()
              OpenGetStocksMenu()

              TriggerServerEvent('esx_yisus_tendero:getStockItem', itemName, count)
            end
          end, function(data2, menu2)
            menu2.close()
          end)
      end, function(data, menu)
        menu.close()
      end)
  end)
end

function OpenGetStocksMenuNorte()
  ESX.TriggerServerCallback('esx_yisus_tendero:getStockItemsNorte', function(items)

    print(json.encode(items))

    local elements = {}

    for i=1, #items, 1 do
      table.insert(elements, {label = 'x' .. items[i].count .. ' ' .. items[i].label, value = items[i].name})
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
        title    = _U('tendero_stock'),
        align    = 'bottom-right',
        elements = elements
      }, function(data, menu)

        local itemName = data.current.value

        ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
            title = _U('quantity')
          }, function(data2, menu2)

            local count = tonumber(data2.value)

            if count == nil then
              ESX.ShowNotification(_U('invalid_quantity'))
            else
              menu2.close()
              menu.close()
              OpenGetStocksMenu()

              TriggerServerEvent('esx_yisus_tendero:getStockItem', itemName, count)
            end
          end, function(data2, menu2)
            menu2.close()
          end)
      end, function(data, menu)
        menu.close()
      end)
  end)
end

function OpenGetStocksMenuJefe()
  ESX.TriggerServerCallback('esx_yisus_tendero:getStockItemsJefe', function(items)

    print(json.encode(items))

    local elements = {}

    for i=1, #items, 1 do
      table.insert(elements, {label = 'x' .. items[i].count .. ' ' .. items[i].label, value = items[i].name})
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
        title    = _U('tendero_stock'),
        align    = 'bottom-right',
        elements = elements
      }, function(data, menu)

        local itemName = data.current.value

        ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
            title = _U('quantity')
          }, function(data2, menu2)

            local count = tonumber(data2.value)

            if count == nil then
              ESX.ShowNotification(_U('invalid_quantity'))
            else
              menu2.close()
              menu.close()
              OpenGetStocksMenu()

              TriggerServerEvent('esx_yisus_tendero:getStockItemJefe', itemName, count)
            end
          end, function(data2, menu2)
            menu2.close()
          end)
      end, function(data, menu)
        menu.close()
      end)
  end)
end

function OpenPutStocksMenu()
    ESX.TriggerServerCallback('esx_yisus_tendero:getPlayerInventory', function(inventory)

    local elements = {}

    for i=1, #inventory.items, 1 do
      local item = inventory.items[i]

      if item.count > 0 then
        table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name})
      end
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
        title    = _U('inventory'),
        align    = 'bottom-right',
        elements = elements
      }, function(data, menu)

        local itemName = data.current.value

        ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
            title = _U('quantity')
          }, function(data2, menu2)

            local count = tonumber(data2.value)

            if count == nil then
              ESX.ShowNotification(_U('invalid_quantity'))
            else
              menu2.close()
              menu.close()
              OpenPutStocksMenu()

              TriggerServerEvent('esx_yisus_tendero:putStockItems', itemName, count)
            end
          end, function(data2, menu2)
            menu2.close()
          end)
      end, function(data, menu)
        menu.close()
      end)
  end)
end

function OpenPutStocksMenuNorte()
  ESX.TriggerServerCallback('esx_yisus_tendero:getPlayerInventory', function(inventory)

  local elements = {}

  for i=1, #inventory.items, 1 do
    local item = inventory.items[i]

    if item.count > 0 then
      table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name})
    end
  end

  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
      title    = _U('inventory'),
      align    = 'bottom-right',
      elements = elements
    }, function(data, menu)

      local itemName = data.current.value

      ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
          title = _U('quantity')
        }, function(data2, menu2)

          local count = tonumber(data2.value)

          if count == nil then
            ESX.ShowNotification(_U('invalid_quantity'))
          else
            menu2.close()
            menu.close()
            OpenPutStocksMenuNorte()

            TriggerServerEvent('esx_yisus_tendero:putStockItemsNorte', itemName, count)
          end
        end, function(data2, menu2)
          menu2.close()
        end)
    end, function(data, menu)
      menu.close()
    end)
end)
end

function OpenPutStocksMenuJefe()
  ESX.TriggerServerCallback('esx_yisus_tendero:getPlayerInventory', function(inventory)

  local elements = {}

  for i=1, #inventory.items, 1 do
    local item = inventory.items[i]

    if item.count > 0 then
      table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name})
    end
  end

  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
      title    = _U('inventory'),
      align    = 'bottom-right',
      elements = elements
    }, function(data, menu)

      local itemName = data.current.value

      ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
          title = _U('quantity')
        }, function(data2, menu2)

          local count = tonumber(data2.value)

          if count == nil then
            ESX.ShowNotification(_U('invalid_quantity'))
          else
            menu2.close()
            menu.close()
            OpenPutStocksMenuJefe()

            TriggerServerEvent('esx_yisus_tendero:putStockItemsJefe', itemName, count)
          end
        end, function(data2, menu2)
          menu2.close()
        end)
    end, function(data, menu)
      menu.close()
    end)
end)
end

function OpenShopMenu(zone)
  local elements = {}

  for i=1, #Config.Zones[zone].Items, 1 do
      local item = Config.Zones[zone].Items[i]

      table.insert(elements, {
          label = item.label .. ' - <span style="color:red;">$' .. item.price .. ' </span>',
          realLabel = item.label,
          name = item.name,
          price = item.price,
      })
  end

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'tendero_shop', {
          title    = _U('shop'),
          align    = 'bottom-right',
          elements = elements
      }, function(data, menu)
          TriggerServerEvent('esx_yisus_tendero:buyItem', data.current.name, data.current.price, data.current.realLabel)
      end, function(data, menu)
          menu.close()
      end)
end

function animsAction(animObj)
    Citizen.CreateThread(function()
        if not playAnim then
            local playerPed = GetPlayerPed(-1);
            if DoesEntityExist(playerPed) then
                dataAnim = animObj

                RequestAnimDict(dataAnim.lib)
                while not HasAnimDictLoaded(dataAnim.lib) do
                    Citizen.Wait(0)
                end
                if HasAnimDictLoaded(dataAnim.lib) then
                    local flag = 0
                    if dataAnim.loop ~= nil and dataAnim.loop then
                        flag = 1
                    elseif dataAnim.move ~= nil and dataAnim.move then
                        flag = 49
                    end

                    TaskPlayAnim(playerPed, dataAnim.lib, dataAnim.anim, 8.0, -8.0, -1, flag, 0, 0, 0, 0)
                    playAnimation = true
                end

                while true do
                    Citizen.Wait(0)
                    if not IsEntityPlayingAnim(playerPed, dataAnim.lib, dataAnim.anim, 3) then
                        playAnim = false
                        TriggerEvent('ft_animation:ClFinish')
                        break
                    end
                end
            end
        end
    end)
end

AddEventHandler('esx_yisus_tendero:hasEnteredMarker', function(zone)
    if zone == 'BossActions' or zone == 'BossActions2' and PlayerData.job.grade_name == 'boss' then
      CurrentAction     = 'menu_boss_actions'
      CurrentActionMsg  = _U('open_bossmenu')
      CurrentActionData = {}
    end

    if zone == 'Cloakroom' or zone == 'Cloakroom2'  then
      CurrentAction     = 'menu_cloakroom'
      CurrentActionMsg  = _U('open_cloackroom')
      CurrentActionData = {}
    end

    if zone == 'Vaults' then
      CurrentAction     = 'menu_vault'
      CurrentActionMsg  = _U('open_vault')
      CurrentActionData = {}
    end

    if zone == 'VaultsNorte' then
      CurrentAction     = 'menu_vaultNorte'
      CurrentActionMsg  = _U('open_vault')
      CurrentActionData = {}
    end

    if zone == 'VaultJefe' or zone == 'VaultJefeNorte' then
      if PlayerData.job.grade_name == 'boss' and PlayerData.job.name == 'tendero' then
        CurrentAction     = 'menu_vaultJefe'
        CurrentActionMsg  = _U('open_vault')
        CurrentActionData = {}
      else
        exports['mythic_notify']:SendAlert('error', 'Este alijo tiene otra llave, habla con tu jefe.')
      end
    end

   if zone == 'Tienda' or zone == 'Tienda2' then
      CurrentAction     = 'menu_shop'
      CurrentActionMsg  = _U('shop_menu')
      CurrentActionData = {zone = zone}
    end
end)

AddEventHandler('esx_yisus_tendero:hasExitedMarker', function(zone)
    CurrentAction = nil
    ESX.UI.Menu.CloseAll()
end)

Citizen.CreateThread(function()
    local blipMarker = Config.Blips.Blip
    local blipCoord = AddBlipForCoord(blipMarker.Pos.x, blipMarker.Pos.y, blipMarker.Pos.z)

    SetBlipSprite (blipCoord, blipMarker.Sprite)
    SetBlipDisplay(blipCoord, blipMarker.Display)
    SetBlipScale  (blipCoord, blipMarker.Scale)
    SetBlipColour (blipCoord, blipMarker.Colour)
    SetBlipAsShortRange(blipCoord, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('BaduBar')
    EndTextCommandSetBlipName(blipCoord)

  local blipMarker2 = Config.Blips.Blip2
  local blipCoord2 = AddBlipForCoord(blipMarker2.Pos.x, blipMarker2.Pos.y, blipMarker2.Pos.z)

  SetBlipSprite (blipCoord2, blipMarker2.Sprite)
  SetBlipDisplay(blipCoord2, blipMarker2.Display)
  SetBlipScale  (blipCoord2, blipMarker2.Scale)
  SetBlipColour (blipCoord2, blipMarker2.Colour)
  SetBlipAsShortRange(blipCoord2, true)

  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('CompraYaya')
  EndTextCommandSetBlipName(blipCoord2)
end)

Citizen.CreateThread(function()
    while true do

        Wait(0)
        if PlayerData.job ~= nil and PlayerData.job.name == 'tendero' then

            local coords = GetEntityCoords(GetPlayerPed(-1))

            for k,v in pairs(Config.Zones) do
                if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
                    DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, false, 2, false, false, false, false)
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do

        Wait(0)
        if PlayerData.job ~= nil and PlayerData.job.name == 'tendero' then
            local coords      = GetEntityCoords(GetPlayerPed(-1))
            local isInMarker  = false
            local currentZone = nil

            for k,v in pairs(Config.Zones) do
                if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
                    isInMarker  = true
                    currentZone = k
                end
            end

            if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
                HasAlreadyEnteredMarker = true
                LastZone                = currentZone
                TriggerEvent('esx_yisus_tendero:hasEnteredMarker', currentZone)
            end

            if not isInMarker and HasAlreadyEnteredMarker then
                HasAlreadyEnteredMarker = false
                TriggerEvent('esx_yisus_tendero:hasExitedMarker', LastZone)
            end
        end
    end
end)

Citizen.CreateThread(function()
  while true do

    Citizen.Wait(0)

    if CurrentAction ~= nil then
      SetTextComponentFormat('STRING')
      AddTextComponentString(CurrentActionMsg)
      DisplayHelpTextFromStringLabel(0, 0, 1, -1)

      if IsControlJustReleased(0,  38) and PlayerData.job ~= nil and PlayerData.job.name == 'tendero' then

        if CurrentAction == 'menu_cloakroom' then
            OpenCloakroomMenu()
        end

        if CurrentAction == 'menu_vault' then
            OpenVaultMenu()
        end
        
        if CurrentAction == 'menu_vaultNorte' then
            OpenVaultMenuNorte()
        end

        if CurrentAction == 'menu_vaultJefe' then
          OpenVaultMenuJefe()
        end

        if CurrentAction == 'menu_shop' then
            OpenShopMenu(CurrentActionData.zone)
        end

        if CurrentAction == 'menu_boss_actions' and PlayerData.job.grade_name == 'boss' and PlayerData.job.name == 'tendero' then
          local options = {
            wash = Config.EnableMoneyWash,
          }

          ESX.UI.Menu.CloseAll()

          TriggerEvent('esx_society:openBossMenu', 'tendero', function(data, menu)

            menu.close()
            CurrentAction = 'menu_boss_actions'
            CurrentActionMsg = _U('open_bossmenu')
            CurrentActionData = {}
          end,options)
        end

        CurrentAction = nil
      end
    end

    if IsControlJustReleased(0,  167) and PlayerData.job ~= nil and PlayerData.job.name == 'tendero' and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'tendero_actions') then
        OpenSocietyActionsMenu()
    end
  end
end)
