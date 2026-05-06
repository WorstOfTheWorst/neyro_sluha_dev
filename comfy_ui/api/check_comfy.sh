#!/usr/bin/env bash
# Проверка, запущен ли ComfyUI на основном ПК (IP 192.168.0.113)
# По умолчанию ComfyUI слушает порт 8188. Меняем при необходимости.
HOST="192.168.0.113"
PORT=8188
URL="http://${HOST}:${PORT}/"
# Попытка получить HTTP‑статус
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$URL")
if [[ "$HTTP_CODE" == "200" ]]; then
    echo "ComfyUI is running (HTTP $HTTP_CODE) at $HOST:$PORT"
else
    echo "ComfyUI is NOT reachable (HTTP $HTTP_CODE) at $HOST:$PORT"
fi
