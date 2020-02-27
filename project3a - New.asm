comment~
Author: Yousif
Project: Project3a
Descriptiions: Mixing Masm with C++
~ 
extrn	ExitProcess:		PROC
extrn	DisplayInt:			PROC
extrn	DisplayString:		PROC
extrn	DisplayDouble:		PROC
extrn	DisplayNewline:		PROC

CR equ 0dh
LF equ 0ah

.data
hello	byte	"hello, world",CR,LF,0
myInt	dword	1234567
realNum	real8	1.23456e4
.data?

.code
main	PROC
				sub	rsp,32						;reserve shadow space	

				mov rcx, offset myInt			;point to address of myInt
				call DisplayInt					;print to myInt to display

				call DisplayNewline				;print a new line

				mov rcx, offset hello			;pont to the address of hello
				call DisplayString				;print hello to display

				push rbp						;save the base pointer
				mov rcx, offset realNum			;point to the address of realNum
				call DisplayDouble				;print realNum to display
				pop rbp							;restore the non-volatile regester

				add rsp,40						;release shadow space
				mov rcx,0						;return 0 = ok
				call ExitProcess				;exit
				
main  ENDP
END