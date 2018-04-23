:: Install prebuilt cpymad
@echo off
call "%~dp0\setvars"
if not exist "%PY_LIB%" ( mkdir "%PY_LIB%" )
if not exist "%PY_PIP%" ( mkdir "%PY_PIP%" )
echo on

pip uninstall -y cpymad
pip download --pre -d "%PY_PIP%" cpymad
pip install --pre --target "%PY_LIB%" --find-links "%PY_PIP%" cpymad

@pause
