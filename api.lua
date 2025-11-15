--TheAPI--
--SereMotsatt--

aore.registered_nodes = {}
aore.registered_craftitems = {}
aore.registered_tools = {}
aore.registered_crafts = {}

local S = core.get_translator("aore")

--
-- Helpers
--

function aore.register_node(name, teibol, flag)
	if string.find(name, ":") == nil then error('The use of ":" is necessary, for example "namemod:namenode"',2) end
	local prename = string.gsub(name, ":", "_")
	local preflag = flag or prename
	table.insert(aore.registered_nodes, {prename, teibol, preflag})
	if aore.settings:get_bool("debug_mode", false) then
		if flag == nil then
			core.log("warning", "[AORE_REGISTER_NODE]: the flag in "..name.." was not introduced")
		end
		core.log("info", "[AORE_REGISTER_NODE]: "..name.." as "..prename)
	end
end

function aore.register_craftitem(name, teibol, flag)
	if string.find(name, ":") == nil then error('The use of ":" is necessary, for example "namemod:namecraftitem"',2) end
	local prename = string.gsub(name, ":", "_")
	local preflag = flag or prename
	table.insert(aore.registered_craftitems, {prename, teibol, preflag})
	if aore.settings:get_bool("debug_mode", false) then
		if flag == nil then
			core.log("warning", "[AORE_REGISTER_CRAFTITEM]: the flag in "..name.." was not introduced")
		end
		core.log("info", "[AORE_REGISTER_CRAFTITEM]: "..name.." as "..prename)
	end
end

function aore.register_tool(name, teibol, flag)
	if string.find(name, ":") == nil then error('The use of ":" is necessary, for example "namemod:nametool"',2) end
	local prename = string.gsub(name, ":", "_")
	local preflag = flag or prename
	table.insert(aore.registered_tools, {prename, teibol, preflag})
	if aore.settings:get_bool("debug_mode", false) then
		if flag == nil then
			core.log("warning", "[AORE_REGISTER_TOOL]: the flag in "..name.." was not introduced")
		end
		core.log("info", "[AORE_REGISTER_TOOL]: "..name.." as "..prename)
	end
end

function aore.register_craft(name, teibol, flag)
	if string.find(name, ":") == nil then error('The use of ":" is necessary, for example "namemod:namecraft"',2) end
	local prename = string.gsub(name, ":", "_")
	local preflag = flag or prename
	table.insert(aore.registered_crafts, {prename, teibol, preflag})
	if aore.settings:get_bool("debug_mode", false) then
		if flag == nil then
			core.log("warning", "[AORE_REGISTER_CRAFT]: the flag in "..name.." was not introduced")
		end
		core.log("info", "[AORE_REGISTER_CRAFT]: "..name.." as "..prename)
	end
end

--
-- Main
--

