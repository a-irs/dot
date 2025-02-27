local volume     = require 'volume'
local awful      = require 'awful'
local rules      = require 'awful.rules'
local naughty    = require 'naughty'
local gears      = require 'gears'

local win = "Mod4"
local alt = "Mod1"
local ctrl = "Ctrl"

local function tag_view_nonempty(direction)
    local s = awful.screen.focused()
    for _, _ in pairs(s.tags) do
        awful.tag.viewidx(direction, s)
        if #awful.client.visible(s) > 0 then
            return
        end
    end
end

local function run(cmd)
    awful.spawn(cmd, false)
end

local function run_gui(cmd)
    awful.spawn(cmd, { tag = mouse.screen.selected_tag })
end

local function run_script(script)
    run(os.getenv("HOME") .. "/.bin/" .. script)
    run(os.getenv("HOME") .. "/.bin/" .. hostname .. "/" .. script)
end

local function run_gui_script(script)
    run_gui(os.getenv("HOME") .. "/.bin/" .. script)
end

local function run_or_raise(cmd, class)
    local matcher = function(c)
        return rules.match(c, {class = class})
    end
    awful.client.run_or_raise(cmd, matcher)
end

local function focus(direction)
    -- for suit.max layout, focus by index instead of direction
    if (awful.layout.get(awful.screen.focused()) == awful.layout.suit.max) then
        if direction == "left" or direction == "down" then
            awful.client.focus.byidx(-1)
        else
            awful.client.focus.byidx(1)
        end
    else
        awful.client.focus.bydirection(direction)
    end
    if client.focus then client.focus:raise() end
end

local function swap(direction)
    awful.client.swap.bydirection(direction)
    if client.focus then client.focus:raise() end
end

local function view_tag(i)
    local tag = awful.screen.focused().tags[i]
    if tag then
        tag:view_only()
    end
end

local function toggle_tag(i)
    local tag = awful.screen.focused().tags[i]
    if tag then
        awful.tag.viewtoggle(tag)
    end
end

local function move_client_to_tag(i)
    if client.focus then
        local tag = client.focus.screen.tags[i]
        if tag then
            client.focus:move_to_tag(tag)
        end
    end
end

local function audio(t)
    if t == "toggle" then
        run("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause")
    elseif t == "prev" then
        run("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous")
    elseif t == "next" then
        run("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next")
    end
end


globalkeys = awful.util.table.join(

    -- focus windows

    awful.key({ alt }, "Down",  function() focus("down") end),
    awful.key({ alt }, "Up",    function() focus("up") end),
    awful.key({ alt }, "Left",  function() focus("left") end),
    awful.key({ alt }, "Right", function() focus("right") end),

    -- switch tags

    awful.key({ win          }, "Right", awful.tag.viewnext),
    awful.key({ win          }, "Left",  awful.tag.viewprev),
    awful.key({ alt          }, "Tab",   function() tag_view_nonempty( 1) end),
    awful.key({ alt, "Shift" }, "Tab",   function() tag_view_nonempty(-1) end),
    awful.key({ win          }, "Tab",   awful.tag.history.restore),

    -- modify windows

    awful.key({ win }, "Down", function()
        for _, t in ipairs(awful.tag.selectedlist(1)) do
            for _, c in ipairs(t:clients()) do
                if c.minimized then
                    c:emit_signal("request::activate", "key.unminimize", {raise = true})
                    break
                end
            end
        end
    end),

    -- useless gaps

    awful.key({ win }, "#35", function() awful.tag.incgap(-2) end), -- plus +
    awful.key({ win }, "#61", function() awful.tag.incgap( 2) end), -- minus -

    -- window size

    awful.key({ win, "Control" }, "Right", function() awful.tag.incmwfact( 0.005) end),
    awful.key({ win, "Control" }, "Left",  function() awful.tag.incmwfact(-0.005) end),

    -- swap windows

    awful.key({ win, "Shift" }, "Left",  function() swap("left") end),
    awful.key({ win, "Shift" }, "Right", function() swap("right") end),
    awful.key({ win, "Shift" }, "Up",    function() swap("up") end),
    awful.key({ win, "Shift" }, "Down",  function() swap("down") end),

    -- switch layouts

    awful.key({ win          }, "space", function() awful.layout.inc(1) end),
    awful.key({ win, "Shift" }, "space", function() awful.layout.inc(-1) end),

    -- launch programs

    awful.key({ win }, "i",          function() run_script("invert-window") end),
    awful.key({ win }, "r",          function() awful.screen.focused().myprompt:run() end),
    -- awful.key({ alt }, "space",      function() run("rofi -show drun") end),
    awful.key({ alt }, "space",      function() run("kupfer") end),
    awful.key({ "Ctrl" }, "space",   function() run_script("menu-vpn") end),
    awful.key({ alt }, "Return",     function() run("alacritty -e tmux -u new-session -c ~") end),
    awful.key({ alt, ctrl }, "Return",function() run("alacritty -e bash") end),
    awful.key({ alt }, "f",          function() run_gui("dolphin") end),
    awful.key({ alt }, "c",          function() run_or_raise("firefox", "firefox") end),
    awful.key({ alt }, "t",          function() run_or_raise("thunderbird", "thunderbird") end),
    awful.key({ alt, "Shift" }, "c", function() run_gui("firefox --private-window") end),
    awful.key({ alt }, "k",          function() run_or_raise("keepassxc", "keepassxc") end),
    awful.key({ alt }, "s",          function() run("rofi -show calc -modi calc -no-show-match -no-sort -no-history -lines 0 -calc-command \"echo -n '{result}' | xclip -selection clipboard\"") end),
    awful.key({ alt, ctrl }, "1",    function() run_script("dpitog 1 apply") end),
    awful.key({ alt, ctrl }, "2",    function() run_script("dpitog 2 apply") end),
    awful.key({ alt, ctrl }, "3",    function() run_script("dpitog 3 apply") end),
    awful.key({ alt, ctrl }, "4",    function() run_script("dpitog 4 apply") end),
    awful.key({ alt, ctrl }, "5",    function() run_script("dpitog 5 apply") end),
    awful.key({ alt, ctrl }, "6",    function() run_script("dpitog 6 apply") end),
    awful.key({ alt }, "o",          function() run_gui_script("mpv-clipboard.sh") end),
    awful.key({ alt }, "p",          function() run_script("xr-rate") end),

    -- displays

    awful.key({ alt }, "r", function() run("pkill -USR1 redshift") end),

    -- screenshots

    awful.key({ },        "Print", function() run("flameshot gui -s") end),
    awful.key({ "Ctrl" }, "Print", function() run("flameshot screen -p " .. os.getenv("HOME")) end),

    -- media keys

    awful.key({}, "XF86PowerOff",  function() run("systemctl suspend") end),
    awful.key({}, "XF86RFKill",  function() naughty.notify({ text = "flight mode" }) end),
    awful.key({"Ctrl", "Shift", alt}, "BackSpace",  function() run("systemctl suspend") end),

    awful.key({},        "XF86MonBrightnessUp", function() run_script("brightness ++") end),
    awful.key({"Shift"}, "XF86MonBrightnessUp", function() run_script("brightness +") end),
    awful.key({"Ctrl", alt }, "Right",          function() run_script("brightness ++") end),
    awful.key({"Ctrl"},  "XF86MonBrightnessUp", function() run_script("brightness 100") end),
    awful.key({"Ctrl", "Shift", alt }, "Right", function() run_script("brightness 100") end),
    awful.key({},        "XF86MonBrightnessDown", function() run_script("brightness --") end),
    awful.key({"Shift"}, "XF86MonBrightnessDown", function() run_script("brightness -") end),
    awful.key({"Ctrl", alt }, "Left",             function() run_script("brightness --") end),
    awful.key({"Ctrl"},  "XF86MonBrightnessDown", function() run_script("brightness 1") end),
    awful.key({"Ctrl", "Shift", alt }, "Left",    function() run_script("brightness 1") end),
    awful.key({"Ctrl", "Shift" }, "asciicircum", function() run_script("toggle-display") end),

    -- remote control
    awful.key({ }, "Menu", function() run_script("toggle-display") end),
    awful.key({ }, "XF86HomePage", function() run_or_raise("kodi", "Kodi") end),

    awful.key({},        "XF86AudioRaiseVolume", volume.increase_5),
    awful.key({"Shift"}, "XF86AudioRaiseVolume", volume.increase),
    awful.key({},        "XF86AudioLowerVolume", volume.decrease_5),
    awful.key({"Shift"}, "XF86AudioLowerVolume", volume.decrease),
    awful.key({},        "XF86AudioMute",        volume.toggle),
    awful.key({"Ctrl"},        "XF86AudioMute",        function() run("pavucontrol") end),

    awful.key({}, "XF86AudioPlay",   function() audio("toggle") end),
    awful.key({}, "XF86AudioPrev",   function() audio("prev") end),
    awful.key({}, "XF86AudioNext",   function() audio("next") end),

    -- suspend, lock

    awful.key({ win }, "l",       function() run("loginctl lock-session") end),

    -- restart awesome wm

    awful.key({ win, "Ctrl"  }, "r", awesome.restart),

    -- change master/column count

    awful.key({ win }, ".", function() awful.tag.incnmaster( 1, nil, true); naughty.notify({ text = "Master: " .. awful.tag.getnmaster(), timeout = 1 }) end),
    awful.key({ win }, ",", function() awful.tag.incnmaster(-1, nil, true); naughty.notify({ text = "Master: " .. awful.tag.getnmaster(), timeout = 1 }) end),
    awful.key({ win, alt }, ".", function() awful.tag.incncol( 1, nil, true); naughty.notify({ text = "Columns: " .. awful.tag.getncol(), timeout = 1 }) end),
    awful.key({ win, alt }, ",", function() awful.tag.incncol(-1, nil, true); naughty.notify({ text = "Columns: " .. awful.tag.getncol(), timeout = 1 }) end)
)


clientkeys = gears.table.join(
    awful.key({ win }, "f",  function(c)
        c.fullscreen = not c.fullscreen
        c.maximized_vertical = false
        c.maximized_horizontal = false
        c.maximized = false
        c:raise()
    end),
    awful.key({ alt }, "F4", function(c) c:kill() end),
    awful.key({ win }, "w",  function(c) c:kill() end),
    awful.key({ win }, "q",  function(c) c:kill() end),
    awful.key({ win }, "e",  awful.client.floating.toggle),
    awful.key({ win }, "m",  awful.titlebar.toggle),
    awful.key({ win }, "Up", function(c) c.minimized = true end)
)

for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ win },          "#" .. i + 9, function() view_tag(i) end),
        awful.key({ win, alt },     "#" .. i + 9, function() toggle_tag(i) end),
        awful.key({ win, "Shift" }, "#" .. i + 9, function() move_client_to_tag(i) end)
    )
end

-- mouse buttons

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ win }, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ win }, 3, function(c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

root.keys(globalkeys)
