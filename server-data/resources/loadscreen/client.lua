local timer = GetGameTimer()

-- Variable to check if native has already been run
local Ran = false
local Ready = false

RegisterNUICallback(
    "loadingscreen-ready",
    function(data, cb)
        print('Video time reached')
        Ready = true
    end
)
-- Wait until client is loaded into the map
AddEventHandler("onClientMapStart", function ()
    print('Ready to load')
    print(timer)
   -- If not already ran
    while not Ran do
        Citizen.Wait(0)
        -- wait 5 seconds before starting the switch to the player
        if GetGameTimer() - timer > 15 * 1000 or Ready then
           print('loading screen done')
            DoScreenFadeOut(0)
            ShutdownLoadingScreenNui()
            Citizen.Wait(0)
            DoScreenFadeIn(500)
            Ran = true
        end
    end
end)