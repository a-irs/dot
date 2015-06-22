theme                               = {}

theme.basedir                       = os.getenv("HOME") .. "/.config/awesome"

theme.statusbar_height              = 24

-- FG, BG COLORS

theme.bg_normal                     = "#2c3643"
theme.bg_focus                      = theme.bg_normal
theme.bg_urgent                     = "#aa0000"
theme.bg_systray                    = theme.bg_normal
theme.fg_normal                     = "#aaaaaa"
theme.fg_focus                      = "#eeeeee"
theme.fg_urgent                     = "#af1d18"

theme.border_width                  = 0
theme.border_normal                 = theme.bg_normal
theme.border_focus                  = theme.bg_focus

theme.useless_gap_width             = 0

-- NOTIFICATIONS (NAUGHTY)

theme.naughty_font                  = "Roboto Medium 8"
theme.naughty_padding               = 12
theme.naughty_spacing               = 12
theme.naughty_border_width          = 6
theme.naughty_timeout               = 4
theme.naughty_position              = "top_right"

theme.naughty_defaults_fg           = '#aaaaaa'
theme.naughty_defaults_bg           = '#222a34'
theme.naughty_defaults_border_color = theme.naughty_defaults_bg

theme.naughty_critical_fg           = '#ffffff'
theme.naughty_critical_bg           = '#fa5641'
theme.naughty_critical_border_color = theme.naughty_critical_bg


-- WIDGETS

theme.font                          = "Ubuntu 8"
theme.taglist_font                  = "Ubuntu 7"
theme.widget_mpd_fg                 = "#cfcfcf"
theme.widget_calendar_font          = "Input"
theme.widget_calendar_font_size     = "8"
theme.widget_calendar_fg            = theme.fg_normal
theme.widget_calendar_bg            = "#222a34"
theme.widget_date_fg                = "#cfcfcf"
theme.widget_alsa_fg                = "#c69dc2"
theme.widget_alsa_mute_fg           = "#666666"
theme.widget_yawn_fg                = "#ababab"
theme.widget_speed_down             = "#ffc350"
theme.widget_speed_up               = "#ff8a5a"

-- LAYOUT ICONS

theme.layout_uselesstile            = theme.basedir .. "/layout-icons/tile.xpm"
theme.layout_uselesstileleft        = theme.basedir .. "/layout-icons/tileleft.xpm"
theme.layout_uselesstilebottom      = theme.basedir .. "/layout-icons/tilebottom.xpm"
theme.layout_uselesstiletop         = theme.basedir .. "/layout-icons/tiletop.xpm"
theme.layout_uselesspiral           = theme.basedir .. "/layout-icons/spiral.xpm"

-- TITLEBAR

theme.titlebar_height  = 24
theme.titlebar_font    = "Roboto Bold 8"

theme.titlebar_close_button_focus              = theme.basedir .. "/titlebar/close.xpm"
theme.titlebar_close_button_normal             = theme.basedir .. "/titlebar/unfocused_inactive.xpm"
theme.titlebar_ontop_button_focus_inactive     = theme.basedir .. "/titlebar/ontop_inactive.xpm"
theme.titlebar_ontop_button_focus_active       = theme.basedir .. "/titlebar/ontop_active.xpm"
theme.titlebar_ontop_button_normal_inactive    = theme.basedir .. "/titlebar/ontop_inactive.xpm"
theme.titlebar_ontop_button_normal_active      = theme.basedir .. "/titlebar/ontop_unfocused.xpm"
theme.titlebar_sticky_button_focus_inactive    = theme.basedir .. "/titlebar/sticky_inactive.xpm"
theme.titlebar_sticky_button_focus_active      = theme.basedir .. "/titlebar/sticky_active.xpm"
theme.titlebar_sticky_button_normal_inactive   = theme.basedir .. "/titlebar/unfocused_inactive.xpm"
theme.titlebar_sticky_button_normal_active     = theme.basedir .. "/titlebar/unfocused_active.xpm"
theme.titlebar_floating_button_focus_inactive  = theme.basedir .. "/titlebar/floating_inactive.xpm"
theme.titlebar_floating_button_focus_active    = theme.basedir .. "/titlebar/floating_active.xpm"
theme.titlebar_floating_button_normal_inactive = theme.basedir .. "/titlebar/unfocused_inactive.xpm"
theme.titlebar_floating_button_normal_active   = theme.basedir .. "/titlebar/unfocused_active.xpm"

-- HOST-SPECIFIC SETTINGS

if hostname == "desktop" then
    theme.useless_gap_width         = 24
end


return theme
