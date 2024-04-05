local awful = require 'awful'
local lain = require 'lain'

awful.layout.layouts = {
    awful.layout.suit.tile.right,
    -- lain.layout.centerwork,
    -- lain.layout.centerwork.horizontal,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.fair,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.floating,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
    awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
}
