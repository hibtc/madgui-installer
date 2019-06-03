#include <windows.h>

typedef void (__stdcall * TGetInterfaceInstance) (int*, int*);

int WINAPI WinMain(
        HINSTANCE hInstance,
        HINSTANCE hPrevInstance,
        LPSTR lpCmdLine,
        int nCmdShow)
{
    HMODULE dll = LoadLibraryA("BeamOptikDLL64.dll");

    int iid, done;

    TGetInterfaceInstance GetInterfaceInstance =
        (TGetInterfaceInstance) GetProcAddress(dll, "GetInterfaceInstance");

    GetInterfaceInstance(&iid, &done);

    return (done);
}
