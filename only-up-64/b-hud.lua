-- Remove HUD Elements
hook_event(HOOK_ON_HUD_RENDER, function()
    m = gMarioStates[0]

    -- If in cutscene or Act Selector, don't render anything
    if m.action == ACT_END_PEACH_CUTSCENE or
            m.action == ACT_CREDITS_CUTSCENE or
            m.action == ACT_END_WAVING_CUTSCENE or
            obj_get_first_with_behavior_id(id_bhvActSelector) ~= nil then
        return
    end

    -- Hide HUD Displays and Clear Location Information
    hud_hide()

    -- Render "RESTART LEVEL" Pause Options
    if is_game_paused()
            and not is_pause_menu_hidden()
            and not djui_hud_is_pause_menu_created()
            and not ou64_flood_active then
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