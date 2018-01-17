:: This script is called from other scripts to activate the python environment.

:: Determine path of parent folder:
for %%a in (%~dp0..) do set _BASE=%%~fa
set MADQT_ROOT=%_BASE%
set MADQT_BIN=%MADQT_ROOT%\bin
set MADQT_LIB=%MADQT_ROOT%\lib
set MADQT_SRC=%MADQT_ROOT%\src
set PY_SRC=%MADQT_SRC%


:: Make sure BeamOptikDLL.dll and other scripts can be found later on:
set PATH="%MADQT_ROOT%\bin";"%MADQT_ROOT%\runtime";"%MADX_BIN%\bin";%PATH%


:: Add python to PATH:
call "%MADQT_ROOT%\python\default.bat"
set PY_LIB=%MADQT_LIB%\python%PY_VER%-%PY_ARCH%bit


:: Depend on python version/architecture
set PY_PIP=%MADQT_ROOT%\pip\python%PY_VER%-%PY_ARCH%bit
set MADX_BIN=%MADQT_BIN%\madx%PY_ARCH%


:: Add 'lib' folder to PYTHONPATH, so sitecustomize.py will automatically
:: be imported whenever a python interpreter is fired:
if DEFINED PYTHONPATH (
    set PYTHONPATH=%MADQT_ROOT%\lib;%PYTHONPATH%
) ELSE (
    set PYTHONPATH=%MADQT_ROOT%\lib
)
