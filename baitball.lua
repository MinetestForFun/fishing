






-- baitball

minetest.register_craftitem("fishing:baitball", {
	description = "Bait Ball",
	inventory_image = "fishing_baitball.png",
})

minetest.register_craft({
	type = "shapeless",
	output = "fishing:baitball",
	recipe = {"farming:flour", "farming:corn", "food:egg", "bucket:bucket_water"}
})
