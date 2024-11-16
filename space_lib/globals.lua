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
sigs = {}
_renderer = {} --unused
_stream = {} -- unused
_entity = {} -- going to be used by the time i release this probably 
_network = {}
_file = {}
space = {}
_menu = {}
_ctrl = {}
_g = {}
_o = {}
dbg = {}
_hot_key_tbl = {}
_themes = {}
_r = {}
--_g = {}
_b = {}
_a = {}
red = {} -- change this
green = {} -- change this
blue = {} -- change this
_red = {} -- to use this
_green = {} -- to use this
_blue = {} -- to use this
menu_r = {}
menu_g = {}
menu_b = {}
menu_a = {}
_detctions = {}
_settings = {}
to_enable = {}
speed_unit = {
  number = 2.236936,
  text = "MPH"
}

open_tooltip_tbl = {
    "man it doesn't matter she 15 my nigga i like young girls i like em 14, 15, 16...", -- 1 -- i think
    "what do you mean this toilet is for display only",
    "prizuhm is mad someone that acts as retarded as i do is smarter then him",
    "that ban didnt do much my negro",
    "space on top",
    "would you rather watch a tree grow or a knee grow?",
    "horse fucker or some shit, i would not know i use proton mail",
    "man will i ever get a break from the mutes?",
    "look i hate rape as much as the next person but..." -- 9 -- if the top is not 1 change this shit. edit top is one
}

key_option_output = {-- idk why im making this a global im bored 
    save_hotkey_output = "",
    save_hotkey_input_bool = false,

    save_settings_output = "",
    save_settings_input_bool = false,

    save_theme_output = "",
    save_theme_input_bool = false

}

submenus = {

    main_menu = "main_menu",

    -------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------players list---------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    players_list = "players_list",
    main_players_menu = "main_players_menu",
    player_vehicle_menu = "player_vehicle_menu",
    attach_players_car_menu = "attach_players_car_menu",
    player_griefing_menu = "player_griefing_menu",
    player_crashes_menu = "player_crashes_menu",

    -------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    -----------------------------------------------------self menu-----------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    self_main_menu = "self_main_menu",

    -------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------weapon menu----------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    weapon_main_menu = "weapon_main_menu",

    -------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    ---------------------------------------------------vehicle menu----------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    vehicle_main_menu = "vehicle_main_menu",
    vehicle_rgb_menu = "vehicle_rgb_menu",
    select_paint_to_load_menu = "select_paint_to_load_menu",
    paint_editor_menu = "paint_editor_menu",
    paint_editor_and_saver_menu = "paint_editor_and_saver_menu",

    -------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    -----------------------------------------------------misc menu-----------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    misc_main_menu = "misc_main_menu",

    -------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------world menu-----------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    world_main_menu = "world_main_menu",
    world_train_menu = "world_train_menu",

    -------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    ---------------------------------------------------spawner menu----------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    spawner_menu = "spawner_menu",
    vehicle_spawner_classes_menu = "vehicle_spawner_classes_menu",
    vehicle_spawner_selected_class = "vehicle_spawner_selected_class",
    vehicle_spawner_menu = "vehicle_spawner_menu",

    -------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    ---------------------------------------------------settings menu---------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    settings_main_menu = "settings_main_menu",
    settings_config = "settings_config",
    menu_size_menu = "menu_size_menu",
    menu_position_menu = "menu_position_menu",
    hot_key_files_menu = "hot_key_files_menu",
    settings_files_menu = "settings_files_menu",
    theme_menu = "theme_menu",
    header_color_menu = "header_color_menu",
    header_text_color_menu = "header_text_color_menu",
    scroll_bar_color_no_fade_menu = "scroll_bar_color_no_fade_menu",
    scroll_bar_color_fade_start_menu = "scroll_bar_color_fade_start_menu",
    scroll_bar_color_fade_end_menu = "scroll_bar_color_fade_end_menu",
    background_color_menu = "background_color_menu",
    footer_color_menu = "footer_color_menu",
    sub_footer_color_menu = "sub_footer_color_menu",
    sub_footer_text_color_menu = "sub_footer_text_color_menu",
    option_text_color_menu = "option_text_color_menu",
    option_text_selected_color_menu = "option_text_selected_color_menu",
    loading_indicator_color_menu = "loading_indicator_color_menu",
    break_option_color_menu = "break_option_color_menu",
    theme_saving_menu = "theme_saving_menu"

}
-- im not even going to begin to try to fix this or clean it up its working thats all i care about. if the fucking time shit was working i would not have even done all this shit wonder why shits not working
menu_nav_ticks = {}
menu_nav_ticks2 = {}
menu_nav_ticks3 = {}
menu_nav_ticks4 = {}
menu_nav_supper_speed = {}
menu_nav_do_nav = {}

