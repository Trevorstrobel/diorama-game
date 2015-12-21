--------------------------------------------------
local BreakMenuItem = require ("resources/scripts/menus/menu_items/break_menu_item")
local ButtonMenuItem = require ("resources/scripts/menus/menu_items/button_menu_item")
local Menus = require ("resources/scripts/menus/menu_construction")
local MenuClass = require ("resources/scripts/menus/menu_class")
local Mixin = require ("resources/scripts/menus/mixin")

--------------------------------------------------
local function onCreateNewLevelClicked ()
	return "create_new_level_menu"
end

--------------------------------------------------
local function onLoadLevelClicked ()
	return "load_level_menu"
end

--------------------------------------------------
local function onEditPlayerControlsClicked ()
	return "player_controls_menu"
end

--------------------------------------------------
local c = {}

--------------------------------------------------
function c:onAppShouldClose ()
	self.parent.onAppShouldClose (self)
	return "quitting_menu"
end

--------------------------------------------------
function c:onEnter ()
	-- if not self.isDemoSessionAlive then
	-- 	dio.session.requestBegin (({path = "my_world", shouldSave = false}))
	-- 	self.isDemoSessionAlive = true
	-- end
end

--------------------------------------------------
function c:onExit ()
	-- dio.session.terminate ()
end

--------------------------------------------------
return function ()

	local instance = MenuClass ("MAIN MENU")

	local properties = 
	{
		isDemoSessionAlive = false
	}

	Mixin.CopyTo (instance, properties)
	Mixin.CopyToAndBackupParents (instance, c)

	instance:addMenuItem (ButtonMenuItem ("New Level", onCreateNewLevelClicked))
	instance:addMenuItem (BreakMenuItem ())
	instance:addMenuItem (ButtonMenuItem ("Load Level", onLoadLevelClicked))
	instance:addMenuItem (BreakMenuItem ())
	instance:addMenuItem (ButtonMenuItem ("Edit Player Controls", onEditPlayerControlsClicked))

	return instance
end
