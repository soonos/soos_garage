Citizen.CreateThread(function ()
    while Config.useinsurance do
        Wait(Config.Costintervall * 60000)
        local xPlayers = ESX.GetExtendedPlayers()
        for _, xPlayer in pairs(xPlayers) do
            MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND insured = 1 AND job = "civ"', {
                ['@owner'] = xPlayer.identifier
            }, function(result)
                if result[1] then
                    local cost = Config.Costpercar * #result
                    xPlayer.removeAccountMoney('bank', cost)
                    TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('insurance_menu'), '', _U('insurance_paid1') .. " ~g~" .. cost .. _U('$') .. " ~w~" .. _U('insurance_paid2'), 'CHAR_BANK_MAZE', 0)
                end
            end)
        end
    end
end)