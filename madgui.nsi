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
    File "madgui.exe"
    File "beamopt.exe"
    File "run_beamoptikdll.bat"
    File "run_madgui.bat"
    File "run_python_here.bat"
    File "run_terminal_here.bat"
    File "sitecustomize.py"

    SetOutPath "$INSTDIR\site-packages"
    File /r "site-packages\*"

    SetOutPath $INSTDIR
    FileOpen $4 "activate.bat" w
    FileWrite $4 "set $\"PATH=$PYTHONHOME;%PATH%$\"$\r$\n"
    FileWrite $4 "set $\"PATH=$PYTHONHOME\Scripts;%PATH%$\"$\r$\n"
    FileWrite $4 "set $\"PATH=$INSTDIR\..\beamoptikdll;%PATH%$\"$\r$\n"
    FileWrite $4 "set $\"PYTHONHOME=$PYTHONHOME$\"$\r$\n"
    FileWrite $4 "set $\"PYTHONPATH=$INSTDIR$\"$\r$\n"
    FileClose $4

    FileOpen $4 "activate.ini" w
    FileWrite $4 "[python]$\r$\n"
    FileWrite $4 "home=$PYTHONHOME$\r$\n"
    FileWrite $4 "load=python37.dll$\r$\n"
    FileWrite $4 "extra=$INSTDIR\..\beamoptikdll$\r$\n"
    FileClose $4
SectionEnd
