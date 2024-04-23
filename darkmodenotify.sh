#!/bin/sh

set -ex

if [ "$DARKMODE" == "1" ]; then
	THEME="One Half Dark"
else
	THEME="One Half Light"
fi

kitten themes --reload-in=all $THEME
