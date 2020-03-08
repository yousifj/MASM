comment~
Author: Yousifs
Project: Project4B
Descriptiions: Fibonacci number sequence
~ 
extrn	DisplayInt:			PROTO
extrn	DisplayNewline:		PROTO
extrn	ExitProcess:		PROTO

.data
		input	qword 21
		num1	qword 0
		num2	qword 1
.data?

.code
main			PROC
				sub	rsp,32					;reserve shadow space

			    cmp r14,input				;condtion counter
				jge Continue				;skip loop if greater or equal 

Fibonacci:									;head of the loop
				
				lea  rcx,qword ptr[num1]	;parm1 address of num1
				call DisplayInt				;print the new num1 in memory
				call DisplayNewline			;print a new line
				mov  r12,num1				;clear r12, and add the fisrt number
				add  r12,num2				;add the second number to have the sum

				mov  r13,num2				;use a regester to move value from memory to memory
				mov  num1,r13				;assigning first number to the second number 

				mov  num2,r12				;assigning to the sum of last two numbers
				
				inc  r14					;increment counter
				cmp  r14,input  			;check the counter input
				jl  Fibonacci				;conditional loop jump while less 

Continue:									;after the loop continue
				add  rsp,32					;release shadow space
				mov  rcx,0					;return 0
				call ExitProcess			;exit
main		    ENDP
END

input: 21

output:

0
1
1
2
3
5
8
13
21
34
55
89
144
233
377
610
987
1597
2584
4181
6765