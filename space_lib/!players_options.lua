



function online_players_list()

    -------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------online_player_crashes------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    add_click_option("all bad objects in one", " ", submenus.player_crashes_menu, nil, false, function()
    
    
    
    
    
    end)



    -------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    ---------------------------------------------online_player_griefing------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    add_toggle_option("Explosion Loop", " ", submenus.player_griefing_menu, nil, false, _o.online_explosion_loop, function()
        _o.online_explosion_loop = not _o.online_explosion_loop
    
        toggle_helper(_o.online_explosion_loop, function() 
    
            while _o.online_explosion_loop do
                local ped_coords_x, ped_coords_y, ped_coords_z = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(_network.selected_player), false)
                FIRE.ADD_EXPLOSION(ped_coords_x, ped_coords_y, ped_coords_z, 0, 1.0, true, false, 0.0, false)
                wait_t(0)
            end
    
        end)

    end)



    add_toggle_option("Flying Monkeys", " ", submenus.player_griefing_menu, nil, false, _o.flying_monkeys, function()

        _o.flying_monkeys = not _o.flying_monkeys--bool_flip(_o.flying_monkeys)

        toggle_helper(_o.flying_monkeys, function() 
            _menu.loading_sprite = true
        
            player_coords_x, player_coords_y, player_coords_z = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(_network.selected_player), false)
                local egg = MISC.GET_HASH_KEY("prop_alien_egg_01")
                local _ped = MISC.GET_HASH_KEY("u_m_y_pogo_01")
                local ped_tbl = {}
                local egg_tbl = {}
                for i = 1,20 do

                  egg_tbl[i]=helper_create_object(egg, player_coords_x, player_coords_y, player_coords_z)
                  wait_t(0)
                end
                for i = 1, 20 do
                    ped_tbl[i]=helper_create_ped(_ped, player_coords_x, player_coords_y, player_coords_z, 1, 0.0)
                    wait_t(0)
                end

              for i=1, #ped_tbl and #egg_tbl do
                ENTITY.ATTACH_ENTITY_TO_ENTITY(ped_tbl[i], egg_tbl[i], 0, 0, 0, 0, 0, 0, 0, false, false, false, true, 0, false, false)
              end

              for i = 1, #ped_tbl do
                log_t("about to set godmode")
                helper_set_entity_godmode(ped_tbl[i], true)
                log_t("about to give weapon to ped")
                WEAPON.GIVE_DELAYED_WEAPON_TO_PED(ped_tbl[i], 2138347493, 0, true)
              end
        
            _menu.loading_sprite = false

            while _o.flying_monkeys do
                local coords_monkey_x, coords_monkey_y, coords_monkey_z = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(_network.selected_player), false)
                for i = 1, #ped_tbl do
                    WEAPON.REFILL_AMMO_INSTANTLY(ped_tbl[i])
                    TASK.TASK_COMBAT_PED(ped_tbl[i], PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(_network.selected_player), 0, 16)
                    log_t("Task Combat Ped")
                end
                for i = 1, #egg_tbl do
                    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(egg_tbl[i], coords_monkey_x + math.random(-7,7), coords_monkey_y + math.random(-7,7), coords_monkey_z + math.random(-7,7), false, false, false)
                end
                  wait_t(0)
            end
            _menu.loading_sprite = true
            for i = 1, #egg_tbl do
                helper_delete_entity(egg_tbl[i])
                wait_t(0)
            end
            
            for i = 1, #ped_tbl do
                helper_delete_entity(ped_tbl[i])
                wait_t(0)
            end

            _menu.loading_sprite = false
        
        end)
    
    end)


    _g.null_hotkey, _o.rc_car_troll_value = add_toggle_editor_option("Rc Car Troll (broken)", " ", submenus.player_griefing_menu, nil, false, _o.rc_car_troll, _o.rc_car_troll_value, 1, 10, 1, function()
        _o.rc_car_troll = not _o.rc_car_troll
    
        toggle_helper(_o.rc_car_troll, function() 
            
            _menu.loading_sprite = true
            local coords_x, coords_y, coords_z = player.get_player_coords(_network.selected_player)
            local rc_hash = 0xEEF345EC
            local rc_cars_tbl = {}
            for i=1, _o.rc_car_troll_value do
              rc_cars_tbl[i]=helper_create_vehicle(rc_hash , coords_x, coords_y, coords_z, 0)
              wait_t(0)
            end
            local ped_hash = 0x7A05FA59
            local ped_driver_tbl = {}
            for i=1, _o.rc_car_troll_value do
              ped_driver_tbl[i]=helper_create_ped(ped_hash, coords_x, coords_y, coords_z, 1, 0)
              wait_t(0)
            end
            for i=1, #ped_driver_tbl and #rc_cars_tbl do
                PED.SET_PED_INTO_VEHICLE(ped_driver_tbl[i], rc_cars_tbl[i], -1)
                helper_set_entity_godmode(rc_cars_tbl[i], true)
                wait_t(0)
            end
           
            local blip_01_tbl = {}
            for i=1, #rc_cars_tbl do
              blip_01_tbl[i]=HUD.ADD_BLIP_FOR_ENTITY(rc_cars_tbl[i])
              wait_t(0)
            end
            for i=1, #blip_01_tbl do
              HUD.SET_BLIP_SPRITE(blip_01_tbl[i], 646)
              HUD.SET_BLIP_COLOUR(blip_01_tbl[i], 27)
              wait_t(0)
            end
    
            _menu.loading_sprite = false
            
            while _o.rc_car_troll do
              for i=1, #ped_driver_tbl and #rc_cars_tbl do
                local coords_01_x, coords_01_y, coords_01_z = player.get_player_coords(_network.selected_player)
                PED.SET_PED_COMBAT_ATTRIBUTES(ped_driver_tbl[i], 3, false)
                TASK.TASK_VEHICLE_DRIVE_TO_COORD(ped_driver_tbl[i], rc_cars_tbl[i], coords_01_x, coords_01_y, coords_01_z, 100.0, 0, rc_hash, 16777216, 0.000000000000000001, 0.10)
              end
              wait_t(0)
            end
            
            _menu.loading_sprite = true
            for i=1, #blip_01_tbl do
              remove_blip(blip_01_tbl[i])
              wait_t(0)
            end
          
            for i=1, #ped_driver_tbl do
              helper_delete_entity(ped_driver_tbl[i])
              wait_t(0)
            end
            for i=1, #rc_cars_tbl do
              helper_delete_entity(rc_cars_tbl[i])
              wait_t(0)
            end
            _menu.loading_sprite = false
        end)

    end)




    -------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    -----------------------------------------attach_players_car_options------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    _g.null_hotkey, _o.vehcile_attach_x = add_editor_option("Change X", " ", submenus.attach_players_car_menu, nil, false, _o.vehcile_attach_x, 0, 500, 1, function() end)
    _g.null_hotkey, _o.vehcile_attach_y = add_editor_option("Change Y", " ", submenus.attach_players_car_menu, nil, false, _o.vehcile_attach_y, 0, 500, 1, function() end)
    _g.null_hotkey, _o.vehcile_attach_z = add_editor_option("Change Z", " ", submenus.attach_players_car_menu, nil, false, _o.vehcile_attach_z, 0, 500, 1, function() end)

    add_toggle_option("Attach Players Car", " ", submenus.attach_players_car_menu, nil, false, _o.vehcile_attach_bool, function()
        _o.vehcile_attach_bool = not _o.vehcile_attach_bool
    
        toggle_helper(_o.vehcile_attach_bool, function() 
    
            _menu.loading_sprite = true
    
            _menu.loading_sprite = false
            if _network.selected_player == PLAYER.PLAYER_ID() then
                notify_t("You Cant Do This On Yourself")
                _o.vehcile_attach_bool = false
                _menu.loading_sprite = false
                else
                while _o.vehcile_attach_bool do
                  if player.is_player_in_any_vehicle(p) then
                    if helper_request_control(player.get_player_vehicle(p)) then 
                      --entity.attach_entity_to_entity(player.get_player_vehicle(p), player.get_player_vehicle(player.player_id()), 0, v3(X_01.value[p], Y_01.value[p], Z_01.value[p]), v3(0,0,0), false, false, false, 0, true)
                      ENTITY.ATTACH_ENTITY_TO_ENTITY(player.get_player_vehicle(p), player.get_player_vehicle(PLAYER.PLAYER_ID()), 0, _o.vehcile_attach_z, _o.vehcile_attach_z, _o.vehcile_attach_z, 0, 0, 0, true, true, false, false, 0, true, 0)
                      wait_t(0)
                    else
                        notify_t("Failed To Get Control")
                    end
                    else _o.vehcile_attach_bool = false
                  end
                end
            end
            _menu.loading_sprite = true
            helper_request_control(player.get_player_vehicle(p))
            
            ENTITY.DETACH_ENTITY(player.get_player_vehicle(p))

            _menu.loading_sprite = false
    
        end)
    
    end)



    -------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------player_vehicle_options-----------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    _g.null_hotkey, _o.set_player_vehicle_max_speed_value = add_editor_option("Set Car Max Speed", " ", submenus.player_vehicle_menu, nil, false, _o.set_player_vehicle_max_speed_value, 0.0, 300.0, 1.0, function()
        local broom = player.get_player_vehicle(_network.selected_player)
		if helper_request_control(broom) then
		  ENTITY.SET_ENTITY_MAX_SPEED(broom, _o.set_player_vehicle_max_speed_value)
		  else notify_t("Failed To Get Control")
		end
    
    end)

    add_click_option("Kill Engine", " ", submenus.player_vehicle_menu, nil, false, function() 
        _menu.loading_sprite = true
        local broom = player.get_player_vehicle(p)
		helper_request_control(broom)
		VEHICLE.SET_VEHICLE_ENGINE_HEALTH(broom, -4000)
        _menu.loading_sprite = false
    end)

    add_click_option("Repair Engine", " ", submenus.player_vehicle_menu, nil, false, function() 
        _menu.loading_sprite = true
        local broom = player.get_player_vehicle(p)
		helper_request_control(broom)
		VEHICLE.SET_VEHICLE_FIXED(player.get_player_vehicle(p))
        _menu.loading_sprite = false
    end)

    add_click_option("Kick From Vehicle", " ", submenus.player_vehicle_menu, nil, false, function() 
        _menu.loading_sprite = true
        --CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(_network.selected_player))
        _menu.loading_sprite = false
    end)

    add_click_option("Delete Players Vehicle", " ", submenus.player_vehicle_menu, nil, false, function() 
        _menu.loading_sprite = true
        if player.is_player_in_any_vehicle(p) then
            local car_01 = player.get_player_vehicle(p)
            if helper_request_control(car_01) then 
                helper_delete_entity(car_01)
              else notify_t("Failed To Get Control")
            end
            else notify_t("Player Is Not In A Vehicle")
          end
        _menu.loading_sprite = false
    end)




    -------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------player_vehicle_options---------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------

    _g.null_hotkey, _o.set_player_vehicle_max_speed_value = add_editor_option("Set Car Max Speed", " ", submenus.player_vehicle_menu, nil, false, _o.set_player_vehicle_max_speed_value, 0.0, 300.0, 1.0, function()
        local broom = player.get_player_vehicle(_network.selected_player)
		if helper_request_control(broom) then
		  ENTITY.SET_ENTITY_MAX_SPEED(broom, _o.set_player_vehicle_max_speed_value)
		  else notify_t("Failed To Get Control")
		end
    
    end)

    add_click_option("Kill Engine", " ", submenus.player_vehicle_menu, nil, false, function() 
        _menu.loading_sprite = true
        local broom = player.get_player_vehicle(p)
		helper_request_control(broom)
		VEHICLE.SET_VEHICLE_ENGINE_HEALTH(broom, -4000)
        _menu.loading_sprite = false
    end)

    add_click_option("Repair Engine", " ", submenus.player_vehicle_menu, nil, false, function() 
        _menu.loading_sprite = true
        local broom = player.get_player_vehicle(p)
		helper_request_control(broom)
		VEHICLE.SET_VEHICLE_FIXED(player.get_player_vehicle(p))
        _menu.loading_sprite = false
    end)

    add_click_option("Kick From Vehicle", " ", submenus.player_vehicle_menu, nil, false, function() 
        _menu.loading_sprite = true
        --CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(_network.selected_player))
        _menu.loading_sprite = false
    end)

    add_click_option("Delete Players Vehicle", " ", submenus.player_vehicle_menu, nil, false, function() 
        _menu.loading_sprite = true
        if player.is_player_in_any_vehicle(p) then
            local car_01 = player.get_player_vehicle(p)
            if helper_request_control(car_01) then 
                helper_delete_entity(car_01)
              else notify_t("Failed To Get Control")
            end
            else notify_t("Player Is Not In A Vehicle")
          end
        _menu.loading_sprite = false
    end)



    -------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    -----------------------------------------main players menu---------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------

    add_click_option("Teleport To Player", " ", submenus.main_players_menu,  nil, false, function() 
        local x, y, z = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(_network.selected_player), false)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), x, y, z, true, true, true)
    end)

    add_toggle_option("Spectate Player", " ", submenus.main_players_menu, nil, false, _o.spectate_player, function()

        _o.spectate_player = not _o.spectate_player
    
        toggle_helper(_o.spectate_player, function() 
            _menu.loading_sprite = true
            --CAM.SET_GAMEPLAY_CAM_FOLLOW_PED_THIS_UPDATE(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(_network.selected_player))
            _menu.loading_sprite = false
            while _o.spectate_player do
                local x, y, z = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(_network.selected_player), false)
                CAM.SET_GAMEPLAY_CAM_FOLLOW_PED_THIS_UPDATE(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(_network.selected_player))
                STREAMING.SET_FOCUS_POS_AND_VEL(x, y, z, 0, 0, 0)
                wait_t(0)
            end
            _menu.loading_sprite = true
            
            CAM.DESTROY_ALL_CAMS(true)
            STREAMING.CLEAR_FOCUS()
            _menu.loading_sprite = false
        end)
    
    end)


    if _menu.is_dev then
        add_submenu_option("Crashes Archive", " ", submenus.main_players_menu, submenus.player_crashes_menu)
    end
    add_submenu_option("Griefing", " ", submenus.main_players_menu, submenus.player_griefing_menu)

    add_submenu_option("Attach Car", " ", submenus.main_players_menu, submenus.attach_players_car_menu)

    add_submenu_option("Player Vehicle", " ", submenus.main_players_menu, submenus.player_vehicle_menu)

    for i=0, 32 do
        _detctions.space_dev = " "
        _detctions.god = " "
        if PLAYER.GET_PLAYER_NAME(i) == "fresh_fishy" then
            _detctions.space_dev = " ~r~[space dev]"
        end
        if PLAYER.GET_PLAYER_NAME(i) == "fresh_fishy69" then
            _detctions.god = " [god him self(good friend of mine)]"
        end
        if NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) then
            add_submenu_option_players_list(PLAYER.GET_PLAYER_NAME(i), submenus.players_list, _detctions.space_dev .. _detctions.god, submenus.main_players_menu)
        end

    end

end