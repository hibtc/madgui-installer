:: Install MadQt in release-mode
@echo off
call %~dp0\setvars

:: Install common python packages
pip install --target %MADQT_PYTHON_PACKAGES% --ignore-installed ^
    -r %MADQT_ROOT%\util\requirements_common.txt

:: Install "easy" dependencies
pip install --target %MADQT_PYTHON_PACKAGES% ^
    minrpc

:: Install MadQt without cpymad, so we can do cpymad last
pip install --target %MADQT_PYTHON_PACKAGES% --no-deps ^
    madqt

:: Install cpymad separately – in case of errors
pip install --target %MADQT_PYTHON_PACKAGES% ^
    cpymad
