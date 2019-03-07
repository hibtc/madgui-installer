#include "python.h"

#include <windows.h>
#include <string.h>     // strcpy/strcat/strrchr
#include <stdlib.h>     // malloc/realloc/free

#ifdef DEBUG
# include <stdio.h>
# define LOGI(i) printf(#i " = %d\n", i)
# define LOGS(s) printf(#s " = [%s]\n", s)
#else
# define LOGI(i)
# define LOGS(s)
#endif

typedef int (*Py_Main_T)(int, wchar_t**);

#define DLL_IMPORT(dll, name)  name##_T _##name = (name##_T) GetProcAddress(dll, #name);


static char* ActivateEnvironment();
static void AddEnvironmentPath(const char* varname, const char* dir);
static char* GetExeFolder();
static LPSTR GetModulePath(HMODULE hModule);
static char* GetIniString(const char* filename, const char* section, const char* key, const char* deflt);
static char* StrConcat(const char* a, const char* b);
static char* GetEnvVar(const char* name);


int Py_Main(int argc, wchar_t** wargv)
{
    char* PYDLL = ActivateEnvironment();

    HMODULE pydll = LoadLibrary(PYDLL);
    DLL_IMPORT(pydll, Py_Main);
    return _Py_Main(argc, wargv);
}


// Activate python environment
char* ActivateEnvironment()
{
    char* exe_folder = GetExeFolder();
    char* ini_file = StrConcat(exe_folder, "\\activate.ini");
    char* PYTHONPATH = exe_folder;
    char* PYTHONHOME = GetIniString(ini_file, "python", "home", "");
    char* PYTHONAPPS = StrConcat(PYTHONHOME, "\\Scripts");
    char* PYTHON_DLL = GetIniString(ini_file, "python", "load", "python37.dll");

    LOGS(PYTHONPATH);
    LOGS(PYTHONHOME);
    LOGS(PYTHONAPPS);
    LOGS(PYTHON_DLL);

    // Enable LoadLibrary to find pythonXX.dll:
    AddEnvironmentPath("PATH", PYTHONHOME);

    // Add other useful scripts:
    AddEnvironmentPath("PATH", PYTHONAPPS);

    // Enable python interpreter to find stdlib:
    // otherwise you may get errors as in
    // https://stackoverflow.com/questions/5694706/py-initialize-fails
    SetEnvironmentVariable("PYTHONHOME", PYTHONHOME);

    // Enable python interpreter to find madgui/etc:
    AddEnvironmentPath("PYTHONPATH", PYTHONPATH);

    free(exe_folder);
    free(ini_file);
    free(PYTHONHOME);
    free(PYTHONAPPS);

    return PYTHON_DLL;
}

// Add `dir` to an environment variable
void AddEnvironmentPath(const char* varname, const char* dir)
{
    char* path = GetEnvVar(varname);
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

// Get folder path of current process
char* GetExeFolder()
{
    char* path = GetModulePath(NULL);
    *strrchr(path, '\\') = '\0';
    return path;
}

// Get full path of loaded module
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

// Load string from .ini file
char* GetIniString(const char* filename, const char* section, const char* key, const char* deflt)
{
    DWORD dwBufSize = MAX_PATH;
    LPSTR lpString = malloc(dwBufSize);
    while (GetPrivateProfileString(
            section, key, deflt, lpString, dwBufSize, filename) == dwBufSize - 1) {
        dwBufSize *= 2;
        lpString = realloc(lpString, dwBufSize);
    }
    return lpString;
}

// Get environment variable. Note that `getenv` can't be used in combination
// with SetEnvironmentVariable!! Using getenv can revert changes made by
// SetEnvironmentVariable.
char* GetEnvVar(const char* name)
{
    DWORD dwBufSize = GetEnvironmentVariable(name, NULL, 0);
    if (dwBufSize == 0) {
        dwBufSize += 1;
    }
    LPSTR lpValue = malloc(dwBufSize);
    GetEnvironmentVariable(name, lpValue, dwBufSize);
    lpValue[dwBufSize-1] = '\0';
    return lpValue;
}

// Concatenate two strings
char* StrConcat(const char* a, const char* b)
{
    char* result = malloc(strlen(a) + strlen(b) + 10);
    strcpy(result, a);
    strcat(result, b);
    return result;
}
