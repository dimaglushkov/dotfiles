#!/bin/bash
# Shows top 9 cpu usage processes
# idea by Luke Smith, https://lukesmith.xyz

ps axch -o pid,cmd:20,%cpu --sort=-%cpu | head -9 | awk '{print $0 "%"}'
