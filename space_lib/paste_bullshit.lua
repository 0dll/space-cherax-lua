






add_submenu_option("option_text", "info_text", sub_menu, menu_two_push)

add_submenu_option_players_list("option_text", sub_menu, detections, menu_two_push)

hot_key = add_click_option("option_text", "info_text", sub_menu, hot_key, bool_has_hotkey, function() callback_ end)

hot_key = add_toggle_option("option_text", "info_text", sub_menu, hot_key, bool_has_hotkey, _toggle, function() callback_ end)

hot_key, _value = add_toggle_editor_option(option_text, info_text, sub_menu, hot_key, bool_has_hotkey, _toggle, _value, _min, _max, _mod, function() _callback end)

save_paint_output, save_paint_input_bool = add_keyboard_option("option_text", "info_text", sub_menu, save_paint_output, length--[[usually 32]])
if save_paint_input_bool and save_paint_output ~= nil then
    -- do something with the string given
    save_paint_input_bool = false
end


function paste()
    _menu.loading_sprite = true
    -- do stuff
    _menu.loading_sprite = false
end

to_enable.func = function(bool_)
    if bool_ then
        option_bool = not option_bool
    end
    toggle_helper(option_bool, function()
        _menu.loading_sprite = true
        -- do stuff
        _menu.loading_sprite = false
        while option_bool do

            wait_t(0)
        end
        _menu.loading_sprite = true
        --do stuff
        _menu.loading_sprite = false
    end)
end

    -------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    --------------------------------------------------submenu_divider--------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------