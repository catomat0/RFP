@echo off
chcp 65001 > nul
echo 서버 종료 중...

:: 8000 포트 프로세스 종료
set FOUND=0
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":8000 " 2^>nul') do (
    taskkill /f /pid %%a > nul 2>&1
    set FOUND=1
)

:: ExcelKiller 창 종료
taskkill /f /fi "WINDOWTITLE eq ExcelKiller" > nul 2>&1

if "%FOUND%"=="1" (
    echo 서버가 종료되었습니다.
) else (
    echo 실행 중인 서버가 없습니다.
)
pause
