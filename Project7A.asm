comment~
Author: Yousif 
Project: Project7A  
Descriptions: ASCII decimal to a binary number
~ 

extrn	ReadString:			PROTO
extrn	DisplayInt:			PROTO

extrn	DisplayInt:			PROTO
extrn	ExitProcess:		PROTO

.data

iNum	qword		0

.data?
sizei	word		?
input	byte		?
.code
main	PROC
				sub	rsp,32					;reserve shadow space

				lea rcx,input				;save the first number
				call  ReadString			;get the user input
				mov sizei,ax				;save the size of input in sizei
				dec sizei				    ;size of input-1

				lea rcx,input				;input from user
				
				call StringToInt			;call masm proc

			    lea rcx,iNum				;parm iNum to display
				call DisplayInt				;print the number in char

				add rsp,32					;release shadow space
				mov rcx,0					;return 0 = ok
				call ExitProcess			;exit
				
main  ENDP
StringToInt PROC
			mov r11,0						;clear r11
			lea r15, byte ptr[iNum]			;pointer to soltion 
			lea r13, byte ptr[input]		;pointer to the first input
			mov rbx,1						;bass10 = 1
			mov r8,1						;index 
			mov r9,2						;index if nagative number
			cmp byte ptr[input],'-'			;check if the number is -
			cmove rcx,r9					;chose the nagative index if -
			cmovne rcx,r8					;choese the normal index 
			mov r10w,sizei					;counter

loop1:	
			dec r10							;counter--

			mov r11b,byte ptr[r13+r10]	    ;the first input
			sub r11b, '0'					;(sIn[ix] - '0')
							
			mov rax,r11						;first number to multiply
			mov rdx, rbx					;second number to multiply
			mul rdx							;multiply first * second

			add iNum, rax					;save the new results
			
			mov rax,rbx						;first number to multiply
			mov rdx, 10						;multiply *10
			mul rdx							;multiply first * 10
			mov rbx,rax						;base10 *= 10

			cmp r10,rcx						;check counter with size of the loop
			jge loop1						;loop again in grater

ifneg:
		cmp input,'-'						;check if input was nagative
		jne endd							;if it wasn't end the app
		mov rax,iNum						;first number to multiply
		mov rdx, -1							;make it nagative
		mul rdx								;multiply first * -
		mov iNum, rax						;save the new number
		
endd:

			ret								;return to main
StringToInt ENDP
END

1234
1234

-1234
-1234

-2147483648
-2147483648

2147483647
2147483647