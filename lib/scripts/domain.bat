@echo off
setlocal EnableDelayedExpansion

REM ==== STEP 2: ASK DOMAIN & PORT ====

if not defined DEFAULT_HOST set "DEFAULT_HOST=localhost"
if not defined DEFAULT_PORT set "DEFAULT_PORT=8000"
if not defined HOST_IP set "HOST_IP=127.0.0.1"
if not defined HOST_PORT set "HOST_PORT=80"

echo.
set /p "CUSTOM_ASK=Use custom local domain? (yes/no): "

REM Normalize input to first character
set "FIRST_CHAR=%CUSTOM_ASK:~0,1%"

if /i "%FIRST_CHAR%"=="y" goto SETUP_CUSTOM
goto SETUP_DEFAULT

REM ==== CUSTOM DOMAIN SETUP ====
:SETUP_CUSTOM
echo.

:GETDOMAIN
set /p "HOST_INPUT=Enter Domain (e.g. project.local): "
if "%HOST_INPUT%"=="" goto GETDOMAIN
set "HOST=%HOST_INPUT%"

:GETPORT
set /p "PORT_INPUT=Enter Port (default %HOST_PORT%): "
if "%PORT_INPUT%"=="" (
    set "PORT=%HOST_PORT%"
) else (
    set "PORT=%PORT_INPUT%"
)

echo.
echo [INFO] Checking hosts file...

powershell -NoProfile -Command ^
"$ip='%HOST_IP%';$domain='%HOST%';$file='C:\Windows\System32\drivers\etc\hosts'; ^
if (-not (Select-String -Path $file -Pattern $domain -Quiet)) { ^
  try { ^
    Add-Content -Path $file -Value \"$ip`t$domain\"; ^
    Write-Host '[SUCCESS] Added domain to hosts file.' -ForegroundColor Green; ^
    Start-Process ipconfig -ArgumentList '/flushdns' -NoNewWindow -Wait; ^
    Write-Host '[INFO] DNS cache flushed.' -ForegroundColor Cyan ^
  } catch { ^
    Write-Host '[WARNING] Run as Administrator to update hosts file automatically.' -ForegroundColor Yellow ^
  } ^
} else { ^
  Write-Host '[INFO] Domain already exists in hosts file.' ^
}"

set "BIND_IP=%HOST_IP%"
goto END_DOMAIN

REM ==== DEFAULT SETUP ====
:SETUP_DEFAULT
echo.
echo Using default configuration...
set "HOST=%DEFAULT_HOST%"
set "PORT=%DEFAULT_PORT%"
set "BIND_IP=%HOST_IP%"

REM ==== RETURN VALUES TO run.bat ====
:END_DOMAIN
endlocal & (
    set "HOST=%HOST%"
    set "PORT=%PORT%"
    set "BIND_IP=%BIND_IP%"
)