function aore.register(namemod, teibol)
	local def = {
		description = teibol.description or namemod,
		seed = teibol.seed or 15, --Only if 'custom_mapgen = false or nil'
		main_texture = teibol.main_texture or "noexist",
		y_min = teibol.y_min or -31000, --Only if 'custom_mapgen = false or nil'
		y_max = teibol.y_max or 0, --Only if 'custom_mapgen = false or nil'
		custom_mapgen = teibol.custom_mapgen or false,
		stone_name = teibol.stone_name or "default:stone",
		stone_texture = teibol.stone_texture or "default_stone.png",
		stick_name = teibol.stick_name or "default:stick",
		toolpower = teibol.toolpower or 1,
		flags = teibol.flags or {},
		flags_color = teibol.flags_color or "#FFFFFF",
		custom_tools = teibol.custom_tools or false,
		custom_craft_tools = teibol.custom_craft_tools or false,
		ore_groups = teibol.ore_groups or {cracky=1},
		tool_durability = teibol.tool_durability or nil
	}
	table.insert(aore.registered, def)
	local othergroup = {}
	local otherdamage_group = {}
	local otherdamage_group_sword = {}
	local toolgroups = {}
	if def.toolpower >= 25 then
		othergroup = {supermetal=1}
		otherdamage_group = {fleshy=6}
		otherdamage_group_sword = {fleshy=9}
	elseif def.toolpower >= 16 then
		othergroup = {supermetal=2}
		otherdamage_group = {fleshy=5}
		otherdamage_group_sword = {fleshy=6}
	elseif def.toolpower >= 7 then
		othergroup = {supermetal=3}
		otherdamage_group = {fleshy=4}
		otherdamage_group_sword = {fleshy=3}
	elseif def.toolpower >= 4 then
		othergroup = {cracky=1}
		otherdamage_group = {fleshy=3}
		otherdamage_group_sword = {fleshy=2}
	else
		othergroup = {cracky=2}
		otherdamage_group = {fleshy=1}
		otherdamage_group_sword = {fleshy=1}
	end
	toolgroups.cracky = {3.10/def.toolpower, 2.00/def.toolpower, 1.60/def.toolpower}
	toolgroups.supermetal = {20.00/def.toolpower, 16.00/def.toolpower, 11.00/def.toolpower}
	toolgroups.choppy = {4.60/def.toolpower, 3.00/def.toolpower, 1.60/def.toolpower}
	toolgroups.snappy = {2.00/def.toolpower, 1.60/def.toolpower, 0.40/def.toolpower}
	--Automatic
	if def.tool_durability == nil then
		def.tool_durability = 1 * (def.toolpower*12)
	end
	--core.log("none", tostring(#othergroup).." "..def.toolpower)
	core.register_craftitem(namemod.."_lump", {
		description = S("@1 lump", def.description),
		inventory_image = def.main_texture.."_lump.png",
		wield_item = def.main_texture.."_lump.png",
	})
	core.register_craftitem(namemod.."_ingot", {
		description = S("@1 ingot", def.description),
		inventory_image = def.main_texture.."_ingot.png",
		wield_item = def.main_texture.."_ingot.png",
	})
	core.register_node(namemod.."_ore", {
		description = S("@1 ore", def.description),
		tiles = {def.stone_texture.."^"..def.main_texture.."_mineral.png"},
		drop = {
			items = {
				{items = {namemod.."_lump"}},
			}
		},
		groups = def.ore_groups,
	})

	--ORE MAPGEN (Very Basic)
	if def.custom_mapgen ~= true then
		core.register_ore({
			name = namemod.."_oremapgen",
			ore_type = "scatter",
			ore = namemod.."_ore",
			clust_scarcity = 8 * 8 * 8,
			clust_num_ores = 8,
			clust_size = 3,
			y_min = def.y_min,
			y_max = def.y_max,	
			wherein = def.stone_name, 	
			noise_params = {
				offset = 0,
				scale = 1,
				spread = {x = 250, y = 125, z = 250},
				seed = def.seed,
				octaves = 3,
				persistence = 0.7
			},
		})
	end
	
	core.register_node(namemod.."_block", {
		description = S("@1 block", def.description),
		tiles = {def.main_texture.."_block.png"},
		groups = othergroup,
	})
	--TOOLS
	if def.custom_tools ~= true then
		core.register_tool(namemod.."_pick", {
			description = S("@1 pick", def.description),
			inventory_image = def.main_texture.."_tool_pick.png",
			wield_item = def.main_texture.."_tool_pick.png",
			tool_capabilities = {
				full_punch_interval = 1.0,
				max_drop_level = 0,
				groupcaps = {
					cracky = {times = toolgroups.cracky, uses = def.tool_durability, maxlevel = 1},
					supermetal = {times = toolgroups.supermetal, uses = math.floor(def.tool_durability*0.5), maxlevel = 1},
				},
				damage_groups = otherdamage_group,
			},
		})
		core.register_tool(namemod.."_shovel", {
			description = S("@1 shovel", def.description),
			inventory_image = def.main_texture.."_tool_shovel.png",
			wield_item = def.main_texture.."_tool_shovel.png",
			tool_capabilities = {
				full_punch_interval = 1.0,
				max_drop_level = 0,
				groupcaps = {
					crumbly = {times={3.10, 1.60, 0.60}, uses= def.tool_durability, maxlevel = 1},
				},
				damage_groups = otherdamage_group,
			},
		})
		core.register_tool(namemod.."_axe", {
			description = S("@1 axe", def.description),
			inventory_image = def.main_texture.."_tool_axe.png",
			wield_item = def.main_texture.."_tool_axe.png",
			tool_capabilities = {
				full_punch_interval = 1.0,
				max_drop_level = 0,
				groupcaps = {
					choppy = {times = {4.60, 3.00, 1.60}, uses = def.tool_durability, maxlevel = 1},
				},
				damage_groups = otherdamage_group,
			},
		})
		core.register_tool(namemod.."_sword", {
			description = S("@1 sword", def.description),
			inventory_image = def.main_texture.."_tool_sword.png",
			tool_capabilities = {
				full_punch_interval = 1,
				max_drop_level=0,
				groupcaps={
					snappy={times={2.00, 1.60, 0.40}, uses=def.tool_durability, maxlevel = 1},
				},
				damage_groups = otherdamage_group_sword,
			},
		})
	end
	
	--BULT TO INGOT
	core.register_craft({
		type = "cooking",
		output = namemod.."_ingot",
		recipe = namemod.."_lump",
		cooktime = 9.0,
	})
	
	--CRAFTS
	core.register_craft({
		output = namemod.."_block",
		recipe = {
			{namemod.."_ingot",namemod.."_ingot",namemod.."_ingot"},
			{namemod.."_ingot",namemod.."_ingot",namemod.."_ingot"},
			{namemod.."_ingot",namemod.."_ingot",namemod.."_ingot"},
		},
	})
	core.register_craft({
		output = namemod.."_ingot 9",
		recipe = {{namemod.."_block"},},
	})
	
	if def.custom_tools ~= true and def.custom_craft_tools ~= true then 
		core.register_craft({
			output = namemod.."_pick",
			recipe = {
				{namemod.."_ingot",namemod.."_ingot",namemod.."_ingot"},
				{"",def.stick_name,""},
				{"",def.stick_name,""},
			},
		})
		core.register_craft({
			output = namemod.."_axe",
			recipe = {
				{namemod.."_ingot",namemod.."_ingot"},
				{namemod.."_ingot",def.stick_name},
				{"",def.stick_name},
			},
		})
		core.register_craft({
			output = namemod.."_shovel",
			recipe = {
				{"",namemod.."_ingot",""},
				{"",def.stick_name,""},
				{"",def.stick_name,""},
			},
		})
		core.register_craft({
			output = namemod.."_sword",
			recipe = {
				{"",namemod.."_ingot",""},
				{"",namemod.."_ingot",""},
				{"",def.stick_name,""},
			},
		})
	end
	--
	-- Custom for flags
	--
	
	--Nodes
	for i=1, #aore.registered_nodes do
		local found = false
		for k=1, #def.flags do
			if def.flags[k] == aore.registered_nodes[i][3] then found = true end
		end
		if found then
			local preregister_value = table.copy(aore.registered_nodes[i][2])
			preregister_value.description = string.gsub(preregister_value.description, "*", def.description)
			for m=1, #preregister_value.tiles do
				if preregister_value.tiles_nocolor ~= nil then
					preregister_value.tiles[m] = "("..preregister_value.tiles[m].."^[multiply:"..def.flags_color..")^"..preregister_value.tiles_nocolor[m]
				else
					preregister_value.tiles[m] = preregister_value.tiles[m] .. "^[multiply:" .. def.flags_color
				end
			end
			if preregister_value.inventory_image ~= nil then
				preregister_value.inventory_image = "("..preregister_value.inventory_image .. "^[multiply:" .. def.flags_color..")"
			end
			if preregister_value.wield_item ~= nil then
				preregister_value.wield_item = "("..preregister_value.wield_item .. "^[multiply:" .. def.flags_color..")"
			end
			local prename = namemod.."_"..aore.registered_nodes[i][1]
			core.register_node(prename, preregister_value)
		end
	end
	
	
	--Craftitems
	for i=1, #aore.registered_craftitems do
		local found = false
		for k=1, #def.flags do
			if def.flags[k] == aore.registered_craftitems[i][3] then found = true end
		end
		if found then
			local preregister_value = table.copy(aore.registered_craftitems[i][2])
			preregister_value.description = string.gsub(preregister_value.description, "*", def.description)
			if preregister_value.inventory_image ~= nil then
				preregister_value.inventory_image = preregister_value.inventory_image .. "^[multiply:" .. def.flags_color
			end
			if preregister_value.wield_item ~= nil then
				preregister_value.wield_item = preregister_value.wield_item .. "^[multiply:" .. def.flags_color
			end
			local prename = namemod.."_"..aore.registered_craftitems[i][1]
			core.register_craftitem(prename, preregister_value)
		end
	end
	
	
	--Tools
	for i=1, #aore.registered_tools do
		local found = false
		for k=1, #def.flags do
			if def.flags[k] == aore.registered_tools[i][3] then found = true end
		end
		if found then
			local preregister_value = table.copy(aore.registered_tools[i][2])
			preregister_value.description = string.gsub(preregister_value.description, "*", def.description)
			if preregister_value.inventory_image ~= nil then
				preregister_value.inventory_image = preregister_value.inventory_image .. "^[multiply:" .. def.flags_color
			end
			if preregister_value.wield_item ~= nil then
				preregister_value.wield_item = preregister_value.wield_item .. "^[multiply:" .. def.flags_color
			end
			local prename = namemod.."_"..aore.registered_tools[i][1]
			core.register_tool(prename, preregister_value)
		end
	end
	
	
	--Crafts
	for i=1, #aore.registered_crafts do
		local found = false
		for k=1, #def.flags do
			if def.flags[k] == aore.registered_crafts[i][3] then found = true end
		end
		if found then
			local preregister_value = table.copy(aore.registered_crafts[i][2])
			if type(preregister_value.recipe) == "table" then
				for m=1, #preregister_value.recipe do
					for n=1, #preregister_value.recipe do
						preregister_value.recipe[m][n] = string.gsub(preregister_value.recipe[m][n], "namemod", namemod)
					end
				end
			else
				preregister_value.recipe = string.gsub(preregister_value.recipe, "namemod", namemod)
			end
			preregister_value.output = string.gsub(preregister_value.output, "namemod", namemod)
			core.register_craft(preregister_value)
		end
	end
end