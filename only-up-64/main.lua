-- name: Only Up 64 Beta 1
-- description: Only Up 64 is a romhack created by Kaze and thelegendofzenia\n\nhttps://romhacking.com/hack/only-up-64\n\nThis whole mod is one big, tall level that takes around 25 minutes to complete - if you don't fall. Climb the biggest level ever made! (as of today)\n\nPorted to coop by DizzyThermal and Cooliokid956\n\nSpecial thanks to everyone else on the sm64ex-coop Discord who helped with testing and debugging!
-- incompatible: romhack

LEVEL_ONLY_UP_64 = level_register('level_only_up_64_entry', COURSE_NONE, 'ONLY UP 64', 'ou64', 28000, 0x28, 0x28, 0x28)

gLevelValues.entryLevel = LEVEL_ONLY_UP_64
gLevelValues.fixCollisionBugs = true
gLevelValues.cellHeightLimit = 0x7FFF
gLevelValues.floorLowerLimit = -0x8000
gLevelValues.floorLowerLimitMisc = -0x8000
gLevelValues.floorLowerLimitShadow = -0x8000

gServerSettings.skipIntro = 1
camera_set_use_course_specific_settings(false)

smlua_text_utils_dialog_replace(0, 1, 4, 30, 200, "----------------------\
       Welcome to\
    Only Up 64 Beta 1\
----------------------\
Known issues:\
> Texture bugs are\
present on some models\n\
> Camera may shift on\
warp for non-free camera\n\n\
Please report new issues\
to DizzyThermal\n\
Thanks and enjoy climbing!")

warp_to_level(LEVEL_ONLY_UP_64, 1, 0)

-- Play Only Up 64 Background Music
bgm = audio_stream_load("only-up-64.ogg")
audio_stream_set_looping(bgm, true)
audio_stream_play(bgm, true, 5)

local prev_area = 1
local areas = {
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
	{ area = 3, warpY = -18352, marioY = -16800, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT  },
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
	{ area = 7, warpY = -17373,  marioY = -16000, warpType = SURFACE_INSTANT_WARP_1B, defaultType = SURFACE_DEFAULT  },
    { area = 7, warpY = -17229,  marioY = -16000, warpType = SURFACE_INSTANT_WARP_1D, defaultType = SURFACE_DEFAULT  },

    -- Tower / Cliff -- START
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
}

function mario_update(m)
    -- Disable Fall Damage
    m.hurtCounter = 0
    m.health = 0x880
    if m.area.index ~= prev_area then
        m.peakHeight = m.peakHeight + 32000 * (prev_area - m.area.index)
        prev_area = m.area.index
    end

    -- Keep Players in Level
    if gNetworkPlayers[0].currLevelNum ~= LEVEL_ONLY_UP_64 then
        warp_to_level(LEVEL_ONLY_UP_64, 1, 0)
    end
end

function warp_check(m)
    local floor = collision_find_surface_on_ray(m.pos.x+m.vel.x, m.pos.y+m.vel.y, m.pos.z+m.vel.z, 0, -10000, 0).surface

    if m.area.index ~= 1 and floor ~= nil then
        for i, entry in ipairs(areas) do
            if m.area.index == entry.area and floor.lowerY == entry.warpY then
                if m.pos.y < entry.marioY and m.playerIndex == 0 then
                    floor.type = entry.warpType
                else
                    floor.type = entry.defaultType
                end
            end
        end
    end
end

function on_death()
    warp_to_level(LEVEL_ONLY_UP_64, 1, 0)
end

hook_event(HOOK_BEFORE_PHYS_STEP, warp_check)
hook_event(HOOK_MARIO_UPDATE, mario_update)
hook_event(HOOK_ON_DEATH, on_death)