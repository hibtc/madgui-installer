:: Install madgui in development-mode
@call "%~dp0\lib\_setvars"

:: Install dependencies
pip install --target "%PY_LIB%" --find-links "%PY_PIP%" ^
    -r "%MADGUI_ROOT%\requirements.txt"

:: Now install madgui itself
cd "%PY_SRC%\madgui"   && python setup.py egg_info
cd "%PY_SRC%\hit_acs"  && python setup.py egg_info
pause
