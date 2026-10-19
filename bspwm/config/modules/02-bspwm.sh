#!/bin/sh

bspc config border_width ${BORDER_WIDTH}
bspc config top_padding ${TOP_PADDING}
bspc config bottom_padding ${BOTTOM_PADDING}
bspc config left_padding ${LEFT_PADDING}
bspc config right_padding ${RIGHT_PADDING}

# Lo de arriba es el padding global, pero bspwm guarda ademas uno por
# monitor que lo pisa, y ese se ajusta solo a partir del _NET_WM_STRUT de
# las barras. Ahi quedaba un bottom de 37 que nadie pedia: polybar reserva
# 37 pero solo arriba (strut = 0,0,37,0). Resultado: ~43px muertos abajo
# en todas las ventanas, contra 8px en los otros tres lados.
# Reaplicarlo por monitor deja el borde inferior tan ajustado como el resto.
for monitor in $(bspc query -M --names); do
    bspc config -m "$monitor" top_padding ${TOP_PADDING}
    bspc config -m "$monitor" bottom_padding ${BOTTOM_PADDING}
    bspc config -m "$monitor" left_padding ${LEFT_PADDING}
    bspc config -m "$monitor" right_padding ${RIGHT_PADDING}
done

bspc config normal_border_color "${NORMAL_BC}"
bspc config focused_border_color "${FOCUSED_BC}"
bspc config presel_feedback_color "${blue}"
