-- Only Up 64 Level IDs
_G.ou64_level_id = level_register('level_only_up_64_entry', LEVEL_CASTLE_GROUNDS, '      ONLY UP 64', 'ou64', 28000, 0x28, 0x28, 0x28)
_G.ou64_end_level_id = level_register('level_only_up_64_ending_entry', LEVEL_CASTLE_GROUNDS, ' ONLY UP 64 ENDING', 'ou64e', 28000, 0x28, 0x28, 0x28)
_G.ou64_act_id = 0

-- Only Up 64 Music
_G.ou64_enable_music = true
ou64_background_music = audio_stream_load("only-up-64.ogg")
ou64_music_volume = 3

-- Functions
function mod_active(mod_name)
    for i in pairs(gActiveMods) do
        if string.find(gActiveMods[i].name, mod_name) then
            return true
        end
    end

    return false
end

function warp_to_start()
    warp_to_level(_G.ou64_level_id, 1, _G.ou64_act_id)
end

-- Only Up 64 API (External Functions)
local function play_music()
    audio_stream_set_looping(ou64_background_music, true)
    audio_stream_play(ou64_background_music, true, ou64_music_volume)
end

local function stop_music()
    audio_stream_set_looping(ou64_background_music, false)
    audio_stream_stop(ou64_background_music)
end

_G.ou64_api = {
    ou64_warp_to_start = warp_to_start,
    ou64_play_music = play_music,
    ou64_stop_music = stop_music,
}

-- Active Mods
ou64_active = true
ou64_flood_active = _G.ou64_flood_active ~= nil or mod_active("Only Up 64 Flood")
ou64_plugin_active = _G.ou64_plugin_active ~= nil mod_active("Only Up 64 Plugin")

-- Level / Server Settings
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
camera_set_use_course_specific_settings(false)

-- Areas
ou64_prev_area = 1
ou64_areas = {
    -- Area 2 --
	{ area = 2, warpY = -20194, marioY = -15400, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT },
    -- Star -- START
    { area = 2, warpY = -15924, marioY = -14700, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT },
    { area = 2, warpY = -15753, marioY = -14700, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT },
    { area = 2, warpY = -15623, marioY = -14700, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT },
    { area = 2, warpY = -15675, marioY = -14700, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT },
    { area = 2, warpY = -15768, marioY = -14700, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT },
    { area = 2, warpY = -15851, marioY = -14700, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT },
    { area = 2, warpY = -15998, marioY = -14700, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT },

    -- Area 3 --
	{ area = 3, warpY = -18423, marioY = -16800, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT  },
    -- Chest -- START
    { area = 3, warpY = -17832, marioY = -16000, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT  },
    { area = 3, warpY = -17597, marioY = -16000, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT  },
    { area = 3, warpY = -17690, marioY = -16000, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT  },
    { area = 3, warpY = -17893, marioY = -16000, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT  },
    { area = 3, warpY = -18259, marioY = -16000, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT  },
    { area = 3, warpY = -18310, marioY = -16000, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT  },
    { area = 3, warpY = -18589, marioY = -16000, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT  },

    -- Area 4 --
	{ area = 4, warpY = -19682, marioY = -15800, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT  },
    -- Nidoqueen -- START
    { area = 4, warpY = -16197, marioY = -15650, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT  },
    { area = 4, warpY = -16515, marioY = -15650, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT  },
    { area = 4, warpY = -16585, marioY = -15650, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT  },
    { area = 4, warpY = -16960, marioY = -15650, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT  },
    { area = 4, warpY = -17440, marioY = -15650, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT  },

    -- Area 5 --
	{ area = 5, warpY = -19461,  marioY = -16000, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT  },
    -- Luigi -- START
    { area = 5, warpY = -16216,  marioY = -15600, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT  },
    { area = 5, warpY = -16342,  marioY = -15600, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT  },
    { area = 5, warpY = -16564,  marioY = -15600, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT  },
    { area = 5, warpY = -16663,  marioY = -15600, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT  },
    { area = 5, warpY = -16411,  marioY = -15600, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT  },

    -- Area 6 --
	{ area = 6, warpY = -18532, marioY = -16000, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT  },
    -- Rhino -- START
    { area = 6, warpY = -15893, marioY = -15450, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT  },
    { area = 6, warpY = -15916, marioY = -15450, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT  },
    { area = 6, warpY = -15972, marioY = -15450, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT  },
    { area = 6, warpY = -15889, marioY = -15450, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT  },
    { area = 6, warpY = -16180, marioY = -15450, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT  },
    { area = 6, warpY = -16004, marioY = -15450, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT  },
    { area = 6, warpY = -16234, marioY = -15450, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT  },
    { area = 6, warpY = -17641, marioY = -15450, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT  },
    { area = 6, warpY = -17435, marioY = -15450, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT  },
    { area = 6, warpY = -17985, marioY = -15450, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT  },
    { area = 6, warpY = -16298, marioY = -15450, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT  },
    { area = 6, warpY = -16304, marioY = -15450, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT  },

    -- Area 7 --
	{ area = 7, warpY = -17358,  marioY = -16000, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT  },
    -- Tower -- START
    { area = 7, warpY = -16053,  marioY = -15700, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT  },
    { area = 7, warpY = -16054,  marioY = -15700, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT  },
    { area = 7, warpY = -16055,  marioY = -15700, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT  },
    { area = 7, warpY = -16056,  marioY = -15700, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT  },
    { area = 7, warpY = -16057,  marioY = -15700, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT  },
    { area = 7, warpY = -16058,  marioY = -15700, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT  },
    { area = 7, warpY = -16059,  marioY = -15700, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT  },
    { area = 7, warpY = -16373,  marioY = -15700, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT  },
    { area = 7, warpY = -16375,  marioY = -15700, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT  },
    { area = 7, warpY = -16376,  marioY = -15700, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT  },
    { area = 7, warpY = -16379,  marioY = -15700, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT  },
    { area = 7, warpY = -16382,  marioY = -15700, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT  },
    { area = 7, warpY = -16945,  marioY = -15700, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT  },

    -- Area 0 --
	{ area = 0, warpY = -22777,  marioY = -16400, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT  },
}

-- Text Replacements
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

smlua_text_utils_dialog_replace(8, 1, 5, 30, 200, "----------------------\
    Congratulations!\n\
 you did it! proud of u!\
----------------------\
\n To go back to the start\
   stand in the corner")
