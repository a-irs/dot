local awful   = require 'awful'
local rules   = require 'awful.rules'
local wibox   = require 'wibox'
local lain    = require 'lain'
local naughty = require 'naughty'
local volume  = require 'volume'
local gears   = require 'gears'

local markup = lain.util.markup

local function bg_wrap(widget, color, left, right)
    return wibox.widget {
        {
            widget,
            left   = left,
            right  = right,
            widget = wibox.container.margin
        },
        bg         = color,
        widget     = wibox.container.background
    }
end

-- BATTERY

if is_mobile then
    batterywidget = lain.widget.bat({
        timeout = 10,
        notify = "off",
        battery = "BAT0",
        settings = function()
            perc = tonumber(bat_now.perc)
            if perc == nil then
                widget:set_markup(bat_now.perc)
            end
            if perc > 100 then
                perc = 100
            end
            if perc <= 5 then
                color = "#fa7883"
            elseif perc <= 20 then
                color = "#ffff00"
            elseif perc <= 35 then
                color = "#ffffff"
            else
                color = "#90ee90"
            end

            charg = ''
            if bat_now.status == "Full" or bat_now.status == "Charging" then
                charg = markup("#ffff00", ' +')
            end

            if bat_now.status == "Full" or bat_now.time == "00:00" then
                widget:set_markup(markup.bold(markup(color, perc .. charg)))
            else
                -- widget:set_markup(markup.bold(markup(color, perc .. charg)) .. " " .. bat_now.time)
                widget:set_markup(markup.bold(markup(color, perc .. charg)))
            end
        end
    })
    batterywidget_t = awful.tooltip({
        objects = { batterywidget.widget },
        timer_function = function()
            local handle = io.popen(gears.filesystem.get_configuration_dir() .. "/statusbar/battery-tooltip")
            local result = handle:read("*a")
            handle:close()
            return result
        end,
        timeout = 1,
    })
    batterywidget_wrap = bg_wrap(batterywidget.widget, theme.widget_battery_bg, theme.statusbar_margin, theme.statusbar_margin)
end


-- NETWORK

if is_mobile then
    netwidget = awful.widget.watch(
        gears.filesystem.get_configuration_dir() .. "/statusbar/net",
        3,
        function(widget, stdout)
            widget:set_markup(stdout)
        end
    )
    netwidget_t = awful.tooltip({
        objects = { netwidget },
        timer_function = function()
            local handle = io.popen(gears.filesystem.get_configuration_dir() .. "/statusbar/net-tooltip")
            local result = handle:read("*a")
            handle:close()
            return result
        end,
        timeout = 2,
    })
    netwidget:buttons(awful.util.table.join(
        awful.button({ }, 1, function()
            awful.spawn(os.getenv("HOME") .. "/.bin/menu-vpn", false)
        end)
    ))
    netwidget_wrap = bg_wrap(netwidget, theme.widget_music_bg, theme.statusbar_margin, theme.statusbar_margin)
end

-- DOWNLOAD STATUS

-- if not is_mobile then
--     dlwidget = awful.widget.watch(
--         gears.filesystem.get_configuration_dir() .. "/statusbar/dl-status.py", 2,
--         function(widget, stdout)
--             widget:set_markup(stdout)
--         end
--     )
-- end


-- MUSIC

local musicwidget = awful.widget.watch(
    gears.filesystem.get_configuration_dir() .. "/statusbar/music.sh " .. theme.widget_music_fg:gsub('#', ''), 2,
    function(widget, stdout)
        if stdout == "" then
            widget:set_markup("")
        else
            widget:set_markup(stdout)
        end
    end
)
musicwidget_wrap = bg_wrap(musicwidget, theme.widget_music_bg, 0, 0)

local timewarriorwidget, timewarriorwidget_timer = awful.widget.watch(
    "timew", 10,
    function(widget, stdout)
        color = theme.widget_pulse_fg_mute
        if string.match(stdout, "no active time tracking") then
            widget:set_markup(markup.bold(markup(color, "")))
        else
            tags = string.match(stdout, "Tracking (.*)")
            tags = string.gsub(tags, "\"", "")
            time = string.match(stdout, "Total %s+(%g+)")
            time = string.gsub(time, "^0:", "")
            widget:set_markup(
                markup.bold(markup("#ff79c6", time)) .. " " ..
                markup.bold(markup("#d7d7d7", tags))
            )
        end
    end
)
timewarriorwidget_wrap = bg_wrap(timewarriorwidget, theme.bg_normal, 10, 10)


-- VOLUME

