
function _self_options_main_()

    _hot_key_tbl.ped_wetness, _settings.ped_wetness_value = add_toggle_editor_option("Ped Wetness", "", submenus.self_main_menu, _hot_key_tbl.ped_wetness, true, _settings.ped_wetness, _settings.ped_wetness_value, -1.10, 0.75, 0.05, function() to_enable.option_ped_wetness(true) end)

    _hot_key_tbl.disable_landing_anim = add_toggle_option("Instant Land", " ", submenus.self_main_menu, _hot_key_tbl.disable_landing_anim, true, _settings.disable_landing_anim, function() to_enable.disable_landing_anim_func(true) end)

    _hot_key_tbl.auto_clean_player = add_toggle_option("Auto Clean Player", " ", submenus.self_main_menu, _hot_key_tbl.auto_clean_player, true, _settings.auto_clean_player, function() to_enable.auto_clean_player_func(true) end)

end
