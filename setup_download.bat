@call "%~dp0\activate.bat"

:: Download everything (can be used for offline installation later):
pip wheel -w "%~dp0\wheels" -r "%~dp0\requirements.txt"
