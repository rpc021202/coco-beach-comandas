@echo off
title Coco Beach - Instalacion
color 0A

echo.
echo  ============================================================
echo    COCO BEACH - Sistema de Comandas - Instalacion
echo  ============================================================
echo.

node --version >nul 2>&1
if %errorlevel% neq 0 (
  echo  ERROR: Node.js NO esta instalado.
  echo.
  echo  1. Abre el navegador y ve a: nodejs.org
  echo  2. Descarga la version LTS (boton verde grande)
  echo  3. Instala Node.js y vuelve a ejecutar este archivo
  echo.
  pause
  exit /b 1
)

for /f "tokens=*" %%i in ('node --version') do set NODE_VER=%%i
echo  OK - Node.js %NODE_VER% encontrado
echo.
echo  Instalando dependencias, espera 1-2 minutos...
echo.

cd /d "%~dp0"
npm install

echo.
if %errorlevel% equ 0 (
  echo  ============================================================
  echo    Instalacion completada. Ejecuta arrancar.bat para iniciar.
  echo  ============================================================
) else (
  echo  ERROR. Comprueba la conexion a internet e intentalo de nuevo.
)
echo.
pause
