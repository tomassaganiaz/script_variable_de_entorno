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
