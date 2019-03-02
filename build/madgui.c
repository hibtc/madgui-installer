#include <windows.h>
#include <string.h>     // strcpy/strcat/strrchr
#include <stdlib.h>     // malloc/realloc/free

typedef int (*Py_Main_T)(int, wchar_t**);

#define DLL_IMPORT(dll, name)  name##_T name = (name##_T) GetProcAddress(dll, #name);


#ifndef PYDLL
# define PYDLL          "python37.dll"
#endif
#ifndef PYTHONHOME
# define PYTHONHOME     "Z:\\tools\\madgui\\python\\WinPython64-3.7.1.0\\python-3.7.1.amd64"
#endif


void ActivateEnvironment();
static char* StrConcat(const char* a, const char* b);
static void AddEnvironmentPath(const char* varname, const char* dir);
char* GetExeFolder();


int WINAPI WinMain(
        HINSTANCE hInstance,
        HINSTANCE hPrevInstance,
        LPTSTR lpCmdLine,
        int nCmdShow)
{
    ActivateEnvironment();

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

    HMODULE pydll = LoadLibrary(PYDLL);
    DLL_IMPORT(pydll, Py_Main);
    return Py_Main(argc, wargv);
}


// activate python environment
void ActivateEnvironment()
{
    const char* PYTHONPATH = GetExeFolder();

    // enable LoadLibrary to find pythonXX.dll:
    AddEnvironmentPath("PATH", PYTHONHOME);

    // enable python interpreter to find stdlib:
    // otherwise you may get errors as in
    // https://stackoverflow.com/questions/5694706/py-initialize-fails
    SetEnvironmentVariable("PYTHONHOME", PYTHONHOME);

    // enable python interpreter to find madgui/etc:
    AddEnvironmentPath("PYTHONPATH", PYTHONPATH);
}


// concatenate two strings
char* StrConcat(const char* a, const char* b)
{
    char* result = malloc(strlen(a) + strlen(b) + 1);
    strcpy(result, a);
    strcat(result, b);
    return result;
}


// add `dir` to an environment variable
void AddEnvironmentPath(const char* varname, const char* dir)
{
    char* path = getenv(varname);
    if (path && *path) {
        char* temp  = StrConcat(path, ";");
        char* final = StrConcat(temp, dir);
        SetEnvironmentVariable(varname, final);
        free(temp);
        free(final);
    } else {
        SetEnvironmentVariable(varname, dir);
    }
}


LPSTR GetModulePath(HMODULE hModule)
{
    DWORD dwBufSize = MAX_PATH;
    LPSTR lpFilename = malloc(dwBufSize);
    while (GetModuleFileName(hModule, lpFilename, dwBufSize) == dwBufSize) {
        dwBufSize *= 2;
        lpFilename = realloc(lpFilename, dwBufSize);
    }
    return lpFilename;
}


char* GetExeFolder()
{
    char* path = GetModulePath(NULL);
    *strrchr(path, '\\') = '\0';
    return path;
}
