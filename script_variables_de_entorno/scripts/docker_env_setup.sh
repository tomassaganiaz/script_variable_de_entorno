#!/bin/bash

echo "🐳 Preparando entorno Docker..."

if [ ! -f .env ]; then
  echo "❌ No se encontró .env. Abortando."
  exit 1
fi

cp .env docker-compose.env
echo "✅ docker-compose.env generado"

if [ ! -f docker-compose.yml ]; then
  cat > docker-compose.yml <<EOF
version: '3.8'
services:
  app:
    image: alpine
    env_file:
      - docker-compose.env
    command: sh -c "echo APP_MODE=\$APP_MODE && echo DB_USER=\$DB_USER && echo PORT=\$PORT && echo HOST=\$HOST && echo LOG_LEVEL=\$LOG_LEVEL"
EOF
  echo "✅ docker-compose.yml generado"
fi

echo "🚀 Ejecutando contenedor..."
docker-compose up --build
