:: Install cpymad C-extension in the local src folder, you need to download
:: the cpymad module first
@echo off
call %~dp0\..\scripts\setvars

cd %MADQT_ROOT%\madgui-portable\cpymad

del /f cpymad\libmadx.pyd cpymad\libmadx.c
rd /s /q build

call python setup.py build_ext -lquadmath -c mingw32 --madxdir=%MADX_FOLDER% --inplace
call python setup.py build egg_info
pause
