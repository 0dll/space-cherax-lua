


function _paint_editor_and_saver_()

    local key

    local color_textrue_primary_vopt = Memory.AllocInt()
    local color_texture_type_secondary_vopt = Memory.AllocInt()



    local vehicle_custom_primary_r_vopt = Memory.AllocInt()
    local vehicle_custom_primary_g_vopt = Memory.AllocInt()
    local vehicle_custom_primary_b_vopt = Memory.AllocInt()

    local vehicle_custom_secondary_r_vopt = Memory.AllocInt()
    local vehicle_custom_secondary_g_vopt = Memory.AllocInt()
    local vehicle_custom_secondary_b_vopt = Memory.AllocInt()

    local vehicle_extra_color_primary_vopt = Memory.AllocInt()
    local vehicle_extra_color_secondary_vopt = Memory.AllocInt()

    local vehicle_extra_color_5 = Memory.AllocInt()
    local vehicle_extra_color_6 = Memory.AllocInt()

    local vehicle_tyre_smoke_color_r = Memory.AllocInt()
    local vehicle_tyre_smoke_color_g = Memory.AllocInt()
    local vehicle_tyre_smoke_color_b = Memory.AllocInt()


    VEHICLE.GET_VEHICLE_COLOURS(PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false), color_textrue_primary_vopt, color_texture_type_secondary_vopt)
    VEHICLE.GET_VEHICLE_CUSTOM_PRIMARY_COLOUR(PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false), vehicle_custom_primary_r_vopt, vehicle_custom_primary_g_vopt, vehicle_custom_primary_b_vopt)
    VEHICLE.GET_VEHICLE_CUSTOM_SECONDARY_COLOUR(PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false), vehicle_custom_secondary_r_vopt, vehicle_custom_secondary_g_vopt, vehicle_custom_secondary_b_vopt)
    VEHICLE.GET_VEHICLE_EXTRA_COLOURS(PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false), vehicle_extra_color_primary_vopt, vehicle_extra_color_secondary_vopt)
    VEHICLE.GET_VEHICLE_EXTRA_COLOUR_5(PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false), vehicle_extra_color_5)
    VEHICLE.GET_VEHICLE_EXTRA_COLOUR_6(PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false), vehicle_extra_color_6)

    VEHICLE.GET_VEHICLE_TYRE_SMOKE_COLOR(PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false), vehicle_tyre_smoke_color_r, vehicle_tyre_smoke_color_g, vehicle_tyre_smoke_color_b)

    --[[VEHICLE.SET_VEHICLE_COLOURS(PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false), memory.read_int(color_textrue_primary_vopt), memory.read_int(color_textrue_primary_color_vopt))
    VEHICLE.SET_VEHICLE_MOD_COLOR_2(PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false), memory.read_int(color_texture_type_secondary_vopt), memory.read_int(color_textrue_secondary_color_vopt))
    VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false), memory.read_int(vehicle_custom_primary_r_vopt), memory.read_int(vehicle_custom_primary_g_vopt), memory.read_int(vehicle_custom_primary_b_vopt))
    VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false), memory.read_int(vehicle_custom_secondary_r_vopt), memory.read_int(vehicle_custom_secondary_g_vopt), memory.read_int(vehicle_custom_secondary_b_vopt))
    VEHICLE.SET_VEHICLE_EXTRA_COLOURS(PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false), memory.read_int(vehicle_extra_color_primary_vopt), memory.read_int(vehicle_extra_color_secondary_vopt))
    VEHICLE.SET_VEHICLE_EXTRA_COLOUR_5(PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false), memory.read_int(vehicle_extra_color_5))
    VEHICLE.SET_VEHICLE_EXTRA_COLOUR_6(PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false), memory.read_int(vehicle_extra_color_6))]]

    _file.vehicle_color_type_primary = Memory.ReadInt(color_textrue_primary_vopt)
    _file.vehicle_color_type_secondary = Memory.ReadInt(color_texture_type_secondary_vopt)
    _file.vehicle_custom_primary_r = Memory.ReadInt(vehicle_custom_primary_r_vopt)
    _file.vehicle_custom_primary_g = Memory.ReadInt(vehicle_custom_primary_g_vopt)
    _file.vehicle_custom_primary_b = Memory.ReadInt(vehicle_custom_primary_b_vopt)
    _file.vehicle_custom_secondary_r = Memory.ReadInt(vehicle_custom_secondary_r_vopt)
    _file.vehicle_custom_secondary_g = Memory.ReadInt(vehicle_custom_secondary_g_vopt)
    _file.vehicle_custom_secondary_b = Memory.ReadInt(vehicle_custom_secondary_b_vopt)
    _file.vehicle_extra_color_secondary = Memory.ReadInt(vehicle_extra_color_secondary_vopt)
    _file.vehicle_extra_color_primary = Memory.ReadInt(vehicle_extra_color_primary_vopt)
    _file.vehicle_extra_color_5 = Memory.ReadInt(vehicle_extra_color_5)
    _file.vehicle_extra_color_6 = Memory.ReadInt(vehicle_extra_color_6)

    _file.vehicle_tyre_smoke_color_r = Memory.ReadInt(vehicle_tyre_smoke_color_r)
    _file.vehicle_tyre_smoke_color_g = Memory.ReadInt(vehicle_tyre_smoke_color_g)
    _file.vehicle_tyre_smoke_color_b = Memory.ReadInt(vehicle_tyre_smoke_color_b)


    Memory.Free(color_textrue_primary_vopt)
    Memory.Free(color_texture_type_secondary_vopt)
    Memory.Free(vehicle_custom_primary_r_vopt)
    Memory.Free(vehicle_custom_primary_g_vopt)
    Memory.Free(vehicle_custom_primary_b_vopt)
    Memory.Free(vehicle_custom_secondary_r_vopt)
    Memory.Free(vehicle_custom_secondary_g_vopt)
    Memory.Free(vehicle_custom_secondary_b_vopt)
    Memory.Free(vehicle_extra_color_secondary_vopt)
    Memory.Free(vehicle_extra_color_primary_vopt)
    Memory.Free(vehicle_extra_color_5)
    Memory.Free(vehicle_extra_color_6)

    Memory.Free(vehicle_tyre_smoke_color_r)
    Memory.Free(vehicle_tyre_smoke_color_g)
    Memory.Free(vehicle_tyre_smoke_color_b)



    key, _file.vehicle_color_type_primary = add_editor_option("Color Textrue Primary", " ", submenus.paint_editor_and_saver_menu, key, false, _file.vehicle_color_type_primary, 0, 300, 1, function() end)

    key, _file.vehicle_color_type_secondary = add_editor_option("Color Textrue Secondary", " ", submenus.paint_editor_and_saver_menu, key, false, _file.vehicle_color_type_secondary, 0, 300, 1, function() end)

    key, _file.vehicle_extra_color_primary = add_editor_option("Pearlescent Color", " ", submenus.paint_editor_and_saver_menu, key, false, _file.vehicle_extra_color_primary, 0, 300, 1, function() end)

    key, _file.vehicle_extra_color_secondary = add_editor_option("Wheel Color", " ", submenus.paint_editor_and_saver_menu, key, false, _file.vehicle_extra_color_secondary, 0, 300, 1, function() end)

    key, _file.vehicle_custom_primary_r = add_editor_option("Primary Red", " ", submenus.paint_editor_and_saver_menu, key, false, _file.vehicle_custom_primary_r, 0, 255, 1, function() end)

    key, _file.vehicle_custom_primary_g = add_editor_option("Primary Green", " ", submenus.paint_editor_and_saver_menu, key, false, _file.vehicle_custom_primary_g, 0, 255, 1, function() end)

    key, _file.vehicle_custom_primary_b = add_editor_option("Primary Blue", " ", submenus.paint_editor_and_saver_menu, key, false, _file.vehicle_custom_primary_b, 0, 255, 1, function() end)

    key, _file.vehicle_custom_secondary_r = add_editor_option("Secondary Red", " ", submenus.paint_editor_and_saver_menu, key, false, _file.vehicle_custom_secondary_r, 0, 255, 1, function() end)

    key, _file.vehicle_custom_secondary_g = add_editor_option("Secondary Green", " ", submenus.paint_editor_and_saver_menu, key, false, _file.vehicle_custom_secondary_g, 0, 255, 1, function() end)

    key, _file.vehicle_custom_secondary_b = add_editor_option("Secondary Blue", " ", submenus.paint_editor_and_saver_menu, key, false, _file.vehicle_custom_secondary_b, 0, 255, 1, function() end)

    key, _file.vehicle_extra_color_5 = add_editor_option("Extra Color 1", " ", submenus.paint_editor_and_saver_menu, key, false, _file.vehicle_extra_color_5, 0, 300, 1, function() end)

    key, _file.vehicle_extra_color_6 = add_editor_option("Extra Color 2", " ", submenus.paint_editor_and_saver_menu, key, false, _file.vehicle_extra_color_6, 0, 300, 1, function() end)


    key, _file.vehicle_tyre_smoke_color_r = add_editor_option("Vehicle Tyre Smoke Red", "setting r,g,b to 0 will give the car the Patriot tire smoke.", submenus.paint_editor_and_saver_menu, key, false, _file.vehicle_tyre_smoke_color_r, 0, 255, 1, function() end)

    key, _file.vehicle_tyre_smoke_color_g = add_editor_option("Vehicle Tyre Smoke Green", "setting r,g,b to 0 will give the car the Patriot tire smoke.", submenus.paint_editor_and_saver_menu, key, false, _file.vehicle_tyre_smoke_color_g, 0, 255, 1, function() end)

    key, _file.vehicle_tyre_smoke_color_b = add_editor_option("Vehicle Tyre Smoke Blue", "setting r,g,b to 0 will give the car the Patriot tire smoke.", submenus.paint_editor_and_saver_menu, key, false, _file.vehicle_tyre_smoke_color_b, 0, 255, 1, function() end)



    --VEHICLE.SET_VEHICLE_COLOURS(PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false), _file.vehicle_color_type_primary, --[[memory.read_int(color_textrue_primary_color_vopt)]])
    --VEHICLE.SET_VEHICLE_MOD_COLOR_2(PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false), _file.vehicle_color_type_secondary, memory.read_int(color_textrue_secondary_color_vopt))
    VEHICLE.SET_VEHICLE_COLOURS(PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false), _file.vehicle_color_type_primary, _file.vehicle_color_type_secondary)
    VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false), _file.vehicle_custom_primary_r, _file.vehicle_custom_primary_g, _file.vehicle_custom_primary_b)
    VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false), _file.vehicle_custom_secondary_r, _file.vehicle_custom_secondary_g, _file.vehicle_custom_secondary_b)
    VEHICLE.SET_VEHICLE_EXTRA_COLOURS(PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false), _file.vehicle_extra_color_primary, _file.vehicle_extra_color_secondary)
    VEHICLE.SET_VEHICLE_EXTRA_COLOUR_5(PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false), _file.vehicle_extra_color_5)
    VEHICLE.SET_VEHICLE_EXTRA_COLOUR_6(PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false), _file.vehicle_extra_color_6)
    VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false), _file.vehicle_tyre_smoke_color_r, _file.vehicle_tyre_smoke_color_g, _file.vehicle_tyre_smoke_color_b)
    
    add_break_option("save", submenus.paint_editor_and_saver_menu)

    save_paint_output = " "
    save_paint_output, save_paint_input_bool = add_keyboard_option("Save Paint", " ", submenus.paint_editor_and_saver_menu, save_paint_output, 32)
    if save_paint_input_bool and save_paint_output ~= nil then
        g_vehicle_paint_save(FileMgr.GetMenuRootPath() .. "\\Lua\\space\\paints\\" .. save_paint_output .. ".lua")
        save_paint_input_bool = false
    end


