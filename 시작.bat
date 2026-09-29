@echo off
chcp 65001 > nul
cd /d "%~dp0"

where python > nul 2>&1
if errorlevel 1 (
    echo [INFO] Python not found. Installing via winget...
    winget install --id Python.Python.3.11 --source winget --silent --accept-package-agreements --accept-source-agreements
    if errorlevel 1 (
        echo [ERROR] Python installation failed.
        echo Please install manually from https://www.python.org
        pause
        exit /b 1
    )
    set "PATH=%LOCALAPPDATA%\Programs\Python\Python311;%LOCALAPPDATA%\Programs\Python\Python311\Scripts;%PATH%"
    where python > nul 2>&1
    if errorlevel 1 (
        echo [ERROR] Python installed but PATH not updated.
        echo Please close this window and run the script again.
        pause
        exit /b 1
    )
    echo [INFO] Python installed successfully.
    if exist ".deps_installed" del ".deps_installed"
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
