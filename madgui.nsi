!define madguiVersion "19.1.0"
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
    CreateShortCut "$INSTDIR\beamopt_${madguiVersion}.lnk" "${appFiles}\beamopt.exe"
    File "madgui.yml"
SectionEnd
