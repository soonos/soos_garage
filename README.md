# 🚧 soos_garage (WIP)

A simple FiveM garage script for the ESX framework, featuring job-based and vehicle-type sorting.

---

## 📦 Installation

### 🗄️ Database Setup

> ⚠️ **Important:** If you already have data in your `owned_vehicles` table and don’t want to lose it, make a backup first.

1. Backup your existing `owned_vehicles` table
2. Drop the old `owned_vehicles` table
3. Import `soos_garage.sql` into your database
4. Restore your data (if necessary)

---

### 📁 Script Installation

1. Place the `soos_garage` folder into your resources directory
2. Add the following line to your `server.cfg`:
ensure soos_garage
3. Configure the script by editing `Config.lua`

---

## ⚙️ Configuration Guide

### 🌍 General Settings

- **Locale**  
Choose the language for UI elements.  
Available: `de` (German), `en` (English)  
Custom translations can be added via `locales/custom.lua`.  
Set `Locale = 'custom'` in the config to use it.

---

- **UseAdminCommands**  
Enables admin commands for users with the `garage.admin` ACE permission.

Available commands:
/setplate
/givecar
/getcar
/updatestored
/deletecar
/setallstored
/setehealth


---

- **GarageBlip**  
Map blip configuration for garages.  
👉 https://docs.fivem.net/docs/game-references/blips/

- **DrawDistance**  
Maximum distance at which markers are visible.

---

### 🚗 Insurance System

- **useinsurance**  
Enable or disable vehicle insurance.

- **Costpercar**  
Cost per vehicle (only used if insurance is enabled).

- **Costintervall**  
Time interval (in minutes) between insurance charges.

- **Insurance**  
Location where players can manage their insurance.

- **insuranceblip**  
Map blip for the insurance location.  
👉 https://docs.fivem.net/docs/game-references/blips/

---

### 🔧 Repair System

- **repaircost**  
Cost per 1% of vehicle damage when storing a damaged vehicle.

---

### 🚓 Impound System

- **ImpoundPos**  
Location where players can retrieve their vehicles.

- **ImpoundSpawn**  
Spawn location for retrieved vehicles.

- **ImpoundFee**  
Fee required to retrieve a vehicle.

- **impoundblip**  
Map blip for the impound location.  
👉 https://docs.fivem.net/docs/game-references/blips/

- **ImpoundCss**  
CSS styling for the impound menu.

---

### 🎨 UI Customization

- **InsuranceCss**  
CSS styling for the insurance menu.

---

### 📡 Logging

- **webhook_url**  
Discord webhook URL for logging.

- **webhook_image**  
Image/avatar used for the Discord bot.

---

### 🔗 Dependencies

- **soos_impound_name**  
Name of the `soos_impound` resource  
*(GitHub link coming soon)*

---

## 🅿️ Garage Configuration

Each garage entry supports the following options:

- **name**  
Display name of the garage (shown in the menu)

- **css**  
Custom CSS styling for the garage menu

- **location**  
Position of the garage interaction point

- **spawnpoint**  
Vehicle spawn location

- **delete**  
Parking/vehicle storage point

- **job**  
Job restriction (use `"civ"` for public access)

- **marker**  
Marker type used for the garage  
👉 https://docs.fivem.net/docs/game-references/markers/

- **type**  
Vehicle type supported by this garage

---

## 📝 Notes

- This project is still a **Work in Progress**
- Expect changes and possible breaking updates
- Contributions and feedback are welcome!

---