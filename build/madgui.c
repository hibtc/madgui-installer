#include <windows.h>
#include <string.h>     // strcpy/strcat/strrchr
#include <stdlib.h>     // malloc/realloc/free

typedef int (*Py_Main_T)(int, wchar_t**);

#define DLL_IMPORT(dll, name)  name##_T name = (name##_T) GetProcAddress(dll, #name);


#ifndef PYDLL
# define PYDLL          "python37.dll"
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
    const char* PYTHONHOME = getenv("PYTHONHOME");
    const char* PYTHONPATH = GetExeFolder();

    if (!PYTHONHOME || !*PYTHONHOME) {
        wchar_t* lpCommandLine = StrConcatW(
                L"cmd.exe /C /MIN call activate.bat && start \"madgui\" ",
                GetCommandLineW())

        STARTUPINFO si = {0};
        PROCESS_INFORMATION pi = {0};
        si.cb = sizeof(si);
        si.dwFlags = STARTF_USESHOWWINDOW;
        si.wShowWindow = SW_HIDE;

        CreateProcess(
                NULL, lpCommandLine,
                NULL, NULL,             // security attributes
                TRUE,                   // bInheritHandles
                0,                      // dwCreationFlags
                NULL,                   // lpEnvironment
                GetExeFolder(),         // lpCurrentDirectory
                &si, &pi);

        WaitForSingleObject(si.hProcess, INFINITE);

        ExitProcess(0);
    }

    // enable LoadLibrary to find pythonXX.dll:
    AddEnvironmentPath("PATH", PYTHONHOME);

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
