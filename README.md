# Zen Action Cam (WOTLK 3.3.5a)

![GitHub release (latest by date)](https://img.shields.io/github/v/release/Zendevve/Zen-Action-Cam-WOTLK)
![GitHub license](https://img.shields.io/github/license/Zendevve/Zen-Action-Cam-WOTLK)
![Platform](https://img.shields.io/badge/platform-WoW%203.3.5a-blue)
![Status](https://img.shields.io/badge/status-active-success)

> **Experience World of Warcraft 3.3.5a like never before.**
> Zen Action Cam is a modern, lightweight wrapper for the powerful **ConsoleXP** engine, bringing retail-like ActionCam features—including over-the-shoulder views, head tracking, and dynamic targeting—to the Wrath of the Lich King client.

![Action Cam Preview](https://github.com/Zendevve/Zen-Action-Cam-WOTLK/raw/main/docs/assets/preview.jpg)
*(Placeholder: Add a gif or screenshot here showing the over-shoulder view)*

---

## 📖 Table of Contents
- [Features](#-features)
- [Prerequisites](#-prerequisites)
- [Installation](#-installation)
- [Usage](#-usage)
- [Presets](#-presets)
- [Troubleshooting](#-troubleshooting)
- [Credits](#-credits)

---

## ✨ Features

- **Over-the-Shoulder Camera**: Shift your perspective for a more immersive, RPG-like experience.
- **Dynamic Targeting**: Automatically focuses and tracks your target.
- **Head Tracking**: Camera subtly follows your character's head movement.
- **Zero-Config Presets**: Switch instantly between playstyles (Souls-like, Cinematic, etc.).
- **Lightweight UI**: Simple, native Blizzard configuration panel.
- **Stable**: Runs on the robust ConsoleXP engine (no time bugs, no crashes).

---

## 🛠 Prerequisites

This addon requires the **ConsoleXP** engine to function. The engine provides the low-level camera hooks that the 3.3.5a client lacks.

1.  **Download ConsoleXP Binaries**:
    - Go to [ConsoleXP Releases](https://github.com/leoaviana/ConsoleXP/releases).
    - Download the latest `ConsoleXP-vX.X.X.zip`.
2.  **Extract to WoW Root**:
    - Place `ConsoleXP.dll` and `ConsoleXPPatcher.exe` in the same folder as your `Wow.exe`.
3.  **Patch Client**:
    - Run `ConsoleXPPatcher.exe` **once**. This modifies `Wow.exe` in-memory to allow loading the custom DLL.

---

## 🚀 Installation

1.  **Download the Release**:
    - Go to the [Releases](https://github.com/Zendevve/Zen-Action-Cam-WOTLK/releases) page of this repository.
    - Download `ZenActionCam-vX.X.X.zip`.
2.  **Install Addons**:
    - Extract the contents to your `Interface/AddOns/` folder.
    - You should have two new folders:
        - `ZenActionCam` (The manager)
        - `ConsoleXP` (The engine interface)
3.  **Launch WoW**:
    - Open the game using your patched `Wow.exe`.
    - Ensure "Zen Action Cam" is enabled in the AddOn list.

---

## 🎮 Usage

You can control the camera using slash commands or the interface options.

### Slash Commands
```bash
/zac config       # Open the configuration GUI
/zac preset list  # List available presets
/zac help         # Show all commands
```

### Configuration Panel
Go to **Interface Options > AddOns > Zen Action Cam** to verify settings and adjust sliders manually.

---

## 🎨 Presets

| Preset | Description | Best For |
| :--- | :--- | :--- |
| **Standard** | Default WoW behavior. No offsets. | Raiding, Purists |
| **Action RPG** | **(Recommended)** Right-shoulder offset, enemy focus enabled. | Leveling, Questing |
| **Close Quarters** | Tight zoom, higher FOV, heavy head bob. | Immersion, Cities |
| **Cinematic** | Extreme offset, smooth tracking, no UI. | Machinima, Screenshots |

---

## ❓ Troubleshooting

**Q: I get a "ConsoleXP DLL not loaded" error.**
A: You likely didn't run the `ConsoleXPPatcher.exe` or didn't place the DLL in the WoW root folder.

**Q: My camera is spinning!**
A: Disable any other camera addons (like the original ActionCam or DynamicCam) as they may conflict.

**Q: Does this work on Warmane/ChromieCraft/Ascension?**
A: Generally yes, but strict anti-cheat (Warden) on some servers *might* flag the DLL. Use at your own risk on custom launchers.

---

## 🏆 Credits

- **[ConsoleXP](https://github.com/leoaviana/ConsoleXP)** by Leo Aviana - The incredible engine that makes this possible.
- **Original ActionCam** by freakingblangks - The inspiration for the simplified UI.
- **[DynamicCamLK](https://github.com/leoaviana/DynamicCamLK)** - For the preset logic structure.

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
