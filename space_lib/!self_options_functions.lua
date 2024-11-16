to_enable.option_ped_wetness = function(bool_)
    if bool_ then
        _settings.ped_wetness = not _settings.ped_wetness
    end
    toggle_helper(_settings.ped_wetness, function()
        _menu.loading_sprite = true
        -- do stuff
        _menu.loading_sprite = false
        while _settings.ped_wetness do
            PED.SET_PED_WETNESS_HEIGHT(PLAYER.PLAYER_PED_ID(), _settings.ped_wetness_value)
            wait_t(0)
        end
        _menu.loading_sprite = true
        PED.CLEAR_PED_WETNESS(PLAYER.PLAYER_PED_ID())
        _menu.loading_sprite = false
    end)
    notify_t("ped wet func called")
    log_t("ped wet func called")
end


to_enable.disable_landing_anim_func = function(bool_)
    if bool_ then
        _settings.disable_landing_anim = not _settings.disable_landing_anim
    end
    toggle_helper(_settings.disable_landing_anim, function()
        _menu.loading_sprite = true
        _menu.loading_sprite = false
        while _settings.disable_landing_anim do
            if PED.IS_PED_LANDING(PLAYER.PLAYER_PED_ID()) then
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.PLAYER_PED_ID())
            end
            wait_t(0)
        end
        _menu.loading_sprite = true
        _menu.loading_sprite = false
    end)

end



to_enable.auto_clean_player_func = function(bool_)
    if bool_ then
        _settings.auto_clean_player = not _settings.auto_clean_player
    end
    toggle_helper(_settings.auto_clean_player, function()
        _menu.loading_sprite = true
        _menu.loading_sprite = false
        while _settings.auto_clean_player do
            PED.CLEAR_PED_BLOOD_DAMAGE(PLAYER.PLAYER_PED_ID())
            PED.CLEAR_PED_ENV_DIRT(PLAYER.PLAYER_PED_ID())
            wait_t(0)
        end
        _menu.loading_sprite = true
        _menu.loading_sprite = false
    end)

end


