# algo for recursive gcd :
#	int gcd(int n1, int n2)
#	{
#	    if (n2 != 0)
#	       return gcd(n2, n1%n2);
#	    else 
#	       return n1;
#	}

.data
	num1:	.word 0
	num2:	.word 0
	result:	.word 0
	buffer:	.asciiz ""
	msg1:	.asciiz	"Enter num1 : "
	msg2:	.asciiz	"Enter num2 : "
	msg3:	.asciiz	"GCD : "

.text
.globl main
main:
	
	li $v0, 4
	la $a0, msg1		# print msg1
	syscall

	li $v0, 5
	syscall				# input num1
	sw $v0, num1

	li $v0, 4
	la $a0, msg2		# print msg2
	syscall
	
	li $v0, 5
	syscall				# input num2
	sw $v0, num2
	
	lw $a0, num1		# set arguments
	lw $a1, num2
	
	jal gcd 			# call gcd
	sw $v0, result

	li $v0, 4			# print msg3
	la $a0, msg3
	syscall
	
	li $v0, 1			# print result
	lw $a0, result
	syscall
	
	li $v0, 10			# exit
	syscall
.end main


.globl gcd
.ent gcd
gcd:
	addi $sp, $sp, -12
	sw $ra, ($sp)
	sw $a0, 4($sp)		# save return address and arguments to stack 
	sw $a1, 8($sp)

	div $a0, $a1		# $v0 = n1 % n2
	mfhi $v0

	bne $v0, $zero, gcd_next
	add $v0, $a1, $zero		# if(base case ie. n2 == 0)
	j gcd_done

gcd_next:
	add $a0, $a1, $zero	
	add $a1, $v0, $zero
	jal gcd 				# recursive call ie. gcd(n2, n1%n2);

gcd_done:
	lw $ra, ($sp)
	lw $a0, 4($sp)			
	lw $a1, 8($sp)			# base case return code
	addi $sp, $sp, 12
	jr $ra
.end gcd
