--
-- Minetest password manager
--
-- © Copyright 2019 by luk3yx.
--
-- This program is free software; you can redistribute it and/or modify
-- it under the terms of the GNU Lesser General Public License as published by
-- the Free Software Foundation; either version 2.1 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU Lesser General Public License for more details.
--
-- You should have received a copy of the GNU Lesser General Public License
-- along with this program; if not, write to the Free Software Foundation, Inc.,
-- 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
--

-- The confirm delete dialog
local search, selected_item
local raw_entries = {}
local function get_delete_formspec()
	local entry = assert(raw_entries[selected_item])
	local addr  = core.formspec_escape(entry.address)
	local name  = core.formspec_escape(entry.playername)
	return "size[10,2.75,true]" ..
			"label[0.5,0.5;Delete the saved password for \"" .. name .. "\""
				.. "on \"" .. addr .. ":" .. entry.port .. "\"?]" ..
			"button[0.5,2;2.5,0.5;pwd_delete;" .. fgettext("Delete")
				.. "]" ..
			"button[7,2;2.5,0.5;pwd_back;" .. fgettext("Cancel") .. "]"
end

local function get_delete_buttonhandler(this, fields)
	if fields.pwd_back then
		this:delete()
		return true
	end

	if fields.pwd_delete then
		pwmgr.set_password(raw_entries[selected_item], false)
		this:delete()
		selected_item = 0
		return true
	end
end

-- The actual manager
-- A lot of this was copied from dlg_settings_advanced.lua.
local function get_mgr_formspec()
	local formspec = "size[12,6.5;true]" ..
			"label[0.125,0;Saved passwords]" ..
			"field[0.3,1.1;10.2,1;search_string;;" .. core.formspec_escape(search) .. "]" ..
			"field_close_on_enter[search_string;false]" ..
			"button[10.2,0.8;2,1;search;" .. fgettext("Search") .. "]" ..
			"textlist[0,1.8;12,3.5;accounts_list;"

	-- Compile a list of servers
	raw_entries = {}
	local entries = {}
	for _, data in ipairs(pwmgr.list_passwords()) do
		data.password = nil
		data.raw      = nil
		local match = false
		if search == "" then
			match = true
		else
			for k, v in pairs(data) do
				if tostring(v):lower():find(search, nil, true) then
					match = true
					break
				end
			end
		end

		if match then
			local msg = data.playername .. " on " .. data.address .. ":"
				.. data.port
			entries[#entries + 1] = core.formspec_escape(msg)
			raw_entries[#raw_entries + 1] = data
		end
	end

	-- Finish the formspec
	formspec = formspec .. table.concat(entries, ",") .. ";"
			.. selected_item .. ";true]" ..
		"button[0,6;4,1;btn_back;".. fgettext("< Back to Settings page") .. "]" ..
		"button[10,6;2,1;btn_delete;" .. fgettext("Delete") .. "]"

	return formspec
end

function get_mgr_buttonhandler(this, fields)
	if fields.btn_back then
		this:delete()
		return true
	end

	if fields.accounts_list then
		local event = core.explode_textlist_event(fields.accounts_list)
		if event.type == "CHG" then
			selected_item = event.index
		end
		return
	end

	if fields.btn_delete and raw_entries[selected_item] then
		local dlg = dialog_create("pwmgr_confirm_delete",
					get_delete_formspec,
					get_delete_buttonhandler,
					nil)
		dlg:set_parent(this)
		this:hide()
		dlg:show()
		return true
	end

	if fields.search or fields.key_enter_field == "search_string" then
		if fields.search_string ~= search then
			search = (fields.search_string or ""):lower()
			return true
		end
	end
end

function pwmgr.display_manager(this)
	search = ''
	selected_item = 1
	local dlg = dialog_create("pwmgr_manager",
				get_mgr_formspec,
				get_mgr_buttonhandler,
				nil)
	dlg:set_parent(this)
	this:hide()
	dlg:show()
	return true
end
