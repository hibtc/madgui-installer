:: Set the path of the parent folder:
for %%a in (%~dp0..) do set _BASE=%%~fa

:: Make sure BeamOptikDLL.dll can be found later on:
set PATH=%PATH%;%_BASE%\dll

:: Add python to PATH:
if NOT DEFINED _PYTHON (
    call %_BASE%\python\default.bat
)

:: Add 'libs' folder to PYTHONPATH, so sitecustomize.py will automatically
:: be imported whenever a python interpreter is fired:
if DEFINED PYTHONPATH (
    set PYTHONPATH=%PYTHONPATH%;%_BASE%\lib
) ELSE (
    set PYTHONPATH=%_BASE%\lib
)
