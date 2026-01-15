@echo off
setlocal EnableDelayedExpansion

REM =========================================
REM SSL.BAT - Generate Self-Signed SSL & Nginx HTTPS Config (Optional PHP)
REM =========================================

REM ==============================
REM DETECT SYSTEM ARCHITECTURE
REM ==============================
if /i "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
    if exist "%OPENSSL_EXE_64%" (
        set "OPENSSL_BIN=%OPENSSL_EXE_64%"
    ) else if exist "%OPENSSL_EXE_86%" (
        set "OPENSSL_BIN=%OPENSSL_EXE_86%"
        echo [WARNING] Using 32-bit OpenSSL on 64-bit OS.
    ) else (
        echo [ERROR] No OpenSSL executable found!
        exit /b 1
    )
) else (
    if exist "%OPENSSL_EXE_86%" (
        set "OPENSSL_BIN=%OPENSSL_EXE_86%"
    ) else (
        echo [ERROR] No 32-bit OpenSSL executable found!
        exit /b 1
    )
)
echo [INFO] Using OpenSSL: %OPENSSL_BIN%

REM ==============================
REM CREATE SSL DIRECTORY IF MISSING
REM ==============================
for %%F in ("%SSL_KEY%") do set "SSL_DIR=%%~dpF"
if not exist "%SSL_DIR%" (
    echo [INFO] Creating SSL directory: %SSL_DIR%
    mkdir "%SSL_DIR%"
)

REM ==============================
REM GENERATE SSL IF MISSING
REM ==============================
if exist "%SSL_KEY%" if exist "%SSL_CERT%" if exist "%SSL_PEM%" (
    echo [INFO] SSL key, certificate, and PEM already exist. Skipping generation.
) else (
    if not exist "%OPENSSL_CONF%" (
        echo [ERROR] openssl.cnf not found at %OPENSSL_CONF%
        exit /b 1
    )

    echo [INFO] Generating self-signed SSL certificate...
    "%OPENSSL_BIN%" req -x509 -nodes -days 365 -newkey rsa:2048 ^
        -keyout "%SSL_KEY%" -out "%SSL_CERT%" ^
        -config "%OPENSSL_CONF%" ^
        -subj "/C=US/ST=Local/L=Local/O=Enjin/OU=Dev/CN=%HOST%"

    if errorlevel 1 (
        echo [ERROR] SSL certificate generation failed
        exit /b 1
    )

    REM CREATE COMBINED PEM
    copy /b "%SSL_KEY%"+"%SSL_CERT%" "%SSL_PEM%" >nul
)

REM ==============================
REM VERIFY SSL FILES
REM ==============================
if not exist "%SSL_KEY%" (
    echo [ERROR] SSL key missing: %SSL_KEY%
    exit /b 1
)
if not exist "%SSL_CERT%" (
    echo [ERROR] SSL certificate missing: %SSL_CERT%
    exit /b 1
)
if not exist "%SSL_PEM%" (
    echo [ERROR] PEM file missing: %SSL_PEM%
    exit /b 1
)

echo.
echo [SUCCESS] SSL certificate ready:
echo   Key : %SSL_KEY%
echo   Cert: %SSL_CERT%
echo   PEM : %SSL_PEM%
echo.


exit /b 0
