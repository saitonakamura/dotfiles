#!/bin/sh

set -ex

if [ "$DARKMODE" == "1" ]; then
	THEME="Tokyo Night"
else
	# THEME="Doom One Light"
	THEME="Tokyo Night Day"
fi

kitten themes --reload-in=all $THEME
