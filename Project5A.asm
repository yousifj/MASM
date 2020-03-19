comment~
Author: Yousif Jabbo
Project: Project5A
Descriptions: MACRO
~ 

LF				equ		 10
CR				equ		 13
numBuffer		equ      30
CONSOLE			equ		-11
KEYBOARD		equ		-10

extern GetStdHandle:	PROTO
extern WriteFile:		PROTO
extern ReadFile:		PROTO
extern ExitProcess:		PROTO

mGetHandles		MACRO		

				mov rcx, CONSOLE				;Win display console
				call GetStdHandle				;handle in rax
				mov stdout, rax					;save out handle
				mov rcx, KEYBOARD				;keyboard code
				call GetStdHandle				;handle in rax
				mov stdin, rax					;save input handle

ENDM
mWriteFile		MACRO

				lea r11,byte ptr[rcx]			;save the parm1 
				mov r12,rdx						;save the length
				mov rcx, stdout					;parm1 = console handle
				mov rdx, r11					;parm2 = ASCII message
				mov r8,	r12						;parm3 # bytes in message
				lea r9,  numWrite				;parm4 = # bytes actually written
				mov qword ptr [rsp + 32], 0		;parm5 = 0 (unused)
				call WriteFile 					;display message
ENDM

mReadFile		MACRO

				lea rdx, byte ptr[rcx]			;parm2 = ASCII buffer
				mov rcx, stdin					;parm1 = keyboard handle
				mov r8,  numBuffer				;parm3 = max # bytes to read
				lea r9,  numRead				;parm4 = # bytes actually read
				mov qword ptr [rsp + 32], 0		;parm5 = 0 (unused)
				call ReadFile					;get input
ENDM


.data
stdin			qword ?		
stdout			qword ?		
numWrite		qword ?		
numRead			qword ?		
msg1			byte	"What is your name? "
msg2			byte	"What is your address? "
msg3			byte	"Nice to meet you,",CR,LF
Input1			byte	numBuffer dup(?),CR
Input2			byte	numBuffer dup(?)

.data?

.code
mainCRTStartup	PROC
				sub	rsp,32						;reserve shadow space

			    mGetHandles						;handler

				lea rcx,msg1					;parm address of msg1
				mov rdx,lengthof msg1			;# of bytes to display
				mWriteFile						;display msg1

				lea rcx,Input1					;buffer
				mReadFile						;get input macro
				
				lea rcx,msg2					;parm address of msg2
				mov rdx,lengthof msg2			;# of bytes to display
				mWriteFile						;display msg2

				lea rcx,Input2					;buffer
				mReadFile						;get input macro

				lea rcx,msg3					;parm address of msg3
				mov rdx,lengthof msg3			;# of bytes to display
				mWriteFile						;display msg3

				lea rcx,Input1					;parm address of Input1
				mov rdx,11						;# of bytes to display
				mWriteFile						;display Input1
				
				lea rcx,Input2					;parm address of Input2
				mov rdx,23						;# of bytes to display
				mWriteFile						;display Input2

				add rsp,32						;release shadow space
				mov rcx,0						;return 0 
				call ExitProcess				;exit
				
mainCRTStartup  ENDP

END

What is your name? Bob Smith
What is your address? 1234 Main St., El Cajon
Nice to meet you,
Bob Smith
1234 Main St., El Cajon
