# dotfiles — Andrea rice

bspwm + picom + eww bar + kitty/alacritty + rofi + Thunar + Neovim,
Gruvbox Material palette.

Based on [gh0stzk/dotfiles](https://github.com/gh0stzk/dotfiles) (GPL-3.0).

## Layout

| Path | Install to |
|---|---|
| `bspwm/` (bspwmrc, bin, eww, rices/andrea, picom, rofi-themes, dunst, sxhkd) | `~/.config/bspwm/` |
| `config/nvim`, `config/kitty`, `config/alacritty`, `config/Thunar`, `config/fontconfig`, `config/fastfetch` | `~/.config/` |
| `config/xfce4/xfconf/.../thunar.xml` | `~/.config/xfce4/xfconf/xfce-perchannel-xml/` |
| `home/Andrea-Material` | `~/.themes/` |
| `home/.xinitrc`, `home/.zshrc` | `~/` |

Fonts, emoji and icon/cursor themes: see [FONTS.md](FONTS.md).

## Not included

Wallpaper videos, other rices, backups, and secrets. The weather widget reads
`WEATHER_CITY` (default London) and a free OpenWeather key.

## Shell dependencies

`.zshrc` needs: `zsh-autosuggestions`, `zsh-syntax-highlighting`,
`zsh-history-substring-search`, `fzf-tab-git` (AUR), `eza`, `bat`, `fastfetch`.

## Background switch

`BgSwitch [dark|material|toggle|status]` swaps the rice background between
`#09090F` (near-black) and `#282828` (original Gruvbox Material) across bspwm,
eww, kitty, alacritty, nvim, rofi, dunst and the GTK theme, then reloads.
Running GTK apps need a restart to pick up the new color.
