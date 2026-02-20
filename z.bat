@echo off
cd /d "%~dp0"
start "" code .
@REM this time wait for 1 second
timeout /t 1 /nobreak >nul
taskkill /F /IM cmd.exe
