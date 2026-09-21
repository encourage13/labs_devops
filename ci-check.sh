#!/bin/bash
echo "🔍 CI: проверка на TODO в Python файлах..."

TODO_FILES=$(find . -name "*.py" \
  -not -path "./venv/*" \
  -not -path "./.venv/*" \
  -not -path "*/node_modules/*" \
  -not -path "*/build/*" \
  -not -path "*/.git/*" \
  -not -path "*/__pycache__/*" \
  -print0 | xargs -0 grep -l "TODO" 2>/dev/null || true)

if [ -n "$TODO_FILES" ]; then
    echo "❌ CI failed: TODO found in codebase"
    echo "Файлы с TODO:"
    echo "$TODO_FILES"
    exit 1
fi

echo "✅ CI passed: TODO не найдены"
exit 0