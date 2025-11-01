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

<h3>📁 Estructura del proyecto <code>script_variable_de_entorno</code></h3>
<table>
  <thead>
    <tr>
      <th>Ruta</th>
      <th>Descripción</th>
    </tr>
  </thead>
  <tbody>
    <tr><td><code>README.md</code></td><td>Documentación principal del proyecto</td></tr>
    <tr><td><code>.env</code></td><td>Archivo de entorno (generado automáticamente)</td></tr>
    <tr><td><code>setup_env.sh</code></td><td>Script maestro para Linux (bash)</td></tr>
    <tr><td><code>setup_env.ps1</code></td><td>Script maestro para Windows (PowerShell)</td></tr>
    <tr><td><code>run_app.sh</code></td><td>Script de prueba para Linux</td></tr>
    <tr><td><code>run_app.ps1</code></td><td>Script de prueba para Windows</td></tr>
    <tr><td><code>load_env.sh</code></td><td>Script de carga de variables desde .env (Linux)</td></tr>
    <tr><td><code>load_env.ps1</code></td><td>Script de carga de variables desde .env (Windows)</td></tr>
    <tr><td><code>env_templates/development.env</code></td><td>Valores por defecto para desarrollo</td></tr>
    <tr><td><code>env_templates/production.env</code></td><td>Valores por defecto para producción</td></tr>
    <tr><td><code>scripts/validate_env.sh</code></td><td>(Opcional) Valida formato del .env</td></tr>
    <tr><td><code>scripts/docker_env_setup.sh</code></td><td>(Opcional) Integración con Docker</td></tr>
    <tr><td><code>docs/esquema_variables.png</code></td><td>Infografía explicativa (opcional)</td></tr>
    <tr><td><code>docs/pasos_configuracion.md</code></td><td>Guía paso a paso para estudiantes</td></tr>
  </tbody>
</table>
