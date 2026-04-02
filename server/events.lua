RegisterNetEvent('soos_garage:checkAce')
RegisterNetEvent('soos_garage:setVehicleOwned')

if Config.webhook_url == "test" then
    Config.webhook_url = GetConvar('webhook_url_garage')
end
if Config.webhook_image == "test" then
    Config.webhook_image = GetConvar('webhook_image')
end

AddEventHandler('soos_garage:checkAce', function()
    local playerId = source
    local isAceAllowed = IsPlayerAceAllowed(playerId, 'garage.admin')
    if isAceAllowed then
        TriggerClientEvent("soos_garage:perms", playerId)
    end
end)

AddEventHandler('soos_garage:setVehicleOwned', function(playerId, plate, vehicleProps, model, job, type, model_string, sourceid)
    type = type or "car"
    job = job or "civ"
    if playerId == "me" then
        playerId = source
    end
    local xPlayer = ESX.GetPlayerFromId(playerId)
    local xPlayerSource = ESX.GetPlayerFromId(sourceid)
    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', {
        ['@plate'] = plate
    }, function(result)
        if result[1] == nil then
            MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, job, model, stored, type, insured) VALUES (@owner, @plate, @vehicle, @job, @model, @stored, @type, @insured)', {
                ['@owner']   = xPlayer.identifier,
                ['@plate']   = plate,
                ['@vehicle'] = json.encode(vehicleProps),
                ['@job']    = job,
                ['@model'] = model,
                ['@stored'] = 1,
                ['@type'] = type,
                ['@insured'] = 1
            })
            xPlayer.showNotification(_U('veh_added'))
            if Config.use_webhook then
                text = _U('vehicle_given', xPlayerSource.getName(), xPlayerSource.getIdentifier(), xPlayer.getName(), xPlayer.getIdentifier(), model_string, plate, job, type)
                PerformHttpRequest(Config.webhook_url,
                function(err, text, headers) end,
                'POST',
                json.encode({embeds={{title = "givecar", description = text , footer = {text = "©️ - Soos 2026"}, color=32768}}, avatar_url=Config.webhook_image, username=GetCurrentResourceName()}),  { ['Content-Type'] = 'application/json' })
            end
        else
            xPlayer.showNotification(_U('plate_taken'))
            TriggerClientEvent('soos_garage:delcar', playerId)
        end
    end)
end)