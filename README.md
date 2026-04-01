# soos_garage

A lightweight and configurable garage system for FiveM using the ESX framework.  
Supports job-based access control, vehicle-type filtering, and optional insurance mechanics.

> ⚠️ This resource is currently **Work in Progress (WIP)**. Expect updates and possible breaking changes.

---

## ✨ Features

- Job-restricted garages
- Vehicle type filtering (cars, boats, etc.)
- Integrated insurance system (optional)
- Impound system with retrieval fees
- Damage-based repair cost on vehicle storage
- Admin commands (ACE-permission based)
- Customizable UI (CSS per menu)
- Discord logging via webhook
- Multi-language support (EN/DE + custom)

---

## 📋 Requirements

- ESX Framework
- MySQL database (compatible with `owned_vehicles` table structure)

---

## 📦 Installation

### 1. Database Setup

> ⚠️ **Backup required if you already use `owned_vehicles`**

1. Backup your current `owned_vehicles` table  
2. Drop the existing table  
3. Import `soos_garage.sql`  
4. Restore your data if needed  

---

### 2. Resource Setup

1. Place `soos_garage` into your `resources` folder  
2. Add to your `server.cfg`:
   ```
   ensure soos_garage
   ```
3. Configure the script in `Config.lua`

---

## ⚙️ Configuration

All configuration is handled via `Config.lua`.

### 🌍 Localization

```lua
Locale = 'en' -- 'de' or 'custom'
```

- `en` → English (default)  
- `de` → German  
- `custom` → Define your own in `locales/custom.lua`  

---

### 🔐 Admin Commands

Enable with:

```lua
UseAdminCommands = true
```

Requires ACE permission: `garage.admin`

Available commands:
```
/setplate
/givecar
/getcar
/updatestored
/deletecar
/setallstored
/setehealth
```

---

### 🗺️ Blips & Markers

- `GarageBlip` → Garage map icon  
- `insuranceblip` → Insurance location  
- `impoundblip` → Impound location  

Documentation:  
https://docs.fivem.net/docs/game-references/blips/  
https://docs.fivem.net/docs/game-references/markers/

---

### 🚗 Insurance System

```lua
useinsurance = true
Costpercar = 100
Costintervall = 60
```

- Charge players periodically per insured vehicle  
- Managed via the insurance location  

---

### 🔧 Repair Costs

```lua
repaircost = 50
```

- Cost per 1% vehicle damage when storing  

---

### 🚓 Impound System

```lua
ImpoundFee = 500
```

- Retrieve lost/uninsured vehicles at a cost  
- Includes custom menu styling (`ImpoundCss`)  

---

### 🎨 UI Customization

- `InsuranceCss`  
- `ImpoundCss`  
- Garage-specific `css`  

---

### 📡 Logging

```lua
webhook_url = "YOUR_WEBHOOK"
webhook_image = "IMAGE_URL"
```

- Sends logs to Discord  

---

### 🔗 Dependency

```lua
soos_impound_name = "soos_impound"
```

> GitHub link coming soon

---

## 🅿️ Garage Configuration

Example structure:

```lua
Garages = {
    {
        name = "Central Garage",
        css = "default",
        location = vector3(x, y, z),
        spawnpoint = vector3(x, y, z),
        delete = vector3(x, y, z),
        job = "civ",
        marker = 1,
        type = "car"
    }
}
```

### Parameters

| Key          | Description |
|--------------|------------|
| `name`       | Display name in menu |
| `css`        | UI styling preset |
| `location`   | Interaction point |
| `spawnpoint` | Vehicle spawn location |
| `delete`     | Vehicle storage point |
| `job`        | Job restriction (`"civ"` = public) |
| `marker`     | Marker type |
| `type`       | Vehicle category |

---

## 🧠 Notes

- Designed for flexibility and server-specific customization  
- Database structure differs from standard ESX → migration required  
- Ensure compatibility with your existing garage/vehicle systems  

---

## ⚠️ Known Limitations

- WIP status → features may change  
- Limited documentation for advanced customization (for now)  

---

## 🤝 Contributing

Contributions, bug reports, and feature requests are welcome.  
Feel free to open an issue or submit a pull request.

---

## 📄 License

No license specified yet.