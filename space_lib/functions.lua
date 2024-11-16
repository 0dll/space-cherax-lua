--[[

    ┌──────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    │ THIS LUA WAS CREATED BY CALDWELL/SPACE OR ANY OTHER NAME I HAVE GONE BY.                                     │
    │                                                                                                              │
    │                                                                                                              │
    │******************************************* SPACE ON TOP *****************************************************│
    │                                                                                                              │
    │                    feel free to dm me for suggestions wont say i will respond though                         │
    │                                                                                                              │
    │                                                                                                              │
    └──────────────────────────────────────────────────────────────────────────────────────────────────────────────┘

]]

function hex_to_rgba_(hex)

    hex = hex:gsub("#", "")

    local r = tonumber(hex:sub(1, 2), 16)
    local g = tonumber(hex:sub(3, 4), 16)
    local b = tonumber(hex:sub(5, 6), 16)

    local a = tonumber(hex:sub(7, 8), 16) or 255

    return r, g, b, a
end

--how its used if anyone wants to use it just put credit to me in comments
--local r, g, b, a = hex_to_rgba_("#FF000080")


function rgba_to_hex_(r, g, b, a)
    r, g, b, a = math.min(255, math.max(0, r)), math.min(255, math.max(0, g)), math.min(255, math.max(0, b)), math.min(255, math.max(0, a))

    local hex = string.format("#%02X%02X%02X", r, g, b)

    local alphaHex = string.format("%02X", a)

    return hex .. alphaHex
end

local rip_mt = {
    __index = {
        rip = function(self)
            return Memory.Rip(self)
        end
    }
}

local number_mt = {
    __index = {
        floor_t = function(self)
            return math.floor(self)
        end
    }
}

-- fix conflicting metatable
local combined_mt = {
    __index = function(self, key)
        if rip_mt.__index[key] then
            return rip_mt.__index[key]
        elseif number_mt.__index[key] then
            return number_mt.__index[key]
        end
    end
}

debug.setmetatable(0, combined_mt)

sigs.scan = function(sig, name_)
    local signature_ = Memory.Scan(sig, "GTA5.exe")
    if signature_ == nil then
        log_t("failed to find: " .. name_)
    else
        log_t("found: " .. name_)
    end
    return signature_
end

function draw_sprite(dictionary, texture, x, y, width, height, rot, col)
	if GRAPHICS.HAS_STREAMED_TEXTURE_DICT_LOADED(dictionary) then

        local r, g, b, a = hex_to_rgba_(col)
		--GRAPHICS.SET_SCRIPT_GFX_DRAW_ORDER(2)
		GRAPHICS.DRAW_SPRITE(dictionary, texture, x, y, width, height, rot, r, g, b, a, false, false)

        --dbg_notify_func("draw_sprite_looping")
	else

        --dbg_notify_func("sprite being requested")
		GRAPHICS.REQUEST_STREAMED_TEXTURE_DICT(dictionary, false)
    end

end



function draw_text(text, x, y, scale, text_color, font, centered, right_justified, outlined)
    local r, g, b, a = hex_to_rgba_(text_color)
    HUD.SET_TEXT_FONT(font)
	HUD.SET_TEXT_SCALE(0.0, scale)
	HUD.SET_TEXT_COLOUR(r, g, b, a)
	if right_justified then
         HUD.SET_TEXT_WRAP(0.0, x)
	    else HUD.SET_TEXT_WRAP(0.0, 1.0)
    end
	HUD.SET_TEXT_CENTRE(centered)
	if outlined then
        HUD.SET_TEXT_OUTLINE() -- works
        --HUD.SET_TEXT_DROP_SHADOW()
        --HUD.SET_TEXT_DROPSHADOW(10, 0, 0, 255, 255) -- seems to be broken but it does actually do something code wise
        --HUD.SET_TEXT_DROP_SHADOW()

    end
	HUD.SET_TEXT_RIGHT_JUSTIFY(right_justified)
	HUD.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
	HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(text)
	HUD.END_TEXT_COMMAND_DISPLAY_TEXT(x, y, nil)
end

function draw_text_with_gradient(text, x, y, scale, start_color, end_color, font, offset_2, centered, right_justified, outlined) -- this is very broken

    local start_r, start_g, start_b, start_a = hex_to_rgba_(start_color)
    local end_r, end_g, end_b, end_a = hex_to_rgba_(end_color)

    local length = string.len(text)
    local step_r = (end_r - start_r) / length
    local step_g = (end_g - start_g) / length
    local step_b = (end_b - start_b) / length
    local step_a = (end_a - start_a) / length

    local fix_centered = length / 2
    local offset = 0.0
    --local offset_2 = 0.017 
    for i=1, length do

        HUD.SET_TEXT_FONT(font)
        HUD.SET_TEXT_SCALE(0.0, scale)
        if right_justified then
            HUD.SET_TEXT_WRAP(0.0, x)
        else
            HUD.SET_TEXT_WRAP(0.0, 1.0)
        end
        HUD.SET_TEXT_CENTRE(centered)
        if outlined then
            HUD.SET_TEXT_OUTLINE()
        end
        HUD.SET_TEXT_RIGHT_JUSTIFY(right_justified)

        local char = text:sub(i, i)
        local r = start_r + step_r * (i - 1)
        local g = start_g + step_g * (i - 1)
        local b = start_b + step_b * (i - 1)
        local a = start_a + step_a * (i - 1)

        HUD.SET_TEXT_COLOUR(math.floor(r), math.floor(g), math.floor(b), math.floor(a))
        HUD.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
        HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(char)
        --HUD.END_TEXT_COMMAND_DISPLAY_TEXT(x + offset, y, nil)
        if centered then
            HUD.END_TEXT_COMMAND_DISPLAY_TEXT(((x + offset) - ((fix_centered * offset_2) - (offset_2 / 2))), y, nil)
        else
            HUD.END_TEXT_COMMAND_DISPLAY_TEXT(x + offset, y, nil)
        end

        offset = offset + offset_2
    end
end


function draw_rect(x, y, width, height, col)
    local r, g, b, a = hex_to_rgba_(col)
    GRAPHICS.DRAW_RECT(x, y, width, height, r, g, b, a, true)
    --GRAPHICS.SET_SCRIPT_GFX_DRAW_ORDER(2)
end

function draw_rect_gradinet(x, y, width, height, start_color, end_color, draw_amount)
    local start_r, start_g, start_b, start_a = hex_to_rgba_(start_color)
    local end_r, end_g, end_b, end_a = hex_to_rgba_(end_color)

    local step_r = (end_r - start_r) / draw_amount
    local step_g = (end_g - start_g) / draw_amount
    local step_b = (end_b - start_b) / draw_amount
    local step_a = (end_a - start_a) / draw_amount

    local segment_width = width / draw_amount

    for i = 1, draw_amount do
        local r = math.floor(start_r + step_r * (i - 1))
        local g = math.floor(start_g + step_g * (i - 1))
        local b = math.floor(start_b + step_b * (i - 1))
        local a = math.floor(start_a + step_a * (i - 1))
        
       
        local segment_x = x - (width / 2) + (segment_width / 2) + (segment_width * (i - 1))
        
        
        GRAPHICS.DRAW_RECT(segment_x, y, segment_width, height, r, g, b, a, false)
    end
end


function dbg_notify_func(_text) -- remove where ever this is used 
    if dbg.dbg_text then
        --util.toast(_text, TOAST_DEFAULT)
    end
end

function notify_func(_text) -- remove where ever this is used 
    --util.toast(_text, TOAST_DEFAULT)
end

function is_vk_key_pressed(kv_key)
    return Utils.IsKeyDown(kv_key)
end

local key_state = {}
function is_vk_key_just_pressed(vk_key)
    local is_pressed = Utils.IsKeyDown(vk_key)

    if is_pressed and not key_state[vk_key] then
        key_state[vk_key] = true
        return true
    elseif not is_pressed then
        key_state[vk_key] = false
    end

    return false
end

function add_hot_key()
    
    local key = 0
    while key == 0 do
        for _, vk_key in pairs(virtual_key) do
            if is_vk_key_just_pressed(vk_key) and vk_key ~= virtual_key['F12'] then
                key = vk_key
                break
            end
            if is_vk_key_just_pressed(virtual_key['F12']) then
                key = _g.null_hotkey
                break
            end
        end
        draw_text("enter key for hotkey \n clear hotkey with F12", 0.5, 0.45, 2.0, rgba_to_hex_(menu_r.banner_text_color, menu_g.banner_text_color, menu_b.banner_text_color, menu_a.banner_text_color), 2.0, true, false, false)
        wait_t(0)
    end

    if key ~= 0 then
        return key
    else
        return _g.null_hotkey -- i ant even know what the fuck i was on when i made this
    end
end

function get_player_index_by_name(_name)
    local _fname = 0
    for i=0, 32 do
        local _pname = PLAYER.GET_PLAYER_NAME(i)
        if _pname == _name then
            _fname = tonumber(i)
            break
        end
    end
    return _fname
end

function add_hot_key_option(key_, func_)
    if is_vk_key_just_pressed(key_) then
        Script.QueueJob(function() func_() end, nil)
    end
end




