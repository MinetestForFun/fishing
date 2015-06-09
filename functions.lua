

function fishing_setting.func.save()
	local input = io.open(fishing_setting.file, "w")
	if input then
		input:write(minetest.serialize(fishing_setting.settings))
		input:close()
	else
		minetest.log("action","echec d'ouverture (mode:w) de " .. fishing_setting.file)
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
	
	if settings.chance["hungry_fish"] ~= nil then
		fishing_setting.settings.chance["hungry_fish"] = settings.chance["hungry_fish"]
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

