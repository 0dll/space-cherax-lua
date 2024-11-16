
to_enable.drive_it_gun_func = function(bool_)
    if bool_ then
        _settings.drive_it_gun = not _settings.drive_it_gun
    end
    
    toggle_helper(_settings.drive_it_gun, function()
        _menu.loading_sprite = true
        -- do stuff
        _menu.loading_sprite = false
        while _settings.drive_it_gun do
            if PAD.IS_CONTROL_JUST_PRESSED(0, 24) then
                local ent = Memory.AllocInt()
                PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(PLAYER.GET_PLAYER_INDEX(), ent)
                --entity.set_entity_god_mode(ent, true)
                if ENTITY.IS_ENTITY_A_VEHICLE(Memory.ReadInt(ent)) or ENTITY.IS_ENTITY_A_PED(Memory.ReadInt(ent)) and PED.IS_PED_IN_ANY_VEHICLE(Memory.ReadInt(ent), true) then
                    --[[if ENTITY.IS_ENTITY_A_PED(Memory.ReadInt(ent)) and PED.IS_PED_IN_ANY_VEHICLE(Memory.ReadInt(ent), true) then
                        ent_2 = PED.GET_VEHICLE_PED_IS_USING(Memory.ReadInt(ent))
                        local ped_grabbed = true
                    end
                    local ped_123 = VEHICLE.GET_PED_IN_VEHICLE_SEAT(ent_2, -1, false)
                    if ped_123 ~= 0 then
                        TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped_123)
                        wait_t(100)
                    end
                    PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), bool_true_false(ped_grabbed, Memory.ReadInt(ent), ent_2), -1)
                    ped_grabbed = false]]
                    local ped_vehicle
                    if ENTITY.IS_ENTITY_A_PED(Memory.ReadInt(ent)) and PED.IS_PED_IN_ANY_VEHICLE(Memory.ReadInt(ent), true) then
                        ped_vehicle = PED.GET_VEHICLE_PED_IS_USING(Memory.ReadInt(ent))
                        local ped_123 = VEHICLE.GET_PED_IN_VEHICLE_SEAT(ped_vehicle, -1, false)
                        TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped_123)
                        PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), ped_vehicle, -1)
                    else
                        PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), Memory.ReadInt(ent), -1)
                    end
                    Memory.Free(ent)
                end
            end
            wait_t(0)
        end
        _menu.loading_sprite = true
        --do stuff
        _menu.loading_sprite = false
    end)
end

to_enable.freeze_entity_gun = function(bool_)
    if bool_ then
        _settings.freeze_entity_gun = not _settings.freeze_entity_gun
    end
    toggle_helper(_settings.freeze_entity_gun, function()
        _menu.loading_sprite = true
        -- do stuff
        _menu.loading_sprite = false
        while _settings.freeze_entity_gun do
            if PAD.IS_CONTROL_JUST_PRESSED(0, 24) then
                local ent = Memory.AllocInt()
                PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(PLAYER.GET_PLAYER_INDEX(), ent)
                local thing = Memory.ReadInt(ent)
                --local thing = player.get_entity_player_is_aiming_at(player.player_id())
                
                if ENTITY.IS_ENTITY_A_PED(thing) then
                    local thing2 = ped.get_vehicle_ped_is_using(thing)
                    helper_request_control(thing2)
                    helper_set_entity_godmode(thing2, true)
                    ENTITY.FREEZE_ENTITY_POSITION(thing2, true)
                  else
                    helper_request_control(thing)
                    helper_set_entity_godmode(thing, true)
                    ENTITY.FREEZE_ENTITY_POSITION(thing, true)
                end
                Memory.Free(ent)
            end
            wait_t(0)
        end
        _menu.loading_sprite = true
        --do stuff
        _menu.loading_sprite = false
    end)
