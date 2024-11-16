
function _weapon_options_main_()

    _hot_key_tbl.drive_it_gun = add_toggle_option("Drive It Gun", " ", submenus.weapon_main_menu, _hot_key_tbl.drive_it_gun, true, _settings.drive_it_gun, function() to_enable.drive_it_gun_func(true) end)
    _hot_key_tbl.freeze_entity_gun = add_toggle_option("Freeze Entity Gun", " ", submenus.weapon_main_menu, _hot_key_tbl.freeze_entity_gun, true, _settings.freeze_entity_gun, function() to_enable.freeze_entity_gun(true) end)


end


