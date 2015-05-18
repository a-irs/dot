theme                               = {}

theme.conf_dir                      = os.getenv("HOME") .. "/.config/awesome/theme"
theme.genmon_icon_dir               = os.getenv("HOME") .. "/.bin/lib/genmon/img"
theme.wallpaper                     = os.getenv("HOME") .. "/.wallpaper"

theme.widget_wifi_on                = theme.genmon_icon_dir .. "/wifi.png"
theme.widget_wifi_off               = theme.genmon_icon_dir .. "/wifi_off.png"
theme.widget_audio_on               = theme.genmon_icon_dir .. "/speaker_on.png"
theme.widget_audio_off              = theme.genmon_icon_dir .. "/speaker_off.png"
theme.widget_battery_crit           = theme.genmon_icon_dir .. "/battery_crit.png"
theme.widget_battery_high           = theme.genmon_icon_dir .. "/battery_high.png"
theme.widget_battery_low            = theme.genmon_icon_dir .. "/battery_low.png"
theme.widget_battery_normal         = theme.genmon_icon_dir .. "/battery_normal.png"
theme.widget_date                   = theme.genmon_icon_dir .. "/clock.png"

theme.font                          = "Ubuntu 8"
theme.taglist_font                  = "Ubuntu Bold 8"
theme.menu_bg_normal                = "#000000"
theme.menu_bg_focus                 = "#000000"
theme.bg_normal                     = "#323232"
theme.bg_focus                      = "#323232"
theme.bg_urgent                     = "#aa0000"
theme.fg_normal                     = "#aaaaaa"
theme.fg_focus                      = "#ff8c00"
theme.fg_urgent                     = "#af1d18"
theme.fg_minimize                   = "#ffffff"
theme.fg_black                      = "#424242"
theme.fg_red                        = "#ce5666"
theme.fg_green                      = "#80a673"
theme.fg_yellow                     = "#ffaf5f"
theme.fg_blue                       = "#7788af"
theme.fg_magenta                    = "#94738c"
theme.fg_cyan                       = "#778baf"
theme.fg_white                      = "#aaaaaa"
theme.fg_blu                        = "#8ebdde"
theme.border_width                  = "0"
theme.border_normal                 = "#1c2022"
theme.border_focus                  = "#606060"
theme.border_marked                 = "#3ca4d8"
theme.menu_width                    = "110"
theme.menu_border_width             = "0"
theme.menu_fg_normal                = "#aaaaaa"
theme.menu_fg_focus                 = "#ff8c00"
theme.menu_bg_normal                = "#050505dd"
theme.menu_bg_focus                 = "#050505dd"

theme.taglist_squares_sel           = theme.conf_dir .. "/blank.png"
theme.taglist_squares_unsel         = theme.conf_dir .. "/blank.png"

theme.useless_gap_width = 10

return theme