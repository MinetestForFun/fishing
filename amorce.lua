






-- amorce

minetest.register_craftitem("fishing:amorce", {
	description = "Amorce",
	inventory_image = "fishing_amorce.png",
})

minetest.register_craft({
	type = "shapeless",
	output = "fishing:amorce",
	recipe = {"farming:flour", "farming:corn", "food:egg", "bucket:bucket_water"}
})
