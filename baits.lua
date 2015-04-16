


--bait_corn
minetest.register_craftitem("fishing:bait_corn", {
	description = "Bait corn",
	inventory_image = "fishing_bait_corn.png",
})

fishing_setting.baits["fishing:bait_corn"] = { ["bait"] = "fishing:bait_corn", ["bobber"] = "fishing:bobber_entity" }



--bait_pain
minetest.register_craftitem("fishing:bait_pain", {
	description = "Bait pain",
	inventory_image = "fishing_bait_corn.png",
})

fishing_setting.baits["fishing:bait_pain"] = { ["bait"] = "fishing:bait_pain", ["bobber"] = "fishing:bobber_entity" }
