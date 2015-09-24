local awful   = require 'awful'
local wibox   = require 'wibox'
local lain    = require 'lain'
local naughty = require 'naughty'
local alsa    = require 'alsa'
local volume  = require 'volume'
local vicious = require 'vicious'


markup = lain.util.markup

-- battery critical notification
local function trim(s)
  return s:find'^%s*$' and '' or s:match'^%s*(.*%S)'
end
local function bat_notification()
  local f_capacity = assert(io.open("/sys/class/power_supply/BAT0/capacity", "r"))
  local f_status = assert(io.open("/sys/class/power_supply/BAT0/status", "r"))
  local bat_capacity = tonumber(f_capacity:read("*all"))
  local bat_status = trim(f_status:read("*all"))
  if (bat_capacity <= 20 and bat_status == "Discharging") then
      naughty.notify({
          preset = naughty.config.presets.critical,
          text = markup.bold("Critical battery!")
      })
  end
end
if hostname == "dell" then
    battimer = timer({ timeout = 120 })
    battimer:connect_signal("timeout", bat_notification)
    battimer:start()
end

function get_genmon(script)
    local command = os.getenv("HOME") .. "/.bin/lib/genmon/" .. script .. " awesome"
    local fh = assert(io.popen(command, "r"))
    local text = fh:read("*l")
    fh:close()
    return text
end

function make_genmon(script, timeout)
    local new_widget = wibox.widget.textbox()
    new_widget:set_markup(get_genmon(script))
    local new_widget_timer = timer({ timeout = timeout })
    new_widget_timer:connect_signal("timeout",
        function() new_widget:set_markup(get_genmon(script)) end
    )
    new_widget_timer:start()
    return new_widget
end

function make_widget(widget, background_color, left, right)
    if left and right then
        local m = wibox.layout.margin(widget, left, right, 0, 0)
        local b = wibox.widget.background(m)
        b:set_bg(background_color)
        return b
    end
    local b = wibox.widget.background(widget)
    b:set_bg(background_color)
    return b
end

function lay(layout, widget, background_color, left, right)
    if widget then
        layout:add(make_widget(widget, background_color, left, right))
    end
end

-- BATTERY

if hostname == "dell" then batterywidget = make_genmon("battery.sh", 5) end

-- NETWORK

netwidget = make_genmon("net.sh", 5)

-- DROPBOX

dropboxwidget = make_genmon("dropbox.sh", 5)

-- VOLUME

volumewidget = alsa({
    timeout = 5,
    settings = function()
        if volume_now.status == "off" then
            widget:set_markup(markup.bold(markup(theme.widget_alsa_mute_fg, volume_now.level)))
        else
            widget:set_markup(markup.bold(markup(theme.widget_alsa_fg, "♫ " .. volume_now.level)))
        end
    end
})
volumewidget.widget:buttons(awful.util.table.join(
       awful.button({ }, 4, function() volume.increase() end), -- wheel up
       awful.button({ }, 5, function() volume.decrease() end), -- wheel down
       awful.button({ }, 1, function() volume.toggle()   end), -- left click
       awful.button({ }, 3, function() volume.toggle()   end)  -- right click
))

-- DATE, TIME

datewidget = lain.widgets.base({
    timeout  = 2,
    cmd      = "date +'%a, %d.%m. %H:%M'",
    settings = function()
        local t_output = ""
        local o_it = string.gmatch(output, "%S+")
        widget:set_markup(markup(theme.widget_date_fg, o_it(1) .. " " .. o_it(1)) .. " " .. markup.bold(markup(theme.widget_date_fg, o_it(1))))
    end
})
lain.widgets.calendar:attach(datewidget, { font_size = theme.widget_calendar_font_size,
                                           font = theme.widget_calendar_font,
                                           fg = theme.widget_calendar_fg,
                                           bg = theme.widget_calendar_bg,
                                           icons = "",
})

-- MPD

mpdwidget = wibox.widget.textbox()
mpdwidget:set_font(theme.widget_mpd_font)

vicious.register(mpdwidget, vicious.widgets.mpd,
    function(mpdwidget, args)
        if args["{state}"] == "Play" then
            return markup(theme.widget_mpd_fg, markup.bold(args["{Artist}"]) .. ' - ' .. args["{Title}"])
        else
            return "          "
        end
    end, 2)
mpdwidget:buttons(awful.util.table.join(
                      awful.button({ }, 1, function() awful.util.spawn("ario") end)
))

-- CPU

cpuwidget = lain.widgets.cpu({
    timeout = 2,
    settings = function()
        widget:set_markup(markup(theme.widget_cpu_fg, "CPU: " .. markup.bold(markup.bold(cpu_now.usage .. "%     "))))
    end
})

--- CPU FREQ

cpufreq1widget = wibox.widget.textbox()
vicious.register(cpufreq1widget, vicious.widgets.cpufreq, markup(theme.widget_cpu_freq_fg, "CPU0: " .. markup.bold("$2 Ghz   ")), 2, "cpu0")
cpufreq2widget = wibox.widget.textbox()
vicious.register(cpufreq2widget, vicious.widgets.cpufreq, markup(theme.widget_cpu_freq_fg, "CPU1: " .. markup.bold("$2 GHz     ")), 2, "cpu1")

