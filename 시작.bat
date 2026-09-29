@echo off
chcp 65001 > nul
cd /d "%~dp0"

where python > nul 2>&1
if errorlevel 1 (
    echo [ERROR] Python is not installed.
    echo Please install Python from https://www.python.org
    pause
    exit /b 1
)

if not exist ".deps_installed" (
    echo [INFO] Installing required packages...
    pip install -r requirements.txt -q
    if errorlevel 1 (
        echo [ERROR] Package installation failed.
        echo Please check your internet connection or run as administrator.
        pause
        exit /b 1
    )
    echo installed > .deps_installed
    echo [INFO] Installation complete.
)

python main.py
