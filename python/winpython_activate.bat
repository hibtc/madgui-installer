:: Find and activate a WinPython distribution installed in this folder.
:: Before calling, you must first set MADQT_ARCH and MADQT_PYTHON_VERSION

for /f "tokens=*" %%a in ('dir /b "%~dp0\WinPython-%MADQT_ARCH%bit-%MADQT_PYTHON_VERSION%.*"') do (
    set MADQT_PYTHON_FOLDER=%~fa
)

call %MADQT_PYTHON_FOLDER%\scripts\env.bat
