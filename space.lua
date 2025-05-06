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


--SCRIPT_GFX_VISIBLE_WHEN_PAUSED
dofile(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\entity_tbls.lua")
dofile(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\keys.lua")
dofile(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\json.lua")
dofile(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\nativedb.lua")
dofile(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\globals.lua")
dofile(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\functions.lua")
dofile(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\!all_players_options.lua")
dofile(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\!all_players_options_functions.lua")
dofile(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\!self_options_functions.lua")
dofile(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\!self_options.lua")
dofile(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\!network_options.lua")
dofile(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\!network_options_functions.lua")
dofile(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\!players_options.lua")
dofile(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\!players_options_functions.lua")
dofile(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\!setting_options.lua")
dofile(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\!setting_options_functions.lua")
dofile(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\!vehicle_options.lua")
dofile(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\!vehicle_options_functions.lua")
dofile(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\!weapon_options.lua")
dofile(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\!weapon_options_functions.lua")
dofile(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\!misc_options.lua")
dofile(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\!misc_options_functions.lua")
dofile(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\!world_options.lua")
dofile(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\!world_options_functions.lua")
dofile(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\config_stuff.lua")
dofile(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\sigs.lua")
dofile(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\game_functions.lua")
dofile(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\!spawner_options.lua")
dofile(FileMgr.GetMenuRootPath() .. "\\Lua\\space_lib\\!spawner_options_functions.lua")

--SYSTEM.SETTIMERA(10000)



function dbg_text_thing_test()

    dbg_text_func("frame_time_ns: " .. tostring(_menu.frame_time_ns))
    dbg_text_func("frame_time_ms: " .. tostring(_menu.frame_time_ms))
    dbg_text_func("frame_time_float: " .. tostring(_menu.frame_time_float))
    dbg_text_func("SYSTEM.TIMERA(): " .. SYSTEM.TIMERA()) --SETTIMERB
    dbg_text_func("SYSTEM.TIMERB(): " .. SYSTEM.TIMERB())
    dbg_text_func("sub storeage: " .. menu_storage[#menu_storage])
    dbg_text_func("_g.should_loop_all_vehicle_spawn_options: " .. tostring(_g.should_loop_all_vehicle_spawn_options))


end

local should_be_left_or_right = false
function main_menu_space()
    online_players_list()
    _self_options_main_()
    _weapon_options_main_()
    _vehicle_options_()
    _misc_options_main_()
    _world_options_main_()
    _spawner_options_()
    _settings_main_()

    add_submenu_option("Players List", " ", submenus.main_menu, submenus.players_list)
    add_submenu_option("Self", " ", submenus.main_menu, submenus.self_main_menu)
    add_submenu_option("Weapon", " ", submenus.main_menu, submenus.weapon_main_menu)
    add_submenu_option("Vehicle", " ", submenus.main_menu, submenus.vehicle_main_menu)
    add_submenu_option("Misc", " ", submenus.main_menu, submenus.misc_main_menu)
    add_submenu_option("World", " ", submenus.main_menu, submenus.world_main_menu)
    add_submenu_option("Spawner", " ", submenus.main_menu, submenus.spawner_menu)
    add_submenu_option("Settings", " ", submenus.main_menu, submenus.settings_main_menu)


end


function menu_main_entry()

    local start_time_ns = SYSTEM.TIMERA()--Time.GetEpocheNs()
    local start_time_ms = Time.GetEpocheMs()



    if _menu.push_first_menu then
        push_menu(submenus.main_menu)
        _menu.push_first_menu = false
    end

    if _menu.check_folders then
        check_folders()
        _menu.check_folders = false
    end

    if _menu.auto_load_files then
        auto_load_files()
        _menu.auto_load_files = false
    end

    if menu_storage[#menu_storage] ~= submenus.vehicle_spawner_selected_class then -- make the option loop when not in use so hotkeys work
        _g.should_loop_all_vehicle_spawn_options = true
    else
        _g.should_loop_all_vehicle_spawn_options = false
    end


    --rect_test()




    draw_menu_banner()
    draw_menu_footer()
    _menu.m_option_count = 0
    --menu_storage[#menu_storage]
    main_menu_space()
    _g.null_hotkey = 0x87 -- this should always be corected every frame if its ever changed
    _ctrl.option_press_click = false
    _ctrl.option_down_pressed = false
    _ctrl.option_up_pressed = false
    _ctrl.option_back_pressed = false
    _ctrl.option_pressed_left = false
    _ctrl.option_pressed_right = false
    _ctrl.hot_key_pressed = false
    menu_input_handler()
    fast_input()
    menu_sound_handler()
    if dbg.dbg_text then
        dbg_text_thing_test()
    end
    dbg.dbg_text_count = 0

    local end_time_ns = SYSTEM.TIMERA()
    local end_time_ms = Time.GetEpocheMs() 

    _menu.frame_time_ms = (end_time_ms - start_time_ms)
    _menu.frame_time_ns = (SYSTEM.TIMESTEP()) * (100)--(end_time_ns - start_time_ns)

    _menu.frame_time_float = _menu.frame_time_ns--insertDot(_menu.frame_time_ns)
end

function space_main()

    while true do
        menu_main_entry()
        wait_t(0)
    end

end

function tooltip_bullshit()

    while true do
        if _settings.tooltip_text then
            open_tooltip_func()
        end
        wait_t(0)
    end

end



Script.QueueJob(function() tooltip_bullshit() end, nil)

Script.QueueJob(function() space_main() end, nil)