# INSTRUCTIONS.md – SMMProject

## Описание проекта
`SMMProject` — набор скриптов и настроек для работы с **Comfy UI** (генеративный графический движок) и автоматизации воркфлоу, развёрнутого на основном ПК (IP 192.168.0.113).

## Структура каталогов
```
SMMProject/
├─ comfyDoc.md                 # Общая документация по работе с Comfy UI
├─ README.md                  # Краткое описание проекта
├─ comfy_ui/                  # Код, связанный с API Comfy UI
│   ├─ adapters/              # (пока пусто) – адаптеры под разные модели/плагины
│   ├─ api/                   # API‑утилиты
│   │   ├─ check_comfy.sh     # Bash‑скрипт, проверяющий доступность Comfy UI по HTTP
│   │   └─ status_comfy.sh    # Bash‑скрипт, выводящий статус Comfy UI (запущен/не доступен)
│   └─ helpers.py             # Вспомогательные функции (пока пустой шаблон, используется в будущих workflow)

├─ scripts/                   # Вспомогательные утилиты (здесь можно размещать скрипты для локального тестирования, пока папка пуста)
├─ vps_templates/             # Шаблоны для развёртывания на VPS
│   ├─ deploy.sh              # Скрипт быстрого деплоя (docker‑compose + systemd)
│   ├─ docker-compose.yml     # Docker‑конфигурация для Comfy UI и зависимостей
│   ├─ env.sample             # Пример .env‑файла с переменными окружения
│   └─ systemd_service/
│       └─ comfyui.service    # systemd‑юнит, который стартует `python -m comfy_ui.api` на порту 8188
├─ workflows/                 # Пайплайны (Python/Shell) для генерации изображений/видео (папка готова для новых workflow‑скриптов)
└─ INSTRUCTIONS.md            # **Этот файл** – сводка структуры и назначений
```

## Назначение ключевых скриптов
- **`comfy_ui/api/check_comfy.sh`** – проверяет, запущен ли Comfy UI на `192.168.0.113:8188`. Возвращает строку *"ComfyUI is running …"* или *"ComfyUI is NOT reachable …"*.
- **`vps_templates/deploy.sh`** – автоматический деплой проекта на удалённый сервер: собирает Docker‑контейнеры, копирует `env.sample` → `.env` и подключает `comfyui.service` к `systemd`.
- **`vps_templates/docker-compose.yml`** – описывает сервис `comfyui` (образ `comfyui/comfyui` + порт 8188) и, при необходимости, дополнительный сервис для воркфлоу.
- **`vps_templates/systemd_service/comfyui.service`** – systemd‑юнит, который запускает API‑скрипт в фоне; удобно для автозапуска после перезагрузки сервера.

## Как пользоваться
1. **Запуск локального сервера**
   ```bash
   cd /home/dmitriy/.openclaw/workspace/Projects/SMMProject
   python main.py   # (или `python -m comfy_ui.api` если используете API‑скрипт)
   ```
2. **Проверить доступность**
   ```bash
   ./comfy_ui/api/check_comfy.sh
   ```
3. **Развёртывание на VPS**
   ```bash
   cd vps_templates
   ./deploy.sh   # создаст .env, запустит docker‑compose и включит systemd‑юнит
   ```
4. **Добавление новых воркфлоу**
   Помещайте готовые скрипты в `workflows/`. При готовности добавляйте их описание в этот INSTRUCTIONS.md.

---
*Этот файл поддерживается автоматически: после создания/успешного теста скрипта добавляйте короткое описание и пример использования.*