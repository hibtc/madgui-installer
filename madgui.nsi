!include LogicLib.nsh

!define madguiVersion "19.1.0"
!define pythonVersion "37"
!define pythonEmbedDir "python-3.7.2.post1-embed-amd64"
!define appFiles "$INSTDIR\madgui_${madguiVersion}"

OutFile "madgui_${madguiVersion}_setup.exe"
InstallDir "Z:\tools\madgui"

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
    SetOutPath "${appFiles}"

    File "madgui.yml"
    File "python.exe"
    File "madgui.exe"
    File "beamopt.exe"
    File "sitecustomize.py"

    SetOutPath "${appFiles}\site-packages"
    File /r "site-packages\*"

    SetOutPath "${appFiles}"
    FileOpen $4 "activate.bat" w
    FileWrite $4 "set $\"PATH=$PYTHONHOME;%PATH%$\"$\r$\n"
    FileWrite $4 "set $\"PATH=$PYTHONHOME\Scripts;%PATH%$\"$\r$\n"
    FileWrite $4 "set $\"PYTHONHOME=$PYTHONHOME$\"$\r$\n"
    FileWrite $4 "set $\"PYTHONPATH=$INSTDIR$\"$\r$\n"
    FileClose $4

    FileOpen $4 "activate.ini" w
    FileWrite $4 "[python]$\r$\n"
    FileWrite $4 "home=$PYTHONHOME$\r$\n"
    FileWrite $4 "load=python${pythonVersion}.dll$\r$\n"
    FileClose $4

    SetOutPath "$INSTDIR"
    CreateShortCut "$INSTDIR\madgui_${madguiVersion}.lnk" "${appFiles}\madgui.exe"
    CreateShortCut "$INSTDIR\beamopt_${madguiVersion}.lnk" "${appFiles}\beamopt.exe"
    File "madgui.yml"
SectionEnd

Section "python" SEC_EMBED_PYTHON
    SetOutPath "$PYTHONHOME"
    File /r "${pythonEmbedDir}\*"
SectionEnd

Function initPythonHome
    ${If} ${SectionIsSelected} ${SEC_EMBED_PYTHON}
        StrCpy $PYTHONHOME "${appFiles}\${pythonEmbedDir}"
        Abort
    ${EndIf}
    ReadINIStr $PYTHONHOME ${appFiles}\activate.ini python home
FunctionEnd
