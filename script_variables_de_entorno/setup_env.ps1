Write-Output "🔧 Iniciando configuración de entorno para Windows..."

# 1. Crear variable temporal
$env:APP_MODE = "development"
Write-Output "✅ Variable temporal APP_MODE: $env:APP_MODE"

# 2. Persistir DB_USER en el perfil
if (!(Test-Path $PROFILE)) {
New-Item -ItemType File -Path $PROFILE -Force | Out-Null
Write-Output "🆕 Perfil de PowerShell creado en $PROFILE"
}

$profileContent = Get-Content $PROFILE
if ($profileContent -notcontains '$env:DB_USER = "admin"') {
Add-Content $PROFILE '$env:DB_USER = "admin"'
Write-Output "✅ DB_USER persistida en el perfil de PowerShell"
} else {
Write-Output "ℹ️ DB_USER ya está definida en el perfil"
}

# 3. Crear archivo .env
$useProd = Read-Host "¿Usar entorno de producción? (s/n)"
if ($useProd -eq "s") {
@"
PORT=80
HOST=api.myapp.com
LOG_LEVEL=error
APP_MODE=production
"@ | Set-Content .env
Write-Output "✅ Archivo .env creado para producción"
} else {
@"
PORT=3000
HOST=localhost
LOG_LEVEL=debug
APP_MODE=development
"@ | Set-Content .env
Write-Output "✅ Archivo .env creado para desarrollo"
}

# 4. Crear script run_app.ps1
@'
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
'@ | Set-Content run_app.ps1
Write-Output "✅ Script run_app.ps1 creado"

# 5. Crear script load_env.ps1
@'
Get-Content .env | ForEach-Object {
$pair = $_ -split '='
$env:$($pair[0]) = $pair[1]
}

Write-Output "PORT: $env:PORT"
Write-Output "HOST: $env:HOST"
Write-Output "LOG_LEVEL: $env:LOG_LEVEL"

if ($env:APP_MODE -eq "production") {
Write-Output "🚀 Ejecutando en entorno de producción"
} else {
Write-Output "🧪 Ejecutando en entorno de desarrollo"
}
'@ | Set-Content load_env.ps1
Write-Output "✅ Script load_env.ps1 creado"

# 6. Ejecutar prueba
Write-Output "`n--- 🧪 Ejecutando prueba ---"
.\load_env.ps1
.\run_app.ps1
