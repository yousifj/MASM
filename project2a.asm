comment~
Author: Yousif
Project: Project2A
Descriptiions: 
~ 

CONSOLE equ -11

extrn	GetStdHandle:		PROTO
extrn	WriteFile:			PROTO
extrn	ExitProcess:		PROTO


.data
numb			byte		?
numw			word		?
numd			dword		?
numq			qword		? 


.data?
stdout			qword ?							;handle to console standard out
numwrite		qword ?							;number bytes actullay written

.code
mainCRTStartup	PROC
				sub		rsp,40					;reserve shadow space

				
				mov numb,6dh					;assign numb
				mov numw,7361h					;assign numw
				mov numd,7369206dh				;assign numd
				mov rax,216e754620h				;assign the hex to a regester first 
				mov numq,rax					;assign numq

				
				mov rcx,CONSOLE					;windows handle
				call GetStdHandle				;handle in rax
				mov stdout,rax					;Save handle  

				mov rcx, stdout					;parm 1 (handel)
				mov rdx, offset numb			;parm 2 (String)
				lea rdx, numb					;address
				mov r8,12						;parm 3 bytes requested to display
				lea r9, numwrite				;parm 4 bytes written
				mov qword ptr [rsp + 32], 0		;parm5 = 0 (unused)
				call WriteFile					;display message

				add rsp,40						;release shadow space
				mov rcx,0						;return 0 = ok
				call ExitProcess				;exit
				
mainCRTStartup  ENDP
END