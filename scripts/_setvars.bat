rem Adapt these pathes to your runtime:
set _PYTHON=C:\Python27
for %%a in (%~dp0..) do set _BASE=%%~fa

rem Add python to PATH:
set PATH=%PATH%;%_PYTHON%
set PATH=%PATH%;%_PYTHON%\Scripts

rem Make sure BeamOptikDLL.dll can be found later on:
set PATH=%PATH%;%_BASE%

rem Add portable-lib to PYTHONPATH, so sitecustomize.py will
rem automatically be executed whenever a python interpreter is fired:
if DEFINED PYTHONPATH (
    set PYTHONPATH=%PYTHONPATH%;%_BASE%\libs
) ELSE (
    set PYTHONPATH=%_BASE%\libs
)
