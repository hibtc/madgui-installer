#include <windows.h>

#define EXPAND_STR(x)         #x
#define EXPAND_STRINGMACRO(x) EXPAND_STR(x)


void WINAPI WinMainCRTStartup()
{
    char* exe = EXPAND_STRINGMACRO(EXE);
    STARTUPINFO si = {sizeof(si)};
    PROCESS_INFORMATION pi;
    CreateProcess(
        exe,        // lpApplicationName
        NULL,       // lpCommandLine
        NULL,       // lpProcessAttributes
        NULL,       // lpThreadAttributes
        TRUE,       // bInheritHandles
        0,          // dwCreationFlags
        NULL,       // lpEnvironment
        NULL,       // lpCurrentDirectory
        &si,        // lpStartupInfo
        &pi         // lpProcessInformation
    );
    ExitProcess(GetLastError());
}
