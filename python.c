// This file defines a simple replacement python.exe as drop in replacement for
// the official python.exe. The reason we need this is that for some reason the
// BeamOptikDLL64.dll does not work with the official python.exe on python 3.5
// and later.
#define WIN32_LEAN_AND_MEAN
#include <windows.h>

extern int Py_Main(int argc, wchar_t **argv);

int WINAPI wWinMain(
        HINSTANCE hInstance,
        HINSTANCE hPrevInstance,
        LPWSTR lpCmdLine,
        int nCmdShow)
{
    return Py_Main(__argc, __wargv);
}
