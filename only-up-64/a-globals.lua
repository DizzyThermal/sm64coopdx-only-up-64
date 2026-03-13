---
-- Only Up 64 Level IDs
---
_G.ou64_level_id = level_register('level_only_up_64_entry', LEVEL_CASTLE_GROUNDS, '      ONLY UP 64', 'ou64', 28000, 0x28, 0x28, 0x28)
_G.ou64_end_level_id = level_register('level_only_up_64_ending_entry', LEVEL_CASTLE_GROUNDS, ' ONLY UP 64 ENDING', 'ou64e', 28000, 0x28, 0x28, 0x28)
_G.ou64_act_id = 0

---
-- Active Mods
---
local function mod_active(mod_name)
    for i in pairs(gActiveMods) do
        if string.find(gActiveMods[i].name, mod_name) then return true end
    end

    return false
end

local function mod_active_exact(mod_name)
    for i in pairs(gActiveMods) do
        if gActiveMods[i].name == mod_name then return true end
    end

    return false
end

ou64_active = true
ou64_flood_active = _G.ou64_flood_active or mod_active("Flood")
ou64_plugin_active = _G.ou64_plugin_active or
        mod_active("Only Up 64 Plugin") or
        mod_active_exact("\\#FAFF20\\Only Up \\#E01F2D\\Plugin")

---
-- ROM Hack Level / Server / Camera Settings
---
gLevelValues.entryLevel = _G.ou64_level_id
gLevelValues.disableActs = true
gLevelValues.fixCollisionBugs = true
gLevelValues.cellHeightLimit = 0x7FFF
gLevelValues.floorLowerLimit = -0x8000
gLevelValues.floorLowerLimitMisc = -0x8000
gLevelValues.floorLowerLimitShadow = -0x8000
gLevelValues.zoomOutCameraOnPause = false

gServerSettings.skipIntro = 1
gServerSettings.stayInLevelAfterStar = 2

camera_set_romhack_override(RCO_ALL_EXCEPT_BOWSER)
camera_set_use_course_specific_settings(0)

---
-- ROM Hack Text Replacements
---

-- Starting Area Sign Dialog
smlua_text_utils_dialog_replace(0, 1, 4, 30, 200, "----------------------\
       Welcome to\
       Only Up 64\
----------------------\
Only Up 64 Moveset:\
>  A, Z, A: GP Jump\
(on ground)\n\
>  A, Z, A: Twirl Jump\
  (in air)\
>  A, Z, B: Dive Out\
  (in air)\
Known issues:\
> Camera may shift on\
warp for non-free camera\n\n\
> You can clip through\
some steep vertical walls\n\n\
Please report new issues\
to DizzyThermal\n\
Thanks and enjoy climbing!")

-- Ending Area Painting Dialog
smlua_text_utils_dialog_replace(8, 1, 5, 30, 200, "----------------------\
    Congratulations!\n\
 you did it! proud of u!\
----------------------\
\n To go back to the start\
   stand in the corner")