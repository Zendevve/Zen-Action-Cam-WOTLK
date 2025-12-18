local addonName, addon = ...
local Config = {}
addon.Config = Config

-- Create Options Panel
local panel = CreateFrame("Frame", "ZenActionCamConfig", InterfaceOptionsFramePanelContainer)
panel.name = "Zen Action Cam"
InterfaceOptions_AddCategory(panel)

-- Title
local title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
title:SetPoint("TOPLEFT", 16, -16)
title:SetText("Zen Action Cam")

local subtitle = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
subtitle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
subtitle:SetText("Select a camera behavior preset derived from ConsoleXP features.")

-- Preset Buttons Container
local yOffset = -60

local function ApplyPresetUI(name)
    addon:ApplyPreset(name)
    -- Update visual feedback if needed
end

-- Create buttons for each preset
local presetsOrder = {"Standard", "Action RPG", "Close Quarters", "Cinematic"}

for _, presetName in ipairs(presetsOrder) do
    local data = addon.Presets[presetName]

    local btn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
    btn:SetSize(120, 24)
    btn:SetPoint("TOPLEFT", 16, yOffset)
    btn:SetText(presetName)
    btn:SetScript("OnClick", function() ApplyPresetUI(presetName) end)

    local desc = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    desc:SetPoint("LEFT", btn, "RIGHT", 16, 0)
    desc:SetText(data.description)

    yOffset = yOffset - 35
end

-- Manual Sliders Section
yOffset = yOffset - 20
local manualTitle = panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
manualTitle:SetPoint("TOPLEFT", 16, yOffset)
manualTitle:SetText("Manual Adjustments")

yOffset = yOffset - 40

-- Simple Slider Factory
local function CreateSlider(parent, name, label, minVal, maxVal, step, cvar)
    local slider = CreateFrame("Slider", name, parent, "OptionsSliderTemplate")
    slider:SetHeight(17)
    slider:SetWidth(180)

    -- Label
    local text = slider:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    text:SetPoint("BOTTOM", slider, "TOP", 0, 4)
    text:SetText(label)

    slider:SetMinMaxValues(minVal, maxVal)
    slider:SetValueStep(step)
    slider:SetObeyStepOnDrag(true)

    -- Current Value Label
    local valueText = slider:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    valueText:SetPoint("TOP", slider, "BOTTOM", 0, -2)

    slider:SetScript("OnShow", function(self)
        local val = GetCVar(cvar) or 0
        self:SetValue(tonumber(val))
        valueText:SetText(string.format("%.2f", val))
    end)

    slider:SetScript("OnValueChanged", function(self, value)
        SetCVar(cvar, value)
        valueText:SetText(string.format("%.2f", value))
    end)

    return slider
end

-- Shoulder Slider
local shoulderSlider = CreateSlider(panel, "DAC_ShoulderSlide", "Shoulder Offset", -2, 2, 0.1, "test_cameraOverShoulder")
shoulderSlider:SetPoint("TOPLEFT", 16, yOffset)

-- Pitch Slider
local pitchSlider = CreateSlider(panel, "DAC_PitchSlide", "Pitch Offset", 0, 1, 0.05, "test_cameraDynamicPitchBaseFovPad")
pitchSlider:SetPoint("LEFT", shoulderSlider, "RIGHT", 40, 0)

-- Open Config Command
SLASH_ZACCONFIG1 = "/zac config"
SlashCmdList["ZACCONFIG"] = function()
    InterfaceOptionsFrame_OpenToCategory(panel)
end
