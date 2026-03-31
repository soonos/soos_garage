# WIP!!! soos_garage
Simple Fivem Garrage script for the ESX Framework with job and type sorting mechanism




How to install the garage:

    Database:

        1. If you allready have data in your owned_vehicles table and you   dont want to loose it    BACKUP IT!
        2. Drop the old owned_vehicles table
        3. Insert the soos_garage.sql into your database
        4. Reinsert the data from step 1 if necessary

    Script:
    
        1. Drop the soos_garage folder into its desired location
        2. add "ensure soos_garage" to your server.cfg
        3. Edit the Config.lua to your preferences


Config walkthrough:

    Locale: 

        Chose the translation of the UI elements. German ('de') and Englisch ('en') are already done. If you need a custom Translation you can use the custom.lua file in the locales folder. Put 'costom' in the config. (I´d recommend to translate the english version to get an understanding for what the things stand for)

    UseAdminCommands:

        If you want to enable a couple of commands for players with the "garage.admin" Ace allowed. What the command does stands already in the chat. The commands are : /setplate, /givecar, /getcar, /updatestored, /deletecar, /setallstored and /setehealth

    Garageblip:

        The Map blip for the garrage. (https://docs.fivem.net/docs/game-references/blips/)

    DrawDistance:

        The maximum Distance you´ll have to have to the marker in order to see it.

    useinsurance:

        If you want that the player has to pay Insurance for their cars.

    Costpercar:

        Only in use if useinsurance is turned on! The cost per car that the player is charged with

    Costintervall:

        How long it takes to charge the player for the car insurance in Minutes.

    Insurance:

        The place where the player can manage their cars and insure / uninsure them

    insuranceblip:

        The blip for the Insurance Management place. (https://docs.fivem.net/docs/game-references/blips/)

    repaircost:

        The Ammount the player has to pay for every % of damage when they park their vehicle in damaged.

    ImpoundPos:

    ImpoundSpawn:

    ImpoundFee:

    impoundblip:

    ImpoundCss:

    InsuranceCss:

    webhook_url:

    webhook_image:

    soos_impound_name:


    Garages:

