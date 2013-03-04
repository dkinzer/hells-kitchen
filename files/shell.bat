@echo off
set SCRIPT_DIR=%~dp0
set DEVKITDIR=%SCRIPT_DIR%tools\devkit
set HOME=%SCRIPT_DIR%home
cmd /C %DEVKITDIR%\bin\sh --init-file %HOME%\.bashrc --login -i
