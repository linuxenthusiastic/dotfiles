#############################
#		Andrea Theme		#
#############################
# Copyright (C) 2021-2026 gh0stzk <z0mbi3.zk@protonmail.com>
# https://github.com/gh0stzk/dotfiles

# (Gruvbox Material, fondo oscuro) colorscheme
bg="#09090F"
fg="#d4be98"

black="#32302f"
red="#ea6962"
green="#a9b665"
yellow="#d8a657"
blue="#7daea3"
magenta="#d3869b"
cyan="#89b482"
white="#d4be98"
blackb="#32302f"
redb="#ea6962"
greenb="#a9b665"
yellowb="#d8a657"
blueb="#7daea3"
magentab="#d3869b"
cyanb="#89b482"
whiteb="#d4be98"

accent_color="#32302f"
arch_icon="#7daea3"

# Bspwm options
BORDER_WIDTH="0"		# Bspwm border
TOP_PADDING="52"		# Barra eww = 46px de alto
BOTTOM_PADDING="1"
LEFT_PADDING="1"
RIGHT_PADDING="1"
NORMAL_BC="#000000"		# Normal border color
FOCUSED_BC="#000000"	# Focused border color

# Terminal font & size
term_font_size="15"
term_font_name="IosevkaTerm Nerd Font Propo"

# Picom options
P_FADE="true"			# Fade true|false
P_SHADOWS="true"		# Shadows true|false
SHADOW_C="#000000"		# Shadow color
P_CORNER_R="20"			# Corner radius (0 = disabled)
P_BLUR="true"			# Blur true|false
P_ANIMATIONS="@"		# (@ = enable) (# = disable)
P_TERM_OPACITY="0.99"	# Terminal transparency. Range: 0.1 - 1.0 (1.0 = disabled)

# Dunst
dunst_offset='(20, 30)'
dunst_origin='bottom-right'
dunst_transparency='1'
dunst_corner_radius='6'
dunst_font='JetBrainsMono NF Medium 9'
dunst_border='1'
dunst_frame_color="$yellowb"
dunst_icon_theme="Gruvbox-Plus-Dark"
# Dunst animations
dunst_close_preset="fly-out"
dunst_close_direction="down"
dunst_open_preset="fly-in"
dunst_open_direction="down"

# Jgmenu colors
jg_bg="$bg"
jg_fg="$fg"
jg_sel_bg="$yellowb"
jg_sel_fg="$bg"
jg_sep="$black"

# Rofi menu font and colors
rofi_font="JetBrainsMono NF Bold 9"
rofi_background="$bg"
rofi_bg_alt="$accent_color"
rofi_background_alt="${bg}E0"
rofi_fg="$fg"
rofi_selected="$yellowb"
rofi_active="$greenb"
rofi_urgent="$redb"

# Screenlocker
sl_bg="${bg}"
sl_fg="${fg}"
sl_ring="${yellowb}"
sl_wrong="${red}"
sl_date="${fg}"
sl_verify="${greenb}"

# Gtk theme
gtk_theme="Andrea-Material"
gtk_icons="Gruvbox-Plus-Dark"
gtk_cursor="Qogirr-Dark"
geany_theme="z0mbi3-Gruvbox"

# Wallpaper engine
# Available engines:
# - Random  (Set a random wallpaper from Walls rice directory)
# - CustomDir   (Set a random wallpaper from the directory you specified)
# - Default (Sets a specific image as wallpaper) *Default
# - Animated (Set an animated wallpaper. "mp4, mkv, gif")
# - Slideshow (Change randomly every 15 minutes your wallpaper from Walls rice directory)
ENGINE="Default"

CUSTOM_DIR="/path/to/your/wallpapers/directory"
DEFAULT_WALL="/home/alone/Downloads/thumb-1920-1209089.jpg"
ANIMATED_WALL="/home/alone/Downloads/gojo-hollow-purple-jujutsu-kaisen-moewalls-com.mp4"
