!define madguiVersion "19.3.1"
!define appFiles "$INSTDIR\madgui_${madguiVersion}"

OutFile "madgui_${madguiVersion}_setup.exe"
InstallDir "Z:\tools\madgui"

Page directory
Page instfiles

Section "madgui"
    SetOutPath "${appFiles}"
    File /r "pkg\*"

    SetOutPath "$INSTDIR"
    CreateShortCut "$INSTDIR\madgui_${madguiVersion}.lnk" "${appFiles}\madgui.exe"
    File "madgui.yml"
SectionEnd
