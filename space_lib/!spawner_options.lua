



--[[
function _object_spawner_objects_()

    for index, string_name in pairs(all_objects_table_t) do
        add_click_option(string_name, " ", nil, false, function() 
                _menu.loading_sprite = true
                spawn_object_for_object_spawner(MISC.GET_HASH_KEY(string_name))
                _menu.loading_sprite = false
            end)
    end

end
]]


function _spawner_options_()

    for index, string_name in pairs(all_vehicles_table_t) do
        if (VEHICLE.GET_VEHICLE_CLASS_FROM_NAME(MISC.GET_HASH_KEY(string_name)) == _menu.selected_vehicle_class_for_vehicle_spawner) or (_g.should_loop_all_vehicle_spawn_options) then
            if HUD.GET_FILENAME_FOR_AUDIO_CONVERSATION(string_name) == "NULL" then
                _menu.should_use_name = true
            end

            _hot_key_tbl["vehicle_spawner_vehicle_" .. string_name] = add_click_option(bool_true_false(_menu.should_use_name, string_name, HUD.GET_FILENAME_FOR_AUDIO_CONVERSATION(string_name)), " ", submenus.vehicle_spawner_selected_class, _hot_key_tbl["vehicle_spawner_vehicle_" .. string_name], true, function() 
                _menu.loading_sprite = true
                spawn_vehicle_for_vehicle_spawner(MISC.GET_HASH_KEY(string_name))
                _menu.loading_sprite = false
            end)
            _menu.should_use_name = false
        end
    end


    if submenus.vehicle_spawner_classes_menu == menu_storage[#menu_storage] then
        _menu.selected_vehicle_class_for_vehicle_spawner = _menu.m_current_option - 1
        for i=0, 22 do
            add_submenu_option(HUD.GET_FILENAME_FOR_AUDIO_CONVERSATION("VEH_CLASS_" .. tostring(i)), " ", submenus.vehicle_spawner_classes_menu, submenus.vehicle_spawner_selected_class)
            --_menu.selected_vehicle_class_for_vehicle_spawner = _menu.m_current_option - 1
        end

    end

    add_toggle_option("Spawn Inside Vehicle", " ", submenus.vehicle_spawner_menu, nil, false, _settings.spawn_inside_vehicle_vspawn, function() _settings.spawn_inside_vehicle_vspawn = not _settings.spawn_inside_vehicle_vspawn end)
    add_toggle_option("Spawn With Custom Color", " ", submenus.vehicle_spawner_menu, nil, false, _settings.spawn_with_custom_color_vspawn, function() _settings.spawn_with_custom_color_vspawn = not _settings.spawn_with_custom_color_vspawn end)
    add_toggle_option("Spawn With PTFX", " ", submenus.vehicle_spawner_menu, nil, false, _settings.spawn_with_ptfx_vspawn, function() _settings.spawn_with_ptfx_vspawn = not _settings.spawn_with_ptfx_vspawn end)
    add_toggle_option("Delete Current Vehicle", " ", submenus.vehicle_spawner_menu, nil, false, _settings.delete_current_vehicle_vspawn, function() _settings.delete_current_vehicle_vspawn = not _settings.delete_current_vehicle_vspawn end)
    add_toggle_option("Spawn With Max Upgrades", " ", submenus.vehicle_spawner_menu, nil, false, _settings.spawn_with_max_upgrades, function() _settings.spawn_with_max_upgrades = not _settings.spawn_with_max_upgrades end)
    add_toggle_option("Spawn With No Windows", " ", submenus.vehicle_spawner_menu, nil, false, _settings.spawn_with_no_windows_vspawn, function() _settings.spawn_with_no_windows_vspawn = not _settings.spawn_with_no_windows_vspawn end)
    add_toggle_option("Spawn With Windows Rolled Down", " ", submenus.vehicle_spawner_menu, nil, false, _settings.spawn_with_windows_rolled_down_vspawn, function() _settings.spawn_with_windows_rolled_down_vspawn = not _settings.spawn_with_windows_rolled_down_vspawn end)

    add_submenu_option("Vehicle Spawner", " ", submenus.spawner_menu, submenus.vehicle_spawner_menu)
    add_submenu_option("Classes", " ", submenus.vehicle_spawner_menu, submenus.vehicle_spawner_classes_menu)


    --add_submenu_option("Object Spawner", " ", _object_spawner_objects_)

end
