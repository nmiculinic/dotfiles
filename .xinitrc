#!/bin/bash

setxkbmap -option caps:swapescape
setxkbmap -option terminate:crtl_alt_bksp

[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap
numlockx on
exec i3

