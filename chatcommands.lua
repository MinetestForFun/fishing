


 --FIXME server set fishing enable|disable treasure
minetest.register_chatcommand("fishing_enable", {
	params = "",
	 description = "display trophie of treasure from the water",
	privs = {server=true},
	func = function(name, param)
		if param == "true" then
			fishing_setting.enable = true
			minetest.chat_send_player(name, "treasure is enabled")
		elseif param == "false" then
			fishing_setting.enable = false
			minetest.chat_send_player(name, "treasure is disabled")
		else
			minetest.chat_send_player(name, "unknow param ".. tostring(param))
			minetest.chat_send_player(name, "command is /fishing_enable <true|false>")
		end
		

	end
})





--[[ --FIXME server set fishing random timer
minetest.register_chatcommand("fishing_stimer", {
	params = "",
	 description = "display trophie of treasure from the water",
	privs = {server=true},
	func = function(name, param)
		minetest.chat_send_player(name, "treasure is " .. treasure)

	end
})
]]


--[[ --FIXME server set fishing config
minetest.register_chatcommand("fishing_setting", {
	params = "",
	 description = "display trophie of treasure from the water",
	privs = {server=true},
	func = function(name, param)
		minetest.chat_send_player(name, "")

	end
})
]]



minetest.register_chatcommand("fishing_trophies", {
	params = "",
	 description = "display trophie of treasure from the water",
	privs = {},
	func = function(name, param)
		--FIXME fixed treasure
		local tresure = "nothing"
		minetest.chat_send_player(name, "treasure is " .. treasure)

	end
})



--[[
minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()

end)
]]
