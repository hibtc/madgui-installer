#include "python.h"
#include <windows.h>


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
            L"python -m madgui", &argc);
    }

    return Py_Main(argc, wargv);
}
