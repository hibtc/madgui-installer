:: This script is called from other scripts to activate the python environment.

:: Determine path of parent folder:
for %%a in (%~dp0..) do set _BASE=%%~fa
set MADQT_ROOT=%_BASE%

:: Make sure BeamOptikDLL.dll can be found later on:
set PATH=%MADQT_ROOT%\bin;%MADQT_ROOT%\runtime;%PATH%

:: Add python to PATH:
set MADQT_PYTHON_INIT=%MADQT_ROOT%\python\default.bat
call %MADQT_PYTHON_INIT%
set MADQT_PYTHON_PACKAGES=%MADQT_ROOT%\lib\%MADQT_ARCH%\python%MADQT_PYTHON_VERSION%
set MADQT_PYTHON_SOURCES=%MADQT_ROOT%\src

:: Add 'lib' folder to PYTHONPATH, so sitecustomize.py will automatically
:: be imported whenever a python interpreter is fired:
if DEFINED PYTHONPATH (
    set PYTHONPATH=%MADQT_ROOT%\lib;%PYTHONPATH%
) ELSE (
    set PYTHONPATH=%MADQT_ROOT%\lib
)
