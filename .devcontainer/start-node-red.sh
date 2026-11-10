#!/usr/bin/env bash

LOG="$HOME/node-red.log"

if curl -fsS http://127.0.0.1:1880/ >/dev/null 2>&1; then
    echo "Node-RED uz bezi."
    exit 0
fi

echo "Spustam Node-RED..."
nohup node-red > "$LOG" 2>&1 < /dev/null &

for i in $(seq 1 30); do
    if curl -fsS http://127.0.0.1:1880/ >/dev/null 2>&1; then
        echo "Node-RED je pripraveny na porte 1880."
        exit 0
    fi
    sleep 2
done

echo "Node-RED sa nepodarilo spustit."
cat "$LOG"
exit 1