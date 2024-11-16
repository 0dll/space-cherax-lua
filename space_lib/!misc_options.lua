
function _misc_options_main_()

    _hot_key_tbl.rappel_at_des = add_toggle_option("Chopper Escort Rappel At Destination", " ", submenus.misc_main_menu, _hot_key_tbl.rappel_at_des, true, _settings.rappel_at_des_bool, function() rappel_at_des_function(true) end)

end