local awful     = require 'awful'
                  require 'awful.autofocus'
local wibox     = require 'wibox'
local gears     = require 'gears'
local naughty   = require 'naughty'

function is_empty(tag)
    if tag == nil then return true end
    return #tag:clients() == 0
end

awful.rules.rules = {

    { rule = { },
      properties = { border_width = theme.border_width,
                     border_color = theme.border_normal,
                     focus = awful.client.focus.filter,
                     screen = awful.screen.preferred,
                     placement = awful.placement.centered + awful.placement.no_offscreen,
                     honor_workarea = true,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     maximized = false,
                     maximized_vertical = false,
                     maximized_horizontal = false },
      callback = awful.client.setslave },

    { rule_any = {
        class = { "mpv", "Emacs", "Solaar" }
    },
        properties = { size_hints_honor = false }
    },

    {
        rule = { class = "firefox" },
        properties = { maximized = false, floating = false }
    },

    { rule_any = {
        class = { "Steam" }
    },
        properties = {
            titlebars_enabled = false,
            floating = true,
            border_width = 0,
            border_color = 0,
            size_hints_honor = false
        }
    },

    { rule_any = {
        name = {"Software Keyboard"},
        class = {"Kodi", "steam_app_.*"}
    },
        properties = { fullscreen = true, placement = awful.placement.restore, titlebars_enabled = false, size_hints_honor = false, border_width = 0 }
    },

    { rule_any = {
        instance = { "pinentry" },
        class = { "Arandr", "Gpick", "pinentry", "Lampe-gtk", "KeePassXC", "Event Tester", "Blueman-manager", "Pavucontrol" },
        role = { "AlarmWindow", "ConfigManager", "pop-up" }
    },
        properties = { floating = true, titlebars_enabled = true }
    },

    -- Add titlebars to dialogs
    { rule_any = {type = { "dialog" }
      }, properties = { floating = true, titlebars_enabled = true }
    },

    { class = { "Kupfer.py" }, properties = { floating = true, titlebars_enabled = false }
    },
}

-- automatically focusing back to the previous client on window close (unmanage) or minimize.
-- https://github.com/basaran/awesomewm-backham
local function backham()
    local s = awful.screen.focused()
    local c = awful.client.focus.history.get(s, 0)
    if c then
        client.focus = c
        c:raise()
    end
end
client.connect_signal("property::minimized", backham)
client.connect_signal("unmanage", backham)
tag.connect_signal("property::selected", backham)

local function make_name(existing_clients, client, wanted_name)
    if client.minimized then
        wanted_name = "[" .. wanted_name .. "]"
    elseif client.fullscreen then
        wanted_name = wanted_name .. "^"
    elseif client.floating then
        wanted_name = "(" .. wanted_name .. ")"
    end

    if client.machine and client.machine ~= hostname then
        wanted_name = wanted_name .. " [" .. client.machine .. "]"
    end

    if existing_clients == nil or existing_clients == "" then
        return wanted_name
    else
        return existing_clients .. ", " .. wanted_name
    end
end

local function dynamic_tagging()
    awful.screen.connect_for_each_screen(function(s)
        for _, t in ipairs(s.tags) do
            if is_empty(t) then
                t.name = " " .. theme.taglist_empty_tag .. " "
            else
                local name = ""
                for _, c in ipairs(t:clients()) do
                    if c.name and string.find(c.name, '(Private Browsing)') then
                        name = make_name(name, c, "web[*]")
                    elseif c.name and string.find(c.name, ".mosh. ") then
                        name = make_name(name, c, "mosh")
                    elseif c.class == "Alacritty" and c.name and c.name:find('^ssh ') then
                        name = make_name(name, c, "ssh")
                    elseif c.class == "firefox" or c.class == "Firefox" or c.class == "Chrome" or c.class == "Chromium" then
                        name = make_name(name, c, "web")
                    elseif c.class == "Thunderbird" or c.class == "thunderbird" then
                        name = make_name(name, c, "mail")
                    elseif c.class == "TickTick" or c.class == "ticktick" then
                        name = make_name(name, c, "todo")
                    elseif c.class ~= nil and string.find(c.class:lower(), "libreoffice") then
                        name = make_name(name, c, "office")
                    elseif c.class ~= nil and string.find(c.class:lower(), "org.remmina.remmina") then
                        name = make_name(name, c, "remmina")
                    elseif c.class == "Virt-manager" and c.name and string.find(c.name, ' on QEMU/KVM') then
                        local rex = string.gsub(c.name, "(.*) on QEMU/KVM", "%1 [vm]")
                        name = make_name(name, c, rex)
                    elseif c.class == "qemu-system-x86_64" then
                        name = make_name(name, c, "qemu")
                    elseif c.class == "VirtualBox Manager" then
                        name = make_name(name, c, "vbox-manager")
                    elseif c.class == "VirtualBox Machine" then
                        name = make_name(name, c, "vbox")
                    elseif c.class == "Thunar" or c.class == "Pcmanfm" or c.class == "dolphin" then
                        name = make_name(name, c, "files")
                    elseif c.class == "Gimp-2.8" then
                        name = make_name(name, c, "gimp")
                    elseif c.name and (string.find(c.name, 'vim ') or string.find(c.name, ' - VIM')) then
                        name = make_name(name, c, "vim")
                    elseif c.class == "Termite" or c.class == "Alacritty" then
                        name = make_name(name, c, "term")
                    elseif c.class == "Gpicview" then
                        name = make_name(name, c, "image")
                    elseif c.class == "Engrampa" then
                        name = make_name(name, c, "archive")
                    elseif c.class == "Zathura" then
                        name = make_name(name, c, "pdf")
                    elseif c.class == "jetbrains-idea" then
                        name = make_name(name, c, "intelliJ")
                    -- wine: show window title (up to first space) instead of class
                    elseif c.class and (string.find(c.class, '.exe')) then
                        name = make_name(name, c, string.match(c.name, "%S+"))
                    else
                        if c.class == nil or c.class == "" then
                            if c.name then
                                name = make_name(name, c, c.name:lower())
                            end
                        else
                            name = make_name(name, c, c.class:lower())
                        end
                    end
                end
                t.name = " " .. theme.taglist_nonempty_tag .. " " .. name .. " "
            end
        end
    end)
