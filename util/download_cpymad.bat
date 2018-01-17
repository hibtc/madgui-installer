:: Install prebuilt cpymad
@echo off
call "%~dp0\setvars"
if not exist "%PY_LIB%" ( mkdir "%PY_LIB%" )
if not exist "%PY_PIP%" ( mkdir "%PY_PIP%" )
echo on

pip install --download "%PY_PIP%" cpymad
pip install --target "%PY_LIB%" --find-links "%PY_PIP%" -I cpymad

@pause
