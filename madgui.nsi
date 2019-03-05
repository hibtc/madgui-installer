!include LogicLib.nsh

!define madguiVersion "19.1.0"
!define pythonVersion "37"
!define pythonEmbedDir "python-3.7.2.post1-embed-amd64"

OutFile "madgui_${madguiVersion}_setup.exe"
InstallDir "Z:\tools\madgui\madgui_${madguiVersion}"

Var PYTHONHOME

Page components
Page directory
PageEx directory
    DirText "Help us find the python 3.7 installation for running madgui:" "Where is python 3.7 installed?"
    DirVar $PYTHONHOME
    PageCallbacks initPythonHome
PageExEnd
Page instfiles

Section "madgui"
    SetOutPath $INSTDIR

    File "madgui.yml"
    File "python.exe"
    File "madgui.exe"
    File "beamopt.exe"
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
    FileWrite $4 "load=python${pythonVersion}.dll$\r$\n"
    FileWrite $4 "extra=$INSTDIR\..\beamoptikdll$\r$\n"
    FileClose $4
SectionEnd

Section "python" SEC_EMBED_PYTHON
    SetOutPath "$PYTHONHOME"
    File /r "${pythonEmbedDir}\*"
SectionEnd

Function initPythonHome
    ${If} ${SectionIsSelected} ${SEC_EMBED_PYTHON}
        StrCpy $PYTHONHOME "$INSTDIR\${pythonEmbedDir}"
        Abort
    ${EndIf}
    ReadINIStr $PYTHONHOME $INSTDIR\activate.ini python home
FunctionEnd
