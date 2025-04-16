#!/bin/bash
# Active l'effet 3D avant d'ouvrir Rofi
hyprctl keyword decoration:screen_shader ~/.config/hypr/shaders/unroll.frag

# Lance Rofi en mode "drun"
rofi -show drun

# Désactive l'effet après fermeture
hyprctl keyword decoration:screen_shader ""
