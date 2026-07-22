@echo off
title Coco Beach - Comandas
color 0A

echo.
echo  ============================================================
echo    COCO BEACH - Sistema de Comandas
echo  ============================================================
echo.

if not exist "node_modules" (
  echo  ERROR: Primero ejecuta instalar.bat
  echo.
  pause
  exit /b 1
)

echo  Iniciando servidor...
echo  No cierres esta ventana mientras el sistema este en uso.
echo.

node server.js

echo.
echo  El servidor se ha detenido.
pause
