@echo off
cd /d "%~dp0"
echo Dang chay Tien Mon Linh Van tai http://127.0.0.1:4173/index.html
start "" http://127.0.0.1:4173/index.html
python start_server.py
if errorlevel 1 py start_server.py
pause
