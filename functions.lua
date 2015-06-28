
--function save settings 
function fishing_setting.func.save()
	local input = io.open(fishing_setting.file_settings, "w")
	if input then
		input:write(minetest.serialize(fishing_setting.settings))
		input:close()
	else
		minetest.log("action","Open failed (mode:w) of " .. fishing_setting.file_settings)
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
	
	if settings["tresor_enable"] ~= nil then
		new_settings["tresor_enable"] = settings["tresor_enable"]
	end
	
	if settings["escape_chance"] ~= nil then
		new_settings["escape_chance"] = settings["escape_chance"]
	end		
end


--function load settings from file 
function fishing_setting.func.load()
	local file = io.open(fishing_setting.file_settings, "r")
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


-- function return table where mods actived
function fishing_setting.func.ignore_mod(list)
	local listOk = {}
	for i,v in ipairs(list) do
		if minetest.get_modpath(v[1]) ~= nil then
			table.insert(listOk, v)
		end
	end
	return listOk
end

--function random hungry by bait type
function fishing_setting.func.hungry_random()
	for i,a in pairs(fishing_setting.baits) do
		fishing_setting.baits[i]["hungry"] = math.random(15, 80)
	end
	--change hungry after random time, min 0h30, max 6h00
	minetest.after(math.random(1, 12)*1800,function() fishing_setting.func.hungry_random() end)
end


-- show notification when player catch tresor
function fishing_setting.func.notify(f_name, tresor)
	local title = fishing_setting.func.S("Good luck to %s, He catch the tresor, %s!"):format(f_name, tresor[4])
	for _, player in ipairs(minetest.get_connected_players()) do
		local player_name = player:get_player_name()
		if player_name == f_name then
			minetest.chat_send_player(player_name, fishing_setting.func.S("You catch the tresor, %s!"):format(tresor[4]))
		else
			minetest.chat_send_player(player_name, title)
		end
	end
end


--Menu fishing configuration
fishing_setting.func.on_show_settings = function(player_name)

	if not fishing_setting.tmp_setting then
		fishing_setting.tmp_setting = {}
		fishing_setting.func.set_settings(fishing_setting.tmp_setting, fishing_setting.settings)
	end

	local formspec = "size[11,9]bgcolor[#99a8ba;]label[4,0;FISHING CONFIGURATION]"..
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
				--Chance worm
				"label[7.5,0.5;Chance worm]"..
				"button[6,1;1,1;cworm;-1]"..
				"button[7,1;1,1;cworm;-10]"..
				"label[8.1,1.2;"..tostring(fishing_setting.tmp_setting["worm_chance"]).."]"..
				"button[8.7,1;1,1;cworm;+10]"..
				"button[9.7,1;1,1;cworm;+1]"..
				--Chance escape
				"label[7.3,2;Chance escape]"..
				"button[7,2.5;1,1;cescape;-1]"..
				"label[8.1,2.7;"..tostring(fishing_setting.tmp_setting["escape_chance"]).."]"..
				"button[8.7,2.5;1,1;cescape;+1]"..
				--Bobber view range
				"label[7.2,3.5;Bobber view range]"..
				"button[7,4;1,1;bvrange;-1]"..
				"label[8.1,4.2;"..tostring(fishing_setting.tmp_setting["bobber_view_range"]).."]"..
				"button[8.7,4;1,1;bvrange;+1]"..
				--messages display
				"label[0,5.7;Display messages in chat]"..
				"button[3.7,5.5;1,1;dmessages;"..tostring(fishing_setting.tmp_setting["message"]).."]"..
				--poledeco
				"label[0,6.5;Simple pole deco]"..
				"button[3.7,6.3;1,1;poledeco;"..tostring(fishing_setting.tmp_setting["simple_deco_fishing_pole"]).."]"..
				--wearout
				"label[0,7.3;Poles Wear]"..					
				"button[3.7,7.1;1,1;wearout;"..tostring(fishing_setting.tmp_setting["wear_out"]).."]"..
				--TRESOR_ENABLE
				"label[6,5.7;Tresor enable]"..
				"button[9.7,5.5;1,1;tresorenable;"..tostring(fishing_setting.tmp_setting["tresor_enable"]).."]"..
				--NEW_WORM_SOURCE
				"label[6,6.5;New worm source]"..
				"button[9.7,6.3;1,1;newworm;"..tostring(fishing_setting.tmp_setting["new_worm_source"]).."]"..
				--WORM_IS_MOB
				"label[6,7.3;Worm is mob]"..				
				"button[9.7,7.1;1,1;wormmob;"..tostring(fishing_setting.tmp_setting["worm_is_mob"]).."]"..
				"button_exit[0.5,8.2;1.5,1;save;Abort]"..
				"button_exit[9,8.2;1.5,1;save;Ok]"
	
	minetest.show_formspec(player_name, "fishing:settings", formspec)
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
			fishing_setting.func.set_settings(fishing_setting.settings, fishing_setting.tmp_setting)
			fishing_setting.func.save()
			fishing_setting.tmp_setting = nil
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
		elseif fields["cescape"] then
			fishing_setting.tmp_setting["escape_chance"] = inc(fishing_setting.tmp_setting["escape_chance"], fields["cescape"], 1, 30)
		elseif fields["dmessages"] then
			fishing_setting.tmp_setting["message"] = bool(fields["dmessages"])
		elseif fields["poledeco"] then
			fishing_setting.tmp_setting["simple_deco_fishing_pole"] = bool(fields["poledeco"])
		elseif fields["wearout"] then
			fishing_setting.tmp_setting["wear_out"] = bool(fields["wearout"])
		elseif fields["tresorenable"] then
			fishing_setting.tmp_setting["tresor_enable"] = bool(fields["tresorenable"])
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

