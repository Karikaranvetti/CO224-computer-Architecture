@ ARM Assembly - exercise 7 
@ Group Number :

	.text 	@ instruction memory

	
@ Write YOUR CODE HERE	

@ ---------------------	
Fibonacci:
    SUB sp,sp,#12
    STR lr,[sp,#4]
    STR r0,[sp,#0]
    CMP r0,#1
    BGT L1
    MOV r0,r0
    ADD sp,sp,#12
    MOV pc,lr
L1: 
    SUB r0,r0,#1   
    BL Fibonacci
    STR r0,[sp,#8]
    LDR r0,[sp,#0]
    SUB r0,r0,#2
    BL Fibonacci
    MOV r12,r0
    LDR r0,[sp,#0]
    LDR r1,[sp,#8]
    LDR lr,[sp,#4]
    ADD sp,sp,#12
    ADD r0,r1,r12
    MOV pc,lr

@ ---------------------
	
	.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	mov r4, #8 	@the value n

	@ calling the Fibonacci function
	mov r0, r4 	@the arg1 load
	bl Fibonacci
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
format: .asciz "F_%d is %d\n"

