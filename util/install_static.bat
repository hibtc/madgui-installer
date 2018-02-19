:: Install madgui in release-mode
@echo off
call "%~dp0\setvars"
if not exist "%PY_LIB%" ( mkdir "%PY_LIB%" )
if not exist "%PY_PIP%" ( mkdir "%PY_PIP%" )
echo on

pip install --upgrade pip

:: First download everything (can be used for offline installation later):
pip download -d "%PY_PIP%" -r "%MADGUI_ROOT%\util\requirements.txt"
pip download -d "%PY_PIP%" cpymad madgui

:: Install requirements.txt first to allow specify package versions:
pip install --target "%PY_LIB%" --find-links "%PY_PIP%" ^
    -r "%MADGUI_ROOT%\util\requirements.txt"

:: Install cpymad last (better in case anything goes wrong):
pip install --target "%PY_LIB%" --find-links "%PY_PIP%" minrpc
pip install --target "%PY_LIB%" --find-links "%PY_PIP%" madgui
pip install --target "%PY_LIB%" --find-links "%PY_PIP%" cpymad

@pause