end
--[[ SET_ENTITY_GRAVITY IS WHY YOU CANT GET THIS WORKING RN THERE IS NO NATIVED NAMED THAT COME BACK TO THIS LATER
to_enable.no_gravity_gun = function(bool_)
    if bool_ then
        bool_ = not bool_
    end
    toggle_helper(bool____, function()
        _menu.loading_sprite = true
        -- do stuff
        _menu.loading_sprite = false
        while bool____ do
            if PAD.IS_CONTROL_JUST_PRESSED(0, 24) then
                local thing = player.get_entity_player_is_aiming_at(player.player_id())
                if ENTITY.IS_ENTITY_A_PED(thing) then
                  local thing2 = ped.get_vehicle_ped_is_using(thing)
                  helper_request_control(thing2)
                  helper_set_entity_godmode(thing2, true)
                  entity.set_entity_gravity(thing2, false) -- no native_named_this
                  else
                  request_control(thing)
                  helper_set_entity_godmode(thing, true)
                  entity.set_entity_gravity(thing, false) -- no native_named_this. edit retard ass nigga SET_ENTITY_HAS_GRAVITY(Entity entity, BOOL toggle)
                  system.wait(0)
                end
            end
            wait_t(0)
        end
        _menu.loading_sprite = true
        --do stuff
        _menu.loading_sprite = false
    end)
end
]]


--[[ -- GET_ENTITY_MODEL_HASH IS WHY YOU CANT GET THIS WORKING RN THERE IS NO NATIVED NAMED THAT COME BACK TO THIS LATER
to_enable.america_gun = function(bool_)
    if bool_ then
        bool_ = not bool_
    end
    toggle_helper(bool_, function()
        _menu.loading_sprite = true
        -- do stuff
        _menu.loading_sprite = false
        while bool_ do
            while f.on do
                local glory_to_the_us = 1117917059
                if PAD.IS_CONTROL_JUST_PRESSED(0, 24) then
                  local thing = player.get_entity_player_is_aiming_at(player.player_id())
                  if ENTITY.IS_ENTITY_A_PED(thing) ENTITY.IS_ENTITY_A_VEHICLE(thing) then
                    notify_t("this does not work on peds or vehicles")
                    else
                    helper_request_control(thing)
                    helper_set_entity_godmode(thing, true)
                    local eneity_hash2 = entity.get_entity_model_hash(thing) -- ONLY THING THAT NEEDS FIXING THERE IS NOT A NATIVED NAMED THIS. edit retard ass nigga GET_ENTITY_MODEL(Entity entity)
                    local entity_coords2_x, entity_coords2_y, entity_coords2_z = entity.GET_ENTITY_COORDS(thing, false)
                    ENTITY.CREATE_MODEL_SWAP(entity_coords2_x, entity_coords2_y, entity_coords2_z, 99--[[this is radius increase it if its not working]]    --[[, eneity_hash2, glory_to_the_us, 0)-- model swap
                  end
                end
              end
            wait_t(0)
        end
        _menu.loading_sprite = true
        --do stuff
        _menu.loading_sprite = false
    end)
end]]

--[[
to_enable.func = function(bool_)
    if bool_ then
        _settings.paint_gun = not _settings.paint_gun
    end
    toggle_helper(_settings.paint_gun, function()
        _menu.loading_sprite = true
        -- do stuff
        _menu.loading_sprite = false
        while _settings.paint_gun do
            -- paint splatter decal
            local decal = 1030
            WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(PLAYER.PLAYER_PED_ID(), Vector3* coords) -- there are no v3 pointers in the lua api imma kms
            GRAPHICS.ADD_DECAL(decal, float posX, float posY, float posZ, float p4, float p5, float p6, float p7, float p8, float p9, float width, float height, float rCoef, float gCoef, float bCoef, float opacity, float timeout, BOOL p17, BOOL p18, BOOL p19)
            wait_t(0)
        end
        _menu.loading_sprite = true
        --do stuff
        _menu.loading_sprite = false
    end)
end
]]

