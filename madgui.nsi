OutFile "madgui_19.1.0_setup.exe"

InstallDir "Z:\tools\madgui\madgui_19.1.0"

Var PYTHONHOME

Page directory
PageEx directory
    DirText "Help us find the python 3.7 installation for running madgui:" "Where is python 3.7 installed?"
    DirVar $PYTHONHOME
PageExEnd
Page instfiles

Section
    SetOutPath $INSTDIR

    File "madgui.yml"
    File "python.exe"
    File "run_beamoptikdll.bat"
    File "run_madgui.bat"
    File "run_python_here.bat"
    File "run_terminal_here.bat"
    File "sitecustomize.py"
    File /r "site-packages"

    FileOpen $4 "activate.bat" w
    FileWrite $4 "set $\"PATH=$PYTHONHOME;%PATH%$\"$\r$\n"
    FileWrite $4 "set $\"PATH=$PYTHONHOME\Scripts;%PATH%$\"$\r$\n"
    FileWrite $4 "set $\"PATH=$INSTDIR\..\beamoptikdll;%PATH%$\"$\r$\n"
    FileWrite $4 "set $\"PYTHONHOME=$PYTHONHOME$\"$\r$\n"
    FileWrite $4 "set $\"PYTHONPATH=$INSTDIR$\"$\r$\n"
    FileClose $4
SectionEnd
