@echo off
setlocal EnableDelayedExpansion

REM Ask for project name
set "PROJECT_NAME=%~1"

:ASK_PROJECT
if "%PROJECT_NAME%"=="" (
    echo Current Root: %SERVER_DOC_ROOT%
    set /p "PROJECT_NAME=Enter project name to create: "
)
if "%PROJECT_NAME%"=="" goto ASK_PROJECT

REM Remove spaces
set "PROJECT_NAME=%PROJECT_NAME: =%"

REM Paths
set "PROJECT_DIR=%SERVER_DOC_ROOT%%PROJECT_NAME%"
set "INDEX_FILE=%PROJECT_DIR%\index.php"

REM ===== EXISTENCE CHECK =====
if exist "!PROJECT_DIR!" (
    echo [WARNING] Project "%PROJECT_NAME%" already exists.
    goto EXIST_CHOICE
)

mkdir "!PROJECT_DIR!" || (
    echo [ERROR] Failed to create project directory
    pause
    exit /b 1
)

goto CREATE_FILE

:EXIST_CHOICE
echo.
echo 1. Continue with existing project
echo 2. Enter new project name
set /p "CHOICE=Select 1 or 2: "

if "!CHOICE!"=="1" goto CREATE_FILE
if "!CHOICE!"=="2" (
    set "PROJECT_NAME="
    goto ASK_PROJECT
)

echo Invalid choice.
goto EXIST_CHOICE

:CREATE_FILE
echo PROJECT_DIR = "!PROJECT_DIR!"
echo INDEX_FILE  = "!INDEX_FILE!"

(
    echo ^<?php
    echo phpinfo^(^);
    echo ?^>
) > "!INDEX_FILE!"

if not exist "!INDEX_FILE!" (
    echo [ERROR] index.php was not created
    pause
    exit /b 1
)

echo [SUCCESS] Project ready: !PROJECT_NAME!
echo Path: !PROJECT_DIR!

REM Return value to run.bat
endlocal & set "PROJECT_NAME=%PROJECT_NAME%"  & set "PROJECT_DIR=%PROJECT_DIR%"
