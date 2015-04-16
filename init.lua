print("loading [fishing] mod")
fishing_setting = {}


if (minetest.get_modpath("intllib")) then
  dofile(minetest.get_modpath("intllib").."/intllib.lua")
  fishing_setting.S = intllib.Getter(minetest.get_current_modname())
else
  fishing_setting.S = function ( s ) return s end
end



fishing_setting.file = minetest.get_worldpath() .. "/fishing_config.txt"
fishing_setting.is_creative_mode = minetest.setting_getbool("creative_mode")
fishing_setting.setting = {}
fishing_setting.random_timer = 3600
fishing_setting.prizes = {}

--for random object 
random_objects = {}

fishing_setting.baits = {}
local path = minetest.get_modpath("fishing").."/"
dofile(path .."settings.txt")
dofile(path .."crafting.lua")
dofile(path .."baits.lua")
dofile(path .."prizes.lua")
dofile(path .."amorce.lua")
dofile(path .."bobber.lua")
--dofile(path .."bobber_shark.lua")
dofile(path .."fishes.lua")
dofile(path .."trophies.lua")
dofile(path .."poles.lua")



-- timer
fishing_setting.timer = 0
minetest.register_globalstep(function(dtime)
	if fishing_setting.enable == false then return end
	fishing_setting.timer = fishing_setting.timer - dtime
--	if fishing.new_object then
	--	new object is item, time to catch is timer
	--	fishing_setting.timer = fishing_setting.random_timer
--	end
--	if timer == 300 then
		--you have 5min for catch item
--	end
	if fishing_setting.timer < 0 then
		for _, player in  ipairs(minetest.get_connected_players()) do
			local name = player:get_player_name()
			--FIXME display message
		end
		--get random object
		fishing_setting.timer = fishing_setting.random_timer
	end
end)



