-- name: Only Up 64 v1.2
-- description: Only Up 64 is a romhack created by Kaze and thelegendofzenia\n\nhttps://romhacking.com/hack/only-up-64\n\nThis whole mod is one big, tall level that takes around 25 minutes to complete - if you don't fall. Climb the biggest level ever made! (as of today)\n\nPorted to coop by DizzyThermal and Cooliokid956 and Sunk\n\nSpecial thanks to everyone else on the sm64ex-coop Discord who helped with testing and debugging!
-- incompatible: romhack

LEVEL_ONLY_UP_64 = level_register('level_only_up_64_entry', COURSE_NONE, 'ONLY UP 64', 'ou64', 28000, 0x28, 0x28, 0x28)
LEVEL_ONLY_UP_64_ENDING = level_register('level_only_up_64_ending_entry', COURSE_NONE, 'ONLY UP 64 ENDING', 'ou64e', 28000, 0x28, 0x28, 0x28)

local enable_music = true

gLevelValues.entryLevel = LEVEL_ONLY_UP_64
gLevelValues.fixCollisionBugs = true
gLevelValues.cellHeightLimit = 0x7FFF
gLevelValues.floorLowerLimit = -0x8000
gLevelValues.floorLowerLimitMisc = -0x8000
gLevelValues.floorLowerLimitShadow = -0x8000

gServerSettings.skipIntro = 1
gServerSettings.stayInLevelAfterStar = 2

camera_set_use_course_specific_settings(false)

-- Play Only Up 64 Background Music
local bgm = audio_stream_load("only-up-64.ogg")
audio_stream_set_looping(bgm, true)
audio_stream_play(bgm, true, 5)

function mod_active(mod_name)
    for i in pairs(gActiveMods) do
        if string.find(gActiveMods[i].name, mod_name) then return true end
    end

    return false
end

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

local coins = {
    {
        area = 1,
        coins = {
            { x = -3113, y = -12287, z = 1565, shadow = true },
            { x = -4071, y = -11821, z =  868, shadow = true },
            { x = -1466, y =  -4101, z =  240, shadow = true },
            { x = -1677, y =   -494, z = 3928, shadow = true },
        },
    },
    {
        area = 2,
        coins = {
            { x = -6303, y = -12056, z = -1492, shadow = true  },
            { x =  2763, y =  -7391, z = -2530, shadow = true  },
            { x =   142, y =   4839, z =  3478, shadow = false },
            { x = -4326, y =  10957, z =  1952, shadow = true  },
        },
    },
    {
        area = 3,
        coins = {
            { x = -1197, y = -12849, z =  6076, shadow = true  },
            { x =  2661, y =  -2638, z = -5825, shadow = false },
            { x =  -345, y =     73, z = -1257, shadow = true  },
            { x =  1542, y =   5594, z =  6155, shadow = true  },
        },
    },
    {
        area = 4,
        coins = {
            { x = -2734, y = -11568, z =   871, shadow = true },
            { x = -4178, y =  -9529, z = -1195, shadow = true },
            { x = -2936, y =  -6120, z = -1837, shadow = true },
            { x =  3092, y =  -2576, z =  2342, shadow = true },
        },
    },
    {
        area = 5,
        coins = {
            { x = -170, y = -12341, z = -1973, shadow = true },
            { x = 1569, y = -10634, z = -1623, shadow = true },
            { x = 5642, y =  -6985, z =   819, shadow = true },
            { x = 5777, y =  -5059, z =  4136, shadow = true },
            { x = 4515, y =    -20, z = -3258, shadow = true },
        },
    },
    {
        area = 6,
        coins = {
            { x = -4247, y = -9620, z = -1656, shadow = true },
            { x = -4464, y = -9135, z =   567, shadow = true },
            { x =  -992, y = -6474, z =  5365, shadow = true },
            { x =  6320, y = -3671, z =   410, shadow = true },
            { x = -4157, y =  4354, z =  3987, shadow = true },
            { x = -1797, y = 12831, z =  2381, shadow = true },
        },
    },
    {
        area = 7,
        coins = {
            { x = -2786, y = -14329, z = -3318, shadow = true },
            { x = -1490, y = -11735, z = -4346, shadow = true },
            { x = -1990, y =  -7580, z = -5642, shadow = true },
            { x =  -731, y =  -4418, z = -5755, shadow = true },
            { x = -1255, y =   1487, z = -2010, shadow = true },
            { x = -1118, y =   5994, z =  5506, shadow = true },
        },
    },
    {
        area = 0,
        coins = {
            { x =   254, y = -12028, z =  3578, shadow = true },
            { x =   159, y = -10724, z =  1445, shadow = true },
            { x = -2383, y =  -7167, z =   145, shadow = true },
            { x =   132, y =  -3857, z =  3574, shadow = true },
            { x = -2542, y =    225, z =  2811, shadow = true },
            { x = -2515, y =   8582, z = -1160, shadow = true },
        },
    },
}

-- Warp to LEVEL_ONLY_UP_64
function warp_to_start()
    warp_to_level(LEVEL_ONLY_UP_64, 1, 0)
end
warp_to_start()


function mario_update(m)
    if not mod_active("Flood") then
        -- Disable Fall Damage
        m.hurtCounter = 0
        m.health = 0x880
        if m.area.index ~= prev_area then
            m.peakHeight = m.peakHeight + 32000 * (prev_area - m.area.index)
            prev_area = m.area.index
        end
    end

    -- Keep Players in Level
    if gNetworkPlayers[0].currLevelNum ~= LEVEL_ONLY_UP_64 and gNetworkPlayers[0].currLevelNum ~= LEVEL_ONLY_UP_64_ENDING then
        warp_to_start()
    end
end

function warp_check(m)
    if not mod_active("Flood") then
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
end

function MusicToggle(msg)
	if enable_music == false then
		djui_popup_create("Only Up 64: \n\\#00C7FF\\Music Enabled", 1)
        audio_stream_set_looping(bgm, true)
        audio_stream_play(bgm, true, 5)
	elseif enable_music == true then
		djui_popup_create("Only Up 64: \n\\#A02200\\Music Disabled", 1)
        audio_stream_set_looping(bgm, false)
        audio_stream_stop(bgm)
	end
	enable_music = not enable_music
    return true
end

function spawn_coin(x, y, z, shadow)
    local model = (shadow and E_MODEL_RED_COIN or E_MODEL_RED_COIN_NO_SHADOW)
	local coin = spawn_non_sync_object(
		id_bhvRedCoin,
		model,
		x, y, z,
		function (obj)
			obj.oOpacity = 255
			obj.oFaceAnglePitch = 0
			obj.oFaceAngleYaw = 0
			obj.oFaceAngleRoll = 0
		end
	)
end

function on_warp()
    if mod_active("Flood") then
        m = gMarioStates[0]
        -- Spawn in Coins for Flood Game Mode
        for i, ientry in ipairs(coins) do
            if m.area.index == ientry.area then
                for j, jentry in ipairs(ientry.coins) do
                    spawn_coin(jentry.x, jentry.y, jentry.z, jentry.shadow)
                end
            end
        end
    end
end

hook_event(HOOK_BEFORE_PHYS_STEP, warp_check)
hook_event(HOOK_MARIO_UPDATE, mario_update)
hook_event(HOOK_ON_WARP, on_warp)

hook_chat_command('only-up-music', '- Toggle Only Up 64 Music', MusicToggle)