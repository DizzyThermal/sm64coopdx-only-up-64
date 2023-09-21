local delaying = false
local delay_counter = 0
local delay_count = 20

local LEVEL_ONLY_UP_64_ENDING = 0x33

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
        obj_mark_for_deletion(obj)
        obj.oInteractStatus = 0
        delaying = true
        delay_counter = 0
    end
    spawn_star_number();
end

hook_behavior(id_bhvStar, OBJ_LIST_LEVEL, true, bhv_collect_star_init, bhv_collect_star_loop, "bhvStar")
hook_event(HOOK_UPDATE, function()
    delay_counter = delay_counter + 1
    if delaying and delay_counter >= delay_count then
        delaying = false
        delay_counter = 0
        warp_to_level(LEVEL_ONLY_UP_64_ENDING, 1, 0)
    end
end)