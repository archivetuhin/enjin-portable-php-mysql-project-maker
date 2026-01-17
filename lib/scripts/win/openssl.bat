@echo off
REM =========================================
REM OpenSSL Launcher using config\config.ini
REM =========================================

REM Get the directory of this batch file
set SCRIPT_DIR=%~dp0

REM Set config file path
set CONFIG_FILE=%SCRIPT_DIR%config\config.ini

REM Load variables from config.ini
for /f "usebackq tokens=1,* delims==" %%A in ("%CONFIG_FILE%") do (
    set "%%A=%%B"
)

REM Choose which OpenSSL binary to use
if exist "%OPENSSL_64%\openssl.exe" (
    set OPENSSL_HOME=%OPENSSL_64%
) else if exist "%OPENSSL_86%\openssl.exe" (
    set OPENSSL_HOME=%OPENSSL_86%
) else (
    echo ERROR: OpenSSL not found in config paths!
    pause
    exit /b
)

REM Set environment variables
set OPENSSL_CONF=%SSL_FILE_PATH%\openssl.cnf
set PATH=%OPENSSL_HOME%;%PATH%

REM Optional: change to OpenSSL directory
cd /d %OPENSSL_HOME%

REM Show OpenSSL version
echo Using OpenSSL at: %OPENSSL_HOME%
openssl version -a

REM Pass any arguments to OpenSSL
openssl %*
