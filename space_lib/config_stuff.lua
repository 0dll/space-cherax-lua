






























--[[

    ┌──────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    │                                                                                                              │
    │**************************************************************************************************************│
    │                                                                                                              │
    │*********************************************** OPTIONS ******************************************************│
    │                                                                                                              │
    │**************************************************************************************************************│
    │                                                                                                              │
    │**************************************************************************************************************│
    └──────────────────────────────────────────────────────────────────────────────────────────────────────────────┘

]]











function file_exists(filename)
    local file = io.open(filename, "r")
    if file then
        file:close()
        return true
    else
        return false
    end
end

function is_number(str)
    return tonumber(str) ~= nil
end



function g_save_settings(filename, settingsTable)
    local file = io.open(filename, "w")
    if file then

        file:write(json_encode(settingsTable))

        file:close()
    else
        notify_func("error: unable to open file for writing")
    end
end


function enable_loops_aka_options()

end

function g_load_settings(filename)
    local file = io.open(filename, "r")

    if file then
        local content = file:read("*all")
        local decoded_content = json_decode(content)

        for key, value in pairs(decoded_content) do
            _settings[key] = value
        end

        --to_enable.option_ped_wetness(false) -- works not what i need though 
        --to_enable.speed_plate(false)
        --to_enable.vehicle_fly(false)
        --to_enable.vehicle_projectile_rapid_fire_func(false)
        --to_enable.water_wave_intensity(false)
        --to_enable.gravity_level(false)
        --to_enable.rainbow_paint(false)

        for name, func in pairs(to_enable) do 
            Script.QueueJob(function() func(false) end, nil)  -- Call each function with the argument `false`
        end
    else
        notify_func("error: unable to load settings")
    end
end



--[[

    ┌──────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    │                                                                                                              │
    │**************************************************************************************************************│
    │                                                                                                              │
    │********************************************** HOT HEYS ******************************************************│
    │                                                                                                              │
    │**************************************************************************************************************│
    │                                                                                                              │
    │**************************************************************************************************************│
    └──────────────────────────────────────────────────────────────────────────────────────────────────────────────┘

]]


function g_save_hotkeys(filename)

    local file_1 = io.open(filename, "w")
    if file_1 then

        file_1:write(json_encode(_hot_key_tbl))

        file_1:close()
    else
        notify_func("error: unable to open file for writing")
    end

end


function g_load_hotkeys(filename)
    local file_1 = io.open(filename, "r")

    if file_1 then
        local content = file_1:read("*all")
        local decoded_content = json_decode(content)

        for key, value in pairs(decoded_content) do
            _hot_key_tbl[key] = value
        end
    else
        notify_func("error: unable to load settings")
    end


end





--[[

    ┌──────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    │                                                                                                              │
    │**************************************************************************************************************│
    │                                                                                                              │
    │********************************************** themes ********************************************************│
    │                                                                                                              │
    │**************************************************************************************************************│
    │                                                                                                              │
    │**************************************************************************************************************│
    └──────────────────────────────────────────────────────────────────────────────────────────────────────────────┘

]]


function g_save_theme(filename)
    local file_1 = io.open(filename, "w")
    if file_1 then
        
        local theme_data = {
            themes = _themes,
            _menu_r = menu_r,
            _menu_g = menu_g,
            _menu_b = menu_b,
            _menu_a = menu_a
        }

        
        file_1:write(json_encode(theme_data))
        file_1:close()
    else
        notify_func("error: unable to open file for writing")
    end
end

function g_load_theme(filename)
    local file_1 = io.open(filename, "r")

    if file_1 then
        local content = file_1:read("*all")
        file_1:close()

        local decoded_content = json_decode(content)
        if decoded_content then
            
            local _themes_ = decoded_content.themes
            local _menu_r = decoded_content._menu_r
            local _menu_g = decoded_content._menu_g
            local _menu_b = decoded_content._menu_b
            local _menu_a = decoded_content._menu_a

            for key, value in pairs(_themes_) do
                _themes[key] = value
            end

            for key, value in pairs(_menu_r) do
                menu_r[key] = value
            end

            for key, value in pairs(_menu_g) do
                menu_g[key] = value
            end

            for key, value in pairs(_menu_b) do
                menu_b[key] = value
            end

            for key, value in pairs(_menu_a) do
                menu_a[key] = value
            end
        else
            notify_func("error: unable to decode theme data")
        end
    else
        notify_func("error: unable to load theme")
    end
end








