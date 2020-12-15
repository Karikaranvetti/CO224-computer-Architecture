@ ARM Assembly - lab 2
@ Group Number :

	.text 	@ instruction memory
	.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	@ load values
	mov r0, #10
	mov r1, #5
	mov r2, #7
	mov r3, #-8

	
	@ Write YOUR CODE HERE
	
	@	Sum = 0;
	@	for (i=0;i<10;i++){
	@			for(j=5;j<15;j++){
	@				if(i+j<10) sum+=i*2
	@				else sum+=(i&j);	
	@			}	
	@	} 
	@ Put final sum to r5


	@ ---------------------
	mov r1,#0   // sum
	mov r2,#0 //i
	loop1 :
		cmp r2,#10
		mov r3,#5 ///j 
		BLO loop2
		mov r5,r1
		B exit

		loop2:
		cmp r3,#15
		BLO con_if
		add r2,r2,#1
		B loop1

		con_if:
		add r4,r2,r3
		cmp r4,#10
		BLO op1
		AND r6,r2,r3
		add r1,r1,r6	
		add r3,r3,#1
		B loop2

		op1:
		add r1,r1,r2,LSL#1
		add r3,r3,#1
		B loop2


	exit:
	
	
	
	
	
	
	
	
	
	
	
	@ ---------------------
	
	
	@ load aguments and print
	ldr r0, =format
	mov r1, r5
	bl printf

	@ stack handling (pop lr from the stack) and return
	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr

	.data	@ data memory
format: .asciz "The Answer is %d (Expect 300 if correct)\n"

