# This file launch the bar/s
# Function for generating workspaces.yuck file with eww widgets
generate_eww_workspaces() {
    eww_file="${HOME}/.config/bspwm/rices/${RICE}/bar/workspaces.yuck"
    monitors=$(bspc query -M --names)
    count=0
    listen_workspaces=""
    widgets=""
    workspace_widgets=";; Workspaces Widgets ;;\n"
    printf "%s\n" ";; Workspaces ;;" > "$eww_file"
    for monitor in $monitors; do
        workspace_name="workspace${count}"
        listen_workspaces="${listen_workspaces}(deflisten ${workspace_name} \"scripts/WorkSpaces ${monitor}\")\n"
        widgets="${widgets} (box :visible { monitor==\"${monitor}\" } (${workspace_name}))\n"
        workspace_widgets="${workspace_widgets}(defwidget ${workspace_name} [] (literal :content ${workspace_name}))\n"
        count=$((count + 1))
    done
    printf "%b" "$listen_workspaces" >> "$eww_file"
    printf "%b" "$workspace_widgets" >> "$eww_file"
    printf "%b" ";; Workspaces Main Widget ;;\n(defwidget workspaces [monitor]\n (box :halign \"center\"\n :spacing 10\n :space-evenly \"false\"\n$widgets))" >> "$eww_file"
}

generate_eww_workspaces

# Get a list of monitors and sort them so that the primary monitor is first
monitors=$(xrandr -q | grep -w 'connected' | sort -k3n | cut -d' ' -f1)
count=0
for m in $monitors; do
    eww -c "${HOME}/.config/bspwm/rices/${RICE}/bar" open bar --id "$m" --arg monitor="$m" --toggle --screen "$count"
    count=$((count + 1))
done

# Fix eww when entering fullscreen state
# Se re-evalua en cada evento: si la ventana fullscreen se cierra o cambias de
# escritorio no llega un "fullscreen off" y la barra se quedaba oculta para siempre.
bspc subscribe node_state node_remove node_transfer desktop_focus | while read -r _; do
    if bspc query -N -d focused -n .fullscreen.window >/dev/null 2>&1; then
        [ "$hidden" = 1 ] || { HideBar -h; hidden=1; }
    elif [ "$hidden" = 1 ]; then
        HideBar -u; hidden=0
    fi
done &
