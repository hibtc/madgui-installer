// This file defines a simple replacement python.exe as drop in replacement for
// the official python.exe. The reason we need this is that for some reason the
// BeamOptikDLL64.dll does not work with the official python.exe on python 3.5
// and later.
#include <windows.h>
#include "python.h"


int WINAPI WinMain(
        HINSTANCE hInstance,
        HINSTANCE hPrevInstance,
        LPTSTR lpCmdLine,
        int nCmdShow)
{
    int argc;
    wchar_t** wargv = CommandLineToArgvW(
        GetCommandLineW(), &argc);

    return Py_Main(argc, wargv);
}
