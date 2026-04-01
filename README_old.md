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

        The Position of the Place, where you can get your cars back when they are insured and not in your garrage.

    ImpoundSpawn:

        The Location the retrived Vehicle spawnes.

    ImpoundFee:

        The Fee the player has to pay to retrive their vehicle.

    impoundblip:
    
        The Map Blip for the Impound Position (https://docs.fivem.net/docs/game-references/blips/)

    ImpoundCss:

        The menu css for the Impound Menu.

    InsuranceCss:

        The menu css for the Insurance Menu.

    webhook_url:
        
        The Discord Webhook url for your logs channel.

    webhook_image:

        The immage of the Discord log bot.

    soos_impound_name:

        The name of the soos_impound resource ( github link comming )


    Garages:

        name: 
            
            The Name of the Garage (Displayed at the top of the Menu).

        css:

            The menu css of the specific garage.

        location:

            The locaion of the garage management point.

        spawnpoint:

            The Spawnpoint of the Vehicle for the current garage.

        delete:

            The Park in point for the cuttent garage.

        job:

            The job name of the garage. (leave "civ" for every job).

        marker:

            The Marker for the current garage. (https://docs.fivem.net/docs/game-references/markers/)

        type:

            The Vehicle type of the current garage.