REM ==== RUN COMPOSER (Optional) ====
if exist "%COMPOSER_PATH%" (
    echo.
    echo Do you want to run Composer for this project?
    echo   1. Yes
    echo   2. No
    set /p "RUN_COMPOSER=Select 1 or 2: "

    REM Take first character for safety
    setlocal EnableDelayedExpansion
    set "RUN_COMPOSER=!RUN_COMPOSER:~0,1!"
    set "PROJECT_DIR=%SERVER_ROOT%%PROJECT_NAME%"

    if "!RUN_COMPOSER!"=="1" (
        echo.
        echo [INFO] Target Directory set to: "!PROJECT_DIR!"
        
        REM Ensure project directory exists
        if not exist "!PROJECT_DIR!" (
            echo [INFO] Directory does not exist. Creating it now...
            mkdir "!PROJECT_DIR!"
        )

        echo ----------------------------------------

        REM Ensure PHP executable exists
        if not exist "!PHP_EXE!" (
            echo [ERROR] PHP executable not found: "!PHP_EXE!"
            goto END_COMPOSER
        )

        REM Run Composer
        if exist "!PROJECT_DIR!\composer.json" (
            echo [INFO] composer.json found. Running composer install...
            "!PHP_EXE!" "!COMPOSER_PATH!" install --working-dir="!PROJECT_DIR!"
        ) else (
            echo [INFO] composer.json not found. Running composer init...
            "!PHP_EXE!" "!COMPOSER_PATH!" init --name="enjin/!PROJECT_NAME!" --no-interaction --working-dir="!PROJECT_DIR!"

            if exist "!PROJECT_DIR!\composer.json" (
                echo [SUCCESS] composer.json created.
                echo [INFO] Running composer install after init...
                "!PHP_EXE!" "!COMPOSER_PATH!" install --working-dir="!PROJECT_DIR!"
            ) else (
                echo.
                echo [ERROR] FAILED: Composer init could not create composer.json.
                echo Please check write permissions for "!PROJECT_DIR!"
            )
        )

        echo ----------------------------------------
        if errorlevel 1 (
            echo.
            echo [WARNING] Composer encountered an error!
        ) else (
            echo.
            echo [SUCCESS] Composer process completed.
        )
    ) else if "!RUN_COMPOSER!"=="2" (
        echo.
        echo [INFO] Skipping Composer install.
    ) else (
        echo.
        echo [ERROR] Invalid choice. Skipping Composer install.
    )

    :END_COMPOSER
    endlocal
) else (
    echo [INFO] Composer.phar not found. Skipping Composer step.
)

echo.
