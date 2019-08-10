#!/bin/bash
# Shows top 9 memory usage processes
# idea by Luke Smith, https://lukesmith.xyz
ps axch -o pid,cmd:20,%mem --sort=-%mem | head -9 | awk '{print $0 "%"}'

