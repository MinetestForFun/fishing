

minetest.register_alias("flowers_plus:seaweed", "flowers:seaweed") -- exception


-- bobber
minetest.register_node("fishing:bobber_box", {
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
--			{ left, bottom, front,  right, top ,  back}
			{-8/16, -8/16,     0,  8/16,  8/16,     0}, -- feathers
			{-2/16, -8/16, -2/16,  2/16, -4/16,  2/16},	-- bobber
		}
	},
	tiles = {
		"fishing_bobber_top.png",
		"fishing_bobber_bottom.png",
		"fishing_bobber.png",
		"fishing_bobber.png",
		"fishing_bobber.png",
		"fishing_bobber.png^[transformFX"
	}, -- 
	groups = {not_in_creative_inventory=1},
})


local FISHING_BOBBER_ENTITY={
	hp_max = 605,
	water_damage = 1,
	physical = true,
	timer = 0,
	env_damage_timer = 0,
	visual = "wielditem",
	visual_size = {x=1/3, y=1/3, z=1/3},
	textures = {"fishing:bobber_box"},
	--			   {left ,bottom, front, right,  top ,  back}
	collisionbox = {-2/16, -4/16, -2/16,  2/16, 0/16,  2/16},
	view_range = 7,
	randomtime = 50,
	chance = 0,
	amorce = false,
	prize = "",
	
--	DESTROY BOBBER WHEN PUNCHING IT
	on_punch = function (self, puncher, time_from_last_punch, tool_capabilities, dir)
		if not puncher:is_player() then return end
		local player = puncher:get_player_name()
		if player ~= self.object.owner then return end
		if MESSAGES == true then minetest.chat_send_player(player, fishing_setting.S("You didn't prizes anything."), false) end -- fish escaped
		if not fishing_setting.is_creative_mode then
			local inv = puncher:get_inventory()
			if inv:room_for_item("main", {name="fishing:bait_corn", count=1, wear=0, metadata=""}) then
				inv:add_item("main", {name="fishing:bait_corn", count=1, wear=0, metadata=""})
				if MESSAGES == true then minetest.chat_send_player(player, fishing_setting.S("The bait is still there."), false) end -- bait still there
			end
		end
		-- make sound and remove bobber
		minetest.sound_play("fishing_bobber1", { pos = self.object:getpos(), gain = 0.5, })
		self.object:remove()
	end,
	
	
	
	
--	WHEN RIGHTCLICKING THE BOBBER THE FOLLOWING HAPPENS	(CLICK AT THE RIGHT TIME WHILE HOLDING A FISHING POLE)	
	on_rightclick = function (self, clicker)
		local item = clicker:get_wielded_item()
		local player = clicker:get_player_name()
		local inv = clicker:get_inventory()
		local pos = self.object:getpos()
		local item_name = item:get_name()
		if string.find(item_name, "fishing:pole_") ~= nil then
		
--##############################################################################################################
			if self.prize ~= "" then
			local name = self.prize[1]..":"..self.prize[2]
			local desc = self.prize[4]
			print("You caught "..name.." "..desc)
				minetest.chat_send_player(player, "You caught "..desc, false)
				if inv:room_for_item("main", {name=name, count=1, wear=0, metadata=""}) then
					local used
					if self.prize[3] == "random" then
						used = (2000*(math.random(20, 29)))
					elseif self.prize[3] == "randomtools" then	
						used = (65535/(30-(math.random(15, 29))))				
					else
						used = 0
					end
					inv:add_item("main", {name=name, count=1, wear=used, metadata=""})
				else
					minetest.spawn_item(clicker:getpos(), name)
				end
			end
			
			-- weither player has fishing pole or not
			minetest.sound_play("fishing_bobber1", { pos = self.object:getpos(), gain = 0.5, })
			self.object:remove()
		
		
--##############################################################################################################		
		
		
		
		elseif item:get_name() == "fishing:amorce" then
			
			
			if not fishing_setting.is_creative_mode then
				inv:remove_item("main", "fishing:amorce")
			end
			self.amorce = true
			--addparticle
			minetest.add_particlespawner(30, 0.5,   -- for how long (?)             -- Particles on splash
				{x=pos.x,y=pos.y-0.0625,z=pos.z}, {x=pos.x,y=pos.y,z=pos.z}, -- position min, pos max
				{x=-2,y=-0.0625,z=-2}, {x=2,y=3,z=2}, -- velocity min, vel max
				{x=0,y=-9.8,z=0}, {x=0,y=-9.8,z=0},
				0.3, 1.2,
				0.25, 0.5,  -- min size, max size
				false, "fishing_particle_amorce.png")
			-- add sound
			minetest.sound_play("fishing_bobber1", {pos = self.object:getpos(), gain = 0.2, })
			--inc hp
			print("amorce")
		end
	end,
	
	
	
	
	
-- AS SOON AS THE BOBBER IS PLACED IT WILL ACT LIKE
	on_step = function(self, dtime)
		local pos = self.object:getpos()
		
		if self.owner == nil then self.object:remove(); return end
		local player = minetest.get_player_by_name(self.owner)
		if not player then self.object:remove(); return end
		--remove if nobody in radius
		local p = player:getpos()
		local dist = ((p.x-pos.x)^2 + (p.y-pos.y)^2 + (p.z-pos.z)^2)^0.5		
		if dist > self.view_range then
			minetest.sound_play("fishing_bobber1", {pos = self.object:getpos(),gain = 0.5,})
			self.object:remove()
			return
		end
		
		--rotate bobber
		if math.random(1, 4) == 1 then
			self.object:setyaw(self.object:getyaw()+((math.random(0,360)-180)/2880*math.pi))
		end

	--###################
		self.timer = self.timer + 1
		if self.timer < self.randomtime then
			if self.prize ~= "" then
				local n = math.random(1,3)
				if n == 1 then
					if self.old_pos2 == true then
						pos.y = pos.y-0.0325
						self.object:moveto(pos, false)
						self.old_pos2 = false
					else
						pos.y = pos.y+0.0325
						self.object:moveto(pos, false)
						self.old_pos2 = true
					end
				end
			end
			return	
		end
		
		self.timer = 0
		self.object:moveto(self.old_pos, false)
		self.randomtime = math.random(2,12)*10
		--self.object:moveto({x=pos.x,y=pos.y-0.015625,z=pos.z})
		--print("randomtime:"..tostring(self.randomtime))
		if math.random(1, 100) > FISH_CHANCE then
			self.prize = ""
			return
		end
		
		local c = 0
		if self.amorce then
			c = 20
		end	

		
		local chance = math.random(1, 100)+c
		print(" chance: " .. tostring(chance) .. "   randomtime: "..tostring(self.randomtime))
		if chance == 1 then
			local r = math.random(1, 100)
			if r < 10 then
				self.prize = fishing_setting.prizes.tresor[math.random(1,#fishing_setting.prizes.tresor)]
			else
				self.prize = ""
			end
		elseif chance < 10 then	
			self.prize = ""
		elseif chance < 40 then
			self.prize = fishing_setting.prizes.loose[math.random(1,#fishing_setting.prizes.loose)]
		else
			self.prize = fishing_setting.prizes.fish[math.random(1,#fishing_setting.prizes.fish)]
		end
		
		self.amorce = false
		if self.prize ~= nil then
			pos.y = self.old_pos.y-0.1
			self.object:moveto(pos, false)
			minetest.sound_play("fishing_bobber1", {pos=pos,gain = 0.5,})
			print("prize: "..tostring(self.prize[1])..":"..tostring(self.prize[2]))
		end	
	end,
}


minetest.register_entity("fishing:bobber_entity", FISHING_BOBBER_ENTITY)