audiowidget, audiowidget_timer = awful.widget.watch(
    "sh -c 'pactl get-sink-volume @DEFAULT_SINK@; pactl get-sink-mute @DEFAULT_SINK@'",
    5, -- timeout
    function(widget, stdout)
        local volume = string.match(stdout, "(%d+)%%")
        local mute = string.match(stdout, "Mute: (%S+)")

        local limit = 100
        if is_mobile then
            limit = 120
        end

        if tonumber(volume) == nil then
            widget:set_markup("no audio")
            return
        end
        local volume_rounded = math.floor((volume) / 5 + 0.5) * 5
        local color_fg = theme.widget_pulse_fg
        local color_bg = theme.widget_pulse_bg

        if mute =="yes" then
            if volume_rounded >= limit then
                color_fg = theme.widget_pulse_fg_mute
                color_bg = theme.widget_pulse_bg_crit
            else
                color_fg = theme.widget_pulse_fg_mute
                color_bg = theme.widget_pulse_bg_mute
            end
        elseif volume_rounded >= limit then
            color_fg = theme.widget_pulse_fg_crit
            color_bg = theme.widget_pulse_bg_crit
        end

        widget:set_markup(markup.bold(markup(color_fg, volume_rounded)))
        audiowidget_wrap:set_bg(color_bg)
    end
)
audiowidget:buttons(awful.util.table.join(
    awful.button({ }, 4, function() volume.increase() end), -- wheel up
    awful.button({ }, 5, function() volume.decrease() end), -- wheel down
    awful.button({ }, 1, function() volume.toggle()   end), -- left click
    awful.button({ }, 3, function() -- right click
        local matcher = function(c)
            return rules.match(c, {class = 'Pavucontrol'})
        end
        awful.client.run_or_raise('pavucontrol', matcher)
    end)
))
audiowidget_wrap = bg_wrap(audiowidget, theme.widget_pulse_bg, theme.statusbar_margin, theme.statusbar_margin)

-- DATE, TIME

datewidget = wibox.widget.textclock(markup(theme.widget_date_fg, '%a, %d.%m.'))
timewidget = wibox.widget.textclock(markup.bold(markup(theme.widget_time_fg, '%H:%M')), 10)
lain.widget.cal({
    attach_to = { timewidget, datewidget },
    notification_preset = {
        font = "InputMonoCondensed 8",
        fg   = theme.fg_focus,
        bg   = theme.bg_focus
    }
})
datewidget_wrap = bg_wrap(datewidget, theme.widget_date_bg, theme.statusbar_margin, 0)
timewidget_wrap = bg_wrap(timewidget, theme.widget_time_bg, theme.statusbar_margin, theme.statusbar_margin)


local taglist_buttons = awful.util.table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end)
    )

local tasklist_buttons = awful.util.table.join(
    awful.button({ }, 1, function (c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal(
                "request::activate",
                "tasklist",
                {raise = true}
            )
        end
end))

awful.screen.connect_for_each_screen(function(s)
    s.myprompt = awful.widget.prompt()
    s.myprompt_wrap = bg_wrap(s.myprompt, nil, theme.statusbar_margin, theme.statusbar_margin)

    s.mytasklist = awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.minimizedcurrenttags,
        buttons = tasklist_buttons,
        style = {
            fg_normal = theme.tasklist_fg,
            bg_normal = theme.tasklist_bg,
            font = theme.tasklist_font
        }
    }

    s.mytaglist  = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    systray_wrap = bg_wrap(wibox.widget.systray(), nil, theme.statusbar_margin, theme.statusbar_margin)

    -- layouts

    local layout1 = wibox.layout.fixed.horizontal()
    layout1:add(timewarriorwidget_wrap)
    layout1:add(musicwidget_wrap)
    layout1:add(s.mytasklist)
    layout1:add(s.myprompt_wrap)
    -- if not is_mobile then
    --     layout1:add(dlwidget)
    -- end

    local layout2 = wibox.layout.fixed.horizontal()
    layout2:add(s.mytaglist)

    local layout3 = wibox.layout.fixed.horizontal()
    layout3:add(systray_wrap)
    layout3:add(audiowidget_wrap)
    if is_mobile then
        layout3:add(batterywidget_wrap)
        layout3:add(netwidget_wrap)
    end
    layout3:add(datewidget_wrap)
    layout3:add(timewidget_wrap)


    -- build status bar

    local layout = wibox.layout.align.horizontal()
    layout:set_expand("none")
    layout:set_left(layout1)
    layout:set_middle(layout2)
    layout:set_right(layout3)

    if theme.statusbar_top_pixel then
        awful.wibar({ position = "top", screen = s, height = 1, bg = theme.statusbar_top_pixel })
    end
    awful.wibar({ position = "top", screen = s, height = theme.statusbar_height }):set_widget(layout)

    -- only add bottom statusbar if it has its own (non-border) color
    if theme.statusbar_bottom_pixel ~= theme.border_focus or theme.statusbar_bottom_pixel ~= theme.border_normal then
        awful.wibar({ position = "top", screen = s, height = 1, bg = theme.statusbar_bottom_pixel })
    end
end)