-- MEM

memwidget = wibox.widget.textbox()
vicious.register(memwidget, vicious.widgets.mem, markup(theme.widget_mem_fg, "RAM: " .. markup.bold("$1%     ")), 5)

-- LOAD

loadwidget = lain.widgets.sysload({
    timeout = 2,
    settings  = function()
        widget:set_markup(markup(theme.widget_load_fg, "Load: " .. markup.bold(load_1 .. " " .. load_5 .. " " .. load_15 .. "     ")))
    end
})

-- DISK I/O

iowidget = wibox.widget.textbox()
vicious.register(iowidget, vicious.widgets.dio,
       markup(theme.widget_disk_read_fg, "read: " .. markup.bold("${sda read_mb} MB/s "))
    .. markup(theme.widget_disk_write_fg, " write: " .. markup.bold("${sda write_mb} MB/s    ")), 2)

-- NETWORK SPEED

speedwidget = lain.widgets.net({
    notify = "off",
    settings = function()
        down_speed = math.floor(tonumber(net_now.received))
        up_speed   = math.floor(tonumber(net_now.sent))
        widget:set_markup(
            markup(theme.widget_speed_down, " ↓ DL: " .. markup.bold(down_speed))
            .. " " ..
            markup(theme.widget_speed_up, " ↑ UL: " .. markup.bold(up_speed) .. "     "))
    end
})

-- CPU GRAPH

cpugraphwidget = awful.widget.graph()
cpugraphwidget:set_width(80)
cpugraphwidget:set_background_color(theme.widget_cpu_graph_bg)
cpugraphwidget:set_color(theme.widget_cpu_graph_fg)
vicious.register(cpugraphwidget, vicious.widgets.cpu, "$1")


mywibox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                        awful.button({ }, 1, awful.tag.viewonly),
                        awful.button({ }, 3, awful.tag.viewtoggle)
                    )
systembox = {}

local function systembox_hide(screen)
    systembox[screen].visible = false
end
local function systembox_show(screen)
    systembox[screen].visible = true
end

for s = 1, screen.count() do
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)
    mywibox[s] = awful.wibox({ position = theme.statusbar_position, screen = s, height = theme.statusbar_height })
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                       awful.button({ }, 1, function() awful.layout.inc(layouts,  1) end),
                       awful.button({ }, 3, function() awful.layout.inc(layouts, -1) end),
                       awful.button({ }, 4, function() awful.layout.inc(layouts,  1) end),
                       awful.button({ }, 5, function() awful.layout.inc(layouts, -1) end)))
    mylayoutbox[s]:connect_signal("mouse::enter", function() systembox_show(mouse.screen) end)
    mylayoutbox[s]:connect_signal("mouse::leave", function() systembox_hide(mouse.screen) end)

    -- layouts

    local layout1 = wibox.layout.fixed.horizontal()
    lay(layout1, mylayoutbox[s])
    lay(layout1, mpdwidget, theme.bg_normal, 0, 6)

    local layout2 = wibox.layout.fixed.horizontal()
    lay(layout2, mytaglist[s])

    local layout3 = wibox.layout.fixed.horizontal()
    lay(layout3, dropboxwidget, theme.bg_normal, 0, 8)
    lay(layout3, volumewidget,  theme.bg_normal, 0, 8)
    lay(layout3, batterywidget, theme.bg_normal, 0, 8)
    lay(layout3, datewidget,    theme.bg_focus,  8, 8)

    -- build status bar

    local layout = wibox.layout.align.horizontal()
    layout:set_expand("none")
    layout:set_left(layout1)
    layout:set_middle(layout2)
    layout:set_right(layout3)

    mywibox[s]:set_widget(layout)

    -- SYSTEM BOX

    local systembox_position = "bottom"
    if theme.statusbar_position == "bottom" then systembox_position = "top" end
    systembox[s] = awful.wibox({ position = systembox_position, screen = s, height = theme.statusbar_height })

    local systembox_layout_1 = wibox.layout.fixed.horizontal()
    lay(systembox_layout_1, netwidget)
    lay(systembox_layout_1, speedwidget)
    lay(systembox_layout_1, iowidget)
    lay(systembox_layout_1, memwidget)

    local systembox_layout_2 = wibox.layout.fixed.horizontal()
    lay(systembox_layout_2, loadwidget)
    lay(systembox_layout_2, cpufreq1widget)
    lay(systembox_layout_2, cpufreq2widget)
    lay(systembox_layout_2, cpuwidget)
    lay(systembox_layout_2, cpugraphwidget)
    lay(systembox_layout_2, wibox.widget.systray())

    local systembox_align_left = wibox.layout.align.horizontal()
    systembox_align_left:set_left(systembox_layout_1)
    local systembox_align_right = wibox.layout.align.horizontal()
    systembox_align_right:set_right(systembox_layout_2)

    local systembox_layout_full = wibox.layout.flex.horizontal()
    systembox_layout_full:add(systembox_align_left)
    systembox_layout_full:add(systembox_align_right)
    systembox[s]:set_widget(systembox_layout_full)
    systembox[s].visible = false
end