--function load settings from file 
function fishing_setting.func.load_trophies()
	local file = io.open(fishing_setting.file_trophies, "r")
	fishing_setting.trophies = {}
	if file then
		fishing_setting.trophies = minetest.deserialize(file:read("*all"))
		file:close()
		if not fishing_setting.trophies or type(fishing_setting.trophies) ~= "table" then
			fishing_setting.trophies = {}
		end
	end
end

function fishing_setting.func.save_trophies()
	local input = io.open(fishing_setting.file_trophies, "w")
	if input then
		input:write(minetest.serialize(fishing_setting.trophies))
		input:close()
	else
		minetest.log("action","Open failed (mode:w) of " .. fishing_setting.file_trophies)
	end
end

minetest.register_on_shutdown(function()
	minetest.log("action", "[fishing] Server shuts down. saving trophies table")
	fishing_setting.func.save_trophies()
	fishing_setting.func.save_concours()
end)


--[[
minetest.register_on_joinplayer(function(player)
	local playername = player:get_player_name()
--	if fishing_setting.trophies[fish][playername] == nil then
--		fishing_setting.trophies[fish][playername] = { ["fish_raw"] = 0,["shark_raw"] = 0, ["pike_raw"] = 0, ["clownfish_raw"]= 0,  ["bluefish_raw"] = 0 }
--	end
end)
--]]

function fishing_setting.func.add_to_trophies(player, fish, desc)
	local player_name = player:get_player_name()
	if not player_name then return end
	if fish == "fish_raw" or fish == "shark_raw" or fish == "pike_raw" or fish == "clownfish_raw" or fish == "bluefish_raw" then
		if fishing_setting.trophies[fish] == nil then
			fishing_setting.trophies[fish] = {}
		end
		fishing_setting.trophies[fish][player_name] = (fishing_setting.trophies[fish][player_name] or 0) + 1
		if fishing_setting.trophies[fish][player_name]%100 == 0 then
			minetest.chat_send_player(player_name, fishing_setting.func.S("You win a new trophie, you have catched %s " .. fish.."."):format(fishing_setting.trophies[fish][player_name]))
			local inv = player:get_inventory()
			local name = "fishing:trophy_"..fish
			if inv:room_for_item("main", {name=name, count=1, wear=0, metadata=""}) then
				inv:add_item("main", {name=name, count=1, wear=0, metadata=""})
			else
				minetest.spawn_item(player:getpos(), {name=name, count=1, wear=0, metadata=""})
			end
		end
		
		if fishing_setting.concours["concours"] ~= nil and fishing_setting.concours["concours"] == true then
			if fishing_setting.concours[fish] == nil then
				fishing_setting.concours[fish] = {}
			end
			fishing_setting.concours[fish][player_name] = (fishing_setting.concours[fish][player_name] or 0) + 1
			minetest.chat_send_all(fishing_setting.func.S("Yeah, %s catch "..desc):format(player_name))
		end
	end
