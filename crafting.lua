
-----------------------------------------------------------------------------------------------
-- Fishing Pole
-----------------------------------------------------------------------------------------------
minetest.register_craft({
	output = "fishing:pole_wood",
	recipe = { 
		{"",				"",					"group:stick"	},
		{"",				"group:stick",		"farming:string"},
		{"group:stick",		"",					"farming:string"},
	}
})

if minetest.get_modpath("moreblocks") ~= nil then
minetest.register_craft({
	output = "fishing:pole_wood",
	recipe = { 
		{"", 				"",					"group:stick"		},
		{"", 				"group:stick",		"moreblocks:rope"	},
		{"group:stick",		"",					"moreblocks:rope"	},
	}
})
end

if minetest.get_modpath("ropes") ~= nil then
	minetest.register_craft({
		output = "fishing:pole_wood",
		recipe = { 
			{"", 				"",					"group:stick"	},
			{"", 				"group:stick",		"ropes:rope"   	},
			{"group:stick",		"",					"ropes:rope"   	},
		}
	})
end

-- Mithril Fishing Pole
if minetest.get_modpath("moreores") ~= nil and minetest.get_modpath("mobs") ~= nil then
minetest.register_craft({
	output = "fishing:pole_perfect",
	recipe = { 
		{"", 							"",							"moreores:mithril_ingot"	},
		{"", 							"moreores:mithril_ingot",	"mobs:spider_cobweb"		},
		{"moreores:mithril_ingot",		"",							"mobs:spider_cobweb"		},
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

--bait pain
minetest.register_craft({
	output = "fishing:bait_pain 9",
	recipe = {
		{"", "farming:bread", ""},
	}
})


-----------------------------------------------------------------------------------------------
-- Fishing bobber
-----------------------------------------------------------------------------------------------
--bobber



