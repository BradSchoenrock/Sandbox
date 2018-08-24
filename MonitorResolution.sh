#!/bin/bash

cvt 1920 1080

# 1920x1080 59.96 Hz (CVT 2.07M9) hsync: 67.16 kHz; pclk: 173.00 MHz Modeline "1920x1080_60.00"  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync

sudo xrandr --newmode "1920x1080_60.00"  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync

sudo xrandr --addmode eDP-1 "1920x1080_60.00"

xrandr --output eDP-1 --scale 1x1

#xrandr --output eDP-1 --scale 0.75x0.75

# xrandr --output eDP-1 --scale 1.5x1.5
