#include <windows.h>

typedef void (__stdcall * TGetInterfaceInstance) (int*, int*);

void WINAPI WinMainCRTStartup()
{
    HMODULE dll = LoadLibraryA("BeamOptikDLL64.dll");

    int iid, done;

    TGetInterfaceInstance GetInterfaceInstance =
        (TGetInterfaceInstance) GetProcAddress(dll, "GetInterfaceInstance");

    GetInterfaceInstance(&iid, &done);

    ExitProcess(done);
}
