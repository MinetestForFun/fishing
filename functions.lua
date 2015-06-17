

function fishing_setting.func.save()
	local input = io.open(fishing_setting.file, "w")
	if input then
		input:write(minetest.serialize(fishing_setting.settings))
		input:close()
	else
		minetest.log("action","Open failed (mode:w) of " .. fishing_setting.file)
	end
end


function fishing_setting.func.set_settings(new_settings, settings)
	if settings["message"] ~= nil then
		new_settings["message"] = settings["message"]
	end
	
	if settings["worm_is_mob"] ~= nil then
		new_settings["worm_is_mob"] = settings["worm_is_mob"]
	end	
	
	if settings["worm_chance"] ~= nil then
		new_settings["worm_chance"] = settings["worm_chance"]
	end	
	
	if settings["new_worm_source"] ~= nil then
		new_settings["new_worm_source"] = settings["new_worm_source"]
	end	
	if settings["wear_out"] ~= nil then
		new_settings["wear_out"] = settings["wear_out"]
	end

	if settings["bobber_view_range"] ~= nil then
		new_settings["bobber_view_range"] = settings["bobber_view_range"]
	end

	if settings["simple_deco_fishing_pole"] ~= nil then
		new_settings["simple_deco_fishing_pole"] = settings["simple_deco_fishing_pole"]
	end

	if settings["fish_chance"] ~= nil then
		new_settings["fish_chance"] = settings["fish_chance"]
	end

	if settings["tresor_chance"] ~= nil then
		new_settings["tresor_chance"] = settings["tresor_chance"]
	end

	if settings["shark_chance"] ~= nil then
		new_settings["shark_chance"] = settings["shark_chance"]
	end
	
	if settings["tresor_timer"] ~= nil then
		new_settings["tresor_timer"] = settings["tresor_timer"]
	end
	
	if settings["tresor_random_enable"] ~= nil then
		new_settings["tresor_random_enable"] = settings["tresor_random_enable"]
	end
end


--function load settings from file 
function fishing_setting.func.load()
	local file = io.open(fishing_setting.file, "r")
	local settings = {}
	if file then
		settings = minetest.deserialize(file:read("*all"))
		file:close()
		if settings and type(settings) == "table" then
			fishing_setting.func.set_settings(fishing_setting.settings, settings)
		end
	end
end

--function return wear tool value (old or new)
function fishing_setting.func.wear_value(wear)
	local used = 0
	if wear == "random" then
		used = (2000*(math.random(20, 29)))
	elseif wear == "randomtools" then
		used = (65535/(30-(math.random(15, 29))))
	end
	return used
end

minetest.register_on_shutdown(function()
	minetest.log("action", "[fishing] Server shuts down. Saving config")
	fishing_setting.func.save()
end)

--function random hungry by bait type
function fishing_setting.func.hungry_random()
	for i,a in pairs(fishing_setting.baits) do
		fishing_setting.baits[i]["hungry"] = math.random(15, 80)
		print("hungry " ..i..": " ..fishing_setting.baits[i]["hungry"])
	end
end


-- show notification when player catch tresor
function fishing_setting.func.notify(f_name, tresor)
	local title = f_name .." catch a tresor"

	for _, player in ipairs(minetest.get_connected_players()) do
		local name = player:get_player_name()
		--FIXME display message
		--if name == f_name then
		--	fishing_setting.func.notify_send(name, tresor, message)
		--else
			fishing_setting.func.notify_send(name, title, tresor[4])
		--end
	end
end

