title = 'PvP Areas mod for Minetest'
project = 'PvP Areas'
description = "Mod that allows PvP in specified areas of map only."
format = 'markdown'
not_luadoc = true
wrap = true
--boilerplate = true
ignore = true
output = 'api'


-- Custom tags
new_type('chatcmd', 'Chat Commands', false, 'param')
new_type('item', 'Items', false)
custom_tags = {
	-- Optional chat command parameter
	{'cparam',
		title = 'Parameters',
	},
	{'texture',
		title = 'Image',
	},
}

alias('rcparam', 'cparam')

-- Functions

local function chatcmd_handler(item)
	local output = item.name
	if item.tags.cparam ~= nil then
		for i, p in ipairs(item.tags.cparam) do
			local left = ' ['
			local right = ']'
			if item.tags.rcparam ~= nil then
				left = ' &lt;'
				right = '&gt;'
			end
			output = output .. left .. p .. right
		end
	end
	--[[
	if item.tags.rcparam ~= nil then
		for i, p in ipairs(item.tags.rcparam) do
			output = output .. ' &lt;' .. p .. '&gt;'
		end
	end
	]]

	return output
end

local function item_handler(item)
	return item.name
end

function custom_display_name_handler(item, default_handler)
	if item.type == 'chatcmd' then
		return chatcmd_handler(item)
	elseif item.type == 'item' then
		return item_handler(item)
	end

	return default_handler(item)
end
