:: Install MadQt in development-mode
@echo off
call "%~dp0\setvars"
if not exist "%PY_PIP%" ( mkdir "%PY_PIP%" )
echo on

:: First download everything (can be used for offline installation later):
pip download -d "%PY_PIP%" ^
    -r "%MADQT_ROOT%\util\requirements.txt"

:: Install common python packages
pip install --target "%PY_LIB%" --find-links "%PY_PIP%" ^
    -r "%MADQT_ROOT%\util\requirements.txt"

:: Generate the .egg_info to add the packages
cd %PY_SRC%\minrpc   && python setup.py egg_info
cd %PY_SRC%\madqt    && python setup.py egg_info
cd %PY_SRC%\hit_csys && python setup.py egg_info

:: Please do the following manually if needed:
::  "%MADQT_ROOT%\util\build_madx.bat"
::  "%MADQT_ROOT%\util\build_cpymad.bat"

pause
