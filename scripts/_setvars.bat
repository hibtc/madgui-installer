:: Adapt these pathes to your runtime:
set _PYTHON=C:\Python27

:: Set the path of the parent folder:
for %%a in (%~dp0..) do set _BASE=%%~fa

:: Add python to PATH:
set PATH=%PATH%;%_PYTHON%
set PATH=%PATH%;%_PYTHON%\Scripts

:: Make sure BeamOptikDLL.dll can be found later on:
set PATH=%PATH%;%_BASE%

:: Add 'libs' folder to PYTHONPATH, so sitecustomize.py will automatically
:: be imported whenever a python interpreter is fired:
if DEFINED PYTHONPATH (
    set PYTHONPATH=%PYTHONPATH%;%_BASE%\libs
) ELSE (
    set PYTHONPATH=%_BASE%\libs
)
