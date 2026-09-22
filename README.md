# Бакушев Илья, Вариант 2 

## Задание 2 (базовый уровень): Виртуальное окружение и зависимости

Создано виртуальное окружение Python для сервиса `FastAPI-service`.

- `venv/` — виртуальное окружение (в `.gitignore`)
- `FastAPI-service/requirements.txt` — основные зависимости (fastapi, torch, transformers и др.)
- `FastAPI-service/requirements-dev.txt` — зависимости для разработки (pytest, ruff и др.)
- Пакеты установлены в окружение

## Задание 17 (повышенный уровень): CI/CD для монорепозитория

Спроектирован `Jenkinsfile` для монорепозитория с двумя микросервисами:

| Сервис | Стек | Линтер | Тесты |
|---|---|---|---|
| `FastAPI-service/` | Python + FastAPI | ruff | pytest |
| `node-service/` | Node.js + Express | eslint | jest |

**Ключевые особенности пайплайна:**

- Определяет изменённые сервисы через `when { changeset "..." }`
- Запускает проверки только для затронутых сервисов
- Оба сервиса проверяются **параллельно** (директива `parallel`)
- Этапы для каждого сервиса: setup → lint → tests
- Для Python дополнительно: compilation check, TODO check

