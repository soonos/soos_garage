
RegisterNetEvent("soos_garage:perms")
AddEventHandler("soos_garage:perms", function()
    print("" .. _U('rights'))
    RegisterCommand("setplate", function (source, args, rawCommand)
        ped = GetPlayerPed(-1)
        veh = GetVehiclePedIsIn(ped, false)
        SetVehicleNumberPlateText(veh, args[1])
    end)
    exports.chat:addSuggestion('/setplate', 'Set the license plate of the current vehicle', {
        { name="Licenseplate", help="New license plate" }
    })

    RegisterCommand("givecar", function(source, args, rawCommand)
        local ModelHash = args[2]
        if not IsModelInCdimage(ModelHash) then return end
            RequestModel(ModelHash) 
        while not HasModelLoaded(ModelHash) do
          Wait(0)
        end
        local MyPed = PlayerPedId()
        local coords = GetEntityCoords(MyPed)
        local heading = GetEntityHeading(MyPed)
        ESX.Game.SpawnVehicle(ModelHash, coords, heading, function(Vehicle) 
            SetModelAsNoLongerNeeded(ModelHash)
            TaskWarpPedIntoVehicle(MyPed, Vehicle, -1)
            if args[3] then
                SetVehicleNumberPlateText(Vehicle, args[3])
            end
            local vehicleProps = ESX.Game.GetVehicleProperties(Vehicle)
            local id = PlayerId()
            TriggerServerEvent('soos_garage:setVehicleOwned', args[1], vehicleProps.plate, vehicleProps, vehicleProps.model, args[4], args[5], args[2], GetPlayerServerId(id))
        end)
    end, false)
    exports.chat:addSuggestion('/givecar', 'Gives a vehicle to a player', {
        { name="ID", help="Player ID" },
        { name="Model", help="Vehicle model" },
        { name="Licenseplate", help="License plate (optional)" },
        { name="Jobname", help="Name of the job (optional)" },
        { name="Type", help="Type of the vehicle (optional)" }
    })

    RegisterNetEvent('soos_garage:delcar')
    AddEventHandler('soos_garage:delcar', function()
        local ped = GetPlayerPed(-1)
        local veh = GetVehiclePedIsIn(ped, false)
        ESX.Game.DeleteVehicle(veh)
    end)

    RegisterCommand("getcar", function(source, args, rawCommand)
        ESX.TriggerServerCallback('soos_garage:getcar', function(r)
            local number = 1
            if r[number] == nil then
                ESX.ShowNotification('Vehicle not found!', 'error')
            else
                local coords = GetEntityCoords(PlayerPedId())
                local vehicle = ESX.Game.SpawnVehicle(tonumber(r[number]["model"]), coords, 0.0, nil, true)
                ESX.Game.SetVehicleProperties(vehicle, json.decode(r[number]["vehicle"]))
                TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
            end
        end, args[1])
    end, false)
    exports.chat:addSuggestion('/getcar', 'Spawns given vehicle from the database', {
        { name="Licenseplate", help="License plate of the vehicle" }
    })

    RegisterCommand("updatestored", function(source, args, rawCommand)
        ESX.TriggerServerCallback('soos_garage:updatestored', nil, args[1], args[2])
    end)
    exports.chat:addSuggestion('/updatestored', 'Stores a vehicle in the garage', {
        { name="Licenseplate", help="License plate of the vehicle" },
        { name="State", help="1 = Vehicle in garage, 0 = Vehicle not in garage" }
    })

    RegisterCommand("deletecar", function(source, args, rawCommand)
        ESX.TriggerServerCallback('soos_garage:deletecar2', function(r)
        end, args[1], args[2])
    end)
    exports.chat:addSuggestion('/deletecar', 'Deletes a vehicle from the garage', {
        { name="Licenseplate", help="License plate of the vehicle" },
    })

    RegisterCommand("setallstored", function(source, args, rawCommand)
        ESX.TriggerServerCallback('soos_garage:setallstored', nil, args[1])
    end)
    exports.chat:addSuggestion('/setallstored', 'Sets all vehicles of a player in the garage', {
        { name="ID", help="Player ID" }
    })

    RegisterCommand('setehealth', function(source, args, rawCommand)
        local ped = GetPlayerPed(-1)
        local veh = GetVehiclePedIsIn(ped, false)
        local a = tonumber(args[1])
        a = a + 0.1
        a = a - 0.1
        SetVehicleEngineHealth(veh, a)
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
        ESX.ShowNotification("Engine health set to " .. vehicleProps.engineHealth .. "!", 'success')
    end)
    exports.chat:addSuggestion('/setehealth', 'Sets the engine health of a vehicle', {
        { name="Number", help="The amount of engine health to set" }
    })

    RegisterCommand('d', function (source, args, rawCommand)
        car = GetVehiclePedIsIn(GetPlayerPed(-1), false)
        SetEntityAsMissionEntity(car, true, true)
        DeleteVehicle(car)
        FreezeEntityPosition(GetPlayerPed(-1), false)
        SetEntityVisible(GetPlayerPed(-1), true)
    end)
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
    reloadblips()
end)