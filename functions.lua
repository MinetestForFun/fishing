

function fishing_setting.func.save()
	local input = io.open(fishing_setting.file, "w")
	if input then
		input:write(minetest.serialize(fishing_setting.settings))
		input:close()
	else
		minetest.log("action","Open failed (mode:w) of " .. fishing_setting.file)
	end
end


function fishing_setting.func.load()
	local file = io.open(fishing_setting.file, "r")
	local settings = {}
	if file then
		settings = minetest.deserialize(file:read("*all"))
		file:close()
	else
		return
	end
	if  settings == nil or type(settings) ~= "table" then return end
	
	if settings["message"] ~= nil then
		fishing_setting.settings["message"] = settings["message"]
	end
	
	if settings["worm_is_mob"] ~= nil then
		fishing_setting.settings["worm_is_mob"] = settings["worm_is_mob"]
	end	
	
	if settings["worm_chance"] ~= nil then
		fishing_setting.settings["worm_chance"] = settings["worm_chance"]
	end	
	
	if settings["new_worm_source"] ~= nil then
		fishing_setting.settings["new_worm_source"] = settings["new_worm_source"]
	end	
	if settings["wear_out"] ~= nil then
		fishing_setting.settings["wear_out"] = settings["wear_out"]
	end

	if settings["bobber_view_range"] ~= nil then
		fishing_setting.settings["bobber_view_range"] = settings["bobber_view_range"]
	end

	if settings["simple_deco_fishing_pole"] ~= nil then
		fishing_setting.settings["simple_deco_fishing_pole"] = settings["simple_deco_fishing_pole"]
	end

	if settings.chance["fish"] ~= nil then
		fishing_setting.settings.chance["fish"] = settings.chance["fish"]
	end

	if settings.chance["tresor"] ~= nil then
		fishing_setting.settings.chance["tresor"] = settings.chance["tresor"]
	end

	if settings.chance["shark"] ~= nil then
		fishing_setting.settings.chance["shark"] = settings.chance["shark"]
	end
	
	if settings["tresor_timer"] ~= nil then
		fishing_setting.settings["tresor_timer"] = settings["tresor_timer"]
	end
	
	if settings["tresor_random_enable"] ~= nil then
		fishing_setting.settings["tresor_random_enable"] = settings["tresor_random_enable"]
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
local formspec = "size[11,10]"..
				"label[4,0;Fishing Config]"..
				
				--Chance fish
				"label[1.6,0.5;Chance fish]"..
				"button[0,1;1,1;hsharkd1;-1]"..
				"button[1,1;1,1;hsharkd10;-10]"..
				"label[2.1,1.2;%s]"..
				"button[2.7,1;1,1;hsharki10;+10]"..
				"button[3.7,1;1,1;hsharki1;+1]"..
				
				--Chance shark
				"label[1.5,2;Chance shark]"..
				"button[0,2.5;1,1;hfishd1;-1]"..
				"button[1,2.5;1,1;hfishd10;-10]"..
				"label[2.1,2.7;%s]"..
				"button[2.7,2.5;1,1;hfishi10;+10]"..
				"button[3.7,2.5;1,1;hfishi1;+1]"..
				
				
				--Chance tresor
				"label[1.5,3.5;Chance tresor]"..
				"button[0,4.;1,1;hfishd1;-1]"..
				"button[1,4;1,1;hfishd10;-10]"..
				"label[2.1,4.2;%s]"..
				"button[2.7,4;1,1;hfishi10;+10]"..
				"button[3.7,4;1,1;hfishi1;+1]"..				
				
				
				
				--Bobber view range
				"label[7.4,0.5;Bobber view range]"..
				"button[7,1;1,1;hfishd1;-1]"..
				"label[8.1,1.2;%s]"..
				"button[8.7,1;1,1;hfishi1;+1]"..				
				
				--Chance worm
				"label[7.5,2;Chance worm]"..
				"button[6,2.5;1,1;hfishd1;-1]"..
				"button[7,2.5;1,1;hfishd10;-10]"..
				"label[8.1,2.7;%s]"..
				"button[8.7,2.5;1,1;hfishi10;+10]"..
				"button[9.7,2.5;1,1;hfishi1;+1]"..
				
				
				--Timer tresor
				"label[7.5,3.5;Timer tresor]"..
				"button[6,4.;1,1;hfishd10;-10]"..
				"button[7,4;1,1;hfishd100;-100]"..
				"label[8.1,4.2;%s]"..
				"button[8.7,4;1,1;hfishi100;+100]"..
				"button[9.7,4;1,1;hfishi10;+10]"..				
				
				
				"button[0,5.2;1,1;messages;true]"..
				"label[1,5.4;Messages]"..			
				
				"button[0,6;1,1;poledeco;true]"..
				"label[1,6.2;Simple pole deco]"..				
				
				"button[0,8.2;1,1;wearout;true]"..
				"label[1,8.4;Wear out]"..					
				
				"button[0,9.7;1,1;newworm;true]"..
				"label[1,9.4;New worm source]"..				
				
				
				"button_exit[0.5,9.2;1.5,1;abort;Abort]"..
				"button_exit[8,9.2;1.5,1;abort;Ok]"



--[[
MESSAGES = true
SIMPLE_DECO_FISHING_POLE = true
WEAR_OUT = true
NEW_WORM_SOURCE = true
WORM_IS_MOB = true
TRESOR_RANDOM_ENABLE = true


BOBBER_VIEW_RANGE = 7
CHANCE_FISH = 60
CHANCE_SHARK = 30
CHANCE_TRESOR = 5
TRESOR_TIMER = 3600
WORM_CHANCE = 66
--]]


fishing_setting.func.on_show_settings = function(name, music, ambience, other)
	minetest.show_formspec( name, "fishing:settings", string.format(formspec, tostring("7"), tostring("80"), tostring("80"), tostring("08"), tostring("08"), tostring("08")))
end


minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname == "fishing:settings" then
		local name = player:get_player_name()
		if not name then return end

		if fields["abort"] == "Ok" then
				print("ok")
				--fishing_setting.func.save()
			return
		elseif fields["abort"] == "Abort" then
			return
		elseif fields["quit"] == "true" then
			return
		else
			return
		end

		fishing_setting.func.on_show_settings(name)
	end
end)



