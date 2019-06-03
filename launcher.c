#include "python.h"
#include <windows.h>

#ifndef MODULE
# define MODULE "madgui"
#endif
#define EXPAND_STR(x)         #x
#define EXPAND_STRINGMACRO(x) EXPAND_STR(x)


int WINAPI WinMain(
        HINSTANCE hInstance,
        HINSTANCE hPrevInstance,
        LPTSTR lpCmdLine,
        int nCmdShow)
{
    int argc;
    wchar_t** wargv = CommandLineToArgvW(
        GetCommandLineW(), &argc);

    // Only execute madgui if no arguments are passed and otherwise, behave
    // like python.exe. This enables using `sys.executable` for python
    // subprocesses.
    if (argc == 1) {
        wargv = CommandLineToArgvW(
            L"python -m " EXPAND_STRINGMACRO(MODULE), &argc);
    }

    return Py_Main(argc, wargv);
}
