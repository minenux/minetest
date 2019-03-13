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

local db_path = core.get_modpath() .. DIR_DELIM .. ".." .. DIR_DELIM ..
	".saved_passwords"
local db = {}

-- Convert a gamedata table to a key
local function gamedata_to_key(data)
	data = data or gamedata
	return "P" .. tonumber(data.port)     .. " "
		.. data.playername:gsub(" ", "_") .. " "
		.. data.address
end

-- Convert a table key back to a gamedata table
local function key_to_gamedata(key)
	local port, name, address = key:match("^P([0-9]+) ([^ ]+) (.*)$")
	port = tonumber(port)
	if not port or port ~= port or not name or not address then return end
	return {
		address    = address,
		port       = port,
		playername = name
	}
end

-- Load the database
local function load_db()
	local f = io.open(db_path, "rb")
	if not f then return end

	local data = f:read()
	f:close()

	data = core.deserialize(data)
	if type(data) == "table" then
		db = data
		return true
	end
end

-- Save the database
local function save_db()
	local data = core.serialize(db)
	if not data then return end

	if core.safe_write_file then
		return core.safe_write_file(db_path, data)
	end

	local f = io.open(db_path, "wb")
	if not f then return end
	f:write(data)
	f:close()
	return true
end

-- Get and set passwords
function pwmgr.get_password(data)
	load_db()
	if type(data) ~= "string" then data = gamedata_to_key(data) end
	local pw = db[data]
	if type(pw) == "string" and pw ~= "" then
		return pw
	end
end

function pwmgr.set_password(data, new_pw)
	if new_pw == nil then
		if type(data) == "table" then
			new_pw = data.password
		else
			new_pw = data
		end
		new_pw = data or gamedata.password
		data   = false
	end

	load_db()
	db[gamedata_to_key(data)] = new_pw or nil
	save_db()
end

-- List passwords
function pwmgr.list_passwords()
	load_db()
	local res = {}
	for k, pw in pairs(db) do
		local data = key_to_gamedata(k)
		if data and pw then
			data.raw      = k
			data.password = pw
			res[#res + 1] = data
		end
	end
	return res
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
		core.settings:set_bool("enable_pwmgr", false)
		core.settings:write()

		-- Delete the "pwmgr" global variable
		pwmgr = nil

		-- Continue joining
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
		core.start()
		return true
	end

	return false
end

function pwmgr.prejoin(this)
	local port = tonumber(gamedata.port)
	if not port or port ~= port or gamedata.playername:find(" ") or
			gamedata.playername == "" or gamedata.address == "" or
			not gamedata.playername or not gamedata.address then
		return
	end

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

-- Wrapper
function pwmgr.display_manager(...)
	dofile(core.get_mainmenu_path() .. DIR_DELIM .. "dlg_pwmgr_manage.lua")
	return pwmgr.display_manager(...)
end
