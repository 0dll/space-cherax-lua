
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

