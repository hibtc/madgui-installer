@echo off
:: This script is called from other scripts to prepare the environment.

:: Determine path of parent folder:
for %%a in (%~dp0) do set "MADGUI_ROOT=%%~fa"

:: Load user custom config
if exist "%~dp0..\env.bat" call "%~dp0..\env.bat"

:: Depend on python version/architecture
set "PY_SRC=%MADGUI_ROOT%\src"
set "PY_LIB=%MADGUI_ROOT%\site-packages"
set "PY_PIP=%MADGUI_ROOT%\wheelhouse"

:: Add this folder to PYTHONPATH, so sitecustomize.py will automatically
:: be imported whenever a python interpreter is fired:
if DEFINED PYTHONPATH (
    set "PYTHONPATH=%MADGUI_ROOT%;%PYTHONPATH%"
) ELSE (
    set "PYTHONPATH=%MADGUI_ROOT%"
)

echo on
