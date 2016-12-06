:: Install MadQt in release-mode
@echo off
call %~dp0\setvars
if not exist "%MADQT_PYTHON_PACKAGES%" ( mkdir "%MADQT_PYTHON_PACKAGES%" )
echo on

pip install --upgrade pip

:: Install common python packages
pip install --target %MADQT_PYTHON_PACKAGES% ^
    -r %MADQT_ROOT%\util\requirements_common.txt

:: Install "easy" dependencies
pip install --target %MADQT_PYTHON_PACKAGES% ^
    minrpc

:: Install MadQt without cpymad, so we can do cpymad last
pip install --target %MADQT_PYTHON_PACKAGES% --no-deps ^
    https://github.com/hibtc/madqt/zipball/master

:: Install cpymad separately – in case of errors
pip install --target %MADQT_PYTHON_PACKAGES% ^
    cpymad

@pause