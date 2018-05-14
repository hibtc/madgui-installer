@echo off
:: This script is called from other scripts to activate the python environment.

:: First load user custom config
if exist "%~dp0\env.bat" call "%~dp0\env.bat"
set "MADGUI_ROOT=%~dp0"


:: Make sure BeamOptikDLL.dll and other scripts can be found later on:
set "PATH=%MADGUI_ROOT%\bin;%MADGUI_ROOT%\runtime;%PATH%"


:: Add python to PATH:
if not defined PY_ARCH set "PY_ARCH=64"
if not defined PY_VER  set "PY_VER=3.4"
if not defined PY_ROOT set "PY_ROOT=%MADGUI_ROOT%\python"
if not defined PY_DIR (
    for /f "tokens=*" %%A in ('dir /b /a:d /o:n "%PY_ROOT%\WinPython-%PY_ARCH%bit-%PY_VER%.*"') do (
        set "PY_DIR=%PY_ROOT%\%%A"
    )
)
call "%PY_DIR%\scripts\env.bat"


:: Depend on python version/architecture
set "PY_SRC=%MADGUI_ROOT%\src"
set "PY_LIB=%MADGUI_ROOT%\lib\site-packages"
set "PY_PIP=%MADGUI_ROOT%\cache\wheelhouse"


:: Add 'lib' folder to PYTHONPATH, so sitecustomize.py will automatically
:: be imported whenever a python interpreter is fired:
if DEFINED PYTHONPATH (
    set "PYTHONPATH=%MADGUI_ROOT%\lib;%PYTHONPATH%"
) ELSE (
    set "PYTHONPATH=%MADGUI_ROOT%\lib"
)

echo on
