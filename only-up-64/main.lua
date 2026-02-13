-- name: \\#FAFF20\\Only Up 64
-- description: \\#FAFF20\\Only Up 64\\#FFF\\ v1.5.0\nBy \\#65834B\\Kaze\\#FFF\\ and \\#0868EC\\thelegendofzenia\\#FFF\\\n\nThis whole mod is one big, tall level that takes around 25 minutes to complete - if you don't fall. Climb the biggest level ever made! (as of today)\n\nPorted to sm64coopdx by \\#E01F2D\\DizzyThermal\\#FFF\\ and \\#0868EC\\Cooliokid956\\#FFF\\
-- incompatible: romhack

-- Backwarp Check Hook
hook_event(HOOK_BEFORE_PHYS_STEP, function(m)
    if not _G.ou64_flood_active then
        local floor = collision_find_surface_on_ray(m.pos.x+m.vel.x, m.pos.y+m.vel.y, m.pos.z+m.vel.z, 0, -10000, 0).surface

        if m.area.index ~= 1 and
                floor ~= nil then
            for i, entry in ipairs(_G.ou64_areas) do
                if m.area.index == entry.area and
                        floor.lowerY == entry.warpY then
                    if m.pos.y < entry.marioY and
                            m.playerIndex == 0 then
                        floor.type = entry.warpType
                    else
                        floor.type = entry.defaultType
                    end
                end
            end
        end
    end
end)

hook_event(HOOK_MARIO_UPDATE, function(m)
    if m.playerIndex ~= 0 then return end

    -- Disable Fall Damage
    if not _G.ou64_flood_active then
        m.hurtCounter = 0
        m.health = 0x880
        if m.area.index ~= _G.ou64_prev_area then
            m.peakHeight = m.peakHeight + 32000 * (_G.ou64_prev_area - m.area.index)
            _G.ou64_prev_area = m.area.index
        end
    end

    -- Keep Actual Players in Level
    local is_player = gServerSettings.headlessServer == 0 or not network_is_server()
    local in_level = (gNetworkPlayers[0].currLevelNum == _G.ou64_level_id or
                      gNetworkPlayers[0].currLevelNum == _G.ou64_end_level_id) and
                      gNetworkPlayers[0].currActNum == _G.ou64_act_id
    if is_player and not in_level then
        warp_to_start()
    end

--    _G.ou64_lakitu_pos = {
--        x = gLakituState.pos.x,
--        y = gLakituState.pos.y,
--        z = gLakituState.pos.z,
--        hspeed = gLakituState.posHSpeed,
--        vspeed = gLakituState.posVSpeed,
--    }
--    _G.ou64_lakitu_focus = {
--        x = gLakituState.focus.x,
--        y = gLakituState.focus.y,
--        z = gLakituState.focus.z,
--        hspeed = gLakituState.focHSpeed,
--        vspeed = gLakituState.focVSpeed,
--    }
--    _G.ou64_lakitu_yaw = gLakituState.yaw
end)

--hook_event(HOOK_ON_INSTANT_WARP, function()
--    djui_chat_message_create("WARP")
--    gLakituState.pos.x = _G.ou64_lakitu_pos.x
--    gLakituState.pos.y = _G.ou64_lakitu_pos.y
--    gLakituState.pos.z = _G.ou64_lakitu_pos.z
--    gLakituState.posHSpeed = _G.ou64_lakitu_pos.hspeed
--    gLakituState.posVSpeed = _G.ou64_lakitu_pos.vspeed
--    gLakituState.focus.x = _G.ou64_lakitu_focus.x
--    gLakituState.focus.y = _G.ou64_lakitu_focus.y
--    gLakituState.focus.z = _G.ou64_lakitu_focus.z
--    gLakituState.focHSpeed = _G.ou64_lakitu_focus.hspeed
--    gLakituState.focVSpeed = _G.ou64_lakitu_focus.vspeed
--    gLakituState.yaw = _G.ou64_lakitu_yaw
--end)

hook_event(HOOK_ON_HUD_RENDER, function()
    m = gMarioStates[0]

    -- If in cutscene or Act Selector, don't render anything
    if m.action == ACT_END_PEACH_CUTSCENE or
            m.action == ACT_CREDITS_CUTSCENE or
            m.action == ACT_END_WAVING_CUTSCENE or
            obj_get_first_with_behavior_id(id_bhvActSelector) ~= nil then return end

    -- Hide HUD Displays and Clear Location Information
    hud_hide()

    -- Restart Level Pause Options
    if is_game_paused()
            and not is_pause_menu_hidden()
            and not djui_hud_is_pause_menu_created() 
            and not _G.ou64_flood_active then
        djui_hud_set_resolution(RESOLUTION_N64)
        djui_hud_set_font(FONT_ALIASED)
        local center_x = djui_hud_get_screen_width() / 2
        djui_hud_set_font(FONT_NORMAL)
        djui_hud_set_color(20, 20, 20, 250)
        djui_hud_render_rect(center_x - 52, 149, 90, 13)
        djui_hud_render_rect(center_x - 52, 164, 90, 13)
        djui_hud_set_color(255, 255, 255, 255)
        djui_hud_print_text("RESTART LEVEL",  center_x - 51, 147, 0.5)
        djui_hud_print_text("RESTART LEVEL", center_x - 51, 162, 0.5)
    end
end)

-- Restart Level on Exit
hook_event(HOOK_ON_PAUSE_EXIT, function()
    if not _G.ou64_flood_active then
        warp_to_start()
    end
end)

-- Music --
hook_chat_command('only-up-music', '- Toggle Only Up 64 Music', function()
    _G.ou64_enable_music = not _G.ou64_enable_music
    if _G.ou64_enable_music then
        djui_popup_create("Only Up 64: \n\\#00C7FF\\Music Enabled", 1)
        audio_stream_set_looping(_G.ou64_background_music, true)
        audio_stream_play(_G.ou64_background_music, true, _G.ou64_music_volume)
    else
        djui_popup_create("Only Up 64: \n\\#A02200\\Music Disabled", 1)
        audio_stream_set_looping(_G.ou64_background_music, false)
        audio_stream_stop(_G.ou64_background_music)
    end

    return true
end)

hook_event(HOOK_UPDATE, function()
    -- Lower Music if Paused
    if is_game_paused() then
        audio_stream_set_volume(_G.ou64_background_music, _G.ou64_music_volume / 10)
    else
        audio_stream_set_volume(_G.ou64_background_music, _G.ou64_music_volume)
    end
end)