end




if (minetest.get_modpath("unified_inventory")) then
	unified_inventory.register_button("menu_fishing", {
		type = "image",
		image = "fishing_fish_raw.png",
		tooltip = "fishing menu configuration",
		action = function(player)
			local player_name = player:get_player_name()
			if not player_name then return end
			if minetest.check_player_privs(player_name, {server=true}) then
				fishing_setting.func.on_show_settings(player_name)
			else
				minetest.chat_send_player(player_name, fishing_setting.func.S("You don't have the server priviledge!"))			
			
			end
		
		end,
	})
end

minetest.register_chatcommand("fishing_config", {
	params = "",
	description = "Display fishing configuration menu (admin only)",
	privs = {server=true},
	func = function(player_name, param)
		if not player_name then return end
		fishing_setting.func.on_show_settings(player_name)
	end
})




--function save settings 
function fishing_setting.func.save_concours()
	local input = io.open(fishing_setting.file_concours, "w")
	if input then
		input:write(minetest.serialize(fishing_setting.concours))
		input:close()
	else
		minetest.log("action","Open failed (mode:w) of " .. fishing_setting.file_concours)
	end
end

--function load councours data from file 
function fishing_setting.func.load_concours()
	local file = io.open(fishing_setting.file_concours, "r")
	local settings = {}
	fishing_setting.concours = {["concours"] = false, ["duration"] = 3600}
	if file then
		 fishing_setting.concours= minetest.deserialize(file:read("*all"))
		file:close()
		if settings == nil or type(settings) ~= "table" then
			fishing_setting.concours = {["concours"] = false, ["duration"] = 3600}
		end
	end
end




--Menu fishing configuration
fishing_setting.func.on_show_settings_concours = function(player_name)

	if not fishing_setting.tmp_setting then
		fishing_setting.tmp_setting = {["concours"] = (fishing_setting.concours["concours"] or false), ["duration"] = 3600, ["reset"] = ""}
	end

	local formspec = "size[6,6]bgcolor[#99a8ba;]label[1.8,0;FISHING CONCOURS]"..
				--Time concours
				"label[2,0.5;Duration]"..
				"button[1,1;1,1;duration;-60]"..
				"button[2,1;1,1;duration;-600]"..
				"label[2.9,1.2;"..tostring(fishing_setting.tmp_setting["duration"]).."]"..
				"button[3.7,1;1,1;duration;+600]"..
				"button[4.7,1;1,1;duration;+60]"..
				--concours enable
				"label[1,2.5;concours enable]"..				
				"button[4.7,2.3;1,1;concours;"..tostring(fishing_setting.tmp_setting["concours"]).."]"..
				--reset
				"label[1,3.3;reset classements(type 'yes')]"..	
				"field[5,3.5;1,1;reset;;]"..
				
				
				"button_exit[0.5,5.2;1.5,1;save;Abort]"..
				"button_exit[4,5.2;1.5,1;save;Ok]"

	minetest.show_formspec(player_name, "fishing:concours", formspec)
end

local function timetostr(time)
	--TODO transform time in H:M:S str
	
	
	
	return time
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname == "fishing:concours" then
		local name = player:get_player_name()
		if not name then return end
		if fields["save"] == "Ok" then
			if fields["reset"] and fields["reset"]:lower() == "yes" then
				fishing_setting.concours["fish_raw"] = {}
				fishing_setting.concours["clownfish_raw"] = {}
				fishing_setting.concours["bluefish_raw"] = {}
				fishing_setting.concours["shark_raw"] = {}
				fishing_setting.concours["pike_raw"] = {}
			end
			
			local progress = (fishing_setting.concours["concours"] or false)
			fishing_setting.concours["duration"] = fishing_setting.tmp_setting["duration"]
			fishing_setting.concours["concours"] = fishing_setting.tmp_setting["concours"]
			
			if progress == false and fishing_setting.tmp_setting["concours"] == true then
				fishing_setting.concours["concours"] = true
				fishing_setting.concours["warning_said"] = false
				--TODO show time in H:M:S
				local time = timetostr(fishing_setting.concours["duration"])
				minetest.chat_send_all(fishing_setting.func.S("Attention, Fishing contest go(duration %s)!!!"):format(time))
				--TODO play sound go contest
				
			elseif progress == true and fishing_setting.tmp_setting["concours"] == false then
				fishing_setting.concours["concours"] = false
			end
			fishing_setting.func.save_concours()
			fishing_setting.tmp_setting = nil
			return
		elseif fields["quit"] or fields["abort"] then
			fishing_setting.tmp_setting = nil
			return
		elseif fields["duration"] then
			fishing_setting.tmp_setting["duration"] = inc(fishing_setting.tmp_setting["duration"], fields["duration"], 120, 14400)
		elseif fields["concours"] then
			fishing_setting.tmp_setting["concours"] = bool(fields["concours"])
		else
			return
		end
		fishing_setting.func.on_show_settings_concours(name)
	end
