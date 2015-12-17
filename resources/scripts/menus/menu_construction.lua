--------------------------------------------------
local m = {}

--------------------------------------------------
function m.addLabel (menu, text)

	local label = 
	{
		text = text,
		x = 0,
		y = menu.next_y
	}

	menu.next_y = menu.next_y + 10
	table.insert (menu.items, label)

	return label
end

--------------------------------------------------
function m.addCheckbox (menu, text, onClicked, is_checked)

	local function decorateText (text, is_checked)
		if is_checked then
			return text .. "           [X]"
		else
			return text .. "           [   ]"
		end
	end

	local checkbox = 
	{
		decorateText = decorateText,
		is_checked = is_checked,
		text_original = text,
		text_unfocused = "  " .. decorateText (text, is_checked) .. "  ",
		text_focused = "[ " .. decorateText (text, is_checked) .. " ]",
		text = "  " .. decorateText (text) .. "  ",
		x = 100,
		y = menu.next_y,
		width = 200,
		height = 10,
		onClicked = function (self) 
			self:setIsChecked (not self.is_checked)
			onClicked (self)
		end,
		setIsChecked = function (self, is_checked)
			self.is_checked = is_checked
			self.text_unfocused = "  " .. self.decorateText (self.text_original, self.is_checked) .. "  "
			self.text_focused = "[ " .. self.decorateText (self.text_original, self.is_checked) .. " ]"
			self.text = "  " .. decorateText (text) .. "  "
		end
	}

	menu.next_y = menu.next_y + 10
	table.insert (menu.items, checkbox)

	return checkbox
end

--------------------------------------------------
function m.addKeyEntry (menu, text, onClicked, initial_key)

	local function decorateText (text, initial_key)
		return text .. "           [" .. initial_key .. "]"
	end

	local key_entry = 
	{
		decorateText = decorateText,
		initial_key = initial_key,
		text_original = text,
		text_unfocused = "  " .. decorateText (text, initial_key) .. "  ",
		text_focused = "[ " .. decorateText (text, initial_key) .. " ]",
		text = "  " .. decorateText (text, initial_key) .. "  ",
		x = 100,
		y = menu.next_y,
		width = 200,
		height = 10,
		onClicked = function (self) 
			if onClicked then
				onClicked (self)
			end
		end,
	}

	menu.next_y = menu.next_y + 10
	table.insert (menu.items, key_entry)

	return key_entry
end

--------------------------------------------------
function m.addEventListener (menu, event, onFired)
	menu.events [event] = onFired
end

--------------------------------------------------
return m