menu_nav_ticks[1] = 0
menu_nav_ticks2[1] = 0
menu_nav_ticks3[1] = 0
menu_nav_ticks4[1] = 0
menu_nav_supper_speed[1] = false
menu_nav_do_nav[1] = false

menu_nav_ticks[2] = 0
menu_nav_ticks2[2] = 0
menu_nav_ticks3[2] = 0
menu_nav_ticks4[2] = 0
menu_nav_supper_speed[2] = false
menu_nav_do_nav[2] = false

menu_nav_ticks[3] = 0
menu_nav_ticks2[3] = 0
menu_nav_ticks3[3] = 0
menu_nav_ticks4[3] = 0
menu_nav_supper_speed[3] = false
menu_nav_do_nav[3] = false

menu_nav_ticks[4] = 0
menu_nav_ticks2[4] = 0
menu_nav_ticks3[4] = 0
menu_nav_ticks4[4] = 0
menu_nav_supper_speed[4] = false
menu_nav_do_nav[4] = false

menu_nav_ticks[5] = 0
menu_nav_ticks2[5] = 0
menu_nav_ticks3[5] = 0
menu_nav_ticks4[5] = 0
menu_nav_supper_speed[5] = false
menu_nav_do_nav[5] = false


_menu.version_text = "V2"

_menu.fast_nav_supper_speed_is_hit = 130--70000000
_menu.fast_nav_first_speed = 20--7000000
_menu.fast_nav_first_speed_time = 4.5--6000
_menu.fast_nav_supper_speed = 0.1--4000

_menu.fast_nav_supper_speed_timer = {}--3000
_menu.fast_nav_first_speed_timer = {}--1000
_menu.fast_nav_first_speed_reset_timer = {}--400

_g.spawn_timeout = 5000

_menu.notify_count = 0
_menu.notify_ticks = 300

dbg.dbg_text_count = 0
dbg.dbg_text_coord = 0.02
dbg.dbg_text_scale = 0.3

_g.null_hotkey = 0x87 -- literally no one has a f24 key so its going to be this. if you do have a f24 key, i would highly recommend you not pressing it

_menu.banner_path = ""

_menu.settings_file = "defualt\\settings_default.lua"

_menu.hot_key_file = "defualt\\hotkey_default.lua"--"hotkey_default.lua" -- due to me probably abandoning this lua soon as no one at cherax seems to like me and not having proper json shit in lua im taking the ez route and just making multiple files

_menu.theme_file = "defualt\\theme_defualt.lua"

_menu.check_folders = true

_menu.auto_load_files = true


_menu.frame_time_ns = 0.0--0
_menu.frame_time_ms = 0

_menu.frame_time_float = 0.0



_menu.show_crashes = true
_menu.is_dev = true
_menu.is_tester = true
_menu.is_release = true
dbg.dbg_text = true


_menu.global_train_created = 0

_menu.selected_vehicle_class_for_vehicle_spawner = 0

_menu.should_use_name = false

_menu.menu_x_coord = 0.60


_menu.option_font = 4

_menu.footer_text_font = 4

_menu.menu_is_menu_open = false

_file.vehicle_color_type_primary = 0
_file.vehicle_color_type_secondary = 0

_file.vehicle_extra_color_primary = 0
_file.vehicle_extra_color_secondary = 0

_file.vehicle_custom_primary_r = 0
_file.vehicle_custom_primary_g = 0
_file.vehicle_custom_primary_b = 0

_file.vehicle_custom_secondary_r = 0
_file.vehicle_custom_secondary_g = 0
_file.vehicle_custom_secondary_b = 0

_file.vehicle_extra_color_5 = 0
_file.vehicle_extra_color_6 = 0

_file.vehicle_tyre_smoke_color_r = 0
_file.vehicle_tyre_smoke_color_g = 0
_file.vehicle_tyre_smoke_color_b = 0




menu_r.option_color = 255
menu_g.option_color = 255
menu_b.option_color = 255
menu_a.option_color = 255

