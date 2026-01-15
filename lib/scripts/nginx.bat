@echo off
setlocal EnableDelayedExpansion

REM ==================================================
REM NGINX.BAT - Configure Nginx for HTTP/HTTPS
REM Overwrites existing nginx.conf
REM ==================================================

REM Step 0: Ensure project variables are loaded
set "PROJECT_DIR=%SERVER_ROOT%%PROJECT_NAME%"

REM Step 1: Ask if SSL should be used
echo.
echo 1) Yes
echo 2) No
set /p "USE_SSL=Do you want to use SSL for this project? (1/2): "
if "%USE_SSL%"=="" set "USE_SSL=2"

REM Normalize input: 1 = Yes, 2 = No
if "%USE_SSL%"=="1" (
    set "USE_SSL=Y"
) else (
    set "USE_SSL=N"
)

REM Step 2: Generate SSL if needed
if /i "%USE_SSL%"=="Y" (
        taskkill /IM nginx.exe /F

    if not exist "%SSL_KEY%" (
        echo [INFO] SSL key not found. Calling ssl.bat...
        if exist "%SSL_INSTALL%" (
            call "%SSL_INSTALL%"
            if errorlevel 1 (
                echo [WARNING] SSL setup failed. Falling back to HTTP.
                set "USE_SSL=N"
            ) else (
                echo [INFO] SSL setup completed successfully.
            )
        ) else (
            echo [WARNING] ssl.bat not found. Falling back to HTTP.
            set "USE_SSL=N"
        )
    ) else (
        echo [INFO] SSL certificate/key already exist.
    )
echo use ssl %USE_SSL%

REM Step 3: Prepare variables for nginx.conf
set "NGINX_CRT=%SSL_CERT:\=/%"
set "NGINX_KEY=%SSL_KEY:\=/%"
set "P_DIR=%PROJECT_DIR:\=/%"


REM Step 4: Overwrite nginx.conf
echo [INFO] Rewriting nginx.conf content...
(
    echo worker_processes 1;
    echo daemon off;
    echo.
    echo events {
    echo     worker_connections 1024;
    echo }
    echo.
    echo http {
    echo     include mime.types;
    echo     default_type application/octet-stream;
    echo.
    echo     server {

    echo         listen 443 ssl;
    echo         ssl_certificate "!NGINX_CRT!";
    echo         ssl_certificate_key "!NGINX_KEY!";


    echo         server_name %HOST%;
    echo         root !P_DIR!;
    echo         index index.php index.html;
    echo.
    echo         location / {
    echo             try_files $uri $uri/ /index.php?$query_string;
    echo         }
    echo.
    echo         location ~ \.php$ {
    echo             fastcgi_pass %BIND_IP%:%PORT%;
    echo             fastcgi_index index.php;
    echo             fastcgi_param SCRIPT_FILENAME "!P_DIR!/index.php";
    echo             include fastcgi_params;
    echo         }
    echo     }
    echo }
    ) > "%NGINX_CONF%"
)

echo [INFO] nginx.conf content overwritten: %NGINX_CONF%
 endlocal & set "USE_SSL=%USE_SSL%"


echo [INFO] Nginx setup completed.
exit /b 0
