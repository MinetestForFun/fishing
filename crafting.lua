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
-- Some subgames have bundled all of moreores' content in their default mod; just check for mithril
if (minetest.get_modpath("moreores") ~= nil or minetest.registered_items["default:mithril_ingot"]) and minetest.get_modpath("mobs") ~= nil then
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
	recipe = "group:fishraw",
	cooktime = 2,
})

if minetest.get_modpath("mobs_fish") ~= nil then
	minetest.register_craft({
		type = "cooking",
		output = "fishing:fish_cooked",
		recipe = "mobs_fish:clownfish",
		cooktime = 2,
	})
	minetest.register_craft({
		type = "cooking",
		output = "fishing:fish_cooked",
		recipe = "mobs_fish:tropical",
		cooktime = 2,
	})
end

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
		recipe = {"fishing:fish_cooked", "farming:seed_wheat", "flowers_plus:seaweed" },
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
	recipe = "fishing:shark_raw",
	cooktime = 2,
})

if minetest.get_modpath("mobs_sharks") ~= nil then
	minetest.register_craft({
		type = "cooking",
		output = "fishing:shark_cooked",
		recipe = "mobs_sharks:shark_lg",
		cooktime = 2,
	})
	minetest.register_craft({
		type = "cooking",
		output = "fishing:shark_cooked",
		recipe = "mobs_sharks:shark_md",
		cooktime = 2,
	})
	minetest.register_craft({
		type = "cooking",
		output = "fishing:shark_cooked",
		recipe = "mobs_sharks:shark_sm",
		cooktime = 2,
	})
end

-----------------------------------------------------------------------------------------------
-- Roasted Pike
-----------------------------------------------------------------------------------------------
minetest.register_craft({
	type = "cooking",
	output = "fishing:pike_cooked",
	recipe = "fishing:pike_raw",
	cooktime = 2,
})


