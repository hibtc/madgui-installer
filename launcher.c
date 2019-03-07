#include "python.h"
#include <windows.h>

#ifndef MODULE
# define MODULE "madgui"
#endif
#define EXPAND_STR(x)         #x
#define EXPAND_STRINGMACRO(x) EXPAND_STR(x)


void WINAPI WinMainCRTStartup()
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

    ExitProcess(Py_Main(argc, wargv));
}
