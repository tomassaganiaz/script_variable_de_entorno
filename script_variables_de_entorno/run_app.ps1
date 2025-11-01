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
