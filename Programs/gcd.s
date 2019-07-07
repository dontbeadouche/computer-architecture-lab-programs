.data
	num1:	.word 0
	num2:	.word 0
	result:	.word 0
	buffer:	.asciiz ""
	msg1:	.asciiz	"A : "
	msg2:	.asciiz	"B : "
	msg3:	.asciiz	"GCD : "

.text
.globl main
main:
	# Print msg1
	li $v0, 4
	la $a0, msg1
	syscall

	# Input num1
	li $v0, 5
	syscall
	sw $v0, num1

	# Print msg2
	li $v0, 4
	la $a0, msg2
	syscall

	# Input num2
	li $v0, 5
	syscall
	sw $v0, num2

	# Set arguments
	lw $a0, num1
	lw $a1, num2

	# Call gcd
	jal gcd
	sw $v0, result

	# Print msg3
	li $v0, 4
	la $a0, msg3
	syscall

	# Print result
	li $v0, 1
	lw $a0, result
	syscall
	
	# Terminate
	li $v0, 10
	syscall
.end main


.globl gcd
.ent gcd
gcd:
	addi $sp, $sp, -12
	sw $ra, ($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)

	div $a0, $a1
	mfhi $v0

	beq $v0, $zero, gcddone

	add $a0, $a1, $zero
	add $a1, $v0, $zero
	jal gcd

	gcddone:
		add $v0, $a1, $zero
		lw $ra, ($sp)
		lw $a0, 4($sp)
		lw $a1, 8($sp)
		addi $sp, $sp, 12
		jr $ra
.end gcd