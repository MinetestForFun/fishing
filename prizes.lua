minetest.register_alias("flowers_plus:seaweed", "flowers:seaweed") -- exception


fishing_setting.prizes.fish = {
	{"fishing",  				"fish_raw",			0,			"a Fish."}
}
    						
    						
-- Here's what you can prizes
fishing_setting.prizes.loose = {
--	  MoD 						 iTeM				WeaR		 MeSSaGe ("You caught "..)
	{"default",					"stick",			0,			"a Twig."},
	{"mobs",					"rat",				0,			"a Rat."},
	{"flowers_plus",			"seaweed",			0,			"some Seaweed."},
	{"seaplants",				"kelpgreen",		0,			"a Green Kelp."},
	{"farming",					"string",			0,			"a String."},
	{"trunks",					"twig_1",			0,			"a Twig."}
}


fishing_setting.prizes.stuff = {
	{"fishing",					"pole_wood",		"randomtools",	"an old Fishing Pole."},
	{"3d_armor",				"boots_wood",		"random",	"some very old Boots."}
}

fishing_setting.prizes.tresor = {"default",			"mese",		0,	"a mese block."}
