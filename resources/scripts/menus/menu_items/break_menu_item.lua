--------------------------------------------------
local MenuItemBase = require ("resources/scripts/menus/menu_items/menu_item_base")
local Mixin = require ("resources/scripts/menus/mixin")

--------------------------------------------------
return function ()
	local instance = 
	{
		text = "******************************************"
	}

	Mixin.CopyTo (instance, MenuItemBase ())

	return instance
end
