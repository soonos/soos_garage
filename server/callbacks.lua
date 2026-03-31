ESX.RegisterServerCallback('soos_garage:storecarcheck', function(source, cb, vehicleProps, job)
    local xPlayer = ESX.GetPlayerFromId(source)
    local a = MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', {
        ['@plate'] = vehicleProps.plate
    }, function(result)
        if result[1] and result[1].owner == xPlayer.identifier then
            if job == result[1].job then
                cb(1)
            else
                cb(2)
            end
        else
            cb(0)
        end
    end)
end)

ESX.RegisterServerCallback('soos_garage:storecar', function(source, cb, vehicleProps, pay)
    vehicleProps.engineHealth = 1000.0
    local xPlayer = ESX.GetPlayerFromId(source)
    if pay > 0 then
        if xPlayer.getAccount('bank').money >= pay then
            xPlayer.removeAccountMoney('bank', pay)
            cb(1)
        else
            cb(0)
        end
    end
 end)

ESX.RegisterServerCallback('soos_garage:storecar2', function(source, cb, vehicleProps, pay)
    MySQL.Async.execute('UPDATE owned_vehicles SET stored = 1 WHERE plate = @plate', {
        ['@plate'] = vehicleProps.plate
    })
    MySQL.Async.execute('UPDATE owned_vehicles SET vehicle = @vehicle WHERE plate = @plate', {
        ['@vehicle'] = json.encode(vehicleProps),
        ['@plate'] = vehicleProps.plate
    })
end)

ESX.RegisterServerCallback('soos_garage:getcar', function(source, cb, plate)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', {
        ['@plate'] = plate
    }, function(result)
        cb(result)
    end)
end)

ESX.RegisterServerCallback('soos_garage:updatestored', function(source, cb, plate, state)
    local xPlayer = ESX.GetPlayerFromId(source)
    local state2 = tonumber(state) or 0
    MySQL.Async.execute('UPDATE owned_vehicles SET stored = @state WHERE owner = @owner AND plate = @plate', {
        ['@owner'] = xPlayer.identifier,
        ['@plate'] = plate,
        ['@state'] = state2
    })
end)

ESX.RegisterServerCallback('soos_garage:getcars', function(source, cb, job, type)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND job = @job AND type = @type', {
        ['@owner'] = xPlayer.identifier,
        ['@job'] = job,
        ['@type'] = type
    }, function(result)
        if GetResourceState(Config.soos_impound_name) == "started" then
            MySQL.Async.fetchAll('SELECT * FROM impound WHERE owner = @owner AND job = @job AND type = @type', {
                ['@owner'] = xPlayer.identifier,
                ['@job'] = job,
                ['@type'] = type
            }, function(result2)
                cb({
                    ['owned'] = result,
                    ['impound'] = result2,
                    ['os_time'] = osTimeGermany()
                })
            end)
        else
            cb({
                ['owned'] = result,
                ['impound'] = nil
            })
        end
    end)
end)

ESX.RegisterServerCallback('soos_garage:getcars2', function(source, cb, job)
    local xPlayer = ESX.GetPlayerFromId(source)
    if job == "civ" then
        MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND job = @job AND stored = 0 AND insured = 1', {
            ['@owner'] = xPlayer.identifier,
            ['@job'] = job
        }, function(result)
            cb(result)
        end)
    else
        MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND job = @job AND stored = 0', {
            ['@owner'] = xPlayer.identifier,
            ['@job'] = job
        }, function(result)
            cb(result)
        end)
    end
end)

ESX.RegisterServerCallback('soos_garage:deletecar2', function(source, cb, plate, plate2)
    local xPlayer = ESX.GetPlayerFromId(source)
    if plate2 ~= nil then
        plate = plate .. " " .. plate2
    end
    MySQL.Async.execute('DELETE FROM owned_vehicles WHERE plate = @plate', {
        ['@plate'] = plate
    }, function(result)
        text = _U('delcar', xPlayer.getName(), xPlayer.getIdentifier(), plate)
        PerformHttpRequest(Config.webhook_url,
        function(err, text, headers) end,
        'POST',
        json.encode({embeds={{title = "deletecar", description = text , footer = {text = "©️ - Soos 2026"}, color=32768}}, avatar_url=Config.webhook_image, username=GetCurrentResourceName()}),  { ['Content-Type'] = 'application/json' })
        cb(result)
    end)
end)

ESX.RegisterServerCallback('soos_garage:setallstored', function(source, cb, id)
    if not id then
        id = source
    end
    if id == "me" then
        id = source
    end
    local xPlayer = ESX.GetPlayerFromId(id)
    MySQL.Async.execute('UPDATE owned_vehicles SET stored = 1 WHERE owner = @owner', {
        ['@owner'] = xPlayer.identifier
    })
end)

ESX.RegisterServerCallback('soos_garage:updateinsurance', function(source, cb, plate, insured)
    local xPlayer = ESX.GetPlayerFromId(source)
    if insured == 1 then
        insured = 0
        cb(0)
    elseif insured == 0 then
        insured = 1
        cb(1)
    end
    MySQL.Async.execute('UPDATE owned_vehicles SET insured = @insured WHERE owner = @owner AND plate = @plate', {
        ['@owner'] = xPlayer.identifier,
        ['@plate'] = plate,
        ['@insured'] = insured
    })
end)

ESX.RegisterServerCallback('soos_garage:hasmoney', function(source, cb, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    if amount ~= 0 then
        if xPlayer.getAccount('bank').money >= amount then
            xPlayer.removeAccountMoney('bank', amount)
            cb(true)
        else
            cb(false)
        end
    else
        cb(true)
    end
 end)