menu_r.option_selected_color = 255
menu_g.option_selected_color = 255
menu_b.option_selected_color = 255
menu_a.option_selected_color = 255

menu_r.toggle_on_color = 0
menu_g.toggle_on_color = 255
menu_b.toggle_on_color = 0
menu_a.toggle_on_color = 255

menu_r.toggle_off_color = 255
menu_g.toggle_off_color = 0
menu_b.toggle_off_color = 0
menu_a.toggle_off_color = 255

menu_r.background_color = 0
menu_g.background_color = 0
menu_b.background_color = 0
menu_a.background_color = 150--100--200

menu_r.banner_color = 50
menu_g.banner_color = 50
menu_b.banner_color = 255
menu_a.banner_color = 200--100--255

menu_r.banner_text_color = 255
menu_g.banner_text_color = 255
menu_b.banner_text_color = 255
menu_a.banner_text_color = 255

menu_r.sub_footer_color = 255
menu_g.sub_footer_color = 255
menu_b.sub_footer_color = 255
menu_a.sub_footer_color = 200--100

menu_r.footer_color = 50
menu_g.footer_color = 50
menu_b.footer_color = 255
menu_a.footer_color = 200--100--255

menu_r.footer_text_color = 255
menu_g.footer_text_color = 255
menu_b.footer_text_color = 255
menu_a.footer_text_color = 255

menu_r.scroll_bar_color = 50
menu_g.scroll_bar_color = 50
menu_b.scroll_bar_color = 255
menu_a.scroll_bar_color = 200--100--255

menu_r.scroll_bar_start_color = 50
menu_g.scroll_bar_start_color = 50
menu_b.scroll_bar_start_color = 255
menu_a.scroll_bar_start_color = 200--100

menu_r.scroll_bar_end_color = 153
menu_g.scroll_bar_end_color = 0
menu_b.scroll_bar_end_color = 255
menu_a.scroll_bar_end_color = 200--100

menu_r.loading_color = 255
menu_g.loading_color = 255
menu_b.loading_color = 255
menu_a.loading_color = 255

menu_r.break_option_color = 99
menu_g.break_option_color = 99
menu_b.break_option_color = 99
menu_a.break_option_color = 170



