# script_variable_de_entorno

🧪 1. Crear variables temporales

Linux (bash)

APP_MODE=development
echo $APP_MODE

🔹 Se pierde al cerrar la terminal.

Windows (PowerShell)

$env:APP_MODE = "development"
Write-Output $env:APP_MODE

🔹 También se pierde al cerrar la terminal.

🗂️ 2. Persistir una variable

Linux (bash)

Agrega al final de ~/.bashrc:

export DB_USER="admin"

Luego:

source ~/.bashrc
echo $DB_USER

Windows (PowerShell)

Agrega a tu perfil ($PROFILE):

$env:DB_USER = "admin"

Verifica abriendo una nueva terminal:

Write-Output $env:DB_USER

📜 3. Usar variables en scripts

Linux – run_app.sh

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

Windows – run_app.ps1

if (-not $env:APP_MODE) {
  Write-Output "⚠️ APP_MODE no está definida"
} else {
  Write-Output "APP_MODE: $env:APP_MODE"
}

if (-not $env:DB_USER) {
  Write-Output "⚠️ DB_USER no está definida"
} else {
  Write-Output "DB_USER: $env:DB_USER"
}

📁 4. Leer variables desde un archivo .env

Ej de .env

PORT=3000
HOST=localhost
LOG_LEVEL=debug

Linux – load_env.sh

#!/bin/bash
source .env
echo "PORT: $PORT"
echo "HOST: $HOST"
echo "LOG_LEVEL: $LOG_LEVEL"

Windows – load_env.ps1

Get-Content .env | ForEach-Object {
  $pair = $_ -split '='
  $env:$($pair[0]) = $pair[1]
}

Write-Output "PORT: $env:PORT"
Write-Output "HOST: $env:HOST"
Write-Output "LOG_LEVEL: $env:LOG_LEVEL"

🧪 5. Simular entorno de producción

.env para producción

PORT=80
HOST=api.myapp.com
LOG_LEVEL=error
APP_MODE=production

🔁 Usa el mismo script de carga (load_env.sh o .ps1) y observa cómo cambia el comportamiento según APP_MODE:

if [ "$APP_MODE" = "production" ]; then
  echo "🚀 Ejecutando en entorno de producción"
else
  echo "🧪 Ejecutando en entorno de desarrollo"
fi

_______________________________________________
if ($env:APP_MODE -eq "production") {
  Write-Output "🚀 Ejecutando en entorno de producción"
} else {
  Write-Output "🧪 Ejecutando en entorno de desarrollo"
}

📁 Estructura del proyecto script_variable_de_entorno
script_variable_de_entorno/
│
├── README.md                  # Documentación principal del proyecto
├── .env                       # Archivo de entorno (generado automáticamente)
│
├── setup_env.sh              # Script maestro para Linux (bash)
├── setup_env.ps1             # Script maestro para Windows (PowerShell)
│
├── run_app.sh                # Script de prueba para Linux
├── run_app.ps1               # Script de prueba para Windows
│
├── load_env.sh               # Script de carga de variables desde .env (Linux)
├── load_env.ps1              # Script de carga de variables desde .env (Windows)
│
├── env_templates/            # Plantillas de entorno
│   ├── development.env       # Valores por defecto para desarrollo
│   └── production.env        # Valores por defecto para producción
│
├── scripts/                  # Scripts auxiliares o extendidos
│   ├── validate_env.sh       # (opcional) Valida formato del .env
│   └── docker_env_setup.sh   # (opcional) Integración con Docker
│
└── docs/                     # Recursos didácticos o visuales
    ├── esquema_variables.png # Infografía explicativa (opcional)
    └── pasos_configuracion.md # Guía paso a paso para estudiantes
