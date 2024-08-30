#!/bin/sh

swaymsg reload
killall waybar
swaymsg exec waybar

