Citizen.CreateThread(function ()
    if Config.useAdminCommands then
        TriggerServerEvent("soos_garage:checkAce")
    end
    for a, b in ipairs(Config.Garages) do
        if b.job == "civ" then
            local blip = AddBlipForCoord(b.location.x, b.location.y, b.location.z)
            SetBlipSprite(blip, Config.garageblip)
            SetBlipDisplay(blip, 3)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(b.name)
            EndTextCommandSetBlipName(blip)
        end
    end
    reloadblips()
    local blip = AddBlipForCoord(Config.Insurance.x, Config.Insurance.y, Config.Insurance.z)
    SetBlipSprite(blip, Config.insuranceblip)
    SetBlipDisplay(blip, 3)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(_U('insurance_blip'))
    EndTextCommandSetBlipName(blip)
    local blip = AddBlipForCoord(Config.ImpoundPos.x, Config.ImpoundPos.y, Config.ImpoundPos.z)
    SetBlipSprite(blip, Config.impoundblip)
    SetBlipDisplay(blip, 3)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(_U('impound_blip'))
    EndTextCommandSetBlipName(blip)
end)

Citizen.CreateThread(function()
    while true do
        local Sleep = 2000
        local coords = GetEntityCoords(GetPlayerPed(-1))
        for key, value in pairs(Config.Garages) do
            Sleep = 300
		    	for k, v in pairs(Config.Garages) do
                    if ESX.PlayerData.job and ESX.PlayerData.job.name == v.job or ESX.PlayerData.job and v.job == "civ" then
		    		    if (#(coords - vector3(v.location.x, v.location.y, v.location.z)) < Config.DrawDistance) then
                            Sleep = 0
		    		    	DrawMarker(36, v.location.x, v.location.y, v.location.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 50, 50, 204, 100, false, true, 2, false, false, false, false)
                            letSleep = false
		    		    end
		    		    if (#(coords - vector3(v.delete.x, v.delete.y, v.delete.z)) < Config.DrawDistance) then
                            Sleep = 0
		    		    	DrawMarker(20, v.delete.x, v.delete.y, v.delete.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.5, 2.5, 2.5, 50, 50, 50, 100, false, true, 2, false, false, false, false)
                            letSleep = false
		    		    end
                        if v.ImpoundPos == nil then
                            v.ImpoundPos = Config.ImpoundPos
                        end
                        if (#(coords - v.ImpoundPos) < Config.DrawDistance) then
                            Sleep = 0
    		    	        DrawMarker(36, v.ImpoundPos.x, v.ImpoundPos.y, v.ImpoundPos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 237, 240, 41, 100, false, true, 2, false, false, false, false)
                        end
                        if v.Insurance == nil then
                            v.Insurance = Config.Insurance
                        end
                        if (#(coords - v.Insurance) < Config.DrawDistance) then
                            Sleep = 0
    		    	        DrawMarker(36, v.Insurance.x, v.Insurance.y, v.Insurance.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 237, 240, 41, 100, false, true, 2, false, false, false, false)
                        end
                    end
		    	end
            Wait(Sleep)
        end
    end
end)

CreateThread(function()
	while true do
		local Sleep = 500
        for key, value in pairs(Config.Garages) do
		    local coords = GetEntityCoords(PlayerPedId())
		    local isInMarker = false
		    currentZone = nil
            for k, v in pairs(Config.Garages ) do
                if ESX.PlayerData.job and ESX.PlayerData.job.name == v.job or v.job == "civ" then
                    if (#(coords - v.location) < 1.0) then
                        Sleep = 0
                        isInMarker = true
                        this_Garage = v
                        currentZone = 'spawn'
                        CurrentActionMsg = _U('ActionMsg_spawn')
                    end
                    if (#(coords - v.delete) < 2.5) then
                        Sleep = 0
                        isInMarker = true
                        this_Garage = v
                        currentZone = 'delete'
                        CurrentActionMsg = _U('ActionMsg_delete')
                    end
                    if v.ImpoundPos == nil then
                        v.ImpoundPos = Config.ImpoundPos
                    end
                    if (#(coords - v.ImpoundPos) < 1.0) then
                        Sleep = 0
                        isInMarker = true
                        this_Garage = v
                        currentZone = 'insurance'
                        CurrentActionMsg = _U('ActionMsg_insurance')
                    end
                    if v.Insurance == nil then
                        v.Insurance = Config.Insurance
                    end
                    if (#(coords - v.Insurance) < 1.0) then
                        Sleep = 0
                        isInMarker = true
                        this_Garage = v
                        currentZone = 'insurance_setup'
                        CurrentActionMsg = _U('ActionMsg_insurance_setup')
                    end
                end
            end
        end
    if currentZone == nil then
        local myMenu = ESX.UI.Menu.GetOpened('default', GetCurrentResourceName(), 'garage_spawn')
        if myMenu then
            myMenu.close()
        end
    end
	Wait(Sleep)
	end
end)

Citizen.CreateThread(function()
    while true do
    local sleep = 500
        if currentZone then
            sleep = 0
            SetTextComponentFormat('STRING')
            AddTextComponentString(CurrentActionMsg)
            DisplayHelpTextFromStringLabel(0, 0, 1, -1)
            if IsControlJustReleased(0, 38) then
                if currentZone == 'insurance' then
                    OpenMenuGarage('insurance')
                end

                if currentZone == 'spawn' then
                    OpenMenuGarage('spawn')
                end

                if currentZone == 'delete' then
                    OpenMenuGarage('delete')
                end
                if currentZone == 'insurance_setup' then
                    OpenMenuGarage('insurance_setup')
                end

                CurrentAction = nil
            end
        end
        Wait(sleep)
    end
end)