-- show notification when player catch tresor
function fishing_setting.func.notify_send(name, title, message)
	local player = minetest.get_player_by_name(name)
	local one = player:hud_add({
		hud_elem_type = "image",
		name = "award_bg",
		scale = {x = 1, y = 1},
		text = "bg_default.png",
		position = {x = 0.5, y = 0},
		offset = {x = 0, y = 138},
		alignment = {x = 0, y = -1}
	})
	local two = player:hud_add({
		hud_elem_type = "text",
		name = "award_au",
		number = 0xFFFFFF,
		scale = {x = 100, y = 20},
		text = title,
		position = {x = 0.5, y = 0},
		offset = {x = 0, y = 40},
		alignment = {x = 0, y = -1}
	})			
	local three = player:hud_add({
		hud_elem_type = "text",
		name = "award_title",
		number = 0xFFFFFF,
		scale = {x = 100, y = 20},
		text = message,
		position = {x = 0.5, y = 0},
		offset = {x = 30, y = 100},
		alignment = {x = 0, y = -1}
	})			
	local four = player:hud_add({
		hud_elem_type = "image",
		name = "award_icon",
		scale = {x = 4, y = 4},
		text = "fishing_pole_perfect.png",
		position = {x = 0.5, y = 0},
		offset = {x = -81.5, y = 126},
		alignment = {x = 0, y = -1}
	})
	minetest.after(6, function()
		player:hud_remove(one)
		player:hud_remove(two)
		player:hud_remove(three)
		player:hud_remove(four)
	end)
end



--Menu fishing configuration
fishing_setting.func.on_show_settings = function(name)

	if not fishing_setting.tmp_setting then
		fishing_setting.tmp_setting = {}
		fishing_setting.func.set_settings(fishing_setting.tmp_setting, fishing_setting.settings)
	end

	local formspec = "size[11,9]label[4,0;FISHING CONFIGURATION]"..
				--Chance fish
				"label[1.6,0.5;Chance fish]"..
				"button[0,1;1,1;cfish;-1]"..
				"button[1,1;1,1;cfish;-10]"..
				"label[2.1,1.2;"..tostring(fishing_setting.tmp_setting["fish_chance"]).."]"..
				"button[2.7,1;1,1;cfish;+10]"..
				"button[3.7,1;1,1;cfish;+1]"..
				--Chance shark
				"label[1.5,2;Chance shark]"..
				"button[0,2.5;1,1;cshark;-1]"..
				"button[1,2.5;1,1;cshark;-10]"..
				"label[2.1,2.7;"..tostring(fishing_setting.tmp_setting["shark_chance"]).."]"..
				"button[2.7,2.5;1,1;cshark;+10]"..
				"button[3.7,2.5;1,1;cshark;+1]"..
				--Chance tresor
				"label[1.5,3.5;Chance tresor]"..
				"button[0,4.;1,1;ctresor;-1]"..
				"button[1,4;1,1;ctresor;-10]"..
				"label[2.1,4.2;"..tostring(fishing_setting.tmp_setting["tresor_chance"]).."]"..
				"button[2.7,4;1,1;ctresor;+10]"..
				"button[3.7,4;1,1;ctresor;+1]"..
				--Bobber view range
				"label[7.2,0.5;Bobber view range]"..
				"button[7,1;1,1;bvrange;-1]"..
				"label[8.1,1.2;"..tostring(fishing_setting.tmp_setting["bobber_view_range"]).."]"..
				"button[8.7,1;1,1;bvrange;+1]"..
				--Chance worm
				"label[7.5,2;Chance worm]"..
				"button[6,2.5;1,1;cworm;-1]"..
				"button[7,2.5;1,1;cworm;-10]"..
				"label[8.1,2.7;"..tostring(fishing_setting.tmp_setting["worm_chance"]).."]"..
				"button[8.7,2.5;1,1;cworm;+10]"..
				"button[9.7,2.5;1,1;cworm;+1]"..
				--Timer tresor
				"label[7.2,3.5;Timer tresor (in sec)]"..
				"button[6,4.;1,1;ttresor;-60]"..
				"button[7,4;1,1;ttresor;-600]"..
				"label[7.9,4.2;"..tostring(fishing_setting.tmp_setting["tresor_timer"]).."]"..
				"button[8.7,4;1,1;ttresor;+600]"..
				"button[9.7,4;1,1;ttresor;+60]"..
				--messages display
				"label[0,5.7;Display messages in chat]"..
				"button[3.7,5.5;1,1;dmessages;"..tostring(fishing_setting.tmp_setting["message"]).."]"..
				--poledeco
				"label[0,6.5;Simple pole deco]"..
				"button[3.7,6.3;1,1;poledeco;"..tostring(fishing_setting.tmp_setting["simple_deco_fishing_pole"]).."]"..
				--wearout
				"label[0,7.3;Poles Wear]"..					
				"button[3.7,7.1;1,1;wearout;"..tostring(fishing_setting.tmp_setting["wear_out"]).."]"..
				--TRESOR_RANDOM_ENABLE
				"label[6,5.7;Random tresor enable]"..
				"button[9.7,5.5;1,1;tresorenable;"..tostring(fishing_setting.tmp_setting["tresor_random_enable"]).."]"..
				--NEW_WORM_SOURCE
				"label[6,6.5;New worm source]"..
				"button[9.7,6.3;1,1;newworm;"..tostring(fishing_setting.tmp_setting["new_worm_source"]).."]"..
				--WORM_IS_MOB
				"label[6,7.3;Worm is mob]"..				
				"button[9.7,7.1;1,1;wormmob;"..tostring(fishing_setting.tmp_setting["worm_is_mob"]).."]"..
				"button_exit[0.5,8.2;1.5,1;save;Abort]"..
				"button_exit[9,8.2;1.5,1;save;Ok]"
	
	minetest.show_formspec( name, "fishing:settings", formspec)
