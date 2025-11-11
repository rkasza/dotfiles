#!/bin/bash

pid=$(pgrep -x "hyprsunset")
echo "$pid"
if [ -n "$pid" ]; then
  kill -9 $pid
  notify-send "Night Light Off" -u "low"
else
  hyprsunset --temperature 4500 &
  notify-send "Night Light On" -u "low"
fi