end

function _select_paint_to_load_for_paint_loader_()

    --[[add_click_option("load paint", nil, function() 
        _menu.loading_sprite = true
        g_vehicle_paint_load(_menu.paint_file)
        _menu.loading_sprite = false
    end)]]

    local files = FileMgr.FindFiles(FileMgr.GetMenuRootPath() .. "\\Lua\\space\\paints", ".lua", false)

    for _, file in pairs(files) do
        _hot_key_tbl["load_paint_name_" .. extract_last_part(file)] = add_click_option(extract_last_part(file), " ", submenus.select_paint_to_load_menu, _hot_key_tbl["load_paint_name_" .. extract_last_part(file)], true, function() 
            _menu.loading_sprite = true
            g_vehicle_paint_load(file)
            notify_t(file)
            _menu.loading_sprite = false
        end)
    end


end



function _vehicle_options_()

    _select_paint_to_load_for_paint_loader_()
    _paint_editor_and_saver_()
    _hot_key_tbl.rainbow_paint, _settings.rainbow_paint_value = add_toggle_editor_option("Rainbow Paint", " ", submenus.vehicle_rgb_menu, _hot_key_tbl.rainbow_paint, true, _settings.rainbow_paint, _settings.rainbow_paint_value, 0.1, 5.0, 0.1, function() to_enable.rainbow_paint(true) end)

    add_submenu_option("Paint Options", " ", submenus.vehicle_main_menu, submenus.paint_editor_menu)
    -- below goes in paint options 
    add_submenu_option("Paint Editor", " ", submenus.paint_editor_menu, submenus.paint_editor_and_saver_menu)
    add_submenu_option("Load Paint File", " ", submenus.paint_editor_menu, submenus.select_paint_to_load_menu)


    add_submenu_option("Rainbow Options", "", submenus.vehicle_main_menu, submenus.vehicle_rgb_menu)

    _hot_key_tbl.vehicle_projectile_rapid_fire, _settings.vehicle_projectile_rapid_fire_speed = add_toggle_editor_option("Projectile Rapid Fire", "Smaller The Number The Faster It Shoots", submenus.vehicle_main_menu, _hot_key_tbl.vehicle_projectile_rapid_fire, true, _settings.vehicle_projectile_rapid_fire, _settings.vehicle_projectile_rapid_fire_speed, 0, 500, 10, function() to_enable.vehicle_projectile_rapid_fire_func(true) end)
    _hot_key_tbl.vehicle_fly_hotkey, _settings.vehicle_fly_value = add_toggle_editor_option("Vehicle Fly", "Its Just Like What Impulse And Luna Had", submenus.vehicle_main_menu, _hot_key_tbl.vehicle_fly_hotkey, true, _settings.vehicle_fly_bool, _settings.vehicle_fly_value, 1, 300, 1, function() to_enable.vehicle_fly(true) end)
    _hot_key_tbl.vehicle_speed_plate = add_toggle_option("Speed On Plate", "Unit Is What Ever You Have The Unit Set To In The Menu", submenus.vehicle_main_menu, _hot_key_tbl.vehicle_speed_plate, true, _settings.vehicle_speed_plate, function() to_enable.speed_plate(true) end)
end
