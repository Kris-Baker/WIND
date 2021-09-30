#include "windows.bi"
 
'control desk.cpl,UndockTaskBar(32);
var sCmd = command() , iPos = instr(sCmd," ")
if iPos = 0 then end 1
'=== mode/operation ===
var sMode = lcase(trim(left(sCmd,iPos-1)))
if sMode <> "control" then end 2
'=== filename ===
sCmd = mid(sCmd,iPos+1) : iPos = instr(sCmd,",")
if iPos = 0 then end 1
var sFile = lcase(trim(left(sCmd,iPos-1)))
sCmd = mid(sCmd,iPos+1) : iPos = instr(sCmd,"(")
if iPos = 0 then iPos = len(sCmd)+1
'=== function ===
var sFunc = lcase(trim(left(sCmd,iPos-1)))
if len(sFunc)=0 then end 1
sCmd = trim(mid(sCmd,iPos+1))
 
select case sFile
case "desk.cpl"
  select case sFunc
  case "undocktaskbar"
    var iPos = instr(sCmd,")"):if iPos=0 then end 1
    var sParm = left(sCmd,iPos-1)
    if len(sParm)=0 orelse instr(sParm,",") then end 1
    var hDsk = GetDesktopWindow()
    var hWnd = FindWindow( "Shell_TrayWnd" , NULL )
    SetWindowPos(hWnd,0, 0,valint(sParm) , 0,0 , SWP_NOSIZE or SWP_NOZORDER or SWP_NOSENDCHANGING)
  case else
    end 1
  end select
case else : end 2
end select
 
'dim as RECT rc : GetClientRect(hDsk,@rc)
'for Y as integer = rc.bottom to 32 step -1
'  SetWindowPos(hWnd,0, 0,Y , 0,0 , SWP_NOSIZE or SWP_NOZORDER or SWP_NOSENDCHANGING)  
'next Y
