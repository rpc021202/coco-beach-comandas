@echo off
title Coco Beach - Barra
echo Cerrando Chrome...
taskkill /F /IM chrome.exe /T 2>nul
timeout /t 2 /nobreak >nul
echo Abriendo Coco Beach Barra...
start "" "C:\Program Files\Google\Chrome\Application\chrome.exe" --kiosk-printing --start-maximized "https://coco-beach-comandas.onrender.com/barra.html"
