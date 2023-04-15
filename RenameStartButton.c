#include <windows.h>
#include <stdio.h>

int main(int argc, char *argv[]) {
    HWND taskbarWnd = FindWindow("Shell_TrayWnd", NULL);
    HWND startButtonWnd = FindWindowEx(taskbarWnd, NULL, "Button", NULL);
    DWORD processId;
    GetWindowThreadProcessId(startButtonWnd, &processId);
    HANDLE processHandle = OpenProcess(PROCESS_ALL_ACCESS, FALSE, processId);
    LPVOID remoteStringAddr = VirtualAllocEx(processHandle, NULL, strlen(argv[1]), MEM_COMMIT, PAGE_READWRITE);
    WriteProcessMemory(processHandle, remoteStringAddr, argv[1], strlen(argv[1]), NULL);
    SendMessage(startButtonWnd, WM_SETTEXT, 0, (LPARAM)remoteStringAddr);
    VirtualFreeEx(processHandle, remoteStringAddr, strlen(argv[1]), MEM_RELEASE);
    CloseHandle(processHandle);
    return 0;
}