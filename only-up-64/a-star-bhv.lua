---@param obj Object
local function bhv_collect_star_init(obj)
    obj.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    bhv_init_room()

    obj_set_model_extended(obj, E_MODEL_STAR)

    local hitbox = get_temp_object_hitbox()
    hitbox.interactType      = INTERACT_STAR_OR_KEY
    hitbox.downOffset        = 0
    hitbox.damageOrCoinValue = 0
    hitbox.health            = 0
    hitbox.numLootCoins      = 0
    hitbox.radius            = 80
    hitbox.height            = 50
    hitbox.hurtboxRadius     = 0
    hitbox.hurtboxHeight     = 0
    obj_set_hitbox(obj, hitbox)
    spawn_star_number()
end

local function bhv_collect_star_loop(obj)
    obj.oFaceAngleYaw = obj.oFaceAngleYaw + 0x800

    if obj.oInteractStatus & INT_STATUS_INTERACTED ~= 0 then
        if not _G.ou64_plugin_active and
                not _G.ou64_flood_active then
            warp_to_level(_G.ou64_end_level_id, 1, _G.ou64_act_id)
        end
        obj.oInteractStatus = 0
    end
    spawn_star_number();
end

if not _G.ou64_flood_active then
    hook_behavior(id_bhvStar, OBJ_LIST_LEVEL, true, bhv_collect_star_init, bhv_collect_star_loop, "bhvStar")
end
