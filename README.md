# ZDot 0.8 ALPHA release
# Revision: 2020-08-23
#
# -------------------------
# Places two high-visibility "you are here" markers over the Zwift in-game map
# See the file WhatZDotLooksLike.png for an example
# Author: ObiQuiet, quietjedi@gmail.com
# -------------------------
# Depends on AutoHotKey https://www.autohotkey.com/ for Windows
#
# -------------------------
# Limitations
# * Hard-coded to a maximized, not fullscreen, Zwift game window
#     - ZDot will maximize the game window for you if it appears after ZDot starts
# * Hard-coded to the current version of the Zwift game interface  (version 1.0.53547)
#     - Zwift may well change elements of their game UI which ZDot is sensitive to, making this code obsolete
# * Zwift needs to be the active window (not in the background, with e.g. Discord being active)
#
# * Accuracy and stability of the moving dot could be improved still
# * The dot in the center of the map is aligned for the zoomed-out map only, not the zoomed-in or perspective map
#     - in game, click on the map to cycle between its modes   
# 
# Bonus Feature
# * ZDot will move the mouse cursor off the screen if it's been left idle for while
#
