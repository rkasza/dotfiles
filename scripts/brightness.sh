#!/usr/bin/env bash

function notify_brightness() {
  # Function to show brightness notification
  CB=$(ddcutil getvcp 10 | sed -n 's/.*current value =\s*\([0-9]*\).*/\1/p')
  notify-send "New brightness is set to: $CB%"
}

# Check command line arguments
if [[ "$#" != 1 || ! ("$1" == "inc" || "$1" == "dec") ]]; then
  printf "Usage: %s [inc|dec]\n" "$0" >&2
  exit 1
fi

CURRENT_BRIGHTNESS=$(ddcutil getvcp 10 | sed -n 's/.*current value =\s*\([0-9]*\).*/\1/p')
MAX_BRIGHTNESS=$(ddcutil getvcp 10 | sed -n 's/.*max value =\s*\([0-9]*\).*/\1/p')

# Perform brightness adjustment
if [[ "$1" == "inc" ]]; then
  new_brightness=$((CURRENT_BRIGHTNESS + 10))
  ddcutil setvcp 10 $new_brightness
  notify_brightness
elif [[ "$1" == "dec" ]]; then
  new_brightness=$((CURRENT_BRIGHTNESS - 10))
  ddcutil setvcp 10 $new_brightness
  notify_brightness
fi
