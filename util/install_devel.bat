:: Install MadQt in development-mode
@echo off
call "%~dp0\setvars"
echo on

if not exist "%PY_PIP%" ( mkdir "%PY_PIP%" )

:: First download everything (can be used for offline installation later):
pip install --download "%PY_PIP%" ^
    -r "%MADQT_ROOT%\util\requirements.txt"

:: Install common python packages
pip install --target "%PY_LIB%" --find-links "%PY_PIP%" -I ^
    -r "%MADQT_ROOT%\util\requirements.txt"

:: Install "easy" dependencies
cd "%PY_SRC%\minrpc" && python setup.py develop -d "%PY_LIB%"
cd "%PY_SRC%\madqt"  && python setup.py develop -d "%PY_LIB%"

:: Please do the following manually if needed:
::  "%MADQT_ROOT%\util\build_madx.bat"
::  "%MADQT_ROOT%\util\build_cpymad.bat"

@echo off
echo (Re-^)generating egg info
call "%MADQT_ROOT%\util\generate_egg_info.bat"