end
for _, signal in ipairs({
    "tagged",
    "untagged",
    "unmanage",
    "property::name",
    "property::minimized",
    "property::fullscreen",
    "property::floating"
}) do
    client.connect_signal(signal, dynamic_tagging)
end

-- client appears
client.connect_signal("manage", function(c)
    c.maximized = false
    c.maximized_horizontal = false
    c.maximized_vertical = false

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end

    if not c.floating then
        awful.titlebar.hide(c)
    end

    -- FIXME: only apply when single window visible
    -- also: slow rendering
    -- c.shape = function(cr, w, h)
    --     gears.shape.rounded_rect(cr, w, h, dpi(14))
    -- end

    -- try to move new client to same tag and screen as parent
    -- parent = c.transient_for
    -- if parent then
    --     tag = parent.first_tag
    --     screen = parent.screen
    --     c:move_to_tag(tag)
    --     c:move_to_screen(screen)
    -- end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    local buttons = awful.util.table.join(
            awful.button({ }, 1, function()
                c:emit_signal("request::activate", "titlebar", {raise = true})
                awful.mouse.client.move(c)
            end),
            awful.button({ }, 3, function()
                c:emit_signal("request::activate", "titlebar", {raise = true})
                awful.mouse.client.resize(c)
            end)
    )

    local layout1 = wibox.layout.fixed.horizontal()
    layout1:add(awful.titlebar.widget.closebutton(c))
    layout1:add(awful.titlebar.widget.floatingbutton(c))
    layout1:add(awful.titlebar.widget.stickybutton(c))

    local layout2 = wibox.layout.flex.horizontal()
    local title = awful.titlebar.widget.titlewidget(c)
    title:set_font(theme.titlebar_font)
    layout2:add(title)
    layout2:buttons(buttons)

    local layout = wibox.layout.align.horizontal()
    layout:set_expand("none")
    layout:set_left(layout1)
    layout:set_middle(layout2)

    awful.titlebar(c, { size = theme.titlebar_height }):set_widget(layout)
end)

-- sloppy focus
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("property::floating", function(c)
    -- if not c.floating then
    --     awful.titlebar.hide(c)
    -- else
    --     awful.titlebar.show(c)
    -- end

    if c.floating and not c.fullscreen then
        if c.class == "mpv" then
            c.size_hints_honor = true
        end
        -- awful.titlebar.show(c)
        awful.placement.no_offscreen(c)
        awful.placement.no_overlap(c)
        c.ontop = true
    else
        if c.class == "mpv" then
            c.size_hints_honor = false
        end
        awful.titlebar.hide(c)
        c.ontop = false
    end
end)

-- client exits
client.connect_signal("unmanage", function(c)

    if c.floating then
        return
    end

    if c.class == nil and c.name == nil then
        return
    end

    if c.class ~= nil and c.class:lower() == "steam" or c.class == "jetbrains-idea" then
        return
    end

    -- return to last tag and reset settings when last window is closed
    selected_tag = awful.screen.focused().selected_tag
    if is_empty(selected_tag) then
        selected_tag.master_width_factor = theme.master_width_factor
        selected_tag.master_count = theme.master_count
        selected_tag.column_count = theme.column_count
        selected_tag.gap = theme.gap

        -- return to last non-empty tag
        i = 1
        while is_empty(awful.screen.focused().selected_tag) and i <= 10 do
            awful.tag.history.restore(nil, i)
            i = i + 1
        end

        -- if still empty, return to first
        if is_empty(awful.screen.focused().selected_tag) then
            local tag = awful.screen.focused().tags[1]
            if tag then tag:view_only() end
        end
    end
end)

if theme.border_focus or theme.border_normal then
    client.connect_signal("focus",   function(c) c.border_color = theme.border_focus end)
    client.connect_signal("unfocus", function(c) c.border_color = theme.border_normal end)
end

tag.connect_signal("property::layout", function(t)
    naughty.notify({ text = "Window layout: " .. awful.tag.getproperty(t, "layout").name, timeout = 2})

    if awful.tag.getproperty(t, "layout").name == "magnifier" then
        t.master_width_factor = 0.8
    else
        t.master_width_factor = theme.master_width_factor
    end
end)

-- set focus to client under mouse cursor when switching tags
-- tag.connect_signal("property::selected", function(t)
--     local selected = tostring(t.selected) == "false"
--     if selected then
--         local focus_timer = timer({ timeout = 0.05 })
--         focus_timer:connect_signal("timeout", function()
--             local c = awful.mouse.client_under_pointer()
--             if not (c == nil) then
--                 client.focus = c
--                 c:raise()
--             end
--             focus_timer:stop()
--         end)
--         focus_timer:start()
--     end
-- end)
