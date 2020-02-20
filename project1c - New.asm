comment~
Author: Yousif
Project: Project1C
Descriptiions: Name in a Box
~ 
CONSOLE  equ -11
KEYBOARD equ -10
LF equ 10
CR equ 13

extrn	GetStdHandle:		PROTO
extrn	ReadFile:			PROTO
extrn	WriteFile:			PROTO
extrn	ExitProcess:		PROTO
	

.data
prompt			byte	'What is your name? '
message			byte	'********************************',LF,CR,'*'
keymsg			byte     34 dup(' '),CR,LF,'********************************',CR,LF

.data?
stdin			qword ?		;handle to console standard in
stdout			qword ?		;handle to console standard out
numWrite		qword ?		;number bytes actullay written
numRead			qword ?		;number bytes actullay read


.code
mainCRTStartup	PROC	

				sub		rsp,40					;reserve shadow space

				mov rcx,CONSOLE					;subsystem/console
				call GetStdHandle				;handle in rax
				mov stdout,rax					;Save out handle  
				mov rcx, KEYBOARD				;handle code
				call GetStdHandle				;handle in rax
				mov stdin,rax					;save in handle
				
												;display message			
				mov rcx, stdout					;parm1 (handel)
				lea rdx, prompt					;parm2 (String)
				mov r8,lengthof prompt			;parm3 bytes to display
				lea r9, numWrite				;parm4 bytes written
				mov qword ptr [rsp + 32], 0     ;parm5 = 0 (unused)
				call WriteFile					;display message
			
												;read ASCII from keyboard

				mov rcx,stdin					;parm1 = keyboard handle
				lea rdx,keymsg					;parm2 = ascii to read
				mov r8,lengthof keymsg			;parm3 = bytes to read	
				lea r9,numRead					;parm4 = bytes atully read
				mov qword ptr [rsp + 32], 0     ;parm5 = 0 (unused)
				call ReadFile					;get keystrokes

				lea r11,keymsg					;go to the first byte input
				add r11,numRead					;get the input length
				sub r11,2						;go to location of LF and CR
				mov word ptr[r11],"  "			;replace LF, CR with spaces
				lea r11,keymsg					;go to the first byte input
				add r11,30						;point to the last byte
				mov word ptr[r11],'*'			;replace it with *
				
				


												;display messege in console
				mov rcx,stdout					;parm 1 (handel)
				lea rdx,message					;parm 2 (message)
				
												;number of bytes to display(write)
				mov r8,lengthof message			;length 'message'
				add r8,lengthof keymsg			;add length input from keyboard
				lea r9, numWrite				;store bytes writen
				mov qword ptr [rsp + 32], 0	    ;parm5 = 0 (unused)

				call WriteFile					;display message

				add rsp,40						;release shadow space
				mov rcx,0						;return 0 
				call ExitProcess				;exit

mainCRTStartup  ENDP
END