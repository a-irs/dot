local awful      = require 'awful'
local tyrannical = require 'tyrannical'
local lain       = require 'lain'


tyrannical.settings.block_children_focus_stealing = true
tyrannical.settings.group_children                = true
tyrannical.settings.mwfact                        = 0.5
tyrannical.settings.default_layout                = layouts[1]
default_nmaster                                   = 1

if not compact_display then
    tyrannical.settings.mwfact                    = 0.68
    default_nmaster                               = 2
end

local fa_globe = " " .. string.char(239, 130, 172) ..     "  www  "
local fa_terminal = string.char(239, 132, 160) ..  "  term  "
local fa_file_text = string.char(239, 133, 156) .. "  dev  "
local fa_cloud = string.char(239, 131, 130) ..     "  "
local fa_asterisk = string.char(239, 129, 169) ..  "  "
local fa_music = string.char(239, 128, 129) ..     "  "

tyrannical.tags = {
    {
        name         = fa_globe,
        init         = true,
        exclusive    = true,
        nmaster      = default_nmaster,
        class        = { "Firefox", "Chromium" }
    },
    {
        name         = fa_terminal,
        init         = true,
        exclusive    = true,
        nmaster      = default_nmaster,
        exec_once    = { user_terminal },
        class        = { "Urxvt", "Terminator", "Termite" }
    },
    {
        name         = fa_file_text,
        init         = true,
        exclusive    = true,
        nmaster      = default_nmaster,
        class        = { "Subl3", "Atom" }
    },
    {
        name         = "○",
        init         = false,
        exclusive    = true,
        nmaster      = default_nmaster,
        class        = { "VirtualBox" }
    },
    {
        name         = fa_music,
        init         = false,
        exclusive    = true,
        nmaster      = default_nmaster,
        class        = { "Ario" }
    },
    {
        name         = "○",
        init         = false,
        exclusive    = true,
        nmaster      = default_nmaster,
        class        = { "Gimp-2.8", "Pinta" }
    },
    {
        name         = fa_asterisk,
        init         = true,
        nmaster      = default_nmaster,
        fallback     = true,
    },
    {
        name         = "kodi",
        init         = false,
        layout       = awful.layout.suit.max.fullscreen,
        class        = { "Kodi" }
    },
}
-- Ignore the tag "exclusive" property for the following clients (matched by classes)
tyrannical.properties.intrusive = {
    "Kupfer.py", "Gtksu", "Pinentry", "Gcolor2", "Gcolor3", "Colorgrab", "Xfce4-appfinder",
}
-- Ignore the tiled layout for the matching clients
tyrannical.properties.floating = {
    "Pinentry", "Plugin-container", "Gcolor3", "Colorgrab", "Xfce4-appfinder",
}
-- Make the matching clients (by classes) on top of the default layout
tyrannical.properties.ontop = {
    "Pinentry", "Plugin-container", "Gcolor2", "Gcolor3", "Colorgrab", "Xfce4-appfinder",
}
-- Force the matching clients (by classes) to be centered on the screen on init
tyrannical.properties.centered = {
    "Gcolor2", "Gcolor3", "Colorgrab", "Xfce4-appfinder",
}

tyrannical.properties.sticky = {
    "Gcolor2", "Gcolor3", "Colorgrab", "Xfce4-appfinder",
}

tyrannical.properties.master = {
    "Firefox", "Atom",
}

tyrannical.properties.fullscreen = {
    "Kodi",
}
