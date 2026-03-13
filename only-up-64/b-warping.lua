-- Warping State
local default_surface = SURFACE_DEFAULT
local warp_surface = SURFACE_INSTANT_WARP_1B
local ou64_prev_area = 1
local ou64_areas = {
    [2] = {
        { warp_y = -20194, mario_y = -15400 },
        -- Star -- START
        { warp_y = -15924, mario_y = -14700 },
        { warp_y = -15753, mario_y = -14700 },
        { warp_y = -15623, mario_y = -14700 },
        { warp_y = -15675, mario_y = -14700 },
        { warp_y = -15768, mario_y = -14700 },
        { warp_y = -15851, mario_y = -14700 },
        { warp_y = -15998, mario_y = -14700 },
    },
    [3] = {
        { warp_y = -18423, mario_y = -16800 },
        -- Chest -- START
        { warp_y = -17832, mario_y = -16000 },
        { warp_y = -17597, mario_y = -16000 },
        { warp_y = -17690, mario_y = -16000 },
        { warp_y = -17893, mario_y = -16000 },
        { warp_y = -18259, mario_y = -16000 },
        { warp_y = -18310, mario_y = -16000 },
        { warp_y = -18589, mario_y = -16000 },
    },
    [4] = {
        { warp_y = -19682, mario_y = -15800 },
        -- Nidoqueen -- START
        { warp_y = -16197, mario_y = -15650 },
        { warp_y = -16515, mario_y = -15650 },
        { warp_y = -16585, mario_y = -15650 },
        { warp_y = -16960, mario_y = -15650 },
        { warp_y = -17440, mario_y = -15650 },
    },
    [5] = {
        { warp_y = -19461,  mario_y = -16000 },
        -- Luigi -- START
        { warp_y = -16216,  mario_y = -15600 },
        { warp_y = -16342,  mario_y = -15600 },
        { warp_y = -16564,  mario_y = -15600 },
        { warp_y = -16663,  mario_y = -15600 },
        { warp_y = -16411,  mario_y = -15600 },
    },
    [6] = {
        { warp_y = -18532, mario_y = -16000 },
        -- Rhino -- START
        { warp_y = -15893, mario_y = -15450 },
        { warp_y = -15916, mario_y = -15450 },
        { warp_y = -15972, mario_y = -15450 },
        { warp_y = -15889, mario_y = -15450 },
        { warp_y = -16180, mario_y = -15450 },
        { warp_y = -16004, mario_y = -15450 },
        { warp_y = -16234, mario_y = -15450 },
        { warp_y = -17641, mario_y = -15450 },
        { warp_y = -17435, mario_y = -15450 },
        { warp_y = -17985, mario_y = -15450 },
        { warp_y = -16298, mario_y = -15450 },
        { warp_y = -16304, mario_y = -15450 },
    },
    [7] = {
        { warp_y = -17358,  mario_y = -16000 },
        -- Tower -- START
        { warp_y = -16053,  mario_y = -15700 },
        { warp_y = -16054,  mario_y = -15700 },
        { warp_y = -16055,  mario_y = -15700 },
        { warp_y = -16056,  mario_y = -15700 },
        { warp_y = -16057,  mario_y = -15700 },
        { warp_y = -16058,  mario_y = -15700 },
        { warp_y = -16059,  mario_y = -15700 },
        { warp_y = -16373,  mario_y = -15700 },
        { warp_y = -16375,  mario_y = -15700 },
        { warp_y = -16376,  mario_y = -15700 },
        { warp_y = -16379,  mario_y = -15700 },
        { warp_y = -16382,  mario_y = -15700 },
        { warp_y = -16945,  mario_y = -15700 },
    },
    [0] = {
        { warp_y = -22777,  mario_y = -16400 },
    },
}

-- Warping Functions
function warp_to_start()
    warp_to_level(_G.ou64_level_id, 1, _G.ou64_act_id)
end

-- Backwarp Check Hook.
hook_event(HOOK_BEFORE_PHYS_STEP, function(m)
    if m.playerIndex ~= 0 or
            ou64_flood_active then
        return
    end

    local floor = collision_find_surface_on_ray(
        m.pos.x + m.vel.x,
        m.pos.y + m.vel.y,
        m.pos.z + m.vel.z,
        0, -10000, 0
    ).surface
    local area_index = m.area.index
    if floor ~= nil and
            area_index ~= 1 then
        for i, surface in ipairs(ou64_areas[area_index]) do
            if floor.lowerY == surface.warp_y then
                floor.type = m.pos.y < surface.mario_y and
                        warp_surface or
                            default_surface
            end
        end
    end
end)

-- Mario Update Hook.
hook_event(HOOK_MARIO_UPDATE, function(m)
    if m.playerIndex ~= 0 then
        return
    end

    if not ou64_flood_active then
        -- Disable Fall Damage (if not Flood)
        m.hurtCounter = 0
        m.health = 0x880
        if m.area.index ~= ou64_prev_area then
            m.peakHeight = m.peakHeight + 32000 * (ou64_prev_area - m.area.index)
            ou64_prev_area = m.area.index
        end
    end

    -- Keep Players in Only Up 64 Level
    local is_player = gServerSettings.headlessServer == 0 or not network_is_server()
    local in_level = (gNetworkPlayers[0].currLevelNum == _G.ou64_level_id or
                      gNetworkPlayers[0].currLevelNum == _G.ou64_end_level_id) and
                      gNetworkPlayers[0].currActNum == _G.ou64_act_id
    if is_player and not in_level then
        warp_to_start()
    end
end)

-- Restart Level on Exit
hook_event(HOOK_ON_PAUSE_EXIT, function()
    if not ou64_flood_active then
        warp_to_start()
    end
end)
