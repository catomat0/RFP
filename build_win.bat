@echo off
cd /d "%~dp0"

echo =============================================
echo   Build: RFP Analyzer
echo =============================================
echo.

where python > nul 2>&1
if errorlevel 1 (
    echo [ERROR] Python not found.
    echo Install from https://www.python.org and retry.
    pause
    exit /b 1
)

echo [1/2] Installing dependencies...
python -m pip install pyinstaller pywebview fastapi "uvicorn[standard]" httpx openpyxl
if errorlevel 1 (
    echo [ERROR] pip install failed.
    pause
    exit /b 1
)

echo.
echo [2/2] Building (may take a few minutes)...
python -m PyInstaller --noconfirm build_win.spec
if errorlevel 1 (
    echo [ERROR] PyInstaller failed.
    pause
    exit /b 1
)

echo.
echo =============================================
echo   Done! Run dist\RFP-Analyzer\RFP-Analyzer.exe
echo =============================================
pause
