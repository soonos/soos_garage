Config = {
    Locale = 'de',
    useAdminCommands = true,
    garageblip = 357,
	DrawDistance = 30,
    useinsurance = true,
    Costpercar = 20, -- per car insured
    Costintervall = 15, -- inrervall in minutes
    Insurance = vector3(-815.72, -1346.12, 5.13),
    insuranceblip = 475,
    repaircost = 5, -- per % of damage
    ImpoundPos = vector3(-1604.09, -832.29, 10.07),
    ImpoundSpawn = vector4(-1605.28, -823.70, 10.02, 51.02),
    ImpoundFee = 50,
    impoundblip = 68,
    ImpoundCss = 'versicherung',
    InsuranceCss = 'versicherung',
    webhook_url = "",
    webhook_image = "",
    soos_impound_name = "soos_impound",
}

Config.Garages = {
    {
        name = "Downtown Garage",
        css = 'parkplatz',
        location = vector3(213.71, -808.99, 30.99),
        spawnpoint = vector4(229.3, -806.36, 30.73, 158.0),
        delete = vector3(212.79, -796.93, 30.73),
        job = "civ",
        marker = 36,
        type = "car"
    },
    {
        name = "Vinewood Garage",
        css = 'parkplatz',
        location = vector3(-751.859314, -80.901093, 41.748779),
        spawnpoint = vector4(-746.729675, -66.329666, 41.748779, 116.22),
        delete = vector3(-733.753845, -59.841755, 41.748779),
        job = "civ",
        marker = 36,
        type = "car"
    },
    {
        name = "Paleto Garage",
        css = 'parkplatz',
        location = vector3(140.558243, 6612.949219, 32.043213),
        spawnpoint = vector4(140.835175, 6605.274902, 31.841064, 181.41),
        delete = vector3(140.835175, 6605.274902, 31.841064),
        job = "civ",
        marker = 36,
        type = "car",
    },
    {
        name = "Admin Garage",
        css = 'homeland',
        location = vector3(-283.23, -610.40, 33.52),
        spawnpoint = vector4(-282.31, -617.43, 33.15, 87.8),
        delete = vector3(-282.31, -617.43, 33.15),
        job = "admin",
        marker = 36,
        ImpoundPos = vector3(-288.81, -611.61, 33.55),
        ImpoundSpawn = vector4(-282.31, -617.43, 33.15, 87.8),
        type = "car"
    },
    {
        name = "Police Garage",
        css = 'lapd',
        location = vector3(424.74, -1016.53, 29.01),
        spawnpoint = vector4(424.10, -1019.53, 29.01, 87.8),
        delete = vector3(424.10, -1019.53, 29.01),
        job = "police",
        marker = 36,
        ImpoundPos = vector3(421.25, -1016.34, 29.09),
        ImpoundSpawn = vector4(424.10, -1019.53, 29.01, 87.8),
        type = "car"
    },
    {
        name = "Police Heli Garage",
        css = 'lapd',
        location = vector3(461.26, -982.04, 43.68),
        spawnpoint = vector4(449.74, -981.40, 43.75, 87.8),
        delete = vector3(449.74, -981.40, 43.75),
        job = "police",
        marker = 36,
        ImpoundPos = vector3(461.01, -986.61, 43.68),
        ImpoundSpawn = vector4(449.74, -981.40, 43.75, 87.8),
        type = "heli"
    },
    {
        name = "Rettungsdienst Garage",
        css = 'amr',
        location = vector3(297.125275, -601.265930, 43.298950),
        spawnpoint = vector4(293.78, -610.43, 43.13, 68.03),
        delete = vector3(293.78, -610.43, 43.13),
        job = "ambulance",
        marker = 36,
        ImpoundPos = vector3(299.367035, -602.136230, 43.332642),
        ImpoundSpawn = vector4(293.78, -610.43, 43.13, 68.03),
        type = "car"
    },
    {
        name = "Rettungsdienst Heli Garage",
        css = 'amr',
        location = vector3(341.314301, -581.802185, 74.150879),
        spawnpoint = vector4(351.309906, -588.131897, 74.250879, 255.118103),
        delete = vector3(351.309906, -588.131897, 74.150879),
        job = "ambulance",
        marker = 36,
        ImpoundPos = vector3(342.975830, -580.127441, 74.150879),
        ImpoundSpawn = vector4(351.309906, -588.131897, 74.250879, 255.118103),
        type = "heli"
    },
    {
        name = "Holzfäller Garage",
        css = 'moderation',
        location = vector3(-675.046143, 5829.270508, 17.316528),
        spawnpoint = vector4(-664.272522, 5826.158203, 17.316528, 99.212593),
        delete = vector3(-664.272522, 5826.158203, 17.316528),
        job = "lumberjack",
        marker = 36,
        ImpoundPos = vector3(-676.905518, 5831.024414, 17.316528),
        ImpoundSpawn = vector4(-664.272522, 5826.158203, 17.316528, 99.212593),
        type = "car"
    },
    {
        name = "Fischerei Garage",
        css = 'moderation',
        location = vector3(-1602.197754, -1047.573608, 13.019775),
        spawnpoint = vector4(-1608.857178, -1037.854980, 12.649048, 283.46),
        delete = vector3(-1608.857178, -1037.854980, 13.21),
        job = "fisherman",
        marker = 36,
        ImpoundPos = vector3(-1606.074707, -1045.107666, 13.070312),
        ImpoundSpawn = vector4(-1608.857178, -1037.854980, 12.649048, 283.464569),
        type = "car"
    },
    {
        name = "Reporter Garage",
        css = 'moderation',
        location = vector3(-556.971436, -942.514282, 23.820557),
        spawnpoint = vector4(-550.52, -929.07, 23.26, 257.95),
        delete = vector3(-550.52, -929.07, 23.76),
        job = "reporter",
        marker = 36,
        ImpoundPos = vector3(-560.057129, -943.041748, 23.854248),
        ImpoundSpawn = vector4(-550.52, -929.07, 23.26, 257.95),
        type = "car"
    },
    {
        name = "Reporter Heli Garage",
        css = 'moderation',
        location = vector3(-571.173645, -925.424194, 36.828613),
        spawnpoint = vector4(-583.028564, -930.527466, 36.828613, 90.708656),
        delete = vector3(-583.028564, -930.527466, 36.828613),
        job = "reporter",
        marker = 36,
        ImpoundPos = vector3(-570.975830, -930.316467, 36.828613),
        ImpoundSpawn = vector4(-583.028564, -930.527466, 36.828613, 90.708656),
        type = "heli"
    },
    {
        name = "Taxi Garage",
        css = 'moderation',
        location = vector3(902.637390, -172.773621, 74.066650),
        spawnpoint = vector4(908.492310, -176.254944, 73.780273, 235.27),
        delete = vector3(908.492310, -176.254944, 74.10273),
        job = "taxi",
        marker = 36,
        ImpoundPos = vector3(901.450562, -174.725281, 74.032959),
        ImpoundSpawn = vector4(908.492310, -176.254944, 73.780273, 235.27589),
        type = "car"
    },
    {
        name = "Mechaniker Garage",
        css = 'boost',
        location = vector3(-356.452759, -130.800003, 39.423462),
        spawnpoint = vector4(-369.217590, -108.290100, 38.665161, 70.866142),
        delete = vector3(-360.501099, -128.017578, 38.682007),
        job = "mechanic",
        marker = 36,
        ImpoundPos = vector3(-355.516479, -128.808792, 39.423462),
        ImpoundSpawn = vector4(-369.217590, -108.290100, 38.665161, 70.866142),
        type = "car"
    }
}


