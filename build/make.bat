windres madgui.rc -O coff -o madgui.res
gcc -o madgui.exe ^
    madgui.c madgui.res ^
    -ID:\Programme\miniconda3\include ^
    -LD:\Programme\miniconda3\libs ^
    -lpython37
