#include "windows.bi"

var hDsk = GetDesktopWindow()
var hWnd = FindWindow( "Shell_TrayWnd" , NULL )

dim as RECT rc : GetClientRect(hDsk,@rc)

for Y as integer = rc.bottom to 0 step -1
  SetWindowPos(hWnd,0, 0,Y , 0, 0 , SWP_NOSIZE or SWP_NOZORDER or SWP_NOSENDCHANGING)  
next Y

sleep : end