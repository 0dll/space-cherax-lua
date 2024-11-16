



function _settings_main_()

    -------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------menu_position_options----------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    _g.null_hotkey, _settings.menu_pos_x = add_editor_option("Menu X Coord", " ", submenus.menu_position_menu, nil, false, _settings.menu_pos_x, -2.0, 2.0, 0.01, function() end)
    _g.null_hotkey, _settings.menu_pos_y = add_editor_option("Menu Y Coord", " ", submenus.menu_position_menu, nil, false, _settings.menu_pos_y, -2.0, 2.0, 0.01, function() end)


    -------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    --------------------------------------------------menu_size_options------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    _g.null_hotkey, _menu.menu_width = add_editor_option("Menu Width", " ", submenus.menu_size_menu, nil, false, _menu.menu_width, 0.0, 5.0, 0.0005, function() end)
    _g.null_hotkey, _menu.menu_hight = add_editor_option("Menu Height", " ", submenus.menu_size_menu, nil, false, _menu.menu_hight, 0.0, 5.0, 0.0005, function() end)

    -------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    -----------------------------------------------------settings------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    -- add_text_option "save"

    add_click_option("Save Current Hotkeys To Auto Load", " ", submenus.hot_key_files_menu, nil, false, function()
        _menu.loading_sprite = true
        g_save_hotkeys(FileMgr.GetMenuRootPath() .. "\\Lua\\space\\hotkeys\\" .. _menu.hot_key_file)
        _menu.loading_sprite = false
    end) -- cant have a hotkey


    key_option_output.save_hotkey_output, key_option_output.save_hotkey_input_bool = add_keyboard_option("Save Hotkeys To File", " ", submenus.hot_key_files_menu, key_option_output.save_hotkey_output, 32)
    if key_option_output.save_hotkey_input_bool and key_option_output.save_hotkey_output ~= nil then
        g_save_hotkeys(FileMgr.GetMenuRootPath() .. "\\Lua\\space\\hotkeys\\" .. key_option_output.save_hotkey_output .. ".lua")
        log_t(key_option_output.save_hotkey_output)
        key_option_output.save_hotkey_input_bool = false
    end

    add_break_option("Configs", submenus.hot_key_files_menu)

    for _, file in pairs(FileMgr.FindFiles(FileMgr.GetMenuRootPath() .. "\\Lua\\space\\hotkeys", ".lua", false)) do
        add_click_option("Load " .. extract_last_part(file), " ", submenus.hot_key_files_menu, nil, false, function() 
            _menu.loading_sprite = true
            g_load_hotkeys(FileMgr.GetMenuRootPath() .. "\\Lua\\space\\hotkeys\\" .. extract_last_part(file))
            notify_t(file)
            _menu.loading_sprite = false
        end)
    end

    -- add_text_option "files"