menu_storage = {}
menu_option_count_storage = {}
current_submenu = menu_storage[#menu_storage]

_menu.push_first_menu = true
_menu.m_max_options = 13
_menu.m_option_count = 0
_menu.m_current_option = 1


_ctrl.option_press_click = false
_ctrl.option_up_pressed = false
_ctrl.option_down_pressed = false
_ctrl.option_back_pressed = false
_ctrl.option_pressed_left = false
_ctrl.option_pressed_right = false
_ctrl.hot_key_pressed = false

_menu.loading_sprite = false

_menu.loading_sprite_rot = 0.0

_network.selected_player = 0

_g.smooth_scroll_speed = 0.0001 -- never actually finished this. edit kys and fix it then

_settings.menu_pos_x = 0.5

_settings.menu_pos_y = 0.15

_menu.menu_width = 0.2305

_menu.menu_hight = 0.0355

_menu.toggle_width = 0.225
_menu.toggle_height = 0.400

_menu.submenu_arrow_width = 0.3375
_menu.submenu_arrow_hight = 0.600

_menu.header_font = 7

_menu.option_text_scale = 0.30

























--[[

    ┌──────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    │                                                                                                              │
    │**************************************************************************************************************│
    │                                                                                                              │
    │**************************************** selected players options ********************************************│
    │                                                                                                              │
    │**************************************************************************************************************│
    │                                                                                                              │
    │**************************************************************************************************************│
    └──────────────────────────────────────────────────────────────────────────────────────────────────────────────┘

]]


_o.online_explosion_loop = false
_o.flying_monkeys = false
_o.spectate_player = false

_o.vehcile_attach_x = 0.0
_o.vehcile_attach_y = 0.0
_o.vehcile_attach_z = 0.0

_o.vehcile_attach_bool = false

_o.set_player_vehicle_max_speed = false
_o.set_player_vehicle_max_speed_value = 1.0

_o.rc_car_troll = false
_o.rc_car_troll_value = 1



--[[

    ┌──────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    │                                                                                                              │
    │**************************************************************************************************************│
    │                                                                                                              │
    │**************************************** all players options *************************************************│
    │                                                                                                              │
    │**************************************************************************************************************│
    │                                                                                                              │
    │**************************************************************************************************************│
    └──────────────────────────────────────────────────────────────────────────────────────────────────────────────┘

]]
_hot_key_tbl.all_players_sound_rape = _g.null_hotkey -- fix this shit
_settings.all_players_sound_rape = false








--[[

    ┌──────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    │                                                                                                              │
    │**************************************************************************************************************│
    │                                                                                                              │
    │******************************************** self options ****************************************************│
    │                                                                                                              │
    │**************************************************************************************************************│
    │                                                                                                              │
    │**************************************************************************************************************│
    └──────────────────────────────────────────────────────────────────────────────────────────────────────────────┘

]]
_settings.ped_wetness = false
_settings.ped_wetness_value = -1.10
_hot_key_tbl.ped_wetness = _g.null_hotkey

_settings.disable_landing_anim = false
_hot_key_tbl.disable_landing_anim = _g.null_hotkey

_settings.auto_clean_player = false
_hot_key_tbl.auto_clean_player = _g.null_hotkey





--[[

    ┌──────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    │                                                                                                              │
    │**************************************************************************************************************│
    │                                                                                                              │
    │******************************************* weapon options ***************************************************│
    │                                                                                                              │
    │**************************************************************************************************************│
    │                                                                                                              │
    │**************************************************************************************************************│
    └──────────────────────────────────────────────────────────────────────────────────────────────────────────────┘

]]
_hot_key_tbl.drive_it_gun = _g.null_hotkey
_settings.drive_it_gun = false

_settings.freeze_entity_gun = false
_hot_key_tbl.freeze_entity_gun = _g.null_hotkey

_settings.paint_gun = false
_hot_key_tbl.paint_gun = _g.null_hotkey





--[[

    ┌──────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    │                                                                                                              │
    │**************************************************************************************************************│
    │                                                                                                              │
    │******************************************* vehicle options **************************************************│
    │                                                                                                              │
    │**************************************************************************************************************│
    │                                                                                                              │
    │**************************************************************************************************************│
    └──────────────────────────────────────────────────────────────────────────────────────────────────────────────┘

]]
_settings.vehicle_projectile_rapid_fire = false --_g.vehicle_projectile_rapid_fire = false
_settings.vehicle_projectile_rapid_fire_speed = 50 --_g.vehicle_projectile_rapid_fire_speed = 50
_hot_key_tbl.vehicle_projectile_rapid_fire = _g.null_hotkey

_settings.vehicle_fly_bool = false
_settings.vehicle_fly_value = 15
_hot_key_tbl.vehicle_fly_hotkey = _g.null_hotkey

_settings.vehicle_speed_plate = false
_hot_key_tbl.vehicle_speed_plate = _g.null_hotkey

_settings.rainbow_paint = false
_settings.rainbow_paint_value = 1.0
_hot_key_tbl.rainbow_paint = _g.null_hotkey









--[[

    ┌──────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    │                                                                                                              │
    │**************************************************************************************************************│
    │                                                                                                              │
    │********************************************* misc options ***************************************************│
    │                                                                                                              │
    │**************************************************************************************************************│
    │                                                                                                              │
    │**************************************************************************************************************│
    └──────────────────────────────────────────────────────────────────────────────────────────────────────────────┘

]]
_settings.rappel_at_des_bool = false
_hot_key_tbl.rappel_at_des = _g.null_hotkey











--[[

    ┌──────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    │                                                                                                              │
    │**************************************************************************************************************│
    │                                                                                                              │
    │******************************************** world options ***************************************************│
    │                                                                                                              │
    │**************************************************************************************************************│
    │                                                                                                              │
    │**************************************************************************************************************│
    └──────────────────────────────────────────────────────────────────────────────────────────────────────────────┘

]]
_settings.water_wave_intensity_bool = false
_settings.water_wave_intensity_value = 0.0
_hot_key_tbl.water_wave_intensity = _g.null_hotkey

_settings.gravity_level_bool = false
_settings.gravity_level_value = 0
_hot_key_tbl.gravity_level = _g.null_hotkey

_settings.set_train_speed = false
_settings.set_train_speed_value = 1.0
_hot_key_tbl.set_train_speed = _g.null_hotkey

_settings.trains_spawn_more = false
_hot_key_tbl.trains_spawn_more = _g.null_hotkey

_settings.enter_train_like_normal_vehicle = false
_hot_key_tbl.enter_train_like_normal_vehicle = _g.null_hotkey

_hot_key_tbl.create_train_for_train_opt = _g.null_hotkey

_hot_key_tbl.exit_train_for_train_opt = _g.null_hotkey

_hot_key_tbl.delete_train_for_train_opt = _g.null_hotkey


_hot_key_tbl.derail_train_for_train_opt = _g.null_hotkey






--[[

    ┌──────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    │                                                                                                              │
    │**************************************************************************************************************│
    │                                                                                                              │
    │**************************************** vehicle spawner options *********************************************│
    │                                                                                                              │
    │**************************************************************************************************************│
    │                                                                                                              │
    │**************************************************************************************************************│
    └──────────────────────────────────────────────────────────────────────────────────────────────────────────────┘

]]
_settings.spawn_inside_vehicle_vspawn = true
_settings.spawn_with_custom_color_vspawn = true
_settings.spawn_with_radio_off_vspawn = true -- fix this then add as a option
_settings.spawn_with_ptfx_vspawn = true
_settings.delete_last_vehicle = false -- fix this then add it as a option
_settings.delete_current_vehicle_vspawn = true
_settings.spawn_with_max_upgrades = true
_settings.spawn_with_no_windows_vspawn = false
_settings.spawn_with_windows_rolled_down_vspawn = false

-- related
_g.should_loop_all_vehicle_spawn_options = false



for index, string_name in pairs(all_vehicles_table_t) do
    _hot_key_tbl["vehicle_spawner_vehicle_" .. string_name] = _g.null_hotkey

end







--[[

    ┌──────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    │                                                                                                              │
    │**************************************************************************************************************│
    │                                                                                                              │
    │******************************************* settings options *************************************************│
    │                                                                                                              │
    │**************************************************************************************************************│
    │                                                                                                              │
    │**************************************************************************************************************│
    └──────────────────────────────────────────────────────────────────────────────────────────────────────────────┘

]]
_hot_key_tbl.save_settings = _g.null_hotkey
_hot_key_tbl.load_settings = _g.null_hotkey

_hot_key_tbl.save_hotkeys = _g.null_hotkey
_hot_key_tbl.load_hotkeys = _g.null_hotkey

_settings.use_multi_color_rect = true

_themes.header_rainbow = false
_themes.header_rainbow_speed = 0.3

_themes.header_text_rainbow = false
_themes.header_text_rainbow_speed = 0.3

_themes.scroll_bar_rainbow = false
_themes.scroll_bar_rainbow_speed = 0.3

_themes.scroll_bar_start_rainbow = false
_themes.scroll_bar_start_rainbow_speed = 0.3

_themes.scroll_bar_end_rainbow = false
_themes.scroll_bar_end_rainbow_speed = 0.3

_themes.background_rainbow = false
_themes.background_rainbow_speed = 0.3

_themes.footer_rainbow = false
_themes.footer_rainbow_speed = 0.3

_themes.sub_footer_rainbow = false
_themes.sub_footer_rainbow_speed = 0.3

_themes.sub_footer_text_rainbow = false
_themes.sub_footer_text_rainbow_speed = 0.3

_themes.option_rainbow = false
_themes.option_rainbow_speed = 0.3

_themes.option_selected_rainbow = false
_themes.option_selected_rainbow_speed = 0.3

_themes.loading_rainbow = false
_themes.loading_rainbow_speed = 0.3

_themes.break_option_rainbow = false
_themes.break_option_rainbow_speed = 0.3







--[[

    ┌──────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    │                                                                                                              │
    │**************************************************************************************************************│
    │                                                                                                              │
    │******************************************** rainbow colors **************************************************│
    │                                                                                                              │
    │**************************************************************************************************************│
    │                                                                                                              │
    │**************************************************************************************************************│
    └──────────────────────────────────────────────────────────────────────────────────────────────────────────────┘

]]


_g.banner_text_rainbow = true
_g.banner_text_rainbow_speed = 5.0

red.banner_text_rainbow = 255.0
green.banner_text_rainbow = 0.0
blue.banner_text_rainbow = 0.0


red.rainbow_paint = 255.0
green.rainbow_paint = 0.0
blue.rainbow_paint = 0.0


_settings.tooltip_text = true

_red.tooltip_text = 255
_green.tooltip_text = 0
_blue.tooltip_text = 0