end)


minetest.register_chatcommand("fishing_concours", {
	params = "fishing_concours <true|false> <time-in-sec>",
	description = "enable|disable fishing concours (admin only)",
	privs = {server=true},
	func = function(player_name, param)
		if not player_name then return end
		fishing_setting.func.on_show_settings_concours(player_name)
	end
})


function spairs(t, order)
    -- collect the keys
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end
    -- if order function given, sort by it by passing the table and keys a, b,
    -- otherwise just sort the keys 
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end
    -- return the iterator function
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end



function fishing_setting.func.set_winners(list)
	local win = {}
	local i = 1
	-- this uses an custom sorting function ordering by score descending
	for k,v in spairs(list, function(t,a,b) return t[b] < t[a] end) do
		table.insert(win, {[k]=v})
		if #win >= 6 then
			break
		end
	end
	return win
end






function fishing_setting.func.get_stat()
	local winners= {}
	for k,v in pairs(fishing_setting.concours) do
		if string.find(k, "_raw") ~= nil then
			if fishing_setting.concours[k] ~= nil then
				winners[k] = fishing_setting.func.set_winners(fishing_setting.concours[k])	
			else
				winners[k] = {}
    		end
    	end
    end
	local formspec = {"size[12,8]bgcolor[#99a8ba;]label[3.5,0;FISHING CONCOURS CLASSEMENT]"}
	local X = 0
	local Y
	for fish, fishers in pairs(winners) do
		Y = 1.4
		table.insert(formspec, "label["..(X+0.4)..",0.5;"..string.gsub(fish, "_raw", ""):upper().."]") --fish name
		for _,s in ipairs(fishers) do
			for pl,nb in pairs(s) do
				table.insert(formspec, "label["..(X) ..","..Y..";"..tostring(nb).."]") -- nb fish catched
				table.insert(formspec, "label["..(X+0.5) ..","..Y..";"..tostring(pl).."]") -- playername
			end
			Y = Y + 0.4
		end
		X = X + 2.3
	end
	return table.concat(formspec)
end


minetest.register_chatcommand("fishing_class", {
	params = "display classement",
	description = "",
	privs = {interact=true},
	func = function(player_name, param)
		if not player_name then return end
		local formspec = fishing_setting.func.get_stat()

		minetest.show_formspec(player_name, "fishing:classement", formspec)
	end
})

local function show_result()
	minetest.after(3, function()
		print("debug1")
		local formspec = fishing_setting.func.get_stat()
		for _,player in pairs(minetest.get_connected_players()) do
			local player_name = player:get_player_name()
			if player_name ~= nil then
				print("debug2")
				minetest.show_formspec(player_name, "fishing:classement", formspec)
			end	
		end
	end)
end

minetest.register_globalstep(function(dtime)
	if fishing_setting.concours["concours"] == true then
		fishing_setting.concours["duration"] = fishing_setting.concours["duration"] - dtime
		
		if fishing_setting.concours["duration"] < 30 and fishing_setting.concours["warning_said"] ~= true then
			minetest.chat_send_all("WARNING, Fishing contest will finish in 30 seconds")
			fishing_setting.concours["warning_said"] = true
		end
		if fishing_setting.concours["duration"] < 0 then
			minetest.chat_send_all("End of fishing contest")
			fishing_setting.concours["concours"] = false
			show_result()
		end
	end
end)