--[[
    add_click_option("Load Hotkeys", " ", submenus.settings_config, nil, false, function()
        _menu.loading_sprite = true
        g_load_hotkeys(FileMgr.GetMenuRootPath() .. "\\Lua\\space\\hotkeys\\" .. _menu.hot_key_file)
        _menu.loading_sprite = false
    end)
]]

    _hot_key_tbl.save_settings = add_click_option("Save Current Settings To Auto Load", " ", submenus.settings_files_menu, _hot_key_tbl.save_settings, false, function() 
        _menu.loading_sprite = true
        g_save_settings(FileMgr.GetMenuRootPath() .. "\\Lua\\space\\settings\\" .. _menu.settings_file, _settings)
        _menu.loading_sprite = false
    end)


    key_option_output.save_settings_output = " "
    key_option_output.save_settings_output, key_option_output.save_settings_input_bool = add_keyboard_option("Save Settings To File", " ", submenus.settings_files_menu, key_option_output.save_settings_output, 32)
    if key_option_output.save_settings_input_bool and key_option_output.save_settings_output ~= nil then
        g_save_settings(FileMgr.GetMenuRootPath() .. "\\Lua\\space\\settings\\" .. key_option_output.save_settings_output .. ".lua", _settings)
        key_option_output.save_settings_input_bool = false
    end

    add_break_option("Configs", submenus.settings_files_menu)


    for _, file in pairs(FileMgr.FindFiles(FileMgr.GetMenuRootPath() .. "\\Lua\\space\\settings", ".lua", false)) do
        add_click_option("Load " .. extract_last_part(file), " ", submenus.settings_files_menu, nil, false, function() 
            _menu.loading_sprite = true
            g_load_settings(FileMgr.GetMenuRootPath() .. "\\Lua\\space\\settings\\" .. extract_last_part(file))
            notify_t(file)
            _menu.loading_sprite = false
        end)
    end
    --[[
    add_click_option("Load Settings", " ", submenus.settings_config, nil, false, function()
        _menu.loading_sprite = true
        g_load_settings(FileMgr.GetMenuRootPath() .. "\\Lua\\space\\settings\\" .. _menu.settings_file)
        _menu.loading_sprite = false
    end) -- cant have a hotkey
    ]]

    add_click_option("Save Theme To Auto Loader", " ", submenus.theme_saving_menu, nil, false, function() 
        _menu.loading_sprite = true
        g_save_theme(FileMgr.GetMenuRootPath() .. "\\Lua\\space\\themes\\" .. _menu.theme_file)
        --notify_t(file)
        _menu.loading_sprite = false
    end)

    key_option_output.save_theme_output = " "
    key_option_output.save_theme_output, key_option_output.save_theme_input_bool = add_keyboard_option("Save theme To File", " ", submenus.theme_saving_menu, key_option_output.save_theme_output, 32)
    if key_option_output.save_theme_input_bool and key_option_output.save_theme_output ~= nil then
        g_save_theme(FileMgr.GetMenuRootPath() .. "\\Lua\\space\\themes\\" .. key_option_output.save_theme_output .. ".lua", _settings)
        key_option_output.save_theme_input_bool = false
    end

    add_break_option("Configs", submenus.theme_saving_menu)

    for _, file in pairs(FileMgr.FindFiles(FileMgr.GetMenuRootPath() .. "\\Lua\\space\\themes", ".lua", false)) do
        add_click_option("Load " .. extract_last_part(file), " ", submenus.theme_saving_menu, nil, false, function() 
            _menu.loading_sprite = true
            g_load_theme(FileMgr.GetMenuRootPath() .. "\\Lua\\space\\themes\\" .. extract_last_part(file))
            notify_t(file)
            _menu.loading_sprite = false
        end)
    end

    -- i hate lua there is not a good way to do pointers
    _themes.header_rainbow, _themes.header_rainbow_speed, menu_r.banner_color, menu_g.banner_color, menu_b.banner_color, menu_a.banner_color = add_color_option("Header Color", " ", submenus.theme_menu, submenus.header_color_menu, _themes.header_rainbow, _themes.header_rainbow_speed, 0.1, menu_r.banner_color, menu_g.banner_color, menu_b.banner_color, menu_a.banner_color, 0, 255, 1)
    
    _themes.header_text_rainbow, _themes.header_text_rainbow_speed, menu_r.banner_text_color, menu_g.banner_text_color, menu_b.banner_text_color, menu_a.banner_text_color = add_color_option("Header Text Color", " ", submenus.theme_menu, submenus.header_text_color_menu, _themes.header_text_rainbow, _themes.header_text_rainbow_speed, 0.1, menu_r.banner_text_color, menu_g.banner_text_color, menu_b.banner_text_color, menu_a.banner_text_color, 0, 255, 1)
    
    _themes.scroll_bar_rainbow, _themes.scroll_bar_rainbow_speed, menu_r.scroll_bar_color, menu_g.scroll_bar_color, menu_b.scroll_bar_color, menu_a.scroll_bar_color = add_color_option("Scroll Bar Color No Fade", " ", submenus.theme_menu, submenus.scroll_bar_color_no_fade_menu, _themes.scroll_bar_rainbow, _themes.scroll_bar_rainbow_speed, 0.1, menu_r.scroll_bar_color, menu_g.scroll_bar_color, menu_b.scroll_bar_color, menu_a.scroll_bar_color, 0, 255, 1)
    
    _themes.scroll_bar_start_rainbow, _themes.scroll_bar_start_rainbow_speed, menu_r.scroll_bar_start_color, menu_g.scroll_bar_start_color, menu_b.scroll_bar_start_color, menu_a.scroll_bar_start_color = add_color_option("Scroll Bar Color Fade Start", " ", submenus.theme_menu, submenus.scroll_bar_color_fade_start_menu, _themes.scroll_bar_start_rainbow, _themes.scroll_bar_start_rainbow_speed, 0.1, menu_r.scroll_bar_start_color, menu_g.scroll_bar_start_color, menu_b.scroll_bar_start_color, menu_a.scroll_bar_start_color, 0, 255, 1)
    
    _themes.scroll_bar_end_rainbow, _themes.scroll_bar_end_rainbow_speed, menu_r.scroll_bar_end_color, menu_g.scroll_bar_end_color, menu_b.scroll_bar_end_color, menu_a.scroll_bar_end_color = add_color_option("Scroll Bar Color With Fade End", " ", submenus.theme_menu, submenus.scroll_bar_color_fade_end_menu, _themes.scroll_bar_end_rainbow, _themes.scroll_bar_end_rainbow_speed, 0.1, menu_r.scroll_bar_end_color, menu_g.scroll_bar_end_color, menu_b.scroll_bar_end_color, menu_a.scroll_bar_end_color, 0, 255, 1)
    
    _themes.background_rainbow, _themes.background_rainbow_speed, menu_r.background_color, menu_g.background_color, menu_b.background_color, menu_a.background_color = add_color_option("Background Color", " ", submenus.theme_menu, submenus.background_color_menu, _themes.background_rainbow, _themes.background_rainbow_speed, 0.1, menu_r.background_color, menu_g.background_color, menu_b.background_color, menu_a.background_color, 0, 255, 1)
    
    _themes.footer_rainbow, _themes.footer_rainbow_speed, menu_r.footer_color, menu_g.footer_color, menu_b.footer_color, menu_a.footer_color = add_color_option("Footer Color", " ", submenus.theme_menu, submenus.footer_color_menu, _themes.footer_rainbow, _themes.footer_rainbow_speed, 0.1, menu_r.footer_color, menu_g.footer_color, menu_b.footer_color, menu_a.footer_color, 0, 255, 1)
    
    _themes.sub_footer_rainbow, _themes.sub_footer_rainbow_speed, menu_r.sub_footer_color, menu_g.sub_footer_color, menu_b.sub_footer_color, menu_a.sub_footer_color = add_color_option("Sub Footer Color", " ", submenus.theme_menu, submenus.sub_footer_color_menu, _themes.sub_footer_rainbow, _themes.sub_footer_rainbow_speed, 0.1, menu_r.sub_footer_color, menu_g.sub_footer_color, menu_b.sub_footer_color, menu_a.sub_footer_color, 0, 255, 1)
    
    _themes.sub_footer_text_rainbow, _themes.sub_footer_text_rainbow_speed, menu_r.footer_text_color, menu_g.footer_text_color, menu_b.footer_text_color, menu_a.footer_text_color = add_color_option("Sub Footer Text Color", " ", submenus.theme_menu, submenus.sub_footer_text_color_menu, _themes.sub_footer_text_rainbow, _themes.sub_footer_text_rainbow_speed, 0.1, menu_r.footer_text_color, menu_g.footer_text_color, menu_b.footer_text_color, menu_a.footer_text_color, 0, 255, 1)
    
    _themes.option_rainbow, _themes.option_rainbow_speed, menu_r.option_color, menu_g.option_color, menu_b.option_color, menu_a.option_color = add_color_option("Option Text Color", " ", submenus.theme_menu, submenus.option_text_color_menu, _themes.option_rainbow, _themes.option_rainbow_speed, 0.1, menu_r.option_color, menu_g.option_color, menu_b.option_color, menu_a.option_color, 0, 255, 1)
    
    _themes.option_selected_rainbow, _themes.option_selected_rainbow_speed, menu_r.option_selected_color, menu_g.option_selected_color, menu_b.option_selected_color, menu_a.option_selected_color = add_color_option("Option Selected Text Color", " ", submenus.theme_menu, submenus.option_text_selected_color_menu, _themes.option_selected_rainbow, _themes.option_selected_rainbow_speed, 0.1, menu_r.option_selected_color, menu_g.option_selected_color, menu_b.option_selected_color, menu_a.option_selected_color, 0, 255, 1)
    
    _themes.loading_rainbow, _themes.loading_rainbow_speed, menu_r.loading_color, menu_g.loading_color, menu_b.loading_color, menu_a.loading_color = add_color_option("Loading Indicator Color", " ", submenus.theme_menu, submenus.loading_indicator_color_menu, _themes.loading_rainbow, _themes.loading_rainbow_speed, 0.1, menu_r.loading_color, menu_g.loading_color, menu_b.loading_color, menu_a.loading_color, 0, 255, 1)

    _themes.break_option_rainbow, _themes.break_option_rainbow_speed, menu_r.break_option_color, menu_g.break_option_color, menu_b.break_option_color, menu_a.break_option_color = add_color_option("Break Option Color", " ", submenus.theme_menu, submenus.break_option_color_menu, _themes.break_option_rainbow, _themes.break_option_rainbow_speed, 0.1, menu_r.break_option_color, menu_g.break_option_color, menu_b.break_option_color, menu_a.break_option_color, 0, 255, 1)



    add_submenu_option("Config", " ", submenus.settings_main_menu, submenus.settings_config)
    add_submenu_option("Hotkeys", " ", submenus.settings_config, submenus.hot_key_files_menu)
    add_submenu_option("Settings", " ", submenus.settings_config, submenus.settings_files_menu)
    add_submenu_option("Theme", " ", submenus.settings_config, submenus.theme_menu)
    add_submenu_option("Theme Saving", " ", submenus.theme_menu, submenus.theme_saving_menu)




    add_submenu_option("Menu Position", " ", submenus.settings_main_menu, submenus.menu_position_menu)
    add_submenu_option("Menu Size", " ", submenus.settings_main_menu, submenus.menu_size_menu)
    add_toggle_option("Open Tooltip", " ", submenus.settings_main_menu, nil, false, _settings.tooltip_text, function() _settings.tooltip_text = not _settings.tooltip_text end)
    add_toggle_option("Use Multi Color Scroll Bar", " ", submenus.settings_main_menu, nil, false, _settings.use_multi_color_rect, function() _settings.use_multi_color_rect = not _settings.use_multi_color_rect end)

    if _menu.is_dev then
        add_click_option("click to pack lua", " ", submenus.settings_main_menu, nil, false, function() 
            _menu.loading_sprite = true
            pack_entire_lua()
            _menu.loading_sprite = false
        end)
    end
end