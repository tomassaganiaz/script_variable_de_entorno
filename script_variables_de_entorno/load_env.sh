#!/bin/bash

# Cargar variables desde .env
source .env

# Mostrar valores
echo "PORT: $PORT"
echo "HOST: $HOST"
echo "LOG_LEVEL: $LOG_LEVEL"

# Simular entorno según APP_MODE
if [ "$APP_MODE" = "production" ]; then
echo "🚀 Ejecutando en entorno de producción"
else
echo "🧪 Ejecutando en entorno de desarrollo"
fi