--[[

    ┌──────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    │                                                                                                              │
    │**************************************************************************************************************│
    │                                                                                                              │
    │******************************************* VEHCILE PAINTS ***************************************************│
    │                                                                                                              │
    │**************************************************************************************************************│
    │                                                                                                              │
    │**************************************************************************************************************│
    └──────────────────────────────────────────────────────────────────────────────────────────────────────────────┘

]]



function update_vehicle_paint_save()

    vehicle_paint_loader = {}

    vehicle_paint_loader["_file.vehicle_color_type_primary"] = _file.vehicle_color_type_primary
    vehicle_paint_loader["_file.vehicle_color_type_secondary"] = _file.vehicle_color_type_secondary

    vehicle_paint_loader["_file.vehicle_extra_color_primary"] = _file.vehicle_extra_color_primary
    vehicle_paint_loader["_file.vehicle_extra_color_secondary"] = _file.vehicle_extra_color_secondary

    vehicle_paint_loader["_file.vehicle_custom_primary_r"] = _file.vehicle_custom_primary_r
    vehicle_paint_loader["_file.vehicle_custom_primary_g"] = _file.vehicle_custom_primary_g
    vehicle_paint_loader["_file.vehicle_custom_primary_b"] = _file.vehicle_custom_primary_b

    vehicle_paint_loader["_file.vehicle_custom_secondary_r"] = _file.vehicle_custom_secondary_r
    vehicle_paint_loader["_file.vehicle_custom_secondary_g"] = _file.vehicle_custom_secondary_g
    vehicle_paint_loader["_file.vehicle_custom_secondary_b"] = _file.vehicle_custom_secondary_b

    vehicle_paint_loader["_file.vehicle_extra_color_5"] = _file.vehicle_extra_color_5
    vehicle_paint_loader["_file.vehicle_extra_color_6"] = _file.vehicle_extra_color_6

    vehicle_paint_loader["_file.vehicle_tyre_smoke_color_r"] = _file.vehicle_tyre_smoke_color_r
    vehicle_paint_loader["_file.vehicle_tyre_smoke_color_g"] = _file.vehicle_tyre_smoke_color_g
    vehicle_paint_loader["_file.vehicle_tyre_smoke_color_b"] = _file.vehicle_tyre_smoke_color_b

end

function update_vehicle_paint_load()
    VEHICLE.SET_VEHICLE_COLOURS(PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false), vehicle_paint_loader["_file.vehicle_color_type_primary"], vehicle_paint_loader["_file.vehicle_color_type_secondary"])
    VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false), vehicle_paint_loader["_file.vehicle_custom_primary_r"], vehicle_paint_loader["_file.vehicle_custom_primary_g"], vehicle_paint_loader["_file.vehicle_custom_primary_b"])
    VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false), vehicle_paint_loader["_file.vehicle_custom_secondary_r"], vehicle_paint_loader["_file.vehicle_custom_secondary_g"], vehicle_paint_loader["_file.vehicle_custom_secondary_b"])
    VEHICLE.SET_VEHICLE_EXTRA_COLOURS(PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false), vehicle_paint_loader["_file.vehicle_extra_color_primary"], vehicle_paint_loader["_file.vehicle_extra_color_secondary"])
    VEHICLE.SET_VEHICLE_EXTRA_COLOUR_5(PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false), vehicle_paint_loader["_file.vehicle_extra_color_5"])
    VEHICLE.SET_VEHICLE_EXTRA_COLOUR_6(PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false), vehicle_paint_loader["_file.vehicle_extra_color_6"])
    VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false), vehicle_paint_loader["_file.vehicle_tyre_smoke_color_b"], vehicle_paint_loader["_file.vehicle_tyre_smoke_color_g"], vehicle_paint_loader["_file.vehicle_tyre_smoke_color_r"])
end

function g_vehicle_paint_save(paint_file)
    --local settings_file = FileMgr.GetMenuRootPath() .. "\\Lua\\space\\paints" .. paint_file

    local file = io.open(paint_file, "w")

    notify_t(paint_file)
    if file then
        update_vehicle_paint_save()
        file:write(json_encode(vehicle_paint_loader))
        file:close()
        notify_t("paint file saved")
    else
        notify_t("could not open file")
    end
end

function g_vehicle_paint_load(paint_file)
    --local settings_file = FileMgr.GetMenuRootPath() .. "\\Lua\\space\\paints" .. paint_file

    if not file_exists(paint_file) then
        notify_t("could not open file")
        return
    end

    local file = io.open(paint_file, "r")

    if file then
        local content = file:read("*all")
        file:close()

        vehicle_paint_loader = json_decode(content)

        update_vehicle_paint_load()

        notify_t("paint file loaded")
    else
        notify_t("could not open file")
    end
end
