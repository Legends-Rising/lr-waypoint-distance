# 🗺️ RedM Waypoint Distance Display

A simple and lightweight script for RedM that displays the distance to your waypoint in real-time under the minimap.

![RedM Version](https://img.shields.io/badge/RedM-Latest-red)
![License](https://img.shields.io/badge/license-Free-green)
![Status](https://img.shields.io/badge/status-Active-brightgreen)

## 📋 Features

- ✅ **Real-time distance display** - Shows distance to your waypoint as you move
- ✅ **Multiple distance units** - Choose between meters, kilometers, or miles
- ✅ **Clean UI** - Distance appears under the minimap in red text
- ✅ **Lightweight** - Minimal performance impact
- ✅ **Easy configuration** - Simple commands to customize
- ✅ **Always visible** - Toggle between always-on or only when aiming
- ✅ **Uses official RedM natives** - Fully compatible and stable

## 📸 Preview

The distance appears in **red text** under your minimap as you travel:

![Preview 1](https://media.discordapp.net/attachments/838115167476514819/1456067687611498686/Screenshot_2026-01-01_022449.png?ex=69570435&is=6955b2b5&hm=b16acfb90c064273ffe045c47c625ddb3ad33ab965377b5ad4fbc387b10de149&=&format=webp&quality=lossless)

![Preview 2](https://media.discordapp.net/attachments/838115167476514819/1456067688638972057/Screenshot_2026-01-01_022548.png?ex=69570435&is=6955b2b5&hm=fd02fb6b095c71234fa9afb8dbe1747588d5728b760d0d56df0db9bae66c70ed&=&format=webp&quality=lossless)

![Preview 3](https://media.discordapp.net/attachments/838115167476514819/1456067688056099021/Screenshot_2026-01-01_022516.png?ex=69570435&is=6955b2b5&hm=70bc93fb61e80740e5015106a4deb2f2fa9223063ddce915f438365db6c810e7&=&format=webp&quality=lossless)

**Distance formats:**
- Meters: `500m`
- Kilometers: `1.2km`
- Miles: `0.8mi`

## 📦 Installation

1. Download the script
2. Extract the folder to your server's `resources` directory
3. Add `ensure redm-waypoint-distance` to your `server.cfg`
4. Restart your server

## 🎮 Usage

### Basic Usage
1. Open your map (default: `M` key)
2. Set a waypoint anywhere on the map
3. Close the map - distance will appear under your minimap
4. The distance updates automatically as you move

### Commands

| Command | Description | Example |
|---------|-------------|---------|
| `/toggledistance` | Toggle distance display on/off | `/toggledistance` |
| `/distanceunit [1-3]` | Change distance unit | `/distanceunit 2` |

### Distance Units

- **1** = Meters (500m)
- **2** = Kilometers (1.2km)
- **3** = Miles (0.8mi)

## ⚙️ Configuration

Edit the `config` section in the script to customize:

```lua
local config = {
    -- Display settings
    font = 1,              -- Text font style
    scale = 0.5,           -- Text size
    posX = 0.135,          -- Horizontal position (under minimap)
    posY = 0.84,           -- Vertical position (bottom left)
    
    -- Colors (R, G, B, A)
    userWaypointColor = {255, 0, 0, 255},      -- Red
    missionWaypointColor = {255, 255, 0, 255}, -- Yellow (future use)
    
    -- Distance units: 1 = meters, 2 = kilometers, 3 = miles
    distanceUnit = 1,
    
    -- Always show distance
    alwaysShow = true      -- Set to false to only show when aiming
}
```

## 🔧 Technical Details

### Natives Used
- `0x202B1BBFC6AB5EE4` - IS_WAYPOINT_ACTIVE
- `0x29B30D07C3F7873B` - GET_WAYPOINT_COORDS
- RedM text rendering natives

### Performance
- **Client-side only** - No server load
- **Minimal draw calls** - Only renders when waypoint is active

## 🤝 Support

If you encounter any issues:
1. Make sure you're using the latest RedM version
2. Check that the script is properly loaded in your `server.cfg`
3. Verify no other scripts conflict with waypoint natives

## 📝 Changelog

### Version 1.0.0 (Initial Release)
- Real-time waypoint distance display
- Multiple distance unit support (meters, kilometers, miles)
- Toggle on/off functionality
- Clean UI under minimap
- Fully optimized for RedM

## 📄 License

This script is **completely free** to use, modify, and distribute.

- ✅ Use on any server (private or public)
- ✅ Modify as needed
- ✅ No credit required (but appreciated!)
- ✅ Share with others

## 🌟 Credits

Created with ❤️ for the RedM community

---

**Enjoy the script!** If you found it useful, consider giving it a ⭐ star!
