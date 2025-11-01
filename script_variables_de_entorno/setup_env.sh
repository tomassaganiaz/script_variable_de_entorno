#!/bin/bash

echo "🔧 Iniciando configuración de entorno para Linux..."

# 1. Crear variable temporal
APP_MODE="development"
export APP_MODE
echo "✅ Variable temporal APP_MODE: $APP_MODE"

# 2. Persistir DB_USER en .bashrc
if ! grep -q 'export DB_USER=' ~/.bashrc; then
echo 'export DB_USER="admin"' >> ~/.bashrc
echo "✅ DB_USER persistida en ~/.bashrc"
else
echo "ℹ️ DB_USER ya está definida en ~/.bashrc"
fi
source ~/.bashrc

# 3. Crear archivo .env
read -p "¿Usar entorno de producción? (s/n): " prod
if [[ "$prod" == "s" ]]; then
cat > .env <<EOF
PORT=80
HOST=api.myapp.com
LOG_LEVEL=error
APP_MODE=production
EOF
echo "✅ Archivo .env creado para producción"
else
cat > .env <<EOF
PORT=3000
HOST=localhost
LOG_LEVEL=debug
APP_MODE=development
EOF
echo "✅ Archivo .env creado para desarrollo"
fi

# 4. Crear script run_app.sh
cat > run_app.sh <<'EOF'
#!/bin/bash

if [ -z "$APP_MODE" ]; then
echo "⚠️ APP_MODE no está definida"
else
echo "APP_MODE: $APP_MODE"
fi

if [ -z "$DB_USER" ]; then
echo "⚠️ DB_USER no está definida"
else
echo "DB_USER: $DB_USER"
fi
EOF
chmod +x run_app.sh
echo "✅ Script run_app.sh creado"

# 5. Crear script load_env.sh
cat > load_env.sh <<'EOF'
#!/bin/bash

source .env
echo "PORT: $PORT"
echo "HOST: $HOST"
echo "LOG_LEVEL: $LOG_LEVEL"

if [ "$APP_MODE" = "production" ]; then
echo "🚀 Ejecutando en entorno de producción"
else
echo "🧪 Ejecutando en entorno de desarrollo"
fi
EOF
chmod +x load_env.sh
echo "✅ Script load_env.sh creado"

# 6. Ejecutar prueba
echo -e "\n--- 🧪 Ejecutando prueba ---"
./load_env.sh
./run_app.sh
