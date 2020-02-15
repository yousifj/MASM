

CONSOLE  equ -11
KEYBOARD equ -10
LF equ 10
CR equ 13

extrn	GetStdHandle:		PROTO
extrn	ReadFile:			PROTO
extrn	WriteFile:			PROTO
extrn	ExitProcess:		PROTO
	

.data
prompt			byte	'what is your name : '
hello			byte	'****************************',LF,'*'
myname			byte     30 dup(0)
line			byte	CR,'*',LF,'****************************'

.data?
stdin			qword ?		;handle to console standard in
stdout			qword ?		;handle to console standard out
numWrite		qword ?		;number bytes actullay written
numRead			qword ?		;number bytes actullay read


.code
mainCRTStartup	PROC
				sub		rsp,40			;reserve shadow space

				mov rcx,CONSOLE			;subsystem/console
				call GetStdHandle		;handle in rax
				mov stdout,rax			;Save out handle  
				mov rcx, KEYBOARD		;handle code
				call GetStdHandle		;handle in rax
				mov stdin,rax			;save in handle
				
										;display message
				mov rcx, stdout			;parm 1 (handel)
				lea rdx, prompt			;parm 2 (String)
				mov r8,lengthof prompt	;bytes to display 
				lea r9, numWrite		;bytes written
				call WriteFile			;display message
				
										;read ASCII from keyboard
				mov rcx,stdin			;parm1 = keyboard handle
				lea rdx,myname			;parm2 = ascii to read
				mov r8,lengthof myname	;bytes to read
				lea r9,numRead			;bytes atully read

				call ReadFile			;get keystrokes
				
										;display messege in console
				mov rcx,stdout			;parm 1 (handel)
				lea rdx, hello			;parm 1 (message)
										;#number of bytes to display(write)
				mov r8, lengthof hello	;length 'hello'
				add r8,	lengthof myname	;add length name
				add r8, lengthof line	;add length of line to display
				lea r9, numWrite		;store bytes writen
				call WriteFile			;display message



				add rsp,40				;release shadow space
				mov rcx,0				;return 0 = ok
				call ExitProcess		;exit
				
mainCRTStartup  ENDP
END
