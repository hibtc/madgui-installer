:: Install MadQt in release-mode
@echo off
call "%~dp0\setvars"
if not exist "%PY_LIB%" ( mkdir "%PY_LIB%" )
if not exist "%PY_PIP%" ( mkdir "%PY_PIP%" )
echo on

pip install --upgrade pip

:: First download everything (can be used for offline installation later):
pip install --download "%PY_PIP%" ^
    -r "%MADQT_ROOT%\util\requirements.txt"

pip install --download "%PY_PIP%" ^
    cpymad madqt

:: Install requirements.txt first to allow specify package versions:
pip install --target "%PY_LIB%" --find-links "%PY_PIP%" ^
    -r "%MADQT_ROOT%\util\requirements.txt"

:: Install cpymad last (better in case anything goes wrong):
pip install --target "%PY_LIB%" --find-links "%PY_PIP%" minrpc
pip install --target "%PY_LIB%" --find-links "%PY_PIP%" madqt
pip install --target "%PY_LIB%" --find-links "%PY_PIP%" cpymad

@pause
