-----------------------------------------------------------------------------------------------
-- Fishing - crabman77 version
-- Rewrited from original Fishing - Mossmanikin's version - Recipes 0.0.8
-----------------------------------------------------------------------------------------------
-- License (code & textures): 	WTFPL
-- Contains code from: 		animal_clownfish, animal_fish_blue_white, fishing (original), stoneage
-- Looked at code from:
-- Dependencies: 			default, farming
-- Supports:				animal_clownfish, animal_fish_blue_white, animal_rat, mobs
-----------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------
-- Fishing Pole
-----------------------------------------------------------------------------------------------
-- Wood Fishing Pole
minetest.register_craft({
	output = "fishing:pole_wood",
	recipe = { 
		{"",            "",            "group:stick"    },
		{"",            "group:stick", "farming:string" },
		{"group:stick", "",            "farming:string" },
	}
})

if minetest.get_modpath("moreblocks") ~= nil then
minetest.register_craft({
	output = "fishing:pole_wood",
	recipe = { 
		{"",            "",            "group:stick"     },
		{"",            "group:stick", "moreblocks:rope" },
		{"group:stick", "",            "moreblocks:rope" },
	}
})
end

if minetest.get_modpath("ropes") ~= nil then
	minetest.register_craft({
		output = "fishing:pole_wood",
		recipe = { 
			{"",            "",            "group:stick" },
			{"",            "group:stick", "ropes:rope"  },
			{"group:stick", "",            "ropes:rope"  },
		}
	})
end

-- Mithril Fishing Pole
if minetest.get_modpath("moreores") ~= nil and minetest.get_modpath("mobs") ~= nil then
minetest.register_craft({
	output = "fishing:pole_perfect",
	recipe = { 
		{"",                            "",                       "moreores:mithril_ingot" },
		{"", 							"moreores:mithril_ingot", "mobs:spider_cobweb"     },
		{"moreores:mithril_ingot",      "",                       "mobs:spider_cobweb"     },
	}
})
end

-----------------------------------------------------------------------------------------------
-- Fishing bait
-----------------------------------------------------------------------------------------------
--bait corn
minetest.register_craft({
	output = "fishing:bait_corn 9",
	recipe = {
		{"", "farming:corn", ""},
	}
})

--bait bread
minetest.register_craft({
	output = "fishing:bait_bread 9",
	recipe = {
		{"", "farming:bread", ""},
	}
})

-----------------------------------------------------------------------------------------------
-- Roasted Fish
-----------------------------------------------------------------------------------------------
minetest.register_craft({
	type = "cooking",
	output = "fishing:fish_cooked",
	recipe = "fishing:fish",
	cooktime = 2,
})

minetest.register_craft({
	type = "cooking",
	output = "fishing:fish_cooked",
	recipe = "fishing:clownfish",
	cooktime = 2,
})
minetest.register_craft({
	type = "cooking",
	output = "fishing:fish_cooked",
	recipe = "fishing:bluefish",
	cooktime = 2,
})


-----------------------------------------------------------------------------------------------
-- Wheat Seed
-----------------------------------------------------------------------------------------------
minetest.register_craft({
	type = "shapeless",
	output = "farming:seed_wheat",
	recipe = {"farming:wheat"},
})

-----------------------------------------------------------------------------------------------
-- Sushi
-----------------------------------------------------------------------------------------------
if minetest.get_modpath("flowers_plus") ~= nil then
	minetest.register_craft({
		type = "shapeless",
		output = "fishing:sushi",
		recipe = {"fishing:fish_cooked", "farming:seed_wheat", "flowers:seaweed" },
	})
end

if minetest.get_modpath("seaplants") ~= nil then
	minetest.register_craft({
		type = "shapeless",
		output = "fishing:sushi",
		recipe = {"fishing:fish_cooked", "farming:seed_wheat", "seaplants:kelpgreen" },

	})
end

-----------------------------------------------------------------------------------------------
-- Roasted Shark
-----------------------------------------------------------------------------------------------
minetest.register_craft({
	type = "cooking",
	output = "fishing:shark_cooked",
	recipe = "fishing:shark",
	cooktime = 2,
})

-----------------------------------------------------------------------------------------------
-- Roasted Pike
-----------------------------------------------------------------------------------------------
minetest.register_craft({
	type = "cooking",
	output = "fishing:pike_cooked",
	recipe = "fishing:pike",
	cooktime = 2,
})



-- baitball
minetest.register_craftitem("fishing:baitball", {
	description = fishing_setting.func.S("Bait Ball"),
	inventory_image = "fishing_baitball.png",
	stack_max = 99,
})

minetest.register_craft({
	type = "shapeless",
	output = "fishing:baitball 20",
	recipe = {"farming:flour", "farming:corn", "bucket:bucket_water"},
	replacements = {{ "bucket:bucket_water", "bucket:bucket_empty"}}
})


-- baitball_shark
minetest.register_craftitem("fishing:baitball_shark", {
	description = fishing_setting.func.S("Shark Bait Ball"),
	inventory_image = "fishing_baitball_shark.png",
	stack_max = 99,
})

minetest.register_craft({
	type = "shapeless",
	output = "fishing:baitball_shark 20",
	recipe = {"fishing:fish", "fishing:fish"}
})

minetest.register_craft({
	type = "shapeless",
	output = "fishing:baitball_shark 20",
	recipe = {"fishing:clownfish", "fishing:clownfish"}
})

minetest.register_craft({
	type = "shapeless",
	output = "fishing:baitball_shark 20",
	recipe = {"fishing:clownfish", "fishing:fish"}
})
minetest.register_craft({
	type = "shapeless",
	output = "fishing:baitball_shark 20",
	recipe = {"fishing:bluefish", "fishing:bluefish"}
})

minetest.register_craft({
	type = "shapeless",
	output = "fishing:baitball_shark 20",
	recipe = {"fishing:bluefish", "fishing:fish"}
})
minetest.register_craft({
	type = "shapeless",
	output = "fishing:baitball_shark 20",
	recipe = {"fishing:clownfish", "fishing:bluefish"}
})


minetest.register_craft({
	type = "shapeless",
	output = "fishing:baitball_shark 20",
	recipe = {"fishing:shark", "fishing:shark"}
})

minetest.register_craft({
	type = "shapeless",
	output = "fishing:baitball_shark 20",
	recipe = {"fishing:pike", "fishing:pike"}
})

minetest.register_craft({
	type = "shapeless",
	output = "fishing:baitball_shark 20",
	recipe = {"fishing:fish", "fishing:shark"}
})

minetest.register_craft({
	type = "shapeless",
	output = "fishing:baitball_shark 20",
	recipe = {"fishing:fish", "fishing:pike"}
})

minetest.register_craft({
	type = "shapeless",
	output = "fishing:baitball_shark 20",
	recipe = {"fishing:shark", "fishing:pike"}
})

















