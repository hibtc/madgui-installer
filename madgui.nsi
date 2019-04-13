!define appFiles "$INSTDIR\madgui_${VERSION}"

OutFile "madgui_${VERSION}_setup.exe"
InstallDir "Z:\tools\madgui"

Page directory enableNetworkDrives
Page instfiles

Section "madgui"
    SetOutPath "${appFiles}"
    File /r "pkg\*"

    SetOutPath "$INSTDIR"
    CreateShortCut "$INSTDIR\madgui_${VERSION}.lnk" "${appFiles}\madgui.exe"
    File "madgui.yml"
SectionEnd

# Let the installer see network drives (Z:\) even if running under elevated
# priviliges:
Function enableNetworkDrives
    WriteRegDword HKLM \
            "SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" \
            "EnableLinkedConnections" 1
FunctionEnd
