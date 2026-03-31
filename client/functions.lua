
function OpenMenuGarage(zone)
    if zone == 'spawn' then
        local elements = {}
        ESX.UI.Menu.CloseAll()
        ESX.TriggerServerCallback('soos_garage:getcars', function(t)
            local r = t['owned']
            local b = nil
            if t['impound'] ~= nil then
                b = t['impound']
            end
            for i, j in pairs(r) do
                local state_stored
                if r[i]['stored'] == 1 or r[i]['stored'] == true then
                    state_stored = '<span style="color:green;">' .. _U('available') .. '</span>'
                else
                    state_stored = '<span style="color:red;">' .. _U('not_available') .. '</span>'
                end
                local state_insured
                if r[i]['insured'] == 1 or r[i]['insured'] == true then
                    state_insured = ' | <span style="color:green;">' .. _U('vehicle_insured') .. '</span>'
                else
                    state_insured = ' | <span style="color:red;">' .. _U('vehicle_not_insured') .. '</span>'
                end
                if this_Garage.job ~= "civ" then
                    state_insured = ''
                end
                table.insert(elements, {label = GetDisplayNameFromVehicleModel(tonumber(j['model'])) .. ' | ' .. r[i]['plate']  .. state_insured .. ' | ' ..  state_stored, value = {j['model'], j["vehicle"], r[i]['stored']}})
            end
            if b ~= nil then
                for i, j in pairs(b) do
                    local impound = '<span style="color:#1660c7">' .. b[i]['impound'] .. '</span>'
                    local time = formatDate(b[i]['time_free'] - t['os_time'])
                    local time_lable
                    if time == 0 then
                        time_lable = ' | <span style="color:green;">' .. _U('available') .. '</span>'
                    else
                        time_lable = ' | <span style="color:red;">' .. time .. '</span>'
                    end
                    table.insert(elements, {label = GetDisplayNameFromVehicleModel(tonumber(j['model'])) .. ' | ' .. j['plate'] .. ' | ' ..  impound .. ' | ' ..  time_lable, value = 'impounded'})
                end
            end
	        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'garage_spawn', {
	        	css      = this_Garage.css,
	        	title    = this_Garage.name,
	        	align    = 'top-left',
	        	elements = elements
            }, function(data, menu)
	        	if data.current.value then
                    if data.current.value[3] == 0 then
                        ESX.ShowNotification(_U('vehicle_not_available'), 'error')
                    elseif data.current.value == 'impounded' then
                        ESX.ShowNotification(_U('vehicle_impounded'), 'error')
                    else
                        local ModelHash = tonumber(data.current.value[1])
                        if not IsModelInCdimage(ModelHash) then return end
                            RequestModel(ModelHash) 
                        while not HasModelLoaded(ModelHash) do
                          Wait(0)
                        end
                        local MyPed = PlayerPedId()
                        ESX.UI.Menu.CloseAll()
                        ESX.Game.SpawnVehicle(ModelHash, this_Garage.spawnpoint, this_Garage.spawnpoint.w, function(Vehicle) 
                            SetModelAsNoLongerNeeded(ModelHash)
                            TaskWarpPedIntoVehicle(MyPed, Vehicle, -1)
                            local vehicleProps = json.decode(data.current.value[2])
                            ESX.Game.SetVehicleProperties(Vehicle, vehicleProps)
                            ESX.TriggerServerCallback('soos_garage:updatestored', nil, vehicleProps.plate)
                        end)
                    end
	        	end
	        end, function(data, menu)
	        	menu.close()
	        end)
        end, this_Garage.job, this_Garage.type)
    end

    if zone == 'delete' then
        if not IsPedInAnyVehicle(PlayerPedId(), false) then
            ESX.ShowNotification(_U('not_in_vehicle'), 'error')
        else
            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
            local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
            ESX.TriggerServerCallback('soos_garage:storecarcheck', function(r)
                if r == 1 then
                    if vehicleProps.engineHealth < 950.0 then
                        ESX.UI.Menu.CloseAll()
	                    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'garage_spawn', {
	                    	css      = this_Garage.css,
	                    	title    = _U('to_damaged') .. " " .. math.ceil(Config.repaircost * ((1000 - vehicleProps.engineHealth) / 10)).. _U('$'),
	                    	align    = 'top-left',
	                    	elements = {
                        		{label = _U('repair'), value = 'yes'},
                                {label = _U('dont_repair'), value = 'no'},
                        }}, function(data, menu)
	                    	if data.current.value then
                                if data.current.value == "no" then
                                    ESX.UI.Menu.CloseAll()
                                elseif data.current.value == "yes" then
                                    ESX.TriggerServerCallback('soos_garage:storecar', function (r)
                                        if r == 1 then
                                            local car = GetVehiclePedIsIn(PlayerPedId(), false)
	                                        SetVehicleFixed(car)
	                                        SetVehicleDirtLevel(car, 0.0)
                                            vehicleProps = ESX.Game.GetVehicleProperties(car)
                                            ESX.TriggerServerCallback('soos_garage:storecar2', nil, vehicleProps, math.ceil(0))
                                            ESX.ShowNotification(_U('vehicle_stored'), 'success')
                                            ESX.Game.DeleteVehicle(vehicle)
                                        else
                                            ESX.ShowNotification(_U('not_enough_money_repair'), 'error')
                                        end
                                    end, vehicleProps, math.ceil(Config.repaircost * ((1000 - vehicleProps.engineHealth) / 10)))
                                end
	                    	end
	                    end, function(data, menu)
	                    	menu.close()
	                    end)
                    else
                        local car = GetVehiclePedIsIn(PlayerPedId(), false)
	                    SetVehicleFixed(car)
	                    SetVehicleDirtLevel(car, 0.0)
                        vehicleProps = ESX.Game.GetVehicleProperties(car)
                        ESX.TriggerServerCallback('soos_garage:storecar2', nil, vehicleProps, math.ceil(0))
                        ESX.ShowNotification(_U('vehicle_stored'), 'success')
                        ESX.Game.DeleteVehicle(vehicle)
                    end
                elseif r == 2 then
                    ESX.ShowNotification(_U('wrong_garage'), 'error')
                else 
                    ESX.ShowNotification(_U('not_your_vehicle'), 'error')
                end
            end, vehicleProps, this_Garage.job)
        end
    end

    if zone == 'insurance' then
        local text = _U('insurance_price_info1') .. ' <span style="color:green;">' .. Config.ImpoundFee .. '&nbsp;' .. _U('insurance_price_info2') .. '</span> ' ..  _U('insurance_price_info3')
        local elements = {
            {label = text, value = 'text'}
        }
        ESX.UI.Menu.CloseAll()
        ESX.TriggerServerCallback('soos_garage:getcars2', function(r)
            for i, j in pairs(r) do
                table.insert(elements, {label = GetDisplayNameFromVehicleModel(tonumber(j['model'])) .. ' | ' .. r[i]['plate'], value = {j['model'], j["vehicle"]}})
            end
	        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'garage_spawn', {
	        	css      = Config.ImpoundCss,
	        	title    = this_Garage.name,
	        	align    = 'top-left',
	        	elements = elements
            }, function(data, menu)
	        	if data.current.value ~= 'text' then
                    ESX.TriggerServerCallback('soos_garage:hasmoney', function(cb)
                        if cb == true then
                            local ModelHash = tonumber(data.current.value[1])
                            if not IsModelInCdimage(ModelHash) then return end
                                RequestModel(ModelHash) 
                            while not HasModelLoaded(ModelHash) do
                              Wait(0)
                            end
                            local MyPed = PlayerPedId()
                            if this_Garage.ImpoundSpawn == nil then
                                this_Garage.ImpoundSpawn = Config.ImpoundSpawn
                            end
                            ESX.Game.SpawnVehicle(ModelHash, this_Garage.ImpoundSpawn, this_Garage.ImpoundSpawn.w, function(Vehicle)
                                SetModelAsNoLongerNeeded(ModelHash)
                                TaskWarpPedIntoVehicle(MyPed, Vehicle, -1)
                                ESX.UI.Menu.CloseAll()
                                local vehicleProps = json.decode(data.current.value[2])
                                ESX.Game.SetVehicleProperties(Vehicle, vehicleProps)
                                ESX.TriggerServerCallback('soos_garage:updatestored', nil, vehicleProps.plate)
                                SetVehicleFixed(Vehicle)
	                            SetVehicleDirtLevel(Vehicle, 0.0)
                            end)
                        else
                            ESX.ShowNotification(_U('not_enough_money'), 'error')
                        end
                    end, Config.ImpoundFee)
	        	end  
	        end, function(data, menu)
	        	menu.close()
	        end)
        end, this_Garage.job)
    end

    if zone == 'insurance_setup' then
        insurancemenu()
    end
