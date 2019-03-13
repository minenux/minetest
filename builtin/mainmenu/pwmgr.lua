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

pwmgr = {}

local db = Settings(core.get_modpath() .. DIR_DELIM .. ".." .. DIR_DELIM ..
	".saved_passwords")

-- Convert to/from the weird .conf-safe format
local function conf_escape(text)
	local res = tostring(text):gsub("[^A-Za-z0-9]", function(char)
		return "_" .. string.byte(char) .. "_"
	end)
	return res
end

local function conf_unescape(text)
	local res = text:gsub("_[0-9]+_", function(esc)
		return string.char(tonumber(esc:sub(2, #esc - 1))) or esc
	end)
	return res
end

-- Get a config entry name
local function get_conf_entry(data)
	data = data or gamedata
	return "pwmgr.plaintext"
		.. "." .. conf_escape(data.address)
		.. "." .. conf_escape(data.port)
		.. "." .. conf_escape(data.playername or data.name)
end

-- Get and set passwords
function pwmgr.get_password(data)
	local pw = db:get(get_conf_entry(data))
	if type(pw) ~= "string" or pw == "" then
		return
	else
		return conf_unescape(pw)
	end
end

function pwmgr.set_password(data, new_pw)
	if not new_pw then
		if type(data) == "table" then
			new_pw = data.password
		else
			new_pw = data
		end
		new_pw = data or gamedata.password
		data   = false
	end
	db:set(get_conf_entry(data), conf_escape(new_pw))
	db:write()
end

-- Get the disable confirmation dialog
local function get_disable_confirm_formspec()
	return "size[10,2.75,true]" ..
			"label[0.5,0.5;Disable the password manager?\n"
				.. "You can re-enable it at any time in \"All Settings\".]" ..
			"button[0.5,2;2.5,0.5;pwd_confirm_disable;" .. fgettext("Disable")
				.. "]" ..
			"button[7,2;2.5,0.5;pwd_back;" .. fgettext("Cancel") .. "]"
end

local function get_disable_confirm_buttonhandler(this, fields)
	if fields.pwd_confirm_disable then
		-- Don't load pwmgr later
		core.settings:set_bool("pwmgr.enable", false)
		core.settings:write()

		-- Delete the "pwmgr" global variable
		pwmgr = nil

		-- Delete the dialogs
		this:delete()
		this.parent:delete()
		core.start()
		return true
	end

	if fields.pwd_back then
		this:delete()
		return true
	end
end

-- Get the "Should this password be saved?" formspec
local function get_prejoin_formspec()
	local msg = "Should this password be saved (in plaintext)?\n"
		.. "\nAddress: "  .. gamedata.address
		.. "\nPort: "     .. gamedata.port
		.. "\nName: "     .. gamedata.playername
		.. "\nPassword: " .. string.rep("*", #gamedata.password)

	return "size[10,5,true]" ..
		"label[0.5,0.5;Password manager]" ..
		"label[0.5,1;" .. core.formspec_escape(msg) .. "]" ..
		"button[1,4;2,1;pwd_cancel;< Cancel]" ..
		"button[3,4;2,1;pwd_disable;Never]" ..
		"button[5,4;2,1;pwd_no_save;Don't save]" ..
		"button[7,4;2,1;pwd_save;Save >]"
end

local function get_prejoin_buttonhandler(this, fields)
	if fields.pwd_cancel then
		this:delete()
		return true
	end

	if fields.pwd_disable then
		local dlg = dialog_create("pwmgr_confirm_disable",
					get_disable_confirm_formspec,
					get_disable_confirm_buttonhandler,
					nil)
		dlg:set_parent(this)
		this:hide()
		dlg:show()
		return true
	end

	if fields.pwd_save then
		pwmgr.set_password()
	end

	if fields.pwd_save or fields.pwd_no_save then
		this:delete()
		core.start()
		return true
	end

	return false
end

function pwmgr.prejoin(this)
	if not gamedata.password or gamedata.password == "" then
		gamedata.password = pwmgr.get_password()
		if not gamedata.password or gamedata.password == "" then
			return true
		end
	elseif this then
		local dlg = dialog_create("pwmgr_save_password",
					get_prejoin_formspec,
					get_prejoin_buttonhandler,
					nil)
		dlg:set_parent(this)
		this:hide()
		dlg:show()
		return true
	end
end
