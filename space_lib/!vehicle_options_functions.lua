
to_enable.vehicle_projectile_rapid_fire_func = function(bool_)
    if bool_ then
        _settings.vehicle_projectile_rapid_fire = not _settings.vehicle_projectile_rapid_fire
    end

    toggle_helper(_settings.vehicle_projectile_rapid_fire, function() 
        _menu.loading_sprite = true
        --do stuff
        _menu.loading_sprite = false
        while _settings.vehicle_projectile_rapid_fire do
            if PAD.IS_CONTROL_PRESSED(0, 68) and PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), true) then
                VEHICLE.SET_VEHICLE_FIXED(PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), true))
                wait_t(_settings.vehicle_projectile_rapid_fire_speed)
            end
            wait_t(0)
        end
        _menu.loading_sprite = true
        --do stuff
        _menu.loading_sprite = false
    end)
end

to_enable.vehicle_fly = function(bool_)
    if bool_ then
        _settings.vehicle_fly_bool = not _settings.vehicle_fly_bool
    end
    
    toggle_helper(_settings.vehicle_fly_bool, function()
  while _settings.vehicle_fly_bool do
    local locspeed,lsp,veh,SHIFT,A,D,W,S
      veh = player.is_player_in_any_vehicle(PLAYER.PLAYER_ID()) and player.player_vehicle() or nil
      ENTITY.SET_ENTITY_MAX_SPEED(veh, 999999999999999999999999999999)
      if veh then
        rotation_x, rotation_y, rotation_z = CAM.GET_GAMEPLAY_CAM_ROT(1)
          ENTITY.SET_ENTITY_ROTATION(veh, rotation_x, rotation_y, rotation_z, 1, true)
          SHIFT = PAD.IS_CONTROL_PRESSED(0, 61)--[[IS_CONTROL_PRESSED]]
          A = PAD.IS_CONTROL_PRESSED(0, 63)--[[IS_CONTROL_PRESSED]]
          D = PAD.IS_CONTROL_PRESSED(0, 64)--[[IS_CONTROL_PRESSED]]
          W = PAD.IS_CONTROL_PRESSED(0, 71)--[[IS_CONTROL_PRESSED]]
          S = PAD.IS_CONTROL_PRESSED(0, 72)--[[IS_CONTROL_PRESSED]]
          if not dont_stop and not W and not S and not A and not D then
              VEHICLE.SET_VEHICLE_FORWARD_SPEED(veh, 0)
          else
              locspeed = SHIFT and _settings.vehicle_fly_value*20 or _settings.vehicle_fly_value*10
              if W then
                  if dont_stop then
                      --entity.apply_force_to_entity(veh, 1, 0, _settings.vehicle_fly_value, 0, 0, 0, 0, true, true)
                      ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0, _settings.vehicle_fly_value, 0, 0, 0, 0, 0, true, false, true, false, false) -- might be broken
                  else 
                    VEHICLE.SET_VEHICLE_FORWARD_SPEED( veh, locspeed*2)
                  end
              end
              if S then
                  if dont_stop then
                      lsp = SHIFT and _settings.vehicle_fly_value or _settings.vehicle_fly_value*2
                      --entity.apply_force_to_entity(veh,      1,     0,                0 - lsp,    0,                 0,     0,      0,   true, true)
                      ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0, 0 - lsp, 0, 0, 0, 0, 0, true, false, true, false, false)
                  else 
                      VEHICLE.SET_VEHICLE_FORWARD_SPEED(veh, locspeed*-2)
                  end
              end
              locspeed = (W or S) and locspeed*5 or locspeed*0.2 -- i added this
              if A then
                  if dont_stop then
                      lsp = SHIFT and _settings.vehicle_fly_value*-2 or _settings.vehicle_fly_value*-1
                      --entity.apply_force_to_entity(veh, 1, lsp, 0, 0, 0, 0, 0, true, true)
                      ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, lsp, 0, 0, 0, 0, 0, 0, true, false, true, false, false)
                  else 
                      --entity.apply_force_to_entity(veh, 1, locspeed*-1, 0, 0, 0, 0, 0, true, true)
                      ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, locspeed*-1, 0, 0, 0, 0, 0, 0, true, false, true, false, false) -- might be broken
                  end
              end
              if D then
                  if dont_stop then
                      lsp = SHIFT and _settings.vehicle_fly_value or _settings.vehicle_fly_value*2
                      --entity.apply_force_to_entity(veh, 1, lsp, 0, 0, 0, 0, 0, true, true)
                      ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, lsp, 0, 0, 0, 0, 0, 0, true, false, true, false, false)
                  else 
                      --entity.apply_force_to_entity(veh, 1, locspeed, 0, 0, 0, 0, 0, true, true)
                      ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, locspeed, 0, 0, 0, 0, 0, 0, true, false, true, false, false)
                  end
              end
          end
      end
      wait_t(0)
  end
    end)
end

to_enable.speed_plate = function(bool_)
    if bool_ then
        _settings.vehicle_speed_plate = not _settings.vehicle_speed_plate
    end

    toggle_helper(_settings.vehicle_speed_plate, function()
        _menu.loading_sprite = true
        -- do stuff
        _menu.loading_sprite = false
        while _settings.vehicle_speed_plate do
            player_car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), true)
            speed = math.floor(ENTITY.GET_ENTITY_SPEED(player_car)*speed_unit.number)
            VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(player_car, speed .. " " .. speed_unit.text)
            wait_t(0)
        end
        _menu.loading_sprite = true
        --do stuff
        _menu.loading_sprite = false
    end)
end


--[[

    ┌──────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    │                                                                                                              │
    │**************************************************************************************************************│
    │                                                                                                              │
    │******************************************* rainbow submenu **************************************************│
    │                                                                                                              │
    │**************************************************************************************************************│
    │                                                                                                              │
    │**************************************************************************************************************│
    └──────────────────────────────────────────────────────────────────────────────────────────────────────────────┘

]]


to_enable.rainbow_paint = function(bool_)
    if bool_ then
        _settings.rainbow_paint = not _settings.rainbow_paint
    end
    toggle_helper(_settings.rainbow_paint, function()
        _menu.loading_sprite = true
        -- do stuff
        _menu.loading_sprite = false
        while _settings.rainbow_paint do
                                                                        --cycle_rgb(red, green, blue, min, max, mod, bool_make_int)
            red.rainbow_paint, green.rainbow_paint, blue.rainbow_paint = cycle_rgb(red.rainbow_paint, green.rainbow_paint, blue.rainbow_paint, 0.0, 255.0, _settings.rainbow_paint_value)
            VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(player.player_vehicle(), red.rainbow_paint:floor_t(), green.rainbow_paint:floor_t(), blue.rainbow_paint:floor_t())
            VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(player.player_vehicle(), red.rainbow_paint:floor_t(), green.rainbow_paint:floor_t(), blue.rainbow_paint:floor_t())
            wait_t(0)
        end
        _menu.loading_sprite = true
        --do stuff
        _menu.loading_sprite = false
    end)
end



