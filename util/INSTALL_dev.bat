:: Install MadQt in development-mode
@echo off
call "%~dp0\setvars"
echo on

:: Upgrade pip
pip install --upgrade pip

:: Install common python packages
pip install --target "%MADQT_PYTHON_PACKAGES%" ^
    -r "%MADQT_ROOT%\util\requirements_common.txt"

:: Install "easy" dependencies
pip install --src "%MADQT_PYTHON_SOURCES%" ^
    -e "git+https://github.com/hibtc/minrpc#egg=minrpc" ^
    -e "git+https://github.com/hibtc/madseq#egg=madseq"

:: Install cpymad as binary package because anything else is hard to automate
pip install --target "%MADQT_PYTHON_PACKAGES%" ^
    "cpymad"

:: madqt
pip install --src "%MADQT_PYTHON_SOURCES%" ^
    -e "git+https://github.com/hibtc/madqt#egg=madqt"

:: HIT-specific
@choice /m "Install (private) HIT specific packages?"
@if not errorlevel 2 (
    pip install --src "%MADQT_PYTHON_SOURCES%" ^
        -e "git+https://bitbucket.org/coldfix/hit-models#egg=hit-models" ^

    git clone ^
        "https://bitbucket.org/coldfix/hit-online-control#egg=hit-online-control" ^
        %MADQT_PYTHON_SOURCES%
)


@echo off
echo (Re-^)generating egg info
call "%MADQT_ROOT%\util\generate_egg_info.bat"
