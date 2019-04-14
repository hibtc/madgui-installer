!define appFiles "$INSTDIR\madgui_${VERSION}"

OutFile "madgui_${VERSION}_setup.exe"
InstallDir "Z:\tools\madgui"

Page directory
Page instfiles

Section "madgui"
    SetOutPath "${appFiles}"
    File /r "pkg\*"

    SetOutPath "$INSTDIR"
    CreateShortCut "$INSTDIR\madgui_${VERSION}.lnk" "${appFiles}\madgui.exe"
    File "madgui.yml"
SectionEnd
