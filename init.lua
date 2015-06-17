print("loading [fishing] mod")
local path = minetest.get_modpath("fishing").."/"

fishing_setting = {}
fishing_setting.func = {}
fishing_setting.is_creative_mode = minetest.setting_getbool("creative_mode")
fishing_setting.file = minetest.get_worldpath() .. "/fishing_config.txt"

fishing_setting.settings = {}
--for random object 
random_objects = {}
fishing_setting.baits = {}
fishing_setting.hungry = {}
fishing_setting.prizes = {}

if (minetest.get_modpath("intllib")) then
  dofile(minetest.get_modpath("intllib").."/intllib.lua")
  fishing_setting.func.S = intllib.Getter(minetest.get_current_modname())
else
  fishing_setting.func.S = function ( s ) return s end
end


dofile(path .."settings.txt")
dofile(path .."functions.lua")

--default_settings
fishing_setting.settings["message"] = MESSAGES
fishing_setting.settings["worm_is_mob"] = WORM_IS_MOB 
fishing_setting.settings["worm_chance"] = WORM_CHANCE
fishing_setting.settings["new_worm_source"] = NEW_WORM_SOURCE
fishing_setting.settings["wear_out"] = WEAR_OUT
fishing_setting.settings["simple_deco_fishing_pole"] = SIMPLE_DECO_FISHING_POLE
fishing_setting.settings["bobber_view_range"] = BOBBER_VIEW_RANGE
fishing_setting.settings["fish_chance"] = FISH_CHANCE
fishing_setting.settings["shark_chance"] = SHARK_CHANCE
fishing_setting.settings["tresor_chance"] = TRESOR_CHANCE
fishing_setting.settings["tresor_timer"] = TRESOR_TIMER
fishing_setting.settings["tresor_random_enable"] = TRESOR_RANDOM_ENABLE

-- load config file if exist in worldpath
fishing_setting.func.load()


dofile(path .."crafting.lua")
dofile(path .."baits.lua")
dofile(path .."prizes.lua")
dofile(path .."baitball.lua")
dofile(path .."bobber.lua")
--dofile(path .."bobber_shark.lua")
dofile(path .."fishes.lua")
dofile(path .."trophies.lua")
dofile(path .."poles.lua")
dofile(path .."chatcommands.lua")

--random hungry bait
fishing_setting.func.hungry_random()

-- timer
fishing_setting.timer = fishing_setting.settings["tresor_timer"]
minetest.register_globalstep(function(dtime)
	if fishing_setting.enable == false then return end
	fishing_setting.timer = fishing_setting.timer - dtime
--	if fishing.new_object then
	--	new object is item, time to catch is timer
	--	fishing_setting.timer = fishing_setting.settings["tresor_timer"]
--	end
--	if timer == 300 then
		--you have 5min for catch item
--	end
	if fishing_setting.timer < 0 then
		for _, player in  ipairs(minetest.get_connected_players()) do
			local name = player:get_player_name()
			--FIXME display message
		end
		--set random object
		fishing_setting.timer = fishing_setting.settings["tresor_timer"]
	end
end)


print("loaded [fishing] mod")
