# Feature: Dynamic Action Cam (ConsoleXP Wrapper)

Status: Draft
Owner: Antigravity
Created: 2025-12-18
Links: [ConsoleXP](https://github.com/leoaviana/ConsoleXP)

---

## Purpose

Provide a simple, user-friendly interface for the powerful camera features enabled by ConsoleXP. The goal is to replicate the simplicity of the original "ActionCam" addon (sliders + presets) while using the modern, stable ConsoleXP backend.

---

## Scope

### In scope

- **Preset Manager**: Single-click setup for different playstyles (e.g., "Souls-like", "Cinematic", "Default").
- **Simplified UI**: A small configuration panel exposing only the most important sliders.
- **ConsoleXP Integration**: Manages `cxp_*` and `test_*` CVars.
- **Slash Commands**: `/dac` to open capability.

### Out of scope

- Situational events (handling mounting/indoors dynamically) — leaving that to DynamicCamLK if users want it.
- Modifying the DLL itself.

---

## Business Rules

- Must fail gracefully if ConsoleXP DLL is not loaded (check for CVar existence).
- Presets should persist across sessions.
- Manual overrides should be saved.

---

## User Flows

### 1. First Load
- **Trigger**: User logs in with addon enabled.
- **System**: Checks for `test_cameraOverShoulder` CVar.
    - If missing: Prints error "ConsoleXP DLL not loaded. Please install the patcher."
    - If present: loads "Default" preset (or saved variable).

### 2. Choosing a Preset
- **Trigger**: User selects "Souls-like" from dropdown.
- **System**:
    - Sets `test_cameraOverShoulder` to `1.5`
    - Sets `test_cameraTargetFocusEnemyEnable` to `1`
    - Sets `test_cameraHeadMovementStrength` to `1`
- **Result**: Camera moves immediately to over-the-shoulder view.

### 3. Customizing
- **Trigger**: User adjusts "Shoulder Offset" slider.
- **System**: Updates `test_cameraOverShoulder` CVar in real-time.
- **Result**: Camera moves left/right.

---

## Technical Details: CVars Mapping

| Feature | ConsoleXP CVar |
|---------|----------------|
| Shoulder Offset | `test_cameraOverShoulder` |
| Pitch Offset | `test_cameraDynamicPitchBaseFovPad` |
| Target Focus (Enemy) | `test_cameraTargetFocusEnemyEnable` |
| Target Focus (Interact) | `test_cameraTargetFocusInteractEnable` |
| Head Bob Strength | `test_cameraHeadMovementStrength` |
| Action Targeting | `cxp_enableActionTarget` |
| Crosshair | `ConsoleXPSettings.enableCrosshair` (LUA) |

---

## Presets Design

### "Standard" (Blizz-like)
- Shoulder: 0
- Target Focus: Off
- Head Bob: Off

### "Action RPG" (Souls-like)
- Shoulder: 1.2 (Right side)
- Target Focus: On (Enemy)
- Pitch Offset: 0.1
- Head Bob: Low

### "Immersive"
- Shoulder: 0.5
- Target Focus: On (Enemy & Interact)
- Head Bob: High
- Action Targeting: On

---

## Verification

### Test environment

- **ConsoleXP DLL** must be injected.
- **ConsoleXP Addon** optional (we act as a standalone UI).

### Test commands

- `/dac` - Open options
- `/dac preset action` - Load Action preset
- `/dac reset` - Reset to defaults

---

## Definition of Done

- Addon loads without errors.
- Detects ConsoleXP presence.
- Applies all presets correctly.
- UI allows fine-tuning.
- Settings saved between sessions.
