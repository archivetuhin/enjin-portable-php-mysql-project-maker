@echo off
setlocal EnableDelayedExpansion

REM ==================================================
REM 1. INPUT LOOP
REM ==================================================
set "PROJECT_NAME=%~1"

:ASK_PROJECT
if "%PROJECT_NAME%"=="" (
    echo Current Root: %SERVER_DOC_ROOT%
    set /p "PROJECT_NAME=Enter project name to create: "
)

if "%PROJECT_NAME%"=="" (
    echo [ERROR] No project name provided.
    goto ASK_PROJECT
)

REM Remove spaces
set "PROJECT_NAME=%PROJECT_NAME: =%"

REM ==================================================
REM 2. CHECK EXISTENCE
REM ==================================================
set "PROJECT_DIR=%SERVER_DOC_ROOT%\%PROJECT_NAME%"

if exist "%PROJECT_DIR%" (
    echo [ERROR] Project "%PROJECT_NAME%" already exists.
    set "PROJECT_NAME="
    goto ASK_PROJECT
)

REM ==================================================
REM 3. CREATE FOLDER AND FILE
REM ==================================================
mkdir "%PROJECT_DIR%" || (
    echo [ERROR] Failed to create project directory.
    pause
    exit /b 1
)

(
    echo ^<?php phpinfo^(^); ^?>
) > "%PROJECT_DIR%\index.php"

echo [SUCCESS] Created project: %PROJECT_NAME%
echo Path: %PROJECT_DIR%

REM ==================================================
REM 4. RETURN VALUE TO run.bat
REM ==================================================
endlocal & set "PROJECT_NAME=%PROJECT_NAME%"
exit /b 0
