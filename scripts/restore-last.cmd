@echo off
setlocal
cd /d "%~dp0.."
set "DRIVE=%~1"
if not defined DRIVE set /p "DRIVE=Letra de unidad de la SD (ejemplo E): "
set "DRIVE=%DRIVE::=%"
if not defined DRIVE (
  echo ERROR: no se indico una letra de unidad.
  pause
  exit /b 1
)
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0restore-last.ps1" -DriveLetter "%DRIVE%"
if errorlevel 1 (
  echo ERROR DE RESTAURACION.
  pause
  exit /b 1
)
pause
