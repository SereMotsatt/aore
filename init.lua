aore = {}
aore.ver = 20251129
aore.registered = {}

aore.settings = core.settings

modpath = core.get_modpath("aore")

--LoadAPI--
dofile(modpath .. "/api.lua")


aore.register_node("aore:test_node", {
	description = "* test",
	tiles = {"aore_test_block.png"},
	groups = {supermetal=2},
}, "testall")

aore.register_node("aore:test_egg", {
	description = "* egg test",
	tiles = {"aore_test_block.png"},
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.45,-0.5,-0.45,0.45,0.0,0.45},
			{-0.35,0.0,-0.35,0.35,0.35,0.35},
			{-0.25,0.15,-0.25,0.25,0.5,0.25},
		},
	},
	groups = {supermetal=2},
})

print("[AORE v"..aore.ver.."] has been loaded.")