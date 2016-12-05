:: Generate the .egg_info to add the packages
@echo off
call %~dp0\setvars

for /f "tokens=*" %%a in ('dir /b %MADQT_ROOT%\src\*') do (
    if exist %~fa\setup.py (
        cd %~fa
        python setup.py egg_info
        cd %MADQT_ROOT%
    )
)
