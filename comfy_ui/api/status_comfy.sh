#!/usr/bin/env bash
# status_comfy.sh – получает статус работающего ComfyUI
# Пример использования: ./status_comfy.sh

HOST="192.168.0.113"
PORT=8188
BASE="http://${HOST}:${PORT}"

# ---------- Проверка доступности ----------
code=$(curl -s -o /dev/null -w "%{http_code}" "$BASE/")
if [[ "$code" != "200" ]]; then
  echo "ComfyUI НЕ доступен (HTTP $code)"
  exit 1
fi

echo "ComfyUI доступен (HTTP $code)"

# ---------- Системная информация ----------
echo "--- System stats ---"
# Если установлен jq – красиво форматировать, иначе вывести как есть
if command -v jq >/dev/null 2>&1; then
  curl -s "$BASE/system_stats" | jq .
else
  curl -s "$BASE/system_stats"
fi

# ---------- Состояние очереди ----------
echo "--- Queue status ---"
if command -v jq >/dev/null 2>&1; then
  curl -s "$BASE/queue" | jq .
else
  curl -s "$BASE/queue"
fi
