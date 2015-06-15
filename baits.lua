

--fish bait
--bait_corn
minetest.register_craftitem("fishing:bait_corn", {
	description = "Bait corn",
	inventory_image = "fishing_bait_corn.png",
})

fishing_setting.baits["fishing:bait_corn"] = { ["bait"] = "fishing:bait_corn", ["bobber"] = "fishing:bobber_entity", ["hungry"] = 50 }


--bait_bread
minetest.register_craftitem("fishing:bait_bread", {
	description = "Bait Bread",
	inventory_image = "fishing_bait_corn.png",
})

fishing_setting.baits["fishing:bait_bread"] = { ["bait"] = "fishing:bait_bread", ["bobber"] = "fishing:bobber_entity", ["hungry"] = 50 }


--bait_worm
fishing_setting.baits["fishing:bait_worm"] = { ["bait"] = "fishing:bait_worm", ["bobber"] = "fishing:bobber_entity", ["hungry"] = 50 }





--shark bait
--bait_fish
fishing_setting.baits["fishing:bait_fish"] = { ["bait"] = "fishing:bait_fish", ["bobber"] = "fishing:bobber_entity_shark", ["hungry"] = 50 }