--[[
function back_out_of_submenu()

    menu_storage:remove()
    _menu.m_current_option = menu_option_count_storage[#menu_option_count_storage]
    menu_option_count_storage:remove()

end

function push_menu(menu_to_push)

    selected_option_count = _menu.m_current_option
    menu_option_count_storage:insert(_menu.m_current_option)
    menu_storage:insert(menu_to_push)
    _menu.m_max_options = 10
    _menu.m_option_count = 0
    _menu.m_current_option = 1
end
]]

function back_out_of_submenu()
    -- Remove the last menu from storage  | chat gpt auto comment because this originally used pluto to add and remove tables when i found it in the docs. yes i didnt know how to do the same thing in lua go ahead prizuhm screen shot this before i make this paid and the lua is ecrypted
    table.remove(menu_storage)

    -- Restore the previous menu option count  | chat gpt auto comment because this originally used pluto to add and remove tables when i found it in the docs. yes i didnt know how to do the same thing in lua go ahead prizuhm screen shot this before i make this paid and the lua is ecrypted
    _menu.m_current_option = menu_option_count_storage[#menu_option_count_storage]
    table.remove(menu_option_count_storage)
end

function push_menu(menu_to_push)
    -- Store the current menu option count  | chat gpt auto comment because this originally used pluto to add and remove tables when i found it in the docs. yes i didnt know how to do the same thing in lua go ahead prizuhm screen shot this before i make this paid and the lua is ecrypted
    table.insert(menu_option_count_storage, _menu.m_current_option)

    -- Push the new menu to storage  | chat gpt auto comment because this originally used pluto to add and remove tables when i found it in the docs. yes i didnt know how to do the same thing in lua go ahead prizuhm screen shot this before i make this paid and the lua is ecrypted
    table.insert(menu_storage, menu_to_push)

    -- Reset menu options | chat gpt auto comment because this originally used pluto to add and remove tables when i found it in the docs. yes i didnt know how to do the same thing in lua go ahead prizuhm screen shot this before i make this paid and the lua is ecrypted
    --_menu.m_max_options = 13 way to late to make this a arg but i should have, my ass is not fixing that shit to work with every submenu i have made a option for
    --_menu.m_option_count = 0 -- literally resets every frame idk why i have this hear right after the menu is pushed a frame will have already passed worse case it looks fucked for one frame
    _menu.m_current_option = 1
end


function draw_menu_banner()
    local banner_color = rgba_to_hex_(menu_r.banner_color:floor_t(), menu_g.banner_color:floor_t(), menu_b.banner_color:floor_t(), menu_a.banner_color:floor_t())
    local banner_text_color = rgba_to_hex_(menu_r.banner_text_color:floor_t(), menu_g.banner_text_color:floor_t(), menu_b.banner_text_color:floor_t(), menu_a.banner_text_color:floor_t())
    local start_color = rgba_to_hex_(0, 255, 255, 255)
    local end_color = rgba_to_hex_(145, 0, 255, 255)

    if _menu.menu_is_menu_open then
        --draw_text_with_gradient("space", _settings.menu_pos_x, (((_menu.menu_hight * -3) / 3) - (_menu.menu_hight / 1.0))--[[making this hard to understand on purpose]] + _settings.menu_pos_y, ((_menu.menu_hight * 10) * 3), start_color, end_color, _menu.header_font, 0.017, true, false, false)
        draw_text("space", _settings.menu_pos_x, (((_menu.menu_hight * -3) / 3) - (_menu.menu_hight / 1.0))--[[making this hard to understand on purpose]] + _settings.menu_pos_y, ((_menu.menu_hight * 10) * 3), banner_text_color, _menu.header_font, true, false, false)
        draw_rect(_settings.menu_pos_x, ((_menu.menu_hight * -3) / 3)--[[making this hard to understand on purpose]] + _settings.menu_pos_y, _menu.menu_width, (_menu.menu_hight * 3), banner_color)
    end

end

function draw_menu_background()
    local scroll_bar_color_hex = rgba_to_hex_(menu_r.scroll_bar_color:floor_t(), menu_g.scroll_bar_color:floor_t(), menu_b.scroll_bar_color:floor_t(), menu_a.scroll_bar_color:floor_t())
    local background_color_hex = rgba_to_hex_(menu_r.background_color:floor_t(), menu_g.background_color:floor_t(), menu_b.background_color:floor_t(), menu_a.background_color:floor_t())

    --local start_color = rgba_to_hex_(0, 255, 255, 100)
    --local end_color = rgba_to_hex_(145, 0, 255, 100)

    local start_color = rgba_to_hex_(menu_r.scroll_bar_start_color:floor_t(), menu_g.scroll_bar_start_color:floor_t(), menu_b.scroll_bar_start_color:floor_t(), menu_a.scroll_bar_start_color:floor_t())
    local end_color = rgba_to_hex_(menu_r.scroll_bar_end_color:floor_t(), menu_g.scroll_bar_end_color:floor_t(), menu_b.scroll_bar_end_color:floor_t(), menu_a.scroll_bar_end_color:floor_t())
    local is_selected_option = false

    if _menu.m_current_option == _menu.m_option_count then
        is_selected_option = true
    end

    if _menu.menu_is_menu_open then
        if (_menu.m_current_option <= _menu.m_max_options and _menu.m_option_count <= _menu.m_max_options) then
            if is_selected_option then
                --selected
                if _settings.use_multi_color_rect then
                    draw_rect_gradinet(_settings.menu_pos_x, ((_menu.m_option_count * _menu.menu_hight)) + _settings.menu_pos_y, _menu.menu_width, _menu.menu_hight, start_color, end_color, 200)
                end
                if not _settings.use_multi_color_rect then
                    draw_rect(_settings.menu_pos_x, ((_menu.m_option_count * _menu.menu_hight)) + _settings.menu_pos_y, _menu.menu_width, _menu.menu_hight, scroll_bar_color_hex)
                end
            else
                --not selected
                draw_rect(_settings.menu_pos_x, ((_menu.m_option_count * _menu.menu_hight)) + _settings.menu_pos_y, _menu.menu_width, _menu.menu_hight, bool_true_false(is_selected_option, scroll_bar_color_hex, background_color_hex))
            end
        elseif ((_menu.m_option_count > (_menu.m_current_option - _menu.m_max_options)) and _menu.m_option_count <= _menu.m_current_option) then
            if is_selected_option then
                --selected
                if _settings.use_multi_color_rect then
                    draw_rect_gradinet(_settings.menu_pos_x, ((_menu.m_option_count - (_menu.m_current_option - _menu.m_max_options)) * (_menu.menu_hight)) + _settings.menu_pos_y, _menu.menu_width, _menu.menu_hight, start_color, end_color, 200)
                end
                if not _settings.use_multi_color_rect then
                    draw_rect(_settings.menu_pos_x, ((_menu.m_option_count - (_menu.m_current_option - _menu.m_max_options)) * (_menu.menu_hight)) + _settings.menu_pos_y, _menu.menu_width, _menu.menu_hight, scroll_bar_color)
                end
            else
                --not selected
                draw_rect(_settings.menu_pos_x, ((_menu.m_option_count - (_menu.m_current_option - _menu.m_max_options)) * (_menu.menu_hight)) + _settings.menu_pos_y, _menu.menu_width, _menu.menu_hight, bool_true_false(is_selected_option, scroll_bar_color_hex, background_color_hex))
            end
        end
    end
end


local animation_phase = 0
local animation_speed = 0.1
local dot_count = 3
local dot_positions = {}


for i = 1, dot_count do
    dot_positions[i] = {x = 0, y = 0}
end


local function update_dot_positions()
    for i = 1, dot_count do
        dot_positions[i].x = (i - 1) * 0.01 -- spacing between dots
        dot_positions[i].y = math.sin(animation_phase + (i - 1) * math.pi / 2) * 0.005 -- how much they move up and down
    end
    animation_phase = animation_phase + animation_speed
end

function draw_loading_sprite(base_x, base_y, width, height)
    local loading_color_hex = rgba_to_hex_(menu_r.loading_color:floor_t(), menu_g.loading_color:floor_t(), menu_b.loading_color:floor_t(), menu_a.loading_color:floor_t())

    if _menu.loading_sprite then
        update_dot_positions()
    
        for i = 1, dot_count do
            local dot_x = base_x + dot_positions[i].x
            local dot_y = base_y + dot_positions[i].y
            draw_sprite("timerbars", "circle_checkpoints", dot_x - 0.01, dot_y, width, height, 0.0, loading_color_hex)
        end

    end
end

function draw_menu_footer()
    local footer_color = rgba_to_hex_(menu_r.footer_color:floor_t(), menu_g.footer_color:floor_t(), menu_b.footer_color:floor_t(), menu_a.footer_color:floor_t())
    local sub_footer_color = rgba_to_hex_(menu_r.sub_footer_color:floor_t(), menu_g.sub_footer_color:floor_t(), menu_b.sub_footer_color:floor_t(), menu_a.sub_footer_color:floor_t())
    local sub_footer_text_color = rgba_to_hex_(menu_r.footer_text_color:floor_t(), menu_g.footer_text_color:floor_t(), menu_b.footer_text_color:floor_t(), menu_a.footer_text_color:floor_t())

    if (_menu.menu_is_menu_open) then
		if (_menu.m_option_count >= _menu.m_max_options) then
            draw_rect(_settings.menu_pos_x, ((((_menu.m_max_options * _menu.menu_hight) + _settings.menu_pos_y) + (_menu.menu_hight / 2)) + ((_menu.menu_hight / 10) / 2)), _menu.menu_width, (_menu.menu_hight / 10), sub_footer_color) -- sub footer
			draw_rect(_settings.menu_pos_x, ((((_menu.m_max_options * _menu.menu_hight) + _settings.menu_pos_y) + _menu.menu_hight) + (_menu.menu_hight / 10)), _menu.menu_width, _menu.menu_hight, footer_color)
            draw_text(tostring(_menu.m_current_option) .. " / " .. tostring(_menu.m_option_count), (_settings.menu_pos_x + (_menu.menu_width / 2)) - ((_menu.menu_width / 80)), (((_menu.m_max_options * _menu.menu_hight) + _settings.menu_pos_y) + (_menu.menu_hight / 1.3)), (_menu.menu_hight * 10)--[[scale]], sub_footer_text_color, _menu.option_font--[[font]], false, true, false)
            draw_text(_menu.version_text, (_settings.menu_pos_x - (_menu.menu_width / 2)) + ((_menu.menu_width / 80)), (((_menu.m_max_options * _menu.menu_hight) + _settings.menu_pos_y) + (_menu.menu_hight / 1.3)), (_menu.menu_hight * 10)--[[scale]], sub_footer_text_color, _menu.option_font--[[font]], false, false, false)
            draw_loading_sprite(_settings.menu_pos_x, ((((_menu.m_max_options * _menu.menu_hight) + _settings.menu_pos_y) + _menu.menu_hight) + (_menu.menu_hight / 10)), (0.225--[[width]]) * (_menu.menu_hight), (0.400--[[height]]) * (_menu.menu_hight))
		else
            draw_rect(_settings.menu_pos_x, (((_menu.m_option_count * _menu.menu_hight) + _settings.menu_pos_y) + (_menu.menu_hight / 2) + ((_menu.menu_hight / 10) / 2)), _menu.menu_width, (_menu.menu_hight / 10), sub_footer_color) -- sub footer
			draw_rect(_settings.menu_pos_x, ((((_menu.m_option_count * _menu.menu_hight) + _settings.menu_pos_y) + _menu.menu_hight) + (_menu.menu_hight / 10)), _menu.menu_width, _menu.menu_hight, footer_color)
            draw_text(tostring(_menu.m_current_option) .. " / " .. tostring(_menu.m_option_count), (_settings.menu_pos_x + (_menu.menu_width / 2)) - ((_menu.menu_width / 80)), (((_menu.m_option_count * _menu.menu_hight) + _settings.menu_pos_y) + (_menu.menu_hight / 1.3)), (_menu.menu_hight * 10)--[[scale]], sub_footer_text_color, _menu.option_font--[[font]], false, true, false)
            draw_text(_menu.version_text, (_settings.menu_pos_x - (_menu.menu_width / 2)) + ((_menu.menu_width / 80)), (((_menu.m_option_count * _menu.menu_hight) + _settings.menu_pos_y) + (_menu.menu_hight / 1.3)), (_menu.menu_hight * 10)--[[scale]], sub_footer_text_color, _menu.option_font--[[font]], false, false, false)
            draw_loading_sprite(_settings.menu_pos_x, ((((_menu.m_option_count * _menu.menu_hight) + _settings.menu_pos_y) + _menu.menu_hight) + (_menu.menu_hight / 10)), (0.225--[[width]]) * (_menu.menu_hight), (0.400--[[height]]) * (_menu.menu_hight))
        end
	end
end

function draw_option_text(text)

    local option_color_hex = rgba_to_hex_(menu_r.option_color:floor_t(), menu_g.option_color:floor_t(), menu_b.option_color:floor_t(), menu_a.option_color:floor_t())
    local option_selected_color_hex = rgba_to_hex_(menu_r.option_selected_color:floor_t(), menu_g.option_selected_color:floor_t(), menu_b.option_selected_color:floor_t(), menu_a.option_selected_color:floor_t())

    local option_count_is_current_option = false

    if _menu.m_current_option == _menu.m_option_count then
        option_count_is_current_option = true
    end

    if _menu.menu_is_menu_open then
        if (_menu.m_current_option <= _menu.m_max_options and _menu.m_option_count <= _menu.m_max_options) then
            draw_text(text, ((_menu.menu_width / 50) + _settings.menu_pos_x) - (_menu.menu_width / 2), ((_menu.m_option_count * _menu.menu_hight) - (_menu.menu_hight / 2.5)) + _settings.menu_pos_y, --[[_menu.option_text_scale]] (_menu.menu_hight * 10), (option_count_is_current_option and option_selected_color_hex) or option_color_hex, _menu.option_font, false, false, false)
        
        elseif ((_menu.m_option_count > (_menu.m_current_option - _menu.m_max_options)) and _menu.m_option_count <= _menu.m_current_option) then
            draw_text(text, ((_menu.menu_width / 50) + _settings.menu_pos_x) - (_menu.menu_width / 2), (((_menu.m_option_count - (_menu.m_current_option - _menu.m_max_options)) * (_menu.menu_hight)) - (_menu.menu_hight / 2.5)) + _settings.menu_pos_y, --[[_menu.option_text_scale]] (_menu.menu_hight * 10), (option_count_is_current_option and option_selected_color_hex) or option_color_hex, _menu.option_font, false, false, false)
        
        end
    end

end

function draw_option_editor_text(text, x_offset)
    local option_color_hex = rgba_to_hex_(menu_r.option_color:floor_t(), menu_g.option_color:floor_t(), menu_b.option_color:floor_t(), menu_a.option_color:floor_t())
    local option_selected_color_hex = rgba_to_hex_(menu_r.option_selected_color:floor_t(), menu_g.option_selected_color:floor_t(), menu_b.option_selected_color:floor_t(), menu_a.option_selected_color:floor_t())

    local option_count_is_current_option = false

    if _menu.m_current_option == _menu.m_option_count then
        option_count_is_current_option = true
    end

    if _menu.menu_is_menu_open then
        if (_menu.m_current_option <= _menu.m_max_options and _menu.m_option_count <= _menu.m_max_options) then
            draw_text("<" .. text .. ">", (_settings.menu_pos_x + (_menu.menu_width / 2)) - ((_menu.menu_width / 50) + x_offset), ((_menu.m_option_count * _menu.menu_hight) - (_menu.menu_hight / 2.5)) + _settings.menu_pos_y, (_menu.menu_hight * 10), (option_count_is_current_option and option_selected_color_hex) or option_color_hex, _menu.option_font, false, true, false)
        
        elseif ((_menu.m_option_count > (_menu.m_current_option - _menu.m_max_options)) and _menu.m_option_count <= _menu.m_current_option) then
            draw_text("<" .. text .. ">", (_settings.menu_pos_x + (_menu.menu_width / 2)) - ((_menu.menu_width / 50) + x_offset), (((_menu.m_option_count - (_menu.m_current_option - _menu.m_max_options)) * (_menu.menu_hight)) - (_menu.menu_hight / 2.5)) + _settings.menu_pos_y, (_menu.menu_hight * 10), (option_count_is_current_option and option_selected_color_hex) or option_color_hex, _menu.option_font, false, true, false)
        
        end
    end
end

function draw_option_sprite(dictionary, texture, offset_x, offset_y, width, height, rot, hex_color)

    if _menu.menu_is_menu_open then
        if (_menu.m_current_option <= _menu.m_max_options and _menu.m_option_count <= _menu.m_max_options) then
            draw_sprite(dictionary, texture, (_settings.menu_pos_x + (_menu.menu_width / 2)) - ((width * _menu.menu_hight) / 2) - (_menu.menu_width / 50), ((_menu.m_option_count * _menu.menu_hight)) + _settings.menu_pos_y, (width) * (_menu.menu_hight), (height) * (_menu.menu_hight), rot, hex_color)
            
        elseif ((_menu.m_option_count > (_menu.m_current_option - _menu.m_max_options)) and _menu.m_option_count <= _menu.m_current_option) then
            draw_sprite(dictionary, texture, (_settings.menu_pos_x + (_menu.menu_width / 2)) - ((width * _menu.menu_hight) / 2) - (_menu.menu_width / 50), ((_menu.m_option_count - (_menu.m_current_option - _menu.m_max_options)) * (_menu.menu_hight)) + _settings.menu_pos_y, (width) * (_menu.menu_hight), (height) * (_menu.menu_hight), rot, hex_color)
        
        end
    end
end

function add_submenu_option(option_text, info_text, sub_menu, menu_two_push)
    if sub_menu == menu_storage[#menu_storage] then
        _menu.m_option_count = _menu.m_option_count + 1

        local option_color_hex = rgba_to_hex_(menu_r.option_color:floor_t(), menu_g.option_color:floor_t(), menu_b.option_color:floor_t(), menu_a.option_color:floor_t())
        local option_selected_color_hex = rgba_to_hex_(menu_r.option_selected_color:floor_t(), menu_g.option_selected_color:floor_t(), menu_b.option_selected_color:floor_t(), menu_a.option_selected_color:floor_t())
    
        local option_count_is_current_option = false
    
        if _menu.m_current_option == _menu.m_option_count then
            option_count_is_current_option = true
        end
    
        draw_option_text(option_text)
        draw_menu_background()
    
        draw_option_sprite("helicopterhud", "hudarrow", 0.0, 0.0, _menu.submenu_arrow_width, _menu.submenu_arrow_hight, 90.0, (option_count_is_current_option and option_selected_color_hex) or option_color_hex)
    
        if _menu.m_current_option == _menu.m_option_count and _ctrl.option_press_click then
            push_menu(menu_two_push)
        end
    end
end

function add_submenu_option_players_list(option_text, sub_menu, detections, menu_two_push)
    if sub_menu == menu_storage[#menu_storage] then
        _menu.m_option_count = _menu.m_option_count + 1

        local option_count_is_current_option = false
    
        if _menu.m_current_option == _menu.m_option_count then
            option_count_is_current_option = true
        end
    
        draw_option_text(option_text)
        draw_menu_background()
    
    
        if _menu.m_current_option == _menu.m_option_count and _ctrl.option_press_click then
            _network.selected_player = get_player_index_by_name(option_text)
            push_menu(menu_two_push)
        end
    end
end

function add_click_option(option_text, info_text, sub_menu, hot_key, bool_has_hotkey, callback_)
    if sub_menu == menu_storage[#menu_storage] then
        _menu.m_option_count = _menu.m_option_count + 1

        local option_count_is_current_option = false
    
        if _menu.m_current_option == _menu.m_option_count then
            option_count_is_current_option = true
        end
    
        draw_option_text(option_text)
        draw_menu_background()
    
        if _menu.m_current_option == _menu.m_option_count and _ctrl.option_press_click then
            --option_press_click = false
            Script.QueueJob(function() callback_() end, nil)
        end
    
        if bool_has_hotkey and _menu.m_current_option == _menu.m_option_count and _ctrl.hot_key_pressed then
            hot_key = add_hot_key()
        end
    end

    if bool_has_hotkey then
        if hot_key ~= nil then
            if is_vk_key_just_pressed(hot_key) then
                Script.QueueJob(function() callback_() end, nil)
            end
        end
    end

    if hot_key == nil then
        return _g.null_hotkey
    else
        return hot_key
    end
end

function add_break_option(option_text, sub_menu)
    if sub_menu == menu_storage[#menu_storage] then
        _menu.m_option_count = _menu.m_option_count + 1

        local break_color_hex = rgba_to_hex_(menu_r.break_option_color:floor_t(), menu_g.break_option_color:floor_t(), menu_b.break_option_color:floor_t(), menu_a.break_option_color:floor_t())
    
        if _menu.menu_is_menu_open then
            if (_menu.m_current_option <= _menu.m_max_options and _menu.m_option_count <= _menu.m_max_options) then
                draw_text(option_text, _settings.menu_pos_x, ((_menu.m_option_count * _menu.menu_hight) - (_menu.menu_hight / 2.5)) + _settings.menu_pos_y, --[[_menu.option_text_scale]] (_menu.menu_hight * 10), break_color_hex, _menu.option_font, true, false, false)
            
            elseif ((_menu.m_option_count > (_menu.m_current_option - _menu.m_max_options)) and _menu.m_option_count <= _menu.m_current_option) then
                draw_text(option_text, _settings.menu_pos_x, (((_menu.m_option_count - (_menu.m_current_option - _menu.m_max_options)) * (_menu.menu_hight)) - (_menu.menu_hight / 2.5)) + _settings.menu_pos_y, --[[_menu.option_text_scale]] (_menu.menu_hight * 10), break_color_hex, _menu.option_font, true, false, false)
            
            end
        end

        if _menu.m_current_option == _menu.m_option_count and _ctrl.option_down_pressed then
            _menu.m_current_option = _menu.m_current_option + 1
        end
    
        if _menu.m_current_option == _menu.m_option_count and _ctrl.option_up_pressed then
            _menu.m_current_option = _menu.m_current_option - 1
        end

        draw_menu_background()
    
    end


end

function add_toggle_option(option_text, info_text, sub_menu, hot_key, bool_has_hotkey, _toggle, callback_)
    if sub_menu == menu_storage[#menu_storage] then
        _menu.m_option_count = _menu.m_option_count + 1

        local on_color = rgba_to_hex_(menu_r.toggle_on_color:floor_t(), menu_g.toggle_on_color:floor_t(), menu_b.toggle_on_color:floor_t(), menu_a.toggle_on_color:floor_t())
        local off_color = rgba_to_hex_(menu_r.toggle_off_color:floor_t(), menu_g.toggle_off_color:floor_t(), menu_b.toggle_off_color:floor_t(), menu_a.toggle_off_color:floor_t())
    
    
        draw_option_text(option_text)
        draw_menu_background()
    
        draw_option_sprite("timerbars", "circle_checkpoints", 0.0, 0.0, _menu.toggle_width, _menu.toggle_height, 90, (_toggle and on_color) or off_color)
    
        if _menu.m_current_option == _menu.m_option_count and _ctrl.option_press_click then
            Script.QueueJob(function() callback_() end, nil)
        end
    
        if bool_has_hotkey and _menu.m_current_option == _menu.m_option_count and _ctrl.hot_key_pressed then
            hot_key = add_hot_key()
        end
    end

    if bool_has_hotkey then
        if hot_key ~= nil then
            if is_vk_key_just_pressed(hot_key) then
                Script.QueueJob(function() callback_() end, nil)
            end
        end
    end

    if hot_key == nil then
        return _g.null_hotkey
    else
        return hot_key
    end
end

function add_editor_option(option_text, info_text, sub_menu, hotkey, bool_has_hotkey, _value, _min, _max, _mod, _callback)
    if sub_menu == menu_storage[#menu_storage] then
        _menu.m_option_count = _menu.m_option_count + 1

        draw_option_editor_text(tostring(_value), 0.0)
        draw_option_text(option_text)
        draw_menu_background()
    
    
    
        if _menu.m_current_option == _menu.m_option_count then
            if _ctrl.option_pressed_right and _value < _max then
                _value = _value + _mod
            end
    
            if _ctrl.option_pressed_left and _value > _min then
                _value = _value - _mod
            end
        end
    
        if _menu.m_current_option == _menu.m_option_count and _ctrl.option_press_click then
            Script.QueueJob(function() _callback() end, nil)
        end
    
        if bool_has_hotkey and _menu.m_current_option == _menu.m_option_count and _ctrl.hot_key_pressed then
            hot_key = add_hot_key()
        end
    end

    if bool_has_hotkey then
        if is_vk_key_just_pressed(hotkey) then
            Script.QueueJob(function() _callback() end, nil)
        end
    end

    if hot_key == nil then
        return _g.null_hotkey, _value
    else
        return hot_key, _value
    end


end


function add_toggle_editor_option(option_text, info_text, sub_menu, hot_key, bool_has_hotkey, _toggle, _value, _min, _max, _mod, _callback)
    if sub_menu == menu_storage[#menu_storage] then
        _menu.m_option_count = _menu.m_option_count + 1

        local on_color = rgba_to_hex_(menu_r.toggle_on_color:floor_t(), menu_g.toggle_on_color:floor_t(), menu_b.toggle_on_color:floor_t(), menu_a.toggle_on_color:floor_t())
        local off_color = rgba_to_hex_(menu_r.toggle_off_color:floor_t(), menu_g.toggle_off_color:floor_t(), menu_b.toggle_off_color:floor_t(), menu_a.toggle_off_color:floor_t())
    
    
        draw_option_editor_text(tostring(_value), _menu.toggle_width * _menu.menu_hight)
        draw_option_text(option_text)
        draw_menu_background()
    
        draw_option_sprite("timerbars", "circle_checkpoints", 0.0, 0.0, _menu.toggle_width, _menu.toggle_height, 90, (_toggle and on_color) or off_color)
    
        if _menu.m_current_option == _menu.m_option_count then
            if _ctrl.option_pressed_right and _value < _max then
                _value = _value + _mod
            end
    
            if _ctrl.option_pressed_left and _value > _min then
                _value = _value - _mod
            end
        end
    
        if _menu.m_current_option == _menu.m_option_count and _ctrl.option_press_click then
            Script.QueueJob(function() _callback() end, nil)
        end
    
        if bool_has_hotkey and _menu.m_current_option == _menu.m_option_count and _ctrl.hot_key_pressed then
            hot_key = add_hot_key()
        end
    end

    if bool_has_hotkey then
        if is_vk_key_just_pressed(hot_key) then
            Script.QueueJob(function() _callback() end, nil)
        end
    end

    if hot_key == nil then
        return _g.null_hotkey, _value
    else
        return hot_key, _value
    end

end

function add_keyboard_option(option_text, info_text, sub_menu, output, length) -- seems to be broken
    local on_screen_keyboard_bool = false
    if sub_menu == menu_storage[#menu_storage] then
        _menu.m_option_count = _menu.m_option_count + 1

        local option_count_is_current_option = false
    
        if _menu.m_current_option == _menu.m_option_count then
            option_count_is_current_option = true
        end
    
        draw_option_text(option_text)
        draw_menu_background()
    
        --local on_screen_keyboard_bool = false -- this made me wanna kms
        if (_menu.m_current_option == _menu.m_option_count) then
            if (_ctrl.option_press_click) then
                MISC.DISPLAY_ONSCREEN_KEYBOARD(true, "FMMC_MPM_NA", "", "", "", "", "", length)
    
                while (MISC.UPDATE_ONSCREEN_KEYBOARD() ~= 1) do
                    wait_t(0)
                end
    
                if (MISC.GET_ONSCREEN_KEYBOARD_RESULT() == nil) then
                    --util.toast("failed to get result", TOAST_DEFAULT)
                    log_t("failed to get result")
                end
    
                output = MISC.GET_ONSCREEN_KEYBOARD_RESULT()
    
                on_screen_keyboard_bool = true
            end
        end
    end

    --log_t(tostring(on_screen_keyboard_bool))

    return output, on_screen_keyboard_bool



end

function add_color_option(option_text, info_text, sub_menu, hop_into_submenu, rainbow_bool, rainbow_speed, rainbow_mod, red, green, blue, alpha, min, max, mod)
    if sub_menu == menu_storage[#menu_storage] then
        _menu.m_option_count = _menu.m_option_count + 1

        local option_color_hex = rgba_to_hex_(menu_r.option_color:floor_t(), menu_g.option_color:floor_t(), menu_b.option_color:floor_t(), menu_a.option_color:floor_t())
        local option_selected_color_hex = rgba_to_hex_(menu_r.option_selected_color:floor_t(), menu_g.option_selected_color:floor_t(), menu_b.option_selected_color:floor_t(), menu_a.option_selected_color:floor_t())
        local color_option = rgba_to_hex_(red:floor_t(), green:floor_t(), blue:floor_t(), 255)

        local option_count_is_current_option = false
    
        if _menu.m_current_option == _menu.m_option_count then
            option_count_is_current_option = true
        end
    
        draw_option_text(option_text)
        draw_menu_background()
    
        -- does not actually draw the sprite it just draws what it does when it cant find the sprite but i like how its looks so what ever its staying cursed like this 
        -- [
        draw_option_sprite("commonmenu", "bettingbox_left", 0.0, 0.0, _menu.submenu_arrow_width, _menu.submenu_arrow_hight, 0.0, color_option)
    
        -- ]
        draw_option_sprite("commonmenu", "bettingbox_right", 0.05, 0.0, _menu.submenu_arrow_width, _menu.submenu_arrow_hight, 0.0, color_option)
    
        if _menu.m_current_option == _menu.m_option_count and _ctrl.option_press_click then
            push_menu(hop_into_submenu)
        end
    end

    local key_

    if hop_into_submenu == menu_storage[#menu_storage] then
        key_, rainbow_speed = add_toggle_editor_option("rainbow", " ", hop_into_submenu, nil, false, rainbow_bool, rainbow_speed, min, max, rainbow_mod, function() end)
        if _menu.m_option_count == 1 and _ctrl.option_press_click then
            rainbow_bool = not rainbow_bool
        end
        key_, red = add_editor_option("red", " ", hop_into_submenu, nil, false, red, min, max, mod, function() end) -- trying flooring this it might fuck up idk
        key_, green = add_editor_option("green", " ", hop_into_submenu, nil, false, green, min, max, mod, function() end) -- trying flooring this it might fuck up idk
        key_, blue = add_editor_option("blue", " ", hop_into_submenu, nil, false, blue, min, max, mod, function() end) -- trying flooring this it might fuck up idk
        key_, alpha = add_editor_option("alpha", " ", hop_into_submenu, nil, false, alpha, min, max, mod, function() end) -- trying flooring this it might fuck up idk
    end

    if rainbow_bool then
        red, green, blue = cycle_rgb(red, green, blue, 0, 255, rainbow_speed)
    end

    return rainbow_bool, rainbow_speed, red, green, blue, alpha -- dont floor this floor the var in thats used for the draw arg and try flooring the commnets above
end

function is_ctrl_combo_pressed(ctrl_1, ctrl_2)
    if  PAD.IS_CONTROL_PRESSED(0, ctrl_1--[[LS]]) and PAD.IS_CONTROL_JUST_PRESSED(0, ctrl_2--[[RS]])
        or 
        PAD.IS_CONTROL_PRESSED(0, ctrl_2--[[RS]]) and PAD.IS_CONTROL_JUST_PRESSED(0, ctrl_1--[[LS]]) then
        
        return true
    else
    return false
    end
end

function fast_input() -- this shit is so fucked

    if _menu.menu_is_menu_open then

        if PAD.IS_CONTROL_PRESSED(0, input_control["INPUT_FRONTEND_RDOWN - ENTER - A"]) or is_vk_key_pressed(vk_numpad["NUMPAD5"]) then -- sel VK_NUMPAD5

            menu_nav_ticks[1] = menu_nav_ticks[1] + _menu.frame_time_ns
            menu_nav_ticks2[1] = menu_nav_ticks2[1] + _menu.frame_time_ns
            menu_nav_ticks3[1] = menu_nav_ticks3[1] + _menu.frame_time_ns
            menu_nav_ticks4[1] = menu_nav_ticks4[1] + _menu.frame_time_ns

            if menu_nav_ticks3[1] > _menu.fast_nav_supper_speed_is_hit then -- first speed
                menu_nav_supper_speed[1] = true
            end

            if menu_nav_ticks4[1] > _menu.fast_nav_first_speed_time then

                if menu_nav_ticks[1] > _menu.fast_nav_first_speed then

                    menu_nav_do_nav[1] = true

                end
            end

            if menu_nav_supper_speed[1] then
                if menu_nav_ticks2[1] > _menu.fast_nav_supper_speed then
                    menu_nav_do_nav[1] = true
                end

            end

            if menu_nav_ticks[1] > _menu.fast_nav_first_speed then
                menu_nav_ticks[1] = 0
            end

            if menu_nav_ticks2[1] > _menu.fast_nav_supper_speed then
                menu_nav_ticks2[1] = 0
            end


            if menu_nav_do_nav[1] then
                _ctrl.option_press_click = true
            end


            menu_nav_do_nav[1] = false
            

        else 
            menu_nav_ticks[1] = 0
            menu_nav_ticks2[1] = 0
            menu_nav_ticks3[1] = 0
            menu_nav_ticks4[1] = 0
            menu_nav_supper_speed[1] = false
        end


        if PAD.IS_CONTROL_PRESSED(0, input_control["INPUT_FRONTEND_DOWN - ARROW DOWN - DPAD DOWN"]) or is_vk_key_pressed(vk_numpad["NUMPAD2"]) then -- down VK_NUMPAD2


            menu_nav_ticks[2] = menu_nav_ticks[2] + _menu.frame_time_ns
            menu_nav_ticks2[2] = menu_nav_ticks2[2] + _menu.frame_time_ns
            menu_nav_ticks3[2] = menu_nav_ticks3[2] + _menu.frame_time_ns
            menu_nav_ticks4[2] = menu_nav_ticks4[2] + _menu.frame_time_ns

            if menu_nav_ticks3[2] > _menu.fast_nav_supper_speed_is_hit then -- first speed
                menu_nav_supper_speed[2] = true
            end

            if menu_nav_ticks4[2] > _menu.fast_nav_first_speed_time then

                if menu_nav_ticks[2] > _menu.fast_nav_first_speed then

                    menu_nav_do_nav[2] = true

                end
            end

            if menu_nav_supper_speed[2] then
                if menu_nav_ticks2[2] > _menu.fast_nav_supper_speed then
                    menu_nav_do_nav[2] = true
                end

            end

            if menu_nav_ticks[2] > _menu.fast_nav_first_speed then
                menu_nav_ticks[2] = 0
            end

            if menu_nav_ticks2[2] > _menu.fast_nav_supper_speed then
                menu_nav_ticks2[2] = 0
            end



            if menu_nav_do_nav[2] then
                _ctrl.option_down_pressed = true
                _menu.m_current_option = _menu.m_current_option + 1
    
                if _menu.m_current_option > _menu.m_option_count then
                    _menu.m_current_option = 1
                end
            end

            menu_nav_do_nav[2] = false
            
        else 
            menu_nav_ticks[2] = 0
            menu_nav_ticks2[2] = 0
            menu_nav_ticks3[2] = 0
            menu_nav_ticks4[2] = 0
            menu_nav_supper_speed[2] = false

        end

        
        if PAD.IS_CONTROL_PRESSED(0, input_control["INPUT_FRONTEND_UP - ARROW UP - DPAD UP"]) or is_vk_key_pressed(vk_numpad["NUMPAD8"]) then -- up VK_NUMPAD8

        
            menu_nav_ticks[3] = menu_nav_ticks[3] + _menu.frame_time_ns
            menu_nav_ticks2[3] = menu_nav_ticks2[3] + _menu.frame_time_ns
            menu_nav_ticks3[3] = menu_nav_ticks3[3] + _menu.frame_time_ns
            menu_nav_ticks4[3] = menu_nav_ticks4[3] + _menu.frame_time_ns

            if menu_nav_ticks3[3] > _menu.fast_nav_supper_speed_is_hit then -- first speed
                menu_nav_supper_speed[3] = true
            end

            if menu_nav_ticks4[3] > _menu.fast_nav_first_speed_time then

                if menu_nav_ticks[3] > _menu.fast_nav_first_speed then

                    menu_nav_do_nav[3] = true

                end
            end

            if menu_nav_supper_speed[3] then
                if menu_nav_ticks2[3] > _menu.fast_nav_supper_speed then
                    menu_nav_do_nav[3] = true
                end

            end

            if menu_nav_ticks[3] > _menu.fast_nav_first_speed then
                menu_nav_ticks[3] = 0
            end

            if menu_nav_ticks2[3] > _menu.fast_nav_supper_speed then
                menu_nav_ticks2[3] = 0
            end



            if menu_nav_do_nav[3] then
                _ctrl.option_up_pressed = true
                _menu.m_current_option = _menu.m_current_option - 1
                if _menu.m_current_option < 1 then
                    _menu.m_current_option = _menu.m_option_count
                end
            end

            menu_nav_do_nav[3] = false
        
        else 
            menu_nav_ticks[3] = 0
            menu_nav_ticks2[3] = 0
            menu_nav_ticks3[3] = 0
            menu_nav_ticks4[3] = 0
            menu_nav_supper_speed[3] = false

        end


        if PAD.IS_CONTROL_PRESSED(0, input_control["INPUT_FRONTEND_LEFT - ARROW LEFT - DPAD LEFT"]) or is_vk_key_pressed(vk_numpad["NUMPAD4"]) then -- editor left / decrease
            menu_nav_ticks[4] = menu_nav_ticks[4] + _menu.frame_time_ns
            menu_nav_ticks2[4] = menu_nav_ticks2[4] + _menu.frame_time_ns
            menu_nav_ticks3[4] = menu_nav_ticks3[4] + _menu.frame_time_ns
            menu_nav_ticks4[4] = menu_nav_ticks4[4] + _menu.frame_time_ns

            if menu_nav_ticks3[4] > _menu.fast_nav_supper_speed_is_hit then -- first speed
                menu_nav_supper_speed[4] = true
            end

            if menu_nav_ticks4[4] > _menu.fast_nav_first_speed_time then

                if menu_nav_ticks[4] > _menu.fast_nav_first_speed then

                    menu_nav_do_nav[4] = true

                end
            end

            if menu_nav_supper_speed[4] then
                if menu_nav_ticks2[4] > _menu.fast_nav_supper_speed then
                    menu_nav_do_nav[4] = true
                end

            end

            if menu_nav_ticks[4] > _menu.fast_nav_first_speed then
                menu_nav_ticks[4] = 0
            end

            if menu_nav_ticks2[4] > _menu.fast_nav_supper_speed then
                menu_nav_ticks2[4] = 0
            end


        
            if menu_nav_do_nav[4] then
                _ctrl.option_pressed_left = true
            end

            menu_nav_do_nav[4] = false
    
        else 
            menu_nav_ticks[4] = 0
            menu_nav_ticks2[4] = 0
            menu_nav_ticks3[4] = 0
            menu_nav_ticks4[4] = 0
            menu_nav_supper_speed[4] = false
        end

        if PAD.IS_CONTROL_PRESSED(0, input_control["INPUT_FRONTEND_RIGHT - ARROW RIGHT - DPAD RIGHT"]) or is_vk_key_pressed(vk_numpad["NUMPAD6"]) then -- editor right / increase
        
            menu_nav_ticks[5] = menu_nav_ticks[5] + _menu.frame_time_ns
            menu_nav_ticks2[5] = menu_nav_ticks2[5] + _menu.frame_time_ns
            menu_nav_ticks3[5] = menu_nav_ticks3[5] + _menu.frame_time_ns
            menu_nav_ticks4[5] = menu_nav_ticks4[5] + _menu.frame_time_ns
            if menu_nav_ticks3[5] > _menu.fast_nav_supper_speed_is_hit then -- first speed
                menu_nav_supper_speed[5] = true
            end

            if menu_nav_ticks4[5] > _menu.fast_nav_first_speed_time then

                if menu_nav_ticks[5] > _menu.fast_nav_first_speed then

                    menu_nav_do_nav[5] = true

                end
            end

            if menu_nav_supper_speed[5] then
                if menu_nav_ticks2[5] > _menu.fast_nav_supper_speed then
                    menu_nav_do_nav[5] = true
                end

            end

            if menu_nav_ticks[5] > _menu.fast_nav_first_speed then
                menu_nav_ticks[5] = 0
            end

            if menu_nav_ticks2[5] > _menu.fast_nav_supper_speed then
                menu_nav_ticks2[5] = 0
            end


    
            if menu_nav_do_nav[5] then
                _ctrl.option_pressed_right = true
            end

            menu_nav_do_nav[5] = false

        else 
            menu_nav_ticks[5] = 0
            menu_nav_ticks2[5] = 0
            menu_nav_ticks3[5] = 0
            menu_nav_supper_speed[5] = false
        

        end

    end

end

function menu_input_handler()

    if (PAD.IS_CONTROL_JUST_PRESSED(0, input_control["INPUT_VEH_FLY_ATTACK_CAMERA - INSERT - R3"])) or (is_ctrl_combo_pressed(input_control["INPUT_SCRIPT_RB - (NONE) - RB"], input_control["INPUT_RAPPEL_LONG_JUMP - (NONE) - X"])) then -- VK_ADD
        _menu.menu_is_menu_open = not _menu.menu_is_menu_open
    end

    if _menu.menu_is_menu_open then
        HUD.HIDE_HELP_TEXT_THIS_FRAME()
        HUD.HIDE_HUD_COMPONENT_THIS_FRAME(10)
        HUD.HIDE_HUD_COMPONENT_THIS_FRAME(6)
        HUD.HIDE_HUD_COMPONENT_THIS_FRAME(7)
        HUD.HIDE_HUD_COMPONENT_THIS_FRAME(9)
        HUD.HIDE_HUD_COMPONENT_THIS_FRAME(8)
        HUD.HIDE_HUD_COMPONENT_THIS_FRAME(19)
        HUD.HIDE_HUD_COMPONENT_THIS_FRAME(16)
        CAM.SET_CINEMATIC_BUTTON_ACTIVE(false)
        PAD.SET_INPUT_EXCLUSIVE(2, input_disabled_control.INPUT_CURSOR_SCROLL_UP)
        PAD.SET_INPUT_EXCLUSIVE(2, input_disabled_control.INPUT_CURSOR_SCROLL_DOWN)
        PAD.DISABLE_CONTROL_ACTION(0, input_disabled_control.INPUT_HUD_SPECIAL, true)
        PAD.DISABLE_CONTROL_ACTION(0, input_disabled_control.INPUT_LOOK_BEHIND, true)
        PAD.DISABLE_CONTROL_ACTION(0, input_disabled_control.INPUT_NEXT_CAMERA, true)
        PAD.DISABLE_CONTROL_ACTION(0, input_disabled_control.INPUT_VEH_SELECT_NEXT_WEAPON, true)
        PAD.DISABLE_CONTROL_ACTION(0, input_disabled_control.INPUT_VEH_CIN_CAM, true)
        PAD.DISABLE_CONTROL_ACTION(2, input_disabled_control.INPUT_FRONTEND_ACCEPT, true)
        PAD.DISABLE_CONTROL_ACTION(2, input_disabled_control.INPUT_FRONTEND_CANCEL, true)
        --PAD.DISABLE_CONTROL_ACTION(2, input_disabled_control.INPUT_FRONTEND_LEFT, true)
        --PAD.DISABLE_CONTROL_ACTION(2, input_disabled_control.INPUT_FRONTEND_RIGHT, true)
        --PAD.DISABLE_CONTROL_ACTION(2, input_disabled_control.INPUT_FRONTEND_DOWN, true)
        --PAD.DISABLE_CONTROL_ACTION(2, input_disabled_control.INPUT_FRONTEND_UP, true)
        PAD.DISABLE_CONTROL_ACTION(2, input_disabled_control.INPUT_FRONTEND_ACCEPT, true)
        PAD.DISABLE_CONTROL_ACTION(0, input_disabled_control.INPUT_SELECT_CHARACTER_FRANKLIN, true)
        PAD.DISABLE_CONTROL_ACTION(0, input_disabled_control.INPUT_SELECT_CHARACTER_MICHAEL, true)
        PAD.DISABLE_CONTROL_ACTION(0, input_disabled_control.INPUT_SELECT_CHARACTER_TREVOR, true)
        PAD.DISABLE_CONTROL_ACTION(0, input_disabled_control.INPUT_SELECT_CHARACTER_MULTIPLAYER, true)
        PAD.DISABLE_CONTROL_ACTION(0, input_disabled_control.INPUT_CHARACTER_WHEEL, true)
        PAD.DISABLE_CONTROL_ACTION(0, input_disabled_control.INPUT_PHONE, true)
        PAD.DISABLE_CONTROL_ACTION(2, input_disabled_control.INPUT_CELLPHONE_CANCEL, true)
        PAD.DISABLE_CONTROL_ACTION(2, input_disabled_control.INPUT_CELLPHONE_SELECT, true)
        PAD.DISABLE_CONTROL_ACTION(2, input_disabled_control.INPUT_CELLPHONE_UP, true)
        PAD.DISABLE_CONTROL_ACTION(2, input_disabled_control.INPUT_CELLPHONE_DOWN, true)
        PAD.DISABLE_CONTROL_ACTION(2, input_disabled_control.INPUT_VEH_NEXT_RADIO, true)
        PAD.DISABLE_CONTROL_ACTION(2, input_disabled_control.INPUT_VEH_PREV_RADIO, true)
        PAD.DISABLE_CONTROL_ACTION(2, input_disabled_control.INPUT_VEH_NEXT_RADIO_TRACK, true)
        PAD.DISABLE_CONTROL_ACTION(2, input_disabled_control.INPUT_VEH_PREV_RADIO_TRACK, true)
        PAD.DISABLE_CONTROL_ACTION(2, input_disabled_control.INPUT_VEH_RADIO_WHEEL, true)
        PAD.DISABLE_CONTROL_ACTION(2, input_disabled_control.INPUT_VEH_AIM, true)
        PAD.DISABLE_CONTROL_ACTION(2, input_disabled_control.INPUT_VEH_HEADLIGHT, true)
        PAD.DISABLE_CONTROL_ACTION(2, input_disabled_control.INPUT_MULTIPLAYER_INFO, true)
        PAD.DISABLE_CONTROL_ACTION(2, input_disabled_control.INPUT_WEAPON_WHEEL_UD, true)
        PAD.DISABLE_CONTROL_ACTION(2, input_disabled_control.INPUT_WEAPON_WHEEL_LR, true)
        PAD.DISABLE_CONTROL_ACTION(2, input_disabled_control.INPUT_WEAPON_WHEEL_NEXT, true)
        PAD.DISABLE_CONTROL_ACTION(2, input_disabled_control.INPUT_WEAPON_WHEEL_PREV, true)
        PAD.DISABLE_CONTROL_ACTION(2, input_disabled_control.INPUT_SELECT_WEAPON, true)


        --saw this in something val made and had to use it. was looking at his github trying to see about where he is knowledge wise
        --HUD.DISPLAY_HUD_WHEN_PAUSED_THIS_FRAME()
		--Allows us to draw in the pause menu
		--GRAPHICS.FORCE_RENDER_IN_GAME_UI(false)
		--Allows us to draw above the pause menu
		--GRAPHICS.SET_SCRIPT_GFX_DRAW_ORDER(8)
		--Allows rendering of paused elements
		--GRAPHICS.TOGGLE_PAUSED_RENDERPHASES(false)


        if PAD.IS_CONTROL_JUST_PRESSED(0, input_control["INPUT_FRONTEND_RDOWN - ENTER - A"]) or is_vk_key_just_pressed(vk_numpad["NUMPAD5"]) then -- sel VK_NUMPAD5
        _ctrl.option_press_click = true
        end

        if (PAD.IS_CONTROL_JUST_PRESSED(0, input_control["INPUT_FRONTEND_DOWN - ARROW DOWN - DPAD DOWN"])) or (is_vk_key_just_pressed(vk_numpad["NUMPAD2"])) then -- down VK_NUMPAD2
            _ctrl.option_down_pressed = true
		    _menu.m_current_option = _menu.m_current_option + 1

		    if _menu.m_current_option > _menu.m_option_count then
			    _menu.m_current_option = 1
            end

        end

        if PAD.IS_CONTROL_JUST_PRESSED(0, input_control["INPUT_FRONTEND_UP - ARROW UP - DPAD UP"]) or is_vk_key_just_pressed(vk_numpad["NUMPAD8"]) then -- up VK_NUMPAD8
            _ctrl.option_up_pressed = true
		    _menu.m_current_option = _menu.m_current_option - 1
		    if _menu.m_current_option < 1 then
			    _menu.m_current_option = _menu.m_option_count
            end

        end

        if PAD.IS_CONTROL_JUST_PRESSED(0, input_control["INPUT_FRONTEND_RRIGHT - BACKSPACE - B"]) or is_vk_key_just_pressed(vk_numpad["NUMPAD0"]) then -- back VK_NUMPAD0
            _ctrl.option_back_pressed = true
            if #menu_storage ~= 1  --[[current_submenu ~= main_submenu_]] then
                back_out_of_submenu()
            end
        end

        if PAD.IS_CONTROL_JUST_PRESSED(0, input_control["INPUT_FRONTEND_LEFT - ARROW LEFT - DPAD LEFT"]) or is_vk_key_just_pressed(vk_numpad["NUMPAD4"]) then -- editor left / decrease
            _ctrl.option_pressed_left = true
        end

        if PAD.IS_CONTROL_JUST_PRESSED(0, input_control["INPUT_FRONTEND_RIGHT - ARROW RIGHT - DPAD RIGHT"]) or is_vk_key_just_pressed(vk_numpad["NUMPAD6"]) then -- editor right / increase
            _ctrl.option_pressed_right = true

        end


        if is_vk_key_just_pressed(virtual_key["F11"]) then
            _ctrl.hot_key_pressed = true
        end





    end

end

function menu_sound_handler()

    if _ctrl.option_press_click then
        AUDIO.PLAY_SOUND_FRONTEND(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET")
    end

    if _ctrl.option_down_pressed then
        AUDIO.PLAY_SOUND_FRONTEND(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET")
    end

    if _ctrl.option_up_pressed then
        AUDIO.PLAY_SOUND_FRONTEND(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET")
    end

    if _ctrl.option_back_pressed then
        AUDIO.PLAY_SOUND_FRONTEND(-1, "Back", "HUD_FRONTEND_DEFAULT_SOUNDSET")
    end

    if _ctrl.option_pressed_left then
        AUDIO.PLAY_SOUND_FRONTEND(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET") -- nig
    end

    if _ctrl.option_pressed_right then
        AUDIO.PLAY_SOUND_FRONTEND(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET") -- nig
    end
end


-- i dont even remember why this looks so fucked
function read_file(filename)
    local file = io.open(filename, "r")
    if file then
        local content = file:read("*a")
        file:close()
        return content
    else
        return"Failed to open file: " .. filename
    end
end


function write_file(filename, content)
    local file = io.open(filename, "w")
    if file then
        file:write(content)
        file:close()
        return true
    else
        return false, "Failed to open file for writing: " .. filename
    end
end
--[[
function read_entire_lua()



    read_content_table = {
        entity_tbls_t = read_file(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\entity_tbls.lua"), -- more broken bullshit
        input_bullshit_t = read_file(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\nigger_keys.lua"),
        json_shit_t = read_file(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\json.lua"),
        natives_t = read_file(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\nativedb.lua"),
        globals_t = read_file(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\globals.lua"), -- fix bullshit
        functions_t = read_file(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\functions.lua"),
        --globals_t = read_file(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\globals.lua"),
        --entity_tbls_t = read_file(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\entity_tbls.lua"),
        --input_bullshit_t = read_file(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\nigger_keys.lua"),
        --json_shit_t = read_file(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\json.lua"),
        all_players_options_t = read_file(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\!all_players_options.lua"),
        all_players_options_functions_t = read_file(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\!all_players_options_functions.lua"),
        network_options_t = read_file(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\!network_options.lua"),
        network_options_functions_t = read_file(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\!network_options_functions.lua"),
        players_options_t = read_file(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\!players_options.lua"),
        players_options_functions_t = read_file(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\!players_options_functions.lua"),
        self_options_functions_t = read_file(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\!self_options_functions.lua"),
        self_options_t = read_file(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\!self_options.lua"),
        setting_options_t = read_file(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\!setting_options.lua"),
        setting_options_functions_t = read_file(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\!setting_options_functions.lua"),
        vehicle_options_t = read_file(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\!vehicle_options.lua"),
        vehicle_options_functions_t = read_file(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\!vehicle_options_functions.lua"),
        weapon_options_t = read_file(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\!weapon_options.lua"),
        weapon_options_functions_t = read_file(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\!weapon_options_functions.lua"),
        misc_options_t = read_file(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\!misc_options.lua"),
        misc_options_functions_t = read_file(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\!misc_options_functions.lua"),
        world_options_t = read_file(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\!world_options.lua"),
        world_options_functions_t = read_file(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\!world_options_functions.lua"),
        spawner_options_t = read_file(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\!spawner_options.lua"),
        spawner_options_functions_t = read_file(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\!spawner_options_functions.lua"),
        config_stuff_t = read_file(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\config_stuff.lua"),
        sigs_t = read_file(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\sigs.lua"),
        game_functions_t = read_file(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\game_functions.lua"),


        space_main_end_only_t = read_file(FileMgr.GetMenuRootPath() .. "\\Lua\\space.lua"),


    }

    return read_content_table
end

function pack_entire_lua()

    local path_ = FileMgr.GetMenuRootPath() .. "\\Lua\\packed_lua\\space_menu.lua"

    content_ = read_entire_lua()

    local file = io.open(path_, "w")
    if file then

        for _, content in pairs(content_) do
            file:write(content)
            file:write("\n")
            file:write("\n")
            file:write("\n")
            file:write("\n")
            file:write("\n")
            file:write("\n")
            wait_t(5000)
        end

        file:close()
    end

end

]]

function read_entire_lua()
    local rootPath = FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\"
    local read_content_table = {
        {name = "entity_tbls_t", content = read_file(rootPath .. "entity_tbls.lua")},
        {name = "input_bullshit_t", content = read_file(rootPath .. "nigger_keys.lua")},
        {name = "json_shit_t", content = read_file(rootPath .. "json.lua")},
        {name = "natives_t", content = read_file(rootPath .. "nativedb.lua")},
        {name = "globals_t", content = read_file(rootPath .. "globals.lua")},
        {name = "functions_t", content = read_file(rootPath .. "functions.lua")},
        {name = "all_players_options_t", content = read_file(rootPath .. "!all_players_options.lua")},
        {name = "all_players_options_functions_t", content = read_file(rootPath .. "!all_players_options_functions.lua")},
        {name = "network_options_t", content = read_file(rootPath .. "!network_options.lua")},
        {name = "network_options_functions_t", content = read_file(rootPath .. "!network_options_functions.lua")},
        {name = "players_options_t", content = read_file(rootPath .. "!players_options.lua")},
        {name = "players_options_functions_t", content = read_file(rootPath .. "!players_options_functions.lua")},
        {name = "self_options_functions_t", content = read_file(rootPath .. "!self_options_functions.lua")},
        {name = "self_options_t", content = read_file(rootPath .. "!self_options.lua")},
        {name = "setting_options_t", content = read_file(rootPath .. "!setting_options.lua")},
        {name = "setting_options_functions_t", content = read_file(rootPath .. "!setting_options_functions.lua")},
        {name = "vehicle_options_t", content = read_file(rootPath .. "!vehicle_options.lua")},
        {name = "vehicle_options_functions_t", content = read_file(rootPath .. "!vehicle_options_functions.lua")},
        {name = "weapon_options_t", content = read_file(rootPath .. "!weapon_options.lua")},
        {name = "weapon_options_functions_t", content = read_file(rootPath .. "!weapon_options_functions.lua")},
        {name = "misc_options_t", content = read_file(rootPath .. "!misc_options.lua")},
        {name = "misc_options_functions_t", content = read_file(rootPath .. "!misc_options_functions.lua")},
        {name = "world_options_t", content = read_file(rootPath .. "!world_options.lua")},
        {name = "world_options_functions_t", content = read_file(rootPath .. "!world_options_functions.lua")},
        {name = "spawner_options_t", content = read_file(rootPath .. "!spawner_options.lua")},
        {name = "spawner_options_functions_t", content = read_file(rootPath .. "!spawner_options_functions.lua")},
        {name = "config_stuff_t", content = read_file(rootPath .. "config_stuff.lua")},
        {name = "sigs_t", content = read_file(rootPath .. "sigs.lua")},
        {name = "game_functions_t", content = read_file(rootPath .. "game_functions.lua")},
        {name = "space_main_end_only_t", content = read_file(rootPath .. "..\\space.lua")},
    }

    return read_content_table
end

function pack_entire_lua()
    local path_ = FileMgr.GetMenuRootPath() .. "\\Lua\\packed_lua\\space_menu.lua"
    local content_ = read_entire_lua()

    local file = io.open(path_, "w")
    if file then
        for _, item in ipairs(content_) do
            file:write(item.content)
            file:write("\n")
            file:write("\n")
            file:write("\n")
            file:write("\n")
            file:write("\n")
            file:write("\n")
            wait_t(5000)
        end
        file:close()
    end
end


function check_folders()

    local main_folder_ = FileMgr.GetMenuRootPath() .. "\\Lua\\space"
    local paints_ = FileMgr.GetMenuRootPath() .. "\\Lua\\space\\paints"
    local settings_ = FileMgr.GetMenuRootPath() .. "\\Lua\\space\\settings"
    local settings_defualt = FileMgr.GetMenuRootPath() .. "\\Lua\\space\\settings\\defualt"
    local hot_key_files_ = FileMgr.GetMenuRootPath() .. "\\Lua\\space\\hotkeys"
    local hot_key_files_defualt = FileMgr.GetMenuRootPath() .. "\\Lua\\space\\hotkeys\\defualt"
    local themes_ = FileMgr.GetMenuRootPath() .. "\\Lua\\space\\themes"
    local themes_defualt = FileMgr.GetMenuRootPath() .. "\\Lua\\space\\themes\\defualt"

    if not FileMgr.DoesFileExist(main_folder_) then
        FileMgr.CreateDir(main_folder_)
    end

    if not FileMgr.DoesFileExist(paints_) then
        FileMgr.CreateDir(paints_)
    end

    if not FileMgr.DoesFileExist(settings_) then
        FileMgr.CreateDir(settings_)
    end

    if not FileMgr.DoesFileExist(settings_defualt) then
        FileMgr.CreateDir(settings_defualt)
    end

    if not FileMgr.DoesFileExist(hot_key_files_) then
        FileMgr.CreateDir(hot_key_files_)
    end

    if not FileMgr.DoesFileExist(hot_key_files_defualt) then
        FileMgr.CreateDir(hot_key_files_defualt)
    end

    if not FileMgr.DoesFileExist(themes_) then
        FileMgr.CreateDir(themes_)
    end

    if not FileMgr.DoesFileExist(themes_defualt) then
        FileMgr.CreateDir(themes_defualt)
    end


end

function auto_load_files()

    g_load_hotkeys(FileMgr.GetMenuRootPath() .. "\\Lua\\space\\hotkeys\\" .. _menu.hot_key_file)
    g_load_settings(FileMgr.GetMenuRootPath() .. "\\Lua\\space\\settings\\" .. _menu.settings_file)
    g_load_theme(FileMgr.GetMenuRootPath() .. "\\Lua\\space\\themes\\" .. _menu.theme_file)


end

function dbg_text_func(_text)
    dbg.dbg_text_count = dbg.dbg_text_count + 1
    if dbg.dbg_text then
        draw_text(_text, 0.0, (dbg.dbg_text_coord * dbg.dbg_text_count) - (0.02), dbg.dbg_text_scale, rgba_to_hex_(255, 0, 0, 255), 0, false, false, false)
        
    end
end

function open_tooltip_helper(string_)
    _red.tooltip_text, _green.tooltip_text, _blue.tooltip_text = cycle_rgb(_red.tooltip_text, _green.tooltip_text, _blue.tooltip_text, 0.0, 255.0, _g.banner_text_rainbow_speed)
    draw_text(string_, 0.5, 0.0, dbg.dbg_text_scale, rgba_to_hex_(_red.tooltip_text:floor_t(), _green.tooltip_text:floor_t(), _blue.tooltip_text:floor_t(), 255), 0, true, false, false)
    draw_text("(INSERT)", 0.5, 0.02, dbg.dbg_text_scale, rgba_to_hex_(_red.tooltip_text:floor_t(), _green.tooltip_text:floor_t(), _blue.tooltip_text:floor_t(), 255), 0, true, false, false)
    --local start_color = rgba_to_hex_(0, 255, 255, 255)
    --local end_color = rgba_to_hex_(145, 0, 255, 255)
    --draw_text_with_gradient(string_, 0.5, 0.0, dbg.dbg_text_scale, start_color, end_color, 0, 0.005, true, false, false)
    --draw_text_with_gradient("(INSERT)", 0.5, 0.02, dbg.dbg_text_scale, start_color, end_color, 7, 0.005, true, false, false)
        
end
local opentooltip_count_01_01 = 0
function open_tooltip_func() -- this is fucked ik

    --local start_time = Time.GetEpocheMs() -- fuck this shit. like honestly the amount of time i have wasted trying to use this only to find out its broken WHAT??????

    if opentooltip_count_01_01 == 0 then
        opentooltip_count_01_01 = 1
    end

    for i=1, 800 do
        if not _settings.tooltip_text then
            break
        end
        open_tooltip_helper(open_tooltip_tbl[opentooltip_count_01_01])
        wait_t(0)
    end

    if opentooltip_count_01_01 == 9 then
        opentooltip_count_01_01 = 0
    end
    opentooltip_count_01_01 = opentooltip_count_01_01 + 1
end


function wait_t(time)
    Script.Yield(time)
end

function helper_request_model(model_, timeout)
    
    if not STREAMING.HAS_MODEL_LOADED(model_) then
        STREAMING.REQUEST_MODEL(model_)
        while not STREAMING.HAS_MODEL_LOADED(model_) do
          wait_t(0)
        end
    end
end

function helper_request_control(entity_)
    --GTA.GiveControl(PLAYER.PLAYER_ID(), entity_)
    local ticks = 0
    dbg_log_t("about to check if you have control")
    if not (NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity_)) then
        dbg_log_t("about to start request control loop")
        while not (NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity_)) and ticks < 500 do
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity_)
            dbg_log_t("requesting control loop")
            ticks = ticks + 1
            wait_t(0)
        end

    end

    ticks = 0

    if NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity_) then
        dbg_log_t("helper_request_control succeeded")
    elseif (not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity_)) then
        dbg_log_t("helper_request_control failed")
    end



    return NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity_)

end

function helper_create_object(_hash, coords_x, coords_y, coords_z)

    if _menu.is_dev then
        dbg_log_t("helper_create_object is about to call GTA.CreateWorldObject")
    end
    local _obj = GTA.CreateWorldObject(_hash, coords_x, coords_y, coords_z, false, true)
    if _menu.is_dev then
        dbg_log_t("helper_create_object is about to call ENTITY.SET_ENTITY_AS_MISSION_ENTITY")
    end
    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(_obj, false, true)

    return _obj
end

function helper_create_ped(hash_, coords_x, coords_y, coords_z, ped_type, heading)

    local _ped = GTA.CreatePed(hash_, ped_type, coords_x, coords_y, coords_z, heading, true, false)
    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(_ped, false, true)

    return _ped

end

function helper_create_vehicle(_hash, coords_x, coords_y, coords_z, heading)

    local _veh = GTA.SpawnVehicle(_hash, coords_x, coords_y, coords_z, heading, true, false)
    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(_veh, false, true)

    return _veh
end

function helper_delete_entity(entity)
    helper_request_control(entity)
    --unrigster_enity_from_handle(entity)
    local ent_ptr = Memory.Alloc(4)
    Memory.WriteInt(ent_ptr, entity)
    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(entity, false, false)
    NETWORK.NETWORK_UNREGISTER_NETWORKED_ENTITY(entity) -- this has checks in place to make it not work if you are trying to delete a clone or script entity but seems to work in most cases i can see why there is this check because when i was messsing with it in my personal menu i ended up crashing my self a few times
    ENTITY.DELETE_ENTITY(ent_ptr)
    Memory.Free(ent_ptr)
end

function helper_delete_mission_train(entity)
    helper_request_control(entity)
    --unrigster_enity_from_handle(entity)
    local ent_ptr = Memory.Alloc(4)
    Memory.WriteInt(ent_ptr, entity)
    VEHICLE.DELETE_MISSION_TRAIN(ent_ptr)
    Memory.Free(ent_ptr)
end

function remove_blip(BLIP)
    local BLIP_ptr = Memory.Alloc(4)
    Memory.WriteInt(BLIP_ptr, BLIP)
    HUD.REMOVE_BLIP(BLIP_ptr)
    Memory.Free(BLIP_ptr)
end


function helper_set_entity_godmode(entity, bool_godmode)

    ENTITY.SET_ENTITY_PROOFS(entity, bool_godmode, bool_godmode, bool_godmode, bool_godmode, bool_godmode, bool_godmode, bool_godmode, bool_godmode)
    -- sig set_entity_invincible and direct function call it here as i dont trust the anti cheat termination cherax does to let me call detected natives 
end

misc = {
    get_ground_z = function(coord_x, coord_y, coord_z)
        ptr_z = Memory.Alloc(24)
        MISC.GET_GROUND_Z_FOR_3D_COORD(coord_x, coord_y, coord_z, ptr_z, false, false)

        final_z = Memory.ReadFloat(ptr_z)

        Memory.Free(ptr_z)

        return final_z
    end
}

ui = {

    get_waypoint_coord = function()
        way_point = HUD.GET_FIRST_BLIP_INFO_ID(HUD.GET_WAYPOINT_BLIP_ENUM_ID())
        coords_x, coords_y, coords_z = HUD.GET_BLIP_COORDS(way_point)
        return coords_x, coords_y
    end

}

ped = {

    get_vehicle_ped_is_using = function(ped_)
        return PED.GET_VEHICLE_PED_IS_IN(ped_, true)
    end,

}

player = {

    get_player_vehicle = function(player_)
        return PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_), true)
    end,
    
    is_player_in_any_vehicle = function(player_)
        return PED.IS_PED_IN_ANY_VEHICLE(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_), true)
    end,
    
    get_player_coords = function(player_)
        return ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_), false)
    end,

    player_vehicle = function()
        return PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), true)
    end,

    
    get_entity_player_is_aiming_at = function(_player)
        ent_ = Memory.AllocInt()
        PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(_player, ent_)

        return_value = Memory.ReadInt(ent_)

        Memory.Free(ent_)

        return return_value

    end
     -- edit: read this shit its kinda funny | fucking add read and free or some shit your api makes me wanna kill my self you dont even have to free memory with stand i could get this working but i dont want it returning 2 fucking things : edit found the solution this is why i dont stay awake for more then 6 hours i start to not be able to function

}

local toggle_state = {}
function toggle_helper(bool_, _callback)  -- GYAT DAMN this code sucks
    
    local current_state = bool_

    if current_state and not toggle_state[1] then
        toggle_state[1] = true
        --util.create_thread( function() _callback() end)
        _callback()
    elseif not current_state then
        toggle_state[1] = false
    end
    

    --[[
    if bool_ then
        _callback()
    end -- use the old method if this one is broken
    ]]
end

function notify_t(text)

    Script.QueueJob(function()

        dbg.dbg_text_count = dbg.dbg_text_count + 1

        for i=1, _menu.notify_ticks do
            draw_text(text, 0.5, (dbg.dbg_text_count * 0.035), 0.30, rgba_to_hex_(0, 255, 0, 255), 2.0, true, false, false)
            wait_t(0)
        end

        Logger.Log(eLogColor.GREEN, "space", text)

        dbg.dbg_text_count = dbg.dbg_text_count - 1

    end, nil)

end

function dbg_notify_t(text)

    Script.QueueJob(function()

        dbg.dbg_text_count = dbg.dbg_text_count + 1

        for i=1, _menu.notify_ticks do
            draw_text(text, 0.5, (dbg.dbg_text_count * 0.035), 0.30, rgba_to_hex_(0, 255, 0, 255), 2.0, true, false, false)
            wait_t(0)
        end

        Logger.Log(eLogColor.GREEN, "space", text)

        dbg.dbg_text_count = dbg.dbg_text_count - 1

    end, nil)

end

function log_t(text_)
    Logger.Log(eLogColor.GREEN, "space", text_)
end

function dbg_log_t(text_)
    Logger.Log(eLogColor.GREEN, "space", text_)
end

function bool_true_false(bool_, if_true, if_false)

    if bool_ then
        return if_true
    else
        return if_false
    end


end

--[[function extract_last_part(file_path)
    local _, last_index = file_path:find(".*/")
    if last_index then
        return file_path:sub(last_index + 1)
    else
        return file_path
    end
end]]
function extract_last_part(file_path)
    local last_index = file_path:match("([^\\/]-%.lua)$")
    if last_index then
        return last_index
    else
        return file_path
    end
end
--[[
function insertDot(num, position)
    local numStr = tostring(num)
    if position > 0 and position <= #numStr then
        return tonumber(numStr:sub(1, -position) .. "." .. numStr:sub(-position + 1))
    else
        return nil
    end
end
]]
function insertDot(num)
    return tonumber("0" .. "." .. num)
end


function cycle_rgb(red_01, green_01, blue_01, min_value, max_value, increase_speed)
    local deltaTime = _menu.frame_time_float
    local adjusted_speed = (increase_speed * deltaTime)
    local fail_check = 0

    if red_01 == max_value and green_01 < max_value and blue_01 == min_value then
        green_01 = math.min(green_01 + adjusted_speed, max_value)
        fail_check = fail_check + 1 --1
    end
    
    if red_01 > min_value and green_01 == max_value and blue_01 == min_value then
        red_01 = math.max(red_01 - adjusted_speed, min_value)
        fail_check = fail_check + 1 --2
    end

    if red_01 == min_value and green_01 == max_value and blue_01 < max_value then
        blue_01 = math.min(blue_01 + adjusted_speed, max_value)
        fail_check = fail_check + 1 --3
    end
    
    if red_01 == min_value and green_01 > min_value and blue_01 == max_value then
        green_01 = math.max(green_01 - adjusted_speed, min_value)
        fail_check = fail_check + 1 --4
    end

    if red_01 < max_value and green_01 == min_value and blue_01 == max_value then
        red_01 = math.min(red_01 + adjusted_speed, max_value)
        fail_check = fail_check + 1 --5
    end
    
    if red_01 == max_value and green_01 == min_value and blue_01 > min_value then
        blue_01 = math.max(blue_01 - adjusted_speed, min_value)
        fail_check = fail_check + 1 --6
    end


    if fail_check == 0 then
        red_01 = 255
        green_01 = 0
        blue_01 = 0
        dbg_log_t("rgb cycler hit fail check")
    end

    return red_01, green_01, blue_01
end




function helper_request_ptfx(_ptfx)
    STREAMING.REQUEST_NAMED_PTFX_ASSET(_ptfx)
    while (not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(_ptfx)) do
        wait_t(0)
    end
end


function spawn_vehicle_for_vehicle_spawner(_hash)

    local coords_x, coords_y, coords_z = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())

    if _settings.delete_last_vehicle then

    end

    if _settings.delete_current_vehicle_vspawn then
        if player.is_player_in_any_vehicle(PLAYER.PLAYER_ID()) then
            helper_delete_entity(PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false))
            dbg_log_t("should have deleted the current vehicle")
        end
        dbg_log_t("_settings.delete_current_vehicle_vspawn returned true")
    end

    local veh_ = helper_create_vehicle(_hash , coords_x, coords_y, coords_z, ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID()))

    if _settings.spawn_inside_vehicle_vspawn then
        PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), veh_, -1)
    end

    wait_t(0)

    VEHICLE.SET_VEHICLE_ENGINE_ON(PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), true), true, true, false)


    if _settings.spawn_with_ptfx_vspawn then
        local coords_ = ENTITY.GET_ENTITY_COORDS(veh_, false)
        helper_request_ptfx("proj_indep_firework_v2")
        GRAPHICS.USE_PARTICLE_FX_ASSET("proj_indep_firework_v2")
        local ptfx_ = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY("scr_firework_indep_repeat_burst_rwb", veh_, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.2, false, false, false, 1.0, 1.0, 1.0, 0--[[this needs to be false but cherax has it as a fucking int or float or something 0 in C++ is false]])
        --GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY("scr_firework_indep_repeat_burst_rwb", veh_, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.2, false, false, false, 255, 255, 255, false)

        wait_t(0)
        GRAPHICS.STOP_PARTICLE_FX_LOOPED(ptfx_, false)
        GRAPHICS.REMOVE_PARTICLE_FX(ptfx_)
        dbg_log_t("tried to spawn with ptfx")
    end

    if _settings.spawn_with_custom_color_vspawn then
        VEHICLE.SET_VEHICLE_COLOURS(veh_, 158, 158)
        VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(veh_, 0, 0, 40)
        VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(veh_, 0, 0, 40)
        --g_vehicle_paint_load(FileMgr.GetMenuRootPath() .. "\\Lua\\space\\paints\\" .. "africans.lua")
        VEHICLE.SET_VEHICLE_EXTRA_COLOURS(veh_, 135, 134)
        VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(veh_, 5)
        VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(veh_, "SPACE")

        --remove and make its own option 
        VEHICLE.SET_VEHICLE_MOD_KIT(veh_, 2)
        VEHICLE.SET_VEHICLE_WHEEL_TYPE(veh_, 8)
        VEHICLE.SET_VEHICLE_MOD(veh_, 23, 107, true)
		VEHICLE.SET_VEHICLE_WINDOW_TINT(veh_, 5)
    end

    if _settings.spawn_with_max_upgrades then

        VEHICLE.SET_VEHICLE_MOD(veh_, 0, 1, 0)
        VEHICLE.SET_VEHICLE_MOD(veh_, 1, 1, 0)
        VEHICLE.SET_VEHICLE_MOD(veh_, 2, 1, 0)
        VEHICLE.SET_VEHICLE_MOD(veh_, 3, 1, 0)
        VEHICLE.SET_VEHICLE_MOD(veh_, 4, 1, 0)
        VEHICLE.SET_VEHICLE_MOD(veh_, 5, 1, 0)
        VEHICLE.SET_VEHICLE_MOD(veh_, 6, 1, 0)
        VEHICLE.SET_VEHICLE_MOD(veh_, 7, 1, 0)
        VEHICLE.SET_VEHICLE_MOD(veh_, 8, 1, 0)
        VEHICLE.SET_VEHICLE_MOD(veh_, 9, 1, 0)
        VEHICLE.SET_VEHICLE_MOD(veh_, 10, 1, 0)
        VEHICLE.TOGGLE_VEHICLE_MOD(veh_, 18, 1)
        VEHICLE.TOGGLE_VEHICLE_MOD(veh_, 22, 1)
        VEHICLE.TOGGLE_VEHICLE_MOD(veh_, 20, 1)
        VEHICLE.SET_VEHICLE_MOD(veh_, 16, 5, 0)
        VEHICLE.SET_VEHICLE_MOD(veh_, 12, 2, 0)
        VEHICLE.SET_VEHICLE_MOD(veh_, 11, 3, 0)
        VEHICLE.SET_VEHICLE_MOD(veh_, 14, 14, 0)
        VEHICLE.SET_VEHICLE_MOD(veh_, 15, 3, 0)
        VEHICLE.SET_VEHICLE_MOD(veh_, 13, 2, 0)

    end

    if _settings.spawn_with_windows_rolled_down_vspawn then
        VEHICLE.ROLL_DOWN_WINDOWS(veh_)
    end

    if _settings.spawn_with_no_windows_vspawn then
        for i=0, 7 do
            VEHICLE.REMOVE_VEHICLE_WINDOW(veh_, i)
        end
    end

    if _settings.spawn_with_radio_off_vspawn then
        AUDIO.SET_VEH_RADIO_STATION(PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), true), "OFF")--AUDIO.SET_RADIO_TO_STATION_NAME("RADIO_OFF")
    end
end

function spawn_object_for_object_spawner(_hash)
    local coords_x, coords_y, coords_z = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    helper_create_object(_hash, coords_x, coords_y, coords_z)
end


function get_net_id_from_handle(ent)

    --wondering why its done like this? because it originally used cases and lua does not fucking have them

    local ent_type = ENTITY.GET_ENTITY_TYPE(ent)

    if ent_type == 1--[[ped]] then
        return NETWORK.PED_TO_NET(ent)
    end

    if ent_type == 2--[[vehicle]] then
        return NETWORK.VEH_TO_NET(ent)
    end

    if ent_type == 3--[[object]] then
        return NETWORK.OBJ_TO_NET(ent)
    end

end

function get_net_obj_from_handle(ent)-- broken

    local net_id = get_net_id_from_handle(ent)

    return NetworkObjectMgr.GetNetworkObject(net_id, false)

end

function unrigster_enity_from_handle(ent)

    local net_obj = get_net_obj_from_handle(ent)
    NetworkObjectMgr.UnregisterNetworkObject(net_obj, 0, true, true)
    --CPhysical_ = CPhysical.FromAddress(ent)
    --Memory.LuaCallCFunction(sigs.UNRIGSTER_ENTITY, CPhysical_, true)
end

--[[
function bool_flip(b00l_)
    _menu.loading_sprite = true
    wait_t(0)
    _menu.loading_sprite = false
    return not b00l_
end]] -- trying to fix some unwanted toggle behavior