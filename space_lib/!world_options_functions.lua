

to_enable.gravity_level = function(bool_)
    if bool_ then
        _settings.gravity_level_bool = not _settings.gravity_level_bool
    end
    toggle_helper(_settings.gravity_level_bool, function()
        _menu.loading_sprite = true
        -- do stuff
        _menu.loading_sprite = false
        while _settings.gravity_level_bool do
            MISC.SET_GRAVITY_LEVEL(_settings.gravity_level_value)
            wait_t(0)
        end
        _menu.loading_sprite = true
        MISC.SET_GRAVITY_LEVEL(0)
        _menu.loading_sprite = false
    end)
end





to_enable.water_wave_intensity = function(bool_)
    if bool_ then
        _settings.water_wave_intensity_bool = not _settings.water_wave_intensity_bool
    end
    toggle_helper(_settings.water_wave_intensity_bool, function()
        _menu.loading_sprite = true
        -- do stuff
        _menu.loading_sprite = false
        while _settings.water_wave_intensity_bool do
            WATER.SET_DEEP_OCEAN_SCALER(_settings.water_wave_intensity_value)
            wait_t(0)
        end
        _menu.loading_sprite = true
        WATER.RESET_DEEP_OCEAN_SCALER()
        _menu.loading_sprite = false
    end)
end

function create_train_for_train_options()
    _menu.loading_sprite = true

    helper_request_model(MISC.GET_HASH_KEY("freight"), _g.spawn_timeout)
    helper_request_model(MISC.GET_HASH_KEY("freightcar"), _g.spawn_timeout)
    helper_request_model(MISC.GET_HASH_KEY("freightgrain"), _g.spawn_timeout)
    helper_request_model(MISC.GET_HASH_KEY("freightcont1"), _g.spawn_timeout)
    helper_request_model(MISC.GET_HASH_KEY("freightcont2"), _g.spawn_timeout)
    helper_request_model(MISC.GET_HASH_KEY("freighttrailer"), _g.spawn_timeout)

    local ped_x, ped_y, ped_z = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)

    _menu.global_train_created = VEHICLE.CREATE_MISSION_TRAIN(15, ped_x, ped_y, ped_z, true, true, false)
    wait_t(100)
    PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), _menu.global_train_created, -1)
    _menu.loading_sprite = false
end

to_enable.set_train_speed = function(bool_)
    if bool_ then
        _settings.set_train_speed = not _settings.set_train_speed
    end
    toggle_helper(_settings.set_train_speed, function()
        _menu.loading_sprite = true
        -- do stuff
        _menu.loading_sprite = false
        while _settings.set_train_speed do
            VEHICLE.SET_TRAIN_SPEED(PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), true), _settings.set_train_speed_value)
            --VEHICLE.SET_TRAIN_CRUISE_SPEED(PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), true), _settings.set_train_speed_value)
            wait_t(0) -- SET_TRAIN_CRUISE_SPEED
        end
        _menu.loading_sprite = true
        --do stuff
        _menu.loading_sprite = false
    end)
end

function derail_train_for_tain_opts()
    
    ENTITY.FREEZE_ENTITY_POSITION(_menu.global_train_created, false)
    ENTITY.DETACH_ENTITY(_menu.global_train_created, true, true)

    wait_t(0)
    
    for i=0, 40, -1 do -- there should not be more then 40
        local cabooose = VEHICLE.GET_TRAIN_CARRIAGE(PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), true), i)
        ENTITY.FREEZE_ENTITY_POSITION(cabooose, false)
        ENTITY.DETACH_ENTITY(cabooose, true, true)
    end
end

function delete_train_for_tain_opts()
    --[[ _menu.global_train_created
    for i=1, 40 do -- there should not be more then 40
        local cabooose = VEHICLE.GET_TRAIN_CARRIAGE(PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), true), i)
        helper_delete_entity(cabooose)
    end
    helper_delete_entity(PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), true))
    ]]

    helper_delete_mission_train(_menu.global_train_created)
    --VEHICLE.DELETE_ALL_TRAINS()
end


function exit_train_for_tain_opts()
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.PLAYER_PED_ID())
end


