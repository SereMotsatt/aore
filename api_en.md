
# Aore API (Advance ore API)


## Main

´´´lua

aore.register(namemod, {
	--Description of the ore, is a description main.
	description = teibol.description or namemod, 
	
	--Seed for mapgen, Only if 'custom_mapgen = false or nil'.
	seed = teibol.seed or 15,
	
	--If 'main_texture' is "default_stone" then "default_stone_pick.png", "default_stone_ore.png"...
	main_texture = teibol.main_texture or "noexist",
	
	--Used for mapgen, Only if 'custom_mapgen = false or nil'.
	y_min = teibol.y_min or -31000,
	
	--Used for mapgen, Only if 'custom_mapgen = false or nil'.
	y_max = teibol.y_max or 0,
	
	--If 'custom_mapgen == true' then you will have to create your own mapgen ore.
	custom_mapgen = teibol.custom_mapgen or false,
	
	--The mapgen need this for embed the mineral.
	stone_name = teibol.stone_name or "default:stone",
	
	--The texture where the mineral will be embedded.
	stone_texture = teibol.stone_texture or "default_stone.png",
	
	--This is need for craft tools.
	stick_name = teibol.stick_name or "default:stick",
	
	--The tool power
	--If the value is > 7 then is supermetal=1
	--If the value is > 16 then is supermetal=2
	--If the value is > 25 then is supermetal=3
	--This too change the hardness of the block ore.
	toolpower = teibol.toolpower or 1,
	
	--It is used to add more decorations and other things from others modders.
	flags = teibol.flags or {},
	
	--This change the color for adapt decorations and other things from others modders.
	--This use '^[multiply'.
	flags_color = teibol.flags_color or "#FFFFFF",
	
	--If is false then it will not generate tools.
	custom_tools = teibol.custom_tools or false,
	
	--If is false then it will not generate craft tools.
	custom_craft_tools = teibol.custom_craft_tools or false,
	
	--Used for customized the groups of the ore, to harden the mineral block.
	ore_groups = teibol.groups or {cracky=1}
	
	--If you put nil or you don't put anything this the tools will have automatic durability.
	tool_durability = teibol.tool_durability or nil
	
})

´´´

## Helpers (It is used in conjunction with flags)

--If in any of 'register_node', 'register_craftitem' or 'register_tool'
--you put the corresponding definition in the description the symbol '*'
--then this will be replaced with the name of the ore that is using it.

´´´lua

aore.register_node("aore:test_node", {node_def}, "testall")

´´´

´´´lua

aore.register_craftitem("aore:test_craftitem", {craftitem_def}, "testall")

´´´

´´´lua

aore.register_tool("aore:test_tool", {tool_def}, "testall")

´´´

--If in 'register_craft' you put in the recipe/output of the definition the text 'namemod'
--this will be replaced with the name mod and the name item together, something like this 'modname:itemname'
--Useful for making crafts of the same ore. 

´´´lua

aore.register_craft("aore:test_craft", {craft_def}, "testall")

´´´

## Test (Used this in other mod path)

´´´lua

local modname = core.get_modpath(core.get_current_modname())

aore.register(modname..":test", {
	description = "Test for aore",
	main_texture = "aore_test",
	seed = 244,
	y_max = -100,
	toolpower = 12,
	stone_name = "default:stone",
	stone_texture = "default_stone.png",
	stick_name = "default:stick",
	flags = {"testall"}, --Test
	flags_hsl = "#BB8855", --Test
})

´´´