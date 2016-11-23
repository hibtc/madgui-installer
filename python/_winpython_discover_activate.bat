
for /f "tokens=*" %%a in ('dir /b "%~dp0\WinPython-%MADQT_ARCH%bit-%MADQT_PYTHON_VERSION%.*"') do (
    set MADQT_PYTHON_FOLDER=%~fa
)

call %MADQT_PYTHON_FOLDER%\scripts\env.bat
