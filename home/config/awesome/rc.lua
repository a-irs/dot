pcall(require, "luarocks.loader")

-- do not use dbus interface for notifications (using other notification daemon)
local _dbus = dbus; dbus = nil
local naughty    = require 'naughty'
dbus = _dbus

local awful      = require 'awful'
local gears      = require 'gears'
local lain       = require 'lain'
local xresources = require('beautiful').xresources
local beautiful  = require 'beautiful'

hostname        = awesome.hostname
is_mobile       = hostname:find("^x1") ~= nil

-- re-set wallpaper after awesomewm reload
awful.spawn("nitrogen --restore", false)

function dpi(value)
    return math.floor(xresources.apply_dpi(value) + 0.5)
end

beautiful.init(gears.filesystem.get_configuration_dir () .. "theme.lua")

require 'awm-notify-settings'

-- error handling
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Errors during startup!",
                     text = awesome.startup_errors })
end

do
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "An error happened!",
                         text = err })
        in_error = false
    end)
end


function dbg(text)
    naughty.notify({ text = text, timeout = 0 })
end

function dbg_crit(text)
    naughty.notify({ preset = naughty.config.presets.critical, text = text, timeout = 0 })
end

--- battery critical notification
local function trim(s)
    return s:find'^%s*$' and '' or s:match'^%s*(.*%S)'
end
-- local function bat_notification()
--     local f_capacity = assert(io.open("/sys/class/power_supply/BAT0/capacity", "r"))
--     local f_status = assert(io.open("/sys/class/power_supply/BAT0/status", "r"))
--     local bat_capacity = tonumber(f_capacity:read("*all"))
--     local bat_status = trim(f_status:read("*all"))
--     if (bat_capacity <= 5 and bat_status == "Discharging") then
--         naughty.notify({
--             preset = naughty.config.presets.critical,
--             text = lain.util.markup.bold("Critical battery!")
--         })
--     end
-- end
-- if is_mobile then
--     battimer = timer({ timeout = 120 })
--     battimer:connect_signal("timeout", bat_notification)
--     battimer:start()
-- end

require 'awm-layouts'
require 'awm-tags'
require 'awm-bindings'
require 'awm-statusbar'
require 'awm-rules'

-- toggle tag1, tag2 on startup (to make initial win+tab possible)
local tag = awful.screen.focused().tags[1]
local tag2 = awful.screen.focused().tags[2]
if tag2 then tag2:view_only() end
if tag then tag:view_only() end
