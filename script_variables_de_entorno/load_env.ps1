# Cargar variables desde .env
Get-Content .env | ForEach-Object {
$pair = $_ -split '='
$env:$($pair[0]) = $pair[1]
}

# Mostrar valores
Write-Output "PORT: $env:PORT"
Write-Output "HOST: $env:HOST"
Write-Output "LOG_LEVEL: $env:LOG_LEVEL"

# Simular entorno según APP_MODE
if ($env:APP_MODE -eq "production") {
Write-Output "🚀 Ejecutando en entorno de producción"
} else {
Write-Output "🧪 Ejecutando en entorno de desarrollo"
}
