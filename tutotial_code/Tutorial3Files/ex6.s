@ ARM Assembly - exercise 6 
@ Group Number :

	.text 	@ instruction memory
	
	
@ Write YOUR CODE HERE	

@ ---------------------	
fact:
SUB sp, sp, #12
STR r3,[sp,#8]
STR r1,[sp,#4]
STR r2,[sp,#0]
mov r1,#1  //i
mov r2,#1  //f
loop:
cmp r1,r0
BLS con1
MOV r0,r2
LDR r2, [sp,#0]
LDR r1, [sp,#4]
LDR r3, [sp,#8]
ADD sp,sp,#12
MOV pc,lr 
B exit

con1:
MUL r3,r1,r2
mov r2,r3
ADD r1,r1,#1
B loop



exit:






@ ---------------------	

.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	mov r4, #4 	@the value n

	@ calling the fact function
	mov r0, r4 	@the arg1 load
	bl fact
	mov r5,r0
	

	@ load aguments and print
	ldr r0, =format
	mov r1, r4
	mov r2, r5
	bl printf

	@ stack handling (pop lr from the stack) and return
	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr

	.data	@ data memory
format: .asciz "Factorial of %d is %d\n"

