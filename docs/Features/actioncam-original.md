# Feature: ActionCam (Original)

Status: Implemented
Owner: robinsch (original), freadblangks (fork)
Created: 2025-12-18
Links: [Original Reddit Post](https://www.reddit.com/r/wowservers/comments/ActionCam)

---

## Purpose

Bring the retail WoW "Action Camera" experience to WoW 3.3.5a clients. Provides dynamic camera behavior that focuses on targets, adjusts camera angle/height during gameplay, and creates a more cinematic/action-game feel.

---

## Scope

### In scope

- Camera angle adjustment (left/right offset)
- Camera distance control
- Camera height (Z-axis) adjustment
- Camera pitch limits (floor/ceiling)
- Camera turn speed when focusing targets
- Target focus (enemies and interactables)
- Head bobbing effect

### Out of scope

- Combat-specific camera modes
- Vehicle camera support
- Cinematic recording

---

## Business Rules

- ActionCam CVars are NOT native to WoW 3.3.5a — they must be injected via DLL
- Settings persist across sessions via SavedVariables
- User can reset to defaults at any time
- Camera changes should be smooth, not jarring

---

## User Flows

### Primary flows

1. **Installation**
   - Actor: User
   - Trigger: Wants ActionCam
   - Steps:
     1. Move Patcher.exe to WoW folder, run it
     2. Move Extensions.dll to WoW folder
     3. Move ActionCam folder to Interface/AddOns
   - Result: Addon available in-game

2. **Configuration**
   - Actor: User
   - Trigger: ESC → Interface → AddOns → ActionCam
   - Steps:
     1. Toggle "Enable Action Camera"
     2. Adjust sliders for angle, distance, height, pitch, turn speed
     3. Toggle focus options (enemy, interact)
     4. Toggle head bob
   - Result: Camera behavior changes immediately

3. **Reset to defaults**
   - Actor: User
   - Trigger: Click "Reset" button
   - Steps: All settings revert to coded defaults
   - Result: Default camera behavior

### Edge cases

- Addon loaded without DLL → Sliders adjust but no visual effect (CVars don't exist)
- Addon loaded without patcher → Same as above
- DLL loaded, settings corrupted → Defaults used

---

## System Behaviour

- Entry points: Interface Options Panel, SavedVariables load on ADDON_LOADED
- Reads from: SavedVariables (`ActionCamOptionsDB`), CVars
- Writes to: SavedVariables, CVars (via SetCVar)
- Side effects: Camera movement, focus behavior
- Error handling: Uses default values if SavedVariables corrupted
- Performance: Minimal (settings UI only, DLL handles camera)

---

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                      WoW 3.3.5a Client                      │
│  ┌─────────────────────────────────────────────────────┐    │
│  │                    Extensions.dll                    │    │
│  │  - Injects custom CVars into client                 │    │
│  │  - Hooks camera functions                           │    │
│  │  - Implements ActionCam behavior                    │    │
│  └─────────────────────────────────────────────────────┘    │
│                            ▲                                │
│                            │ SetCVar / GetCVar              │
│                            ▼                                │
│  ┌─────────────────────────────────────────────────────┐    │
│  │                   ActionCam Addon                    │    │
│  │  - ActionCam.lua: Settings management               │    │
│  │  - ActionCam.xml: Interface Options UI              │    │
│  │  - ActionCam.toc: Addon manifest                    │    │
│  └─────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────┘
          ▲
          │ Patcher.exe modifies Wow.exe to:
          │ - Enable DLL loading
          │ - Possibly other patches
          ▼
┌─────────────────────────────────────────────────────────────┐
│                       Patcher.exe                           │
│  - Patches Wow.exe binary                                   │
│  - Enables Extensions.dll loading                           │
│  - CAUSES TIME BUG (corrupts time system)                   │
└─────────────────────────────────────────────────────────────┘
```

---

## CVars Implemented

| CVar | Default | Range | Purpose |
|------|---------|-------|---------|
| cameraActionAngle | 4.0 | 0.0 - 6.0 | Camera horizontal offset |
| cameraActionDist | 1.25 | 0.25 - 2.0 | Camera distance multiplier |
| cameraActionZ | 0.05 | -1.25 - 0.75 | Camera height offset |
| cameraActionMaxPitch | 0.20 | 0.0 - 1.55 | Floor pitch limit |
| cameraActionMinPitch | -0.05 | -1.55 - 0.0 | Ceiling pitch limit |
| cameraTargetFocusTurnSpeed | 3.15 | 0.5 - 16.5 | Turn speed for focus |
| cameraTargetFocusInteractEnable | 0 | 0/1 | Focus on interact targets |
| cameraTargetFocusEnemyEnable | 1 | 0/1 | Focus on enemy targets |
| cameraActionHeadBobs | 0 | 0/1 | Head bobbing effect |

---

## Known Issues

1. **Windows Defender flags as virus** - DLL injection triggers security software
2. **Server detection** - Some servers detect memory modification, disconnect users
3. **Time cycle broken** - Patcher corrupts time system, always night
4. **Complex installation** - 3 separate steps required
5. **Pitch sliders non-functional without DLL** - The Lua addon code exists but CVars don't

---

## Verification

### Test environment

- Environment: WoW 3.3.5a client + private server
- Data: Fresh AddOns folder
- Dependencies: Patcher.exe, Extensions.dll, ActionCam addon

### Test flows

**Positive scenarios**

| ID | Description | Level | Expected result | Steps |
| --- | --- | --- | --- | --- |
| POS-001 | Enable ActionCam | Manual | Camera behavior changes | Toggle checkbox, observe camera |
| POS-002 | Adjust camera angle | Manual | Camera moves left/right | Move slider, observe camera offset |
| POS-003 | Adjust camera height | Manual | Camera moves up/down | Move slider, observe camera height |
| POS-004 | Focus on enemy | Manual | Camera turns toward target | Target enemy, observe camera rotation |
| POS-005 | Settings persist | Manual | Settings saved | Adjust, logout, login, check values |

**Negative scenarios**

| ID | Description | Level | Expected result | Steps |
| --- | --- | --- | --- | --- |
| NEG-001 | Run without DLL | Manual | Sliders work but no camera effect | Remove DLL, load addon, adjust sliders |
| NEG-002 | Corrupt SavedVariables | Manual | Uses defaults | Delete SavedVariables, reload |

---

## Definition of Done

- All components installed correctly
- Camera responds to slider adjustments
- Settings persist across sessions
- No Lua errors in console

---

## References

- Code: `ActionCam/ActionCam.lua`, `ActionCam/ActionCam.xml`
- External: [WoW Wiki - CVars](https://wowpedia.fandom.com/wiki/Console_variables)
