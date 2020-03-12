comment~
Author: Yousif 
Project: Project4E
Descriptions: Loan rate for a customer
~ 
extrn	ExitProcess:			PROC
extrn	DisplayString:			PROC
extrn	DisplayNewline:			PROC
extrn	DisplayFloat:			PROC
extrn	ReadChar:				PROC

.data
masg1	byte 'Are you a college graduate (Y/N):',0
masg2	byte 'Are you currently employed (Y/N):',0
masg3	byte 'Your loan rate will be: ',0
rate1 	real4	0.03
rate2	real4   0.035
rate3	real4	0.041
rate4	real4	0.045

.data?
graduate	byte	?
employed	byte	?
.code
main	PROC
				sub  rsp,32					;reserve shadow space
				push rbp					;save base pointer

				lea  rcx,masg1				;PARM 1 masg1
				call DisplayString			;print masg on display
				lea rcx,graduate			;save input tograduate
				call ReadChar				;read from keyborad
				lea  rcx,masg2				;Parm 1 masg2
				call DisplayString			;Print masg2 to display
				lea rcx,employed			;save input to employed
				call ReadChar				;read from keyborad

				mov r8b,graduate			;move graduate to a regester
				cmp r8b,employed			;compare graduate to employed
				je	YY						;if the are = go to YY
				jl  NY						;if graduate is less go to NY
				jg	YN						;if graduate is greater go to YN

YY:				cmp graduate,'N'			;compare graduate to N 
				je NN						;if it's = N go to NN
				lea rcx,masg3				;parm1 masg3
				call DisplayString			;print masg3 to display
				lea rcx,rate1				;parm1 rate1
				call DisplayFloat			;print rate1 to display
				jp done						;jump to end the program

NN:				lea rcx,masg3				;parm1 masg3
				call DisplayString			;print masg3 to display
				lea rcx,rate4				;parm1 rate4
				call DisplayFloat			;print rate4 to display
				jp done						;jump to end the program

YN:				lea rcx,masg3				;parm1 masg3
				call DisplayString			;print masg3 to display
				lea rcx,rate3				;parm1 rate3
				call DisplayFloat			;print rate3 to display
				jp done						;jump to end the program

NY:				lea rcx,masg3				;parm1 masg3
				call DisplayString			;print masg3 to display
				lea rcx,rate2				;parm1 rate2
				call DisplayFloat			;print rate2 to display
				jp done						;jump to end the program
done:
				pop rbp						;restore base pointer
				add rsp,32					;release shadow space
				call ExitProcess			;exit
				
main  ENDP
END

Are you a college graduate (Y/N):Y
Are you currently employed (Y/N):Y
Your loan rate will be: 0.03

Are you a college graduate (Y/N):N
Are you currently employed (Y/N):Y
Your loan rate will be: 0.035

Are you a college graduate (Y/N):Y
Are you currently employed (Y/N):N
Your loan rate will be: 0.041

Are you a college graduate (Y/N):N
Are you currently employed (Y/N):N
Your loan rate will be: 0.045