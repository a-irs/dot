backend = "glx";
glx-no-stencil = true;
glx-no-rebind-pixmap = true;
vsync = "opengl-swc";

# Shadow
shadow = true;          # Enabled client-side shadows on windows.
no-dock-shadow = false;     # Avoid drawing shadows on dock/panel windows.
no-dnd-shadow = true;       # Don't draw shadows on DND windows.
shadow-radius = 12;     # The blur radius for shadows. (default 12)
shadow-offset-x = -15;      # The left offset for shadows. (default -15)
shadow-offset-y = -15;      # The top offset for shadows. (default -15)
shadow-opacity = 0.5;       # The translucency for shadows. (default .75)
shadow-ignore-shaped = true;
||DESK||shadow-exclude-reg = "x15+0+0";
||X1||shadow-exclude-reg = "x30+0+0";

# Opacity
#menu-opacity = 1.0;            # The opacity for menus. (default 1.0)
#inactive-opacity = 0.75;          # Opacity of inactive windows. (0.1 - 1.0)
#frame-opacity = 0.1;           # Opacity of window titlebars and borders. (0.1 - 1.0)
#inactive-opacity-override = true;  # Inactive opacity set by 'inactive-opacity' overrides value of _NET_WM_OPACITY.

# Fading
fading = false;         # Fade windows during opacity changes.
fade-delta = 5;     # The time between steps in a fade in milliseconds. (default 10).
fade-in-step = 0.10;        # Opacity change between steps while fading in.
fade-out-step = 0.10;       # Opacity change between steps while fading out.
no-fading-openclose = false;    # Fade windows in/out when opening/closing.

# Other
inactive-dim = 0.25;        # Dim inactive windows. (0.0 - 1.0, defaults to 0).
mark-wmwin-focused = true;  # Try to detect WM windows and mark them as active.
mark-ovredir-focused = true;
detect-rounded-corners = true;
