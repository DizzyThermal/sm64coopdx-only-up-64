-- name: Only Up 64 v1.3.3
-- description: Only Up 64 is a romhack created by Kaze and thelegendofzenia\n\nhttps://romhacking.com/hack/only-up-64\n\nThis whole mod is one big, tall level that takes around 25 minutes to complete - if you don't fall. Climb the biggest level ever made! (as of today)\n\nPorted to sm64coopdx by DizzyThermal and Cooliokid956 and Sunk\n\nSpecial thanks to everyone else on the sm64coopdx Discord who helped with testing and debugging!
-- incompatible: romhack

LEVEL_ONLY_UP_64 = level_register('level_only_up_64_entry', COURSE_NONE, 'ONLY UP 64', 'ou64', 28000, 0x28, 0x28, 0x28)
LEVEL_ONLY_UP_64_ENDING = level_register('level_only_up_64_ending_entry', COURSE_NONE, 'ONLY UP 64 ENDING', 'ou64e', 28000, 0x28, 0x28, 0x28)

local enable_music = true
local music_volume = 3

gLevelValues.entryLevel = LEVEL_ONLY_UP_64
gLevelValues.fixCollisionBugs = true
gLevelValues.cellHeightLimit = 0x7FFF
gLevelValues.floorLowerLimit = -0x8000
gLevelValues.floorLowerLimitMisc = -0x8000
gLevelValues.floorLowerLimitShadow = -0x8000

gServerSettings.skipIntro = 1
gServerSettings.stayInLevelAfterStar = 2

camera_set_use_course_specific_settings(0)

local ou_flood_active = mod_active("Only Up 64 Flood")

-- Play Only Up 64 Music
local bgm = audio_stream_load("only-up-64.ogg")
audio_stream_set_looping(bgm, true)
audio_stream_play(bgm, true, 5)

-- Warp to Start
function warp_to_start()
    warp_to_level(LEVEL_ONLY_UP_64, 1, 0)
end
warp_to_start()

-- Backwarp Checks --
local prev_area = 1
hook_event(HOOK_BEFORE_PHYS_STEP, function(m)
    if not ou_flood_active then
        local floor = collision_find_surface_on_ray(m.pos.x+m.vel.x, m.pos.y+m.vel.y, m.pos.z+m.vel.z, 0, -10000, 0).surface

        if m.area.index ~= 1 and floor ~= nil then
            for i, entry in ipairs(AREAS) do
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
end)

-- Disable Fall Damage / Keep Player in Only Up 64
hook_event(HOOK_MARIO_UPDATE, function(m)
    if not ou_flood_active then
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
end)

-- Flood: Spawn Coins --
hook_event(HOOK_ON_WARP, function()
    m = gMarioStates[0]

    if ou_flood_active then
        for i, ientry in ipairs(FLOOD_COINS) do
            if m.area.index == ientry.area then
                for j, jentry in ipairs(ientry.coins) do
                    local model = (jentry.shadow and E_MODEL_RED_COIN or E_MODEL_RED_COIN_NO_SHADOW)
                    spawn_non_sync_object(
                        id_bhvRedCoin,
                        model,
                        jentry.x, jentry.y, jentry.z,
                        function (obj)
                            obj.oOpacity = 255
                            obj.oFaceAnglePitch = 0
                            obj.oFaceAngleYaw = 0
                            obj.oFaceAngleRoll = 0
                        end
                    )
                end
            end
        end
    end
end)

-- Music --
function MusicToggle(msg)
    enable_music = not enable_music
    if enable_music then
        djui_popup_create("Only Up 64: \n\\#00C7FF\\Music Enabled", 1)
        audio_stream_set_looping(bgm, true)
        audio_stream_play(bgm, true, music_volume)
    else
        djui_popup_create("Only Up 64: \n\\#A02200\\Music Disabled", 1)
        audio_stream_set_looping(bgm, false)
        audio_stream_stop(bgm)
    end
    return true
end
hook_chat_command('only-up-music', '- Toggle Only Up 64 Music', MusicToggle)
hook_event(HOOK_UPDATE, function ()
    if is_game_paused() then
        audio_stream_set_volume(bgm, music_volume / 10)
    else
        audio_stream_set_volume(bgm, music_volume)
    end
end)