end


local inc = function(value, field, min, max)
	local v
	if field == "+1" then
		v = value + 1
	elseif field == "+10" then
		v = value + 10
	elseif field == "+60" then	
		v = value + 60
	elseif field == "+600" then	
		v = value + 600		
	elseif field == "-1" then	
		v = value - 1
	elseif field == "-10" then
		v = value - 10
	elseif field == "-60" then		
		v = value - 60
	elseif field == "-600" then		
		v = value - 600
	else -- useless, prevent crash
		return value
	end

	if v > max then
		v = max
	end
	if v < min then
		v = min
	end
	return v
end


local bool = function(field)
	local v
	if field == "true" then
		v = false
	else 
		v = true
	end
	return v
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname == "fishing:settings" then
		local name = player:get_player_name()
		if not name then return end
		if fields["save"] == "Ok" then
				print("ok")
				 fishing_setting.func.set_settings(fishing_setting.settings, fishing_setting.tmp_setting)
				fishing_setting.func.save()
			return
		elseif fields["quit"] or fields["abort"] then
			fishing_setting.tmp_setting = nil
			return
		elseif fields["cfish"] then
			fishing_setting.tmp_setting["fish_chance"] = inc(fishing_setting.tmp_setting["fish_chance"], fields["cfish"], 1, 100)
		elseif fields["cshark"] then
			fishing_setting.tmp_setting["shark_chance"] = inc(fishing_setting.tmp_setting["shark_chance"], fields["cshark"], 1, 100)
		elseif fields["ctresor"] then
			fishing_setting.tmp_setting["tresor_chance"] = inc(fishing_setting.tmp_setting["tresor_chance"], fields["ctresor"], 1, 100)
		elseif fields["bvrange"] then
			fishing_setting.tmp_setting["bobber_view_range"] = inc(fishing_setting.tmp_setting["bobber_view_range"], fields["bvrange"], 4, 20)
		elseif fields["cworm"] then
			fishing_setting.tmp_setting["worm_chance"] = inc(fishing_setting.tmp_setting["worm_chance"], fields["cworm"], 1, 100)
		elseif fields["ttresor"] then
			fishing_setting.tmp_setting["tresor_timer"] = inc(fishing_setting.tmp_setting["tresor_timer"], fields["ttresor"], 1800, 36000)
		elseif fields["dmessages"] then
			fishing_setting.tmp_setting["message"] = bool(fields["dmessages"])
		elseif fields["poledeco"] then
			fishing_setting.tmp_setting["simple_deco_fishing_pole"] = bool(fields["poledeco"])
		elseif fields["wearout"] then
			fishing_setting.tmp_setting["wear_out"] = bool(fields["wearout"])
		elseif fields["tresorenable"] then
			fishing_setting.tmp_setting["tresor_random_enable"] = bool(fields["tresorenable"])
		elseif fields["newworm"] then
			fishing_setting.tmp_setting["new_worm_source"] = bool(fields["newworm"])
		elseif fields["wormmob"] then
			fishing_setting.tmp_setting["worm_is_mob"] = bool(fields["wormmob"])
		else
			return
		end

		fishing_setting.func.on_show_settings(name)
	end
end)

