
.data
array:	.word 	-3, 0, 2, 5, 7, 8, 19
data: 	.word 	5
len:	.word	7
msg_f:	.asciiz "is found at pos : "
msg_nf:	.asciiz "is not found"

.text
.globl main

main:
	lw $t8, data	# $t8 = data
	li $t0,0	# $t0 = isFound =0
	li $t1, 0	# $t1 = low = 0
	
	lw $t2, len
	addi $t2, $t2, -1	# $t2 = high = n-1
	
loop1:	bgt $t1, $t2, end_label
	add $t3, $t1, $t2
	srl $t3, $t3, 1		# $t3 = mid
	sll $a0, $t3, 2 
	lw $t4, array($a0)	# $t4 = array[mid]

	bne $t8, $t4, smaller_label
	li $t0, 1		# isFound = 1
	j end_label

smaller_label:	bgeu $t8, $t4, greater
	addi $t2, $t3, -1
	j loop1
greater:
	addi $t1, $t3, 1
	j loop1

end_label:
	li $v0, 4
	beq $t0, $zero, not_found	

found:
	la $a0, msg_f
	syscall
	
	li $v0, 1
	move $a0, $t3
	syscall
	j exit

not_found:

	la $a0, msg_nf
	syscall
	j exit

exit:			
	li $v0, 10		#exit
	syscall
.end main