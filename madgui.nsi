!define appFiles "$INSTDIR\madgui_${VERSION}"

OutFile "madgui_${VERSION}_setup.exe"
InstallDir "Z:\tools\madgui"

# Need unelevated execution context to be able to see
# network drives of the current user (Z:\):
RequestExecutionLevel user

Page directory
Page instfiles

Section "madgui"
    SetOutPath "${appFiles}"
    File /r "pkg\*"

    SetOutPath "$INSTDIR"
    File "madgui.exe"
    File "madgui.yml"
SectionEnd
