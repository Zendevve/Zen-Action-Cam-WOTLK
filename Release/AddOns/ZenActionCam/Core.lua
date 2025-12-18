local addonName, addon = ...
local DAC = CreateFrame("Frame")
addon.Main = DAC

-- Defaults
local defaultPreset = "Standard"
local dbDefaults = {
    currentPreset = defaultPreset,
    debug = false
}

-- Check for ConsoleXP Presence
local function IsConsoleXPLoaded()
    -- check if a defining CVar exists
    return GetCVar("test_cameraOverShoulder") ~= nil
end

-- Print helper
local function Print(msg)
    DEFAULT_CHAT_FRAME:AddMessage("|cff00ccffZenCam:|r " .. msg)
end

-- Apply a Preset
function addon:ApplyPreset(presetName)
    local preset = addon.Presets[presetName]
    if not preset then
        Print("Preset '" .. presetName .. "' not found.")
        return
    end

    if not IsConsoleXPLoaded() then
        Print("|cffff0000Error:|r ConsoleXP DLL not loaded. Cannot apply camera settings.")
        return
    end

    local count = 0
    for cvar, value in pairs(preset.cvars) do
        -- Check if CVar exists before setting to avoid Lua errors
        if GetCVar(cvar) ~= nil then
            SetCVar(cvar, value)
            count = count + 1
        else
            if ZenActionCamDB.debug then
                Print("Debug: CVar " .. cvar .. " not found.")
            end
        end
    end

    ZenActionCamDB.currentPreset = presetName
    Print("Applied preset: |cff00ff00" .. presetName .. "|r")
end

-- Initialize
function DAC:OnEvent(event, arg1)
    if event == "ADDON_LOADED" and arg1 == addonName then
        -- Init DB
        if not ZenActionCamDB then
            ZenActionCamDB = dbDefaults
        end

        -- Check ConsoleXP
        if not IsConsoleXPLoaded() then
            Print("|cffff0000Warning:|r ConsoleXP extensions not detected.")
            Print("Please make sure you have installed the ConsoleXP Patcher and DLL.")
        else
            Print("Loaded successfully. Current preset: " .. (ZenActionCamDB.currentPreset or "Unknown"))
            -- Optionally re-apply preset on load to ensure consistency
            -- addon:ApplyPreset(ZenActionCamDB.currentPreset)
            -- (Disabled to respect manual changes, but could be enabled)
        end

        self:UnregisterEvent("ADDON_LOADED")
    end
end

DAC:RegisterEvent("ADDON_LOADED")
DAC:SetScript("OnEvent", DAC.OnEvent)

-- Slash Commands
SLASH_ZENACTIONCAM1 = "/zac"
SLASH_ZENACTIONCAM2 = "/zencam"

SlashCmdList["ZENACTIONCAM"] = function(msg)
    local cmd, arg = msg:match("^(%S*)%s*(.-)$")

    if cmd == "preset" and arg ~= "" then
        -- Attempt to find preset (case insensitive search)
        local target = nil
        for name, _ in pairs(addon.Presets) do
            if name:lower() == arg:lower() then
                target = name
                break
            end
        end

        if target then
            addon:ApplyPreset(target)
        else
            Print("Preset '" .. arg .. "' not found.")
        end

    elseif cmd == "list" then
        Print("Available Presets:")
        for name, data in pairs(addon.Presets) do
           Print("- |cff00ccff" .. name .. "|r: " .. data.description)
        end

    elseif cmd == "reset" then
        addon:ApplyPreset("Standard")

    else
        Print("Zen Action Cam Commands:")
        Print("  /zac preset <name> - Apply a camera preset")
        Print("  /zac list - List all available presets")
        Print("  /zac reset - Reset to Standard view")
    end
end
