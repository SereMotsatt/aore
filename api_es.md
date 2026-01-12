
# Aore API (API avanzada de mineral)


## Principal
´´´lua
aore.register(namemod, {
	--Descripción de el mineral, es la description principal de todo.
	description = teibol.description or namemod, 
	
	--Semilla de la generación del mapa, Solo si 'custom_mapgen = false or nil'.
	seed = teibol.seed or 15,
	
	--Si 'main_texture' es "default_stone" entonces "default_stone_pick.png", "default_stone_ore.png"...
	main_texture = teibol.main_texture or "noexist",
	
	--Usado para la generación del mapa, Solo si 'custom_mapgen = false or nil'.
	y_min = teibol.y_min or -31000,
	
	--Usado para la generación del mapa, Solo si 'custom_mapgen = false or nil'.
	y_max = teibol.y_max or 0,
	
	--Si 'custom_mapgen == true' entonces usted tendrá que crear su propia generación del mineral.
	custom_mapgen = teibol.custom_mapgen or false,
	
	--La generación del mapa necesita esto para incrustar el mineral.
	stone_name = teibol.stone_name or "default:stone",
	
	--La textura donde el mineral se incrustará.
	stone_texture = teibol.stone_texture or "default_stone.png",
	
	--Esto es necesario para construir las herramientas.
	stick_name = teibol.stick_name or "default:stick",
	
	--El poder de la herramientas
	--Si el valor es > 7 entonces es supermetal=1
	--Si el valor es > 16 entonces es supermetal=2
	--Si el valor es > 25 entonces es supermetal=3
	--Esto tambien cambia la dureza del bloque de mineral.
	toolpower = teibol.toolpower or 1,
	
	--Esto es usado para añadir mas decoraciónes y otras cosas de otros creadores.
	flags = teibol.flags or {},
	
	--Esto cambia el color para adaptar decoraciónes y otras cosas de otros creadores.
	--Esto usa '^[multiply'.
	flags_color = teibol.flags_color or "#FFFFFF",
	
	--Si es falso entonces no se generarán herramientas.
	custom_tools = teibol.custom_tools or false,
	
	--Si es falso entonces no se generarán construcciónes de herramientas.
	custom_craft_tools = teibol.custom_craft_tools or false,
	
	--Usado para customizar los grupos del bloque de mineral natural, Para endurecer el bloque de mineral natural.
	ore_groups = teibol.groups or {cracky=1}
	
	--Si lo dejas en nil entonces las herramientas tendrán una durabilidad automatica.
	tool_durability = teibol.tool_durability or nil
	
})
´´´

## Ayudantes (Esto es usado junto con las flags)

--Si en cualquiera de 'register_node', 'register_craftitem' o 'register_tool' 
--pones en la description de la definición correspondiente el simbolo '*'
--entonces este se remplazará con el nombre del mineral que lo esté usando.
´´´lua
aore.register_node("aore:test_node", {node_def}, "testall")
´´´
´´´lua
aore.register_craftitem("aore:test_craftitem", {craftitem_def}, "testall")
´´´
´´´lua
aore.register_tool("aore:test_tool", {tool_def}, "testall")
´´´
--Si en 'register_craft' pones en el recipiente o la salida de la definición el texto 'namemod'
--este se remplazará con el nombre del mod y el nombre del ítem juntos, algo asi 'modname:itemname'
--útil para hacer construcciónes del mismo mineral.
´´´lua
aore.register_craft("aore:test_craft", {craft_def}, "testall")
´´´

## Prueba (Usa esto en otra carpeta de mod)
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
	flags_color = "#BB8855", --Test
})
´´´