# Fonts, emoji and icons

Font binaries are **not** committed: Apple Color Emoji and Cartograph CF are
proprietary, and the free ones are available from the repos below.

| Used by | Font | Source |
|---|---|---|
| kitty | IosevkaTerm Nerd Font Mono | `ttf-iosevkaterm-nerd` |
| alacritty | IosevkaTerm Nerd Font Propo | `ttf-iosevkaterm-nerd` |
| eww bar, dunst, rofi | JetBrainsMono Nerd Font | `ttf-jetbrains-mono-nerd` |
| eww bar | Inconsolata SemiCondensed, Bebas Neue | `ttf-inconsolata`, `ttf-bebas-neue` |
| eww bar (icons) | Font Awesome 6 Free Solid, Material Design Icons Desktop | `ttf-font-awesome`, `ttf-material-design-icons-desktop-git` (AUR) |
| eww player / profile card | Cartograph CF | commercial, buy it or replace it in `bspwm/eww/**/*.scss` |
| Emoji | Apple Color Emoji | `ttf-apple-emoji` (AUR, https://github.com/samuelngs/apple-emoji-ttf) |
| CJK fallback | Noto Sans CJK JP | `noto-fonts-cjk` |
| Nerd icon fallback | Symbols Nerd Font | `ttf-nerd-fonts-symbols` |

Emoji wiring lives in `config/fontconfig/conf.d/60-apple-emoji.conf`
(copy to `~/.config/fontconfig/conf.d/`, then run `fc-cache -fv`).

## GTK (Andrea rice)

- Theme: `Andrea-Material` (`home/Andrea-Material` → `~/.themes/`)
- Icons: `Gruvbox-Plus-Dark` (AUR: `gh0stzk-icons-gruvbox-plus-dark`)
- Cursor: `Qogirr-Dark` (AUR: `gh0stzk-cursor-qogirr`)
- Applied through `bspwm/config/xsettingsd`.
