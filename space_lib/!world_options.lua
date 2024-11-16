
function _world_options_main_()

    _hot_key_tbl.create_train_for_train_opt = add_click_option("Create Train", "", submenus.world_train_menu, _hot_key_tbl.create_train_for_train_opt, true, function() create_train_for_train_options() end)
    _hot_key_tbl.set_train_speed, _settings.set_train_speed_value = add_toggle_editor_option("Set Train Speed", " ", submenus.world_train_menu, _hot_key_tbl.set_train_speed, true, _settings.set_train_speed, _settings.set_train_speed_value, 1.0, 1000.0, 1.0, function() to_enable.set_train_speed(true) end)
    
    --_hot_key_tbl.derail_train_for_train_opt = add_click_option("Derail Train", " ", submenus.world_train_menu, _hot_key_tbl.derail_train_for_train_opt, true, function() derail_train_for_tain_opts() end)
    
    _hot_key_tbl.delete_train_for_train_opt = add_click_option("Delete Train", " ", submenus.world_train_menu, _hot_key_tbl.delete_train_for_train_opt, true, function() delete_train_for_tain_opts() end)
    _hot_key_tbl.exit_train_for_train_opt = add_click_option("Exit Train", " ", submenus.world_train_menu, _hot_key_tbl.exit_train_for_train_opt, true, function() exit_train_for_tain_opts() end)

    add_submenu_option("Train", " ", submenus.world_main_menu, submenus.world_train_menu)
    _hot_key_tbl.water_wave_intensity, _settings.water_wave_intensity_value = add_toggle_editor_option("Set Water Wave Intensity", " ", submenus.world_main_menu, _hot_key_tbl.water_wave_intensity, true, _settings.water_wave_intensity_bool, _settings.water_wave_intensity_value, 0.0, 100.0, 0.1, function() to_enable.water_wave_intensity(true) end)
    _hot_key_tbl.gravity_level, _settings.gravity_level_value = add_toggle_editor_option("Set Gravity Level", " ", submenus.world_main_menu, _hot_key_tbl.gravity_level, true, _settings.gravity_level_bool, _settings.gravity_level_value, 0, 3, 1, function() to_enable.gravity_level(true) end)
end