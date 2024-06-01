#!/bin/bash

address="https://www.google.com"
proxy="https:http://127.0.0.1:7890"
# as specific as possible
response=`xh get -h --timeout 5 --proxy ${proxy} ${address} 2>&1`

if echo "$response" | grep "error" 1>/dev/null 2>/dev/null; then
    echo "Network Error"
else
    echo $(echo "$response" | head -n 1 | cut -d' ' -f2-)
fi
