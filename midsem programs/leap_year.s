
   # algo for checking leap year :
    # (year % 4 == 0 && year % 100 != 0) ||   (year % 400 == 0)

	.data
msg1:	.asciiz "Enter a year : "
msg2:	.asciiz " is a leap year"
msg3:	.asciiz " is not a leap year"

	.text
	.globl main

main:
	li $v0, 4
	la $a0, msg1
	syscall

	li $v0, 5
	syscall
	move $t0, $v0		# year in $t0

	li $t1, 4
	li $t2, 100
	li $t3, 400

	div $t0, $t1		# year % 4
	mfhi $t1

	div $t0, $t2		# year % 100
	mfhi $t2

	div $t0, $t3		# year % 400
	mfhi $t3

	li $v0, 1
	move $a0, $t0
	syscall

	li $v0, 4

	divby4:
		beq $t1, 0, divby100
		j divby400

	divby100:
		bne $t2, 0, leapyear
		
	divby400:
		beq $t3, 0, leapyear
		j noleapyear

	leapyear:
		la $a0, msg2
		j end

	noleapyear:
		la $a0, msg3

	end:
		syscall
		li $v0, 10
		syscall
.end main
