--------------------------------------------------
local BreakMenuItem = require ("resources/scripts/menus/menu_items/break_menu_item")
local ButtonMenuItem = require ("resources/scripts/menus/menu_items/button_menu_item")
local LabelMenuItem = require ("resources/scripts/menus/menu_items/label_menu_item")
local Menus = require ("resources/scripts/menus/menu_construction")
local MenuClass = require ("resources/scripts/menus/menu_class")
local Mixin = require ("resources/scripts/menus/mixin")
local Paint = require ("resources/scripts/menus/paint/paint_app")

--------------------------------------------------
local function onUsePaintClicked(menuItem, menu)
    menu.paint = Paint (menu)
    menu.paint:startApp ()
end

--------------------------------------------------
local function onMainMenuClicked()
    return "main_menu"
end

--------------------------------------------------
local c = {}

--------------------------------------------------
function c:onEnter ()
end

--------------------------------------------------
function c:onExit ()
    self.paint = nil
end

--------------------------------------------------
function c:onUpdate (x, y, was_left_clicked)
    if self.paint then
		self.paint:update (x, y, was_left_clicked)
	else
		return self.parent.onUpdate (self, x, y, was_left_clicked)
	end
end

--------------------------------------------------
function c:onKeyClicked (keyCode, keyCharacter, keyModifiers, menus)
	if self.paint then
		self.paint:onKeyClicked (keyCode, keyCharacter, keyModifiers, menus)
	end
end

--------------------------------------------------
function c:onRender ()
    if self.paint then
        self.paint:render ()
    else
        return self.parent.onRender (self)
    end
end

--------------------------------------------------
function c:recordAppClose ()
    self.paint = nil
end

--------------------------------------------------
return function()
	local instance = MenuClass ("Paint Menu")

	local properties =
	{
        paint = nil,
	}

	Mixin.CopyTo (instance, properties)
	Mixin.CopyToAndBackupParents (instance, c)

	instance:addMenuItem (ButtonMenuItem ("Paint", onUsePaintClicked))
	instance:addMenuItem (BreakMenuItem ())
	instance:addMenuItem (ButtonMenuItem ("Return To Main Menu", onMainMenuClicked))
	instance:addMenuItem (BreakMenuItem ())

	return instance
end
