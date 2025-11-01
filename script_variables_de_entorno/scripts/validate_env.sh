#!/bin/bash

echo "🔍 Validando archivo .env..."

if [ ! -f .env ]; then
  echo "❌ No se encontró el archivo .env"
  exit 1
fi

declare -A keys
valid=true
linenum=0

while IFS= read -r line || [ -n "$line" ]; do
  linenum=$((linenum + 1))

  # Ignorar líneas vacías o comentarios
  [[ -z "$line" || "$line" =~ ^# ]] && continue

  if [[ ! "$line" =~ ^[A-Z_][A-Z0-9_]*=.+$ ]]; then
    echo "⚠️ Línea $linenum con formato inválido: $line"
    valid=false
    continue
  fi

  key="${line%%=*}"
  if [[ -n "${keys[$key]}" ]]; then
    echo "⚠️ Clave duplicada en línea $linenum: $key"
    valid=false
  else
    keys[$key]=1
  fi
done < .env

if $valid; then
  echo "✅ .env válido"
else
  echo "❌ Se encontraron errores en .env"
  exit 1
fi
