@E/16/172
@karikaran.v
@Lab Exercise 4

.text	@ instruction memory
	
	.global main
main:
	@ stack handling
	@ push (store) lr to the stack
	sub	sp, sp, #4
	str	lr, [sp, #0]

    @printf for int1
	ldr	r0, =formatd2
	bl	printf

    @allocate stack for input
	sub	sp, sp, #4

    @scanf for int1
	ldr	r0, =formati
	mov	r1, sp	
	bl	scanf	@scanf("%d",sp)

    @copy int1 from the stack to register r4
	ldr	r4, [sp]

    @release stack
	add	sp, sp, #4

    @Check for positive values
	@counter
	mov	r5, #0

    cmp r4,#0
    
	bge Scanner
    beq Exit

	@printf for invalid input
	ldr	r0, =formatd3
	bl	printf

	b Exit
    

    Scanner:
    cmp	r5,r4
	beq Exit
	

	sub	sp, sp, #204
	str	lr, [sp, #200]

	@printf for inputs
	mov	r1, r5
	ldr	r0, =formatd1
	bl printf

	@scanf for string
	ldr	r0, =formats
	mov	r1, sp
	bl	scanf	@scanf("%[^\n]%*c",sp)

	@printf for inputs
	mov	r1, r5
	ldr	r0, =formatio
	bl printf

	@function call
	mov	r0, sp
	bl	stringLen

	
	mov	r1, sp
	mov	r2, r0
	sub	sp, sp, #16
	str r6,[sp,#0]
	str r7,[sp,#4]
	str r8,[sp,#8]
	str r9,[sp,#12]
	
	mov r6,#0
	mov r7,#0
	mov r8,#0
	mov r9,#0
	Add r8,r1,r2
	sub r8,r8,#1
	add r7,r2,#0
	Lop:
		cmp r6,r7
		beq endLop
		
		sub	sp, sp, #4
		ldrb r9,[r8,#0]
		str r9,[sp,#0]
		
		
		mov r1,sp
		ldr	r0, =formato
		bl printf
		
		sub r8,r8,#1
		add r6,r6,#1
		add sp,sp,#4
		b Lop
	endLop:
	ldr	r0, =formatp
	bl printf
	
	@restore stack 
	ldr r6,[sp,#0]
	ldr r7,[sp,#4]
	ldr r8,[sp,#8]
	ldr r9,[sp,#16]
	Add sp,sp,#16

 
	ldr	lr, [sp, #200]
	add	sp, sp, #204
    add	r5, r5, #1
	
	b	Scanner

    Exit:
	 
	@ stack handling (pop lr from the stack) and return
	ldr	lr, [sp, #0]
	add	sp, sp, #4
	mov	pc, lr	
   
   
    @ string length function///////////////////////////////////////////////////////
stringLen:
	sub	sp, sp, #4
	str	lr, [sp, #0]

	mov	r1, #0	@ length counter

loop:
	ldrb	r2, [r0, #0]
	cmp	r2, #0
	beq	endLoop

	add	r1, r1, #1	@ count length
	add	r0, r0, #1	@ move to the next element in the char array
	b	loop

endLoop:
	mov	r0, r1		@ to return the length
	ldr	lr, [sp, #0]
	add	sp, sp, #4
	mov	pc, lr



    .data	@ data memory
formatd1: .asciz "Enter input string %d:\n"
formatd2: .asciz "Enter the number of strings :\n"
formatd3: .asciz "Invalid Number\n"
formati: .asciz "%d%*c"
formats: .asciz "%[^\n]%*c"
formatp: .asciz "\n"
formato: .asciz "%s"
formatio: .asciz "Output string %d is...\n"
formatl: .asciz "%d it %d \n"