end

function insurancemenu()
    local elements = {}
    ESX.UI.Menu.CloseAll()
    ESX.TriggerServerCallback('soos_garage:getcars', function(t)
        local r = t['owned']
        for i, j in pairs(r) do
            local state_insured
            if r[i]['insured'] == 1 then
                state_insured = ' | <span style="color:green;">' .. _U('vehicle_insured') .. '</span>'
            else
                state_insured = ' | <span style="color:red;">' .. _U('vehicle_not_insured') .. '</span>'
            end
            table.insert(elements, {label = GetDisplayNameFromVehicleModel(tonumber(j['model'])) .. ' | ' .. r[i]['plate']  .. state_insured, value = {j["plate"], r[i]['insured']}})
        end
	    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'garage_spawn', {
	    	css      = Config.InsuranceCss,
	    	title    = _U('insurance_menu'),
	    	align    = 'top-left',
	    	elements = elements
        }, function(data, menu)
	    	if data.current.value then
                ESX.UI.Menu.CloseAll()
                ESX.TriggerServerCallback('soos_garage:updateinsurance', function(r)
                    if r == 1 then
                        ESX.ShowNotification(_U('vehicle_insured_msg'), 'success')
                        Wait(10)
                        insurancemenu()
                    else
                        ESX.ShowNotification(_U('vehicle_not_insured_msg'), 'success')
                        Wait(10)
                        insurancemenu()
                    end
                end, data.current.value[1], data.current.value[2])
	    	end
	    end, function(data, menu)
	    	menu.close()
	    end)
    end, "civ")
end

local blips = {}

function reloadblips()
    for _, blip in ipairs(blips) do
        RemoveBlip(blip)
    end
    blips = {}
    for _, garage in ipairs(Config.Garages) do
        if ESX.PlayerData.job and ESX.PlayerData.job.name == garage.job then
            local blip = AddBlipForCoord(garage.location.x, garage.location.y, garage.location.z)
            table.insert(blips, blip)
            SetBlipSprite(blip, Config.garageblip)
            SetBlipScale(blip, 0.4)
            SetBlipDisplay(blip, 3)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(garage.name)
            EndTextCommandSetBlipName(blip)
        end
    end
end

function formatDate(timestamp)
    seconds = tonumber(timestamp) or 0
	if seconds <= 0 then return 0 end
    local h = math.floor(seconds / 3600)
    local m = math.floor((seconds % 3600) / 60)
    local s = seconds % 60
    return string.format("%02dh %02dm %02ds", h, m, s)
end