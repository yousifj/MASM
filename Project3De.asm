comment~
Author: Yousif 
Project: Project3D(e)
Descriptiions: C++ with masm
~
extrn	Display:			PROC

.data

.data?

c1	 byte ?
s1   word ?
us1  word ?
i1	 dword ?
ull1 qword ?
ll1	 qword ?
uc1	 byte ?

.code
Store	PROC

				mov c1,cl							;save parm 1 in c1 
				mov s1,dx							;save parm 2 in s1 
				mov us1,r8w							;save parm 3 in us1
				mov i1,r9d							;save parm 4 in i1
				mov	rax,qword ptr[rsp+40]			;copy the content of the stack to rax
				mov ull1, rax						;save parm 5 in ull1
				mov rax,qword ptr[rsp+48]			;copy the content of the stack to rax
				mov	ll1,rax							;save parm 6 in ll1
				mov al,byte ptr[rsp+56]				;copy the content of the stack to rax
				mov uc1,al							;save parm 7 in uc1
 
				ret									;return
Store	ENDP
Increment	PROC
				inc c1								;increment by 1
				inc	s1								;increment by 1
				inc	us1								;increment by 1
				inc	i1								;increment by 1
				inc ull1							;increment by 1
				inc	ll1								;increment by 1
				inc uc1								;increment by 1
				ret									;return to c++
Increment	ENDP
Show	PROC
				sub	rsp,56							;reserve shadow space


				lea rcx,c1							;pass parm1 
				lea rdx,s1							;pass parm2
				lea	r8,us1							;pass parm3
				lea	r9,i1							;pass parm4
				lea rax,ull1						;point to parm5
				mov qword ptr[rsp+32],rax			;pass parm 5 using the stack
				lea rax,ll1							;point to parm6
				mov qword ptr[rsp+40],rax			;pass parm6 using the stack
				lea rax,uc1							;point to parm7
				mov qword ptr[rsp+48],rax			;pass parm7 using the stack

				call Display						;print
				add rsp,56							;release shadow space
				ret									;return to c++
Show	ENDP
END

output 

Enter a char: a
Enter a short: 12
Enter a ushort: 24
Enter a int: 1234567
Enter a ulong long: 12345671234567
Enter a long long: 3232323232
Enter a uchar: =
b 13 25 1234568 12345671234568 3232323233 >