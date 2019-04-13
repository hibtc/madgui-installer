$ErrorActionPreference = "Stop"

function call()
{
    & $args[0] $args[1..$args.length]
    if (!$?) { throw "Exit code $LastExitCode from command `"$args`"." }
}

# On some machines required to make HTTPS work:
[Net.ServicePointManager]::Expect100Continue = $true;
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;

# Download embeddable python:
$zip = "python-3.7.2.post1-embed-amd64.zip"
$url = "https://www.python.org/ftp/python/3.7.2/$zip"
$web = New-Object System.Net.WebClient
$web.DownloadFile($url, $zip)
Expand-Archive -Force -LiteralPath $zip -DestinationPath pkg
Add-Content pkg\python37._pth "import site`r`n"
Add-Content pkg\python37._pth "purelib.zip`r`n"
Add-Content pkg\python37._pth "distinfo.zip`r`n"

# Install py37 for site-packages:
conda create -p py37 -qy python=3.7 wheel
conda activate .\py37
conda install -qy nsis -c nsis

call pip wheel -w wheels -r requirements.txt
call pip install -f wheels -r requirements.txt `
    -t pkg\Lib\site-packages --no-index -I
rm -r pkg\Lib\site-packages\bin

# Safe our packages at top level to make them easier to find and edit,
# and to prevent them from being minified down below:
mv pkg\Lib\site-packages\madgui pkg
mv pkg\Lib\site-packages\minrpc pkg
mv pkg\Lib\site-packages\cpymad pkg
mv pkg\Lib\site-packages\hit_acs pkg

# Performance tweaks: remove .py files and zip up pure thirdparty packages:
call pip install distlib
call python minify.py pkg\Lib\site-packages
call python purelib.py pkg\Lib\site-packages
mv purelib.zip pkg

# Install py34 for mingwpy:
conda create -p py34 -qy python=3.4
conda install -p py34 -qy mingwpy -c conda-forge

$gcc = "py34\Scripts\gcc.exe"
$windres = "py34\Scripts\windres.exe"
$cflags = @( '-Ipy37\include' )
$lflags = @( '-Lpy37\libs', '-lpython37', '-nostdlib', '-lkernel32', '-lshell32' )

# Determine madgui version, and create madgui.rc:
$env:VERSION = & python -c "import madgui; print(madgui.__version__)"
call pip install j2cli
call j2 madgui.template.rc > madgui.rc

call $gcc @cflags python.c @lflags -o pkg\python.exe

call $windres madgui.rc -O coff -o madgui.res
call $gcc @cflags launcher.c @lflags -o pkg\madgui.exe `
    "-DMODULE=madgui" -mwindows madgui.res
call $gcc @cflags launcher.c @lflags -o pkg\beamopt.exe `
    "-DMODULE=hit_acs.gui_qt"

cp madgui.yml pkg\
call makensis /DVERSION=$env:VERSION madgui.nsi
