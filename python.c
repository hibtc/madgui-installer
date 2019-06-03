// This file defines a simple replacement python.exe as drop in replacement for
// the official python.exe. The reason we need this is that for some reason the
// BeamOptikDLL64.dll does not work with the official python.exe on python 3.5
// and later.
#include <windows.h>

extern int Py_Main(int argc, wchar_t **argv);

void WINAPI WinMainCRTStartup()
{
    int argc;
    wchar_t** wargv = CommandLineToArgvW(
        GetCommandLineW(), &argc);

    ExitProcess(Py_Main(argc, wargv));
}
