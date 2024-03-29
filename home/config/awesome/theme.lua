local gears = require("gears")

theme                               = {}

theme.statusbar_height              = dpi(22)
theme.statusbar_top_pixel           = "#586779"
theme.statusbar_bottom_pixel        = "#3f4e60"


-- FG, BG COLORS

-- theme.bg_normal                     = "#17263f"
theme.bg_normal                     = "#132132"
theme.bg_focus                      = "#254061"
theme.bg_focus2                     = "#1C314A"
theme.bg_urgent                     = "#d9304f"
theme.fg_normal                     = "#aaaaaa"
theme.fg_focus                      = "#ffffff"
theme.fg_urgent                     = "#ffffff"

theme.border_width                  = 1
theme.border_focus                  = theme.statusbar_bottom_pixel
theme.border_normal                 = theme.statusbar_bottom_pixel

theme.gap                           = 0
theme.master_count                  = 1
theme.column_count                  = 1
theme.master_width_factor           = 0.65


-- NOTIFICATIONS (NAUGHTY)

theme.naughty_font                  = "Sans Medium 8"
theme.naughty_padding               = dpi(18)
theme.naughty_spacing               = dpi(18)
theme.naughty_border_width          = dpi(6)
theme.naughty_timeout               = 6
theme.naughty_position              = "top_right"

theme.naughty_defaults_fg           = theme.fg_focus
theme.naughty_defaults_bg           = theme.bg_focus
theme.naughty_defaults_border_color = theme.naughty_defaults_bg

theme.naughty_critical_fg           = '#ffffff'
theme.naughty_critical_bg           = '#d9304f'
theme.naughty_critical_border_color = theme.naughty_critical_bg


-- WIDGETS

theme.font = "InputMonoCondensed Medium 8"
theme.taglist_font = "InputMonoCondensed Bold 8"
theme.taglist_empty_tag = "☐"  -- ○
theme.taglist_nonempty_tag = "■"  -- ●

theme.tasklist_font                 = theme.font
theme.tasklist_fg                   = theme.fg_focus
theme.tasklist_bg                   = theme.bg_normal
theme.tasklist_disable_icon         = true

theme.statusbar_margin              = dpi(8)
theme.bg_systray                    = theme.bg_normal
theme.systray_icon_spacing          = dpi(4)
theme.systray_icon_size             = dpi(12)
theme.systray_margin_left           = dpi(12)
theme.systray_margin_top            = dpi(4)
theme.systray_margin_bottom         = dpi(4)
theme.systray_margin_right          = dpi(12)

theme.widget_music_fg               = theme.fg_focus
theme.widget_music_bg               = theme.bg_focus2

theme.widget_date_fg                = "#cccccc"
theme.widget_date_bg                = theme.bg_normal
theme.widget_time_fg                = "#eeeeee"
theme.widget_time_bg                = theme.bg_normal

theme.widget_battery_bg             = theme.bg_normal

theme.widget_pulse_bg               = theme.bg_focus2
theme.widget_pulse_fg               = "#96b7e2"
theme.widget_pulse_bg_crit          = theme.bg_urgent
theme.widget_pulse_fg_crit          = "#ffffff"
theme.widget_pulse_bg_mute          = theme.bg_normal
theme.widget_pulse_fg_mute          = "#aaaaaa"

-- TITLEBAR

theme.titlebar_height                          = dpi(22)
theme.titlebar_font                            = "InputMonoCondensed Medium 8"

theme.titlebar_fg_normal                       = theme.fg_normal
theme.titlebar_fg_focus                        = theme.fg_focus
theme.titlebar_bg_normal                       = theme.bg_normal
theme.titlebar_bg_focus                        = theme.bg_normal

resource_folder                                = gears.filesystem.get_configuration_dir() .. "/resource"
theme.titlebar_close_button_focus              = resource_folder .. "/titlebar/close.xpm"
theme.titlebar_close_button_normal             = resource_folder .. "/titlebar/unfocused_inactive.xpm"
theme.titlebar_ontop_button_focus_inactive     = resource_folder .. "/titlebar/ontop_inactive.xpm"
theme.titlebar_ontop_button_focus_active       = resource_folder .. "/titlebar/ontop_active.xpm"
theme.titlebar_ontop_button_normal_inactive    = resource_folder .. "/titlebar/ontop_inactive.xpm"
theme.titlebar_ontop_button_normal_active      = resource_folder .. "/titlebar/ontop_unfocused.xpm"
theme.titlebar_sticky_button_focus_inactive    = resource_folder .. "/titlebar/sticky_inactive.xpm"
theme.titlebar_sticky_button_focus_active      = resource_folder .. "/titlebar/sticky_active.xpm"
theme.titlebar_sticky_button_normal_inactive   = resource_folder .. "/titlebar/unfocused_inactive.xpm"
theme.titlebar_sticky_button_normal_active     = resource_folder .. "/titlebar/unfocused_active.xpm"
theme.titlebar_floating_button_focus_inactive  = resource_folder .. "/titlebar/floating_inactive.xpm"
theme.titlebar_floating_button_focus_active    = resource_folder .. "/titlebar/floating_active.xpm"
theme.titlebar_floating_button_normal_inactive = resource_folder .. "/titlebar/unfocused_inactive.xpm"
theme.titlebar_floating_button_normal_active   = resource_folder .. "/titlebar/unfocused_active.xpm"

return theme
