!define madguiVersion "19.1.0"
!define pythonVersion "37"
!define pythonEmbedDir "python-3.7.2.post1-embed-amd64"
!define appFiles "$INSTDIR\madgui_${madguiVersion}"

OutFile "madgui_${madguiVersion}_setup.exe"
InstallDir "Z:\tools\madgui"

Page directory
Page instfiles

Section "madgui"
    SetOutPath "${appFiles}"
    File /r "${pythonEmbedDir}\*"

    File "madgui.yml"
    File "python.exe"
    File "madgui.exe"
    File "beamopt.exe"

    FileOpen $4 "python${pythonVersion}._pth" a
    FileSeek $4 0 END
    FileWrite $4 "$\r$\nimport site$\r$\n"
    FileClose $4

    SetOutPath "${appFiles}\Lib\site-packages"
    File /r "site-packages\*"

    SetOutPath "$INSTDIR"
    CreateShortCut "$INSTDIR\madgui_${madguiVersion}.lnk" "${appFiles}\madgui.exe"
    CreateShortCut "$INSTDIR\beamopt_${madguiVersion}.lnk" "${appFiles}\beamopt.exe"
    File "madgui.yml"
SectionEnd
