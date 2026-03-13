-- Music Parameters
_G.ou64_enable_music = true
local music_pause_factor = 6
local ou64_background_music = audio_stream_load("only-up-64.ogg")
local ou64_music_volume = 3

-- Music State
local music_initialized = false

-- Music Functions
function play_music(show_popup)
    if show_popup == nil or
            show_popup then
        djui_popup_create("Only Up 64: \n\\#00C7FF\\Music Enabled", 1)
    end
    audio_stream_set_looping(ou64_background_music, true)
    audio_stream_play(ou64_background_music, true, ou64_music_volume)
end

function stop_music(show_popup)
    if show_popup == nil or
            show_popup then
        djui_popup_create("Only Up 64: \n\\#A02200\\Music Disabled", 1)
    end
    audio_stream_set_looping(ou64_background_music, false)
    audio_stream_stop(ou64_background_music)
end

-- Music Chat Command.
hook_chat_command('ou64-music', '- Toggles \\#FAFF20\\Only Up 64\\#FFF\\ Soundtrack', function()
    _G.ou64_enable_music = not _G.ou64_enable_music
    if _G.ou64_enable_music then
        play_music()
    else
        stop_music()
    end

    return true
end)

-- Lower Music if Paused.
hook_event(HOOK_UPDATE, function()
    if not music_initialized then
        -- Start Only Up 64 Music if Plugin not present
        if not ou64_plugin_active then
            _G.ou64_api.ou64_play_music()
        end
        music_initialized = true
    end
    local music_factor = is_game_paused() and music_pause_factor or 1
    audio_stream_set_volume(ou64_background_music, ou64_music_volume / music_factor)
end)