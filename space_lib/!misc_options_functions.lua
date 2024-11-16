

function rappel_at_des_function(bool_)
    if bool_ then
        _settings.rappel_at_des_bool = not _settings.rappel_at_des_bool
    end
    toggle_helper(_settings.rappel_at_des_bool, function()

		
		local coords_x, coords_y, coords_z = player.get_player_coords(PLAYER.PLAYER_ID())
		local ped_hash = MISC.GET_HASH_KEY("cs_andreas")
		local ped_ = helper_create_ped(ped_hash, coords_x, coords_y, coords_z, 1, 0.0)
		helper_set_entity_godmode(ped_, true)
		local veh_hash = MISC.GET_HASH_KEY("maverick")
		local veh = helper_create_vehicle(veh_hash, coords_x, coords_y, coords_z, 0.0)
		helper_set_entity_godmode(veh, true)
		PED.SET_PED_INTO_VEHICLE(ped_, veh, -1)
		PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), veh, 1)
		wait_t(50)
		VEHICLE.SET_HELI_BLADES_FULL_SPEED(veh)
		local waypoint_coord_x, waypoint_coord_y = ui.get_waypoint_coord()
		local ground_z_ = misc.get_ground_z(waypoint_coord_x, waypoint_coord_y, 0)

		TASK.TASK_GO_TO_COORD_ANY_MEANS(ped_, waypoint_coord_x, waypoint_coord_y, ground_z_ + 15.0, 100.0, veh, true, 8, 0.0)
		while not ENTITY.IS_ENTITY_AT_COORD(ped_, waypoint_coord_x, waypoint_coord_y, ground_z_ + 15.0, 100.0, 100.0, 100.0, false, true, 2) do
		  wait_t(500)
		  if ENTITY.IS_ENTITY_AT_COORD(ped_, waypoint_coord_x, waypoint_coord_y, ground_z_ + 100.0, 100.0, 100.0, 100.0, false, true, 2) then
			break 
		  end
		  if _settings.rappel_at_des_bool == false then
			break
		  end
		end
		TASK.TASK_RAPPEL_FROM_HELI(PLAYER.PLAYER_PED_ID(), 10.0)
		while _settings.rappel_at_des_bool do
		  wait_t(0)
		end
		helper_delete_entity(ped_)
		helper_delete_entity(veh)

        _menu.loading_sprite = false
    end)
end

