local addonName, addon = ...

addon.Presets = {
    ["Standard"] = {
        description = "Default WoW camera behavior. No action features.",
        cvars = {
            test_cameraOverShoulder = 0,
            test_cameraDynamicPitchBaseFovPad = 0,
            test_cameraDynamicPitchHeight = 0,
            test_cameraTargetFocusEnemyEnable = 0,
            test_cameraTargetFocusInteractEnable = 0,
            test_cameraHeadMovementStrength = 0,
            test_cameraHeadMovementMovingStrength = 0,
            test_cameraHeadMovementStandingStrength = 0,
            cxp_enableActionTarget = 0,
        }
    },
    ["Action RPG"] = {
        description = "Balanced shoulder view with enemy focus. Great for leveling.",
        cvars = {
            test_cameraOverShoulder = 1.2, -- Right shoulder
            test_cameraDynamicPitchBaseFovPad = 0.15,
            test_cameraDynamicPitchHeight = 0.4,
            test_cameraTargetFocusEnemyEnable = 1,
            test_cameraTargetFocusInteractEnable = 0,
            test_cameraHeadMovementStrength = 0.2, -- Subtle
            test_cameraHeadMovementMovingStrength = 0.5,
            test_cameraHeadMovementStandingStrength = 0.2,
            cxp_enableActionTarget = 1,
        }
    },
    ["Close Quarters"] = {
        description = "Tight, immersive view. Heavy head bob and focus.",
        cvars = {
            test_cameraOverShoulder = 0.8,
            test_cameraDynamicPitchBaseFovPad = 0.35, -- More pitch
            test_cameraDynamicPitchHeight = 0.2,
            test_cameraTargetFocusEnemyEnable = 1,
            test_cameraTargetFocusInteractEnable = 1,
            test_cameraHeadMovementStrength = 0.8,
            test_cameraHeadMovementMovingStrength = 1.0,
            test_cameraHeadMovementStandingStrength = 0.5,
            cxp_enableActionTarget = 1,
        }
    },
    ["Cinematic"] = {
        description = "Extreme offset and smooth tracking.",
        cvars = {
            test_cameraOverShoulder = 3.0, -- Wide offset
            test_cameraDynamicPitchBaseFovPad = 0.0,
            test_cameraDynamicPitchHeight = 0.5,
            test_cameraTargetFocusEnemyEnable = 1,
            test_cameraHeadMovementStrength = 0.0, -- Smooth
            test_cameraHeadMovementMovingStrength = 0.0,
            test_cameraHeadMovementStandingStrength = 0.0,
            cxp_enableActionTarget = 0,
        }
    }
}
