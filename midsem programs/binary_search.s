# binary search algo :
# isFound = 0
# lo = 0
# high = n-1
# while (lo <= high) {
#	mid = (lo + high)/2;
#   if (data == A[mid]) { isFound = 1; break; }
#   if (data < A[mid]) { high = mid - 1; continue;}
#   low = mid + 1;
#}

	.data
A: 		.word -32, -16, 0, 8, 16, 32, 64
n: 		.word 7
data: 	.word -16
msg1:   .asciiz " Found at pos: "
msg2:   .asciiz " Not found"

	.text
	.globl main
main:
	lw		$t0, data		# $t0 =  (data)
	li      $t1, 0          # $t1 = 0 (isFound)
	li		$t2, 0			# $t2 = 0 (lo)
	lw      $t3, n      	# $t3 = n
	add		$t3, $t3, -1 	# $t3 = n-1 (high)
L1:
	bgt 	$t2, $t3, end_loop 	# if (lo > hi) end_loop
	add 	$t4, $t2, $t3		# $t4 = lo + high
	srl		$t4, $t4, 1             	# shift right logical: $t4 = $t4/2 (mid)
	sll		$t5, $t4, 2			# shift left logical: $t5 = $t4 * 4
	lw      $t6, A($t5)			# $t6 = A[mid]
	bne		$t0, $t6, not_equal # $t0 != $t6 (data != A[mid])
	li      $t1, 1              # $t1 = 1 (isFound = 1)
	j       end_loop            # jmp outside loop
not_equal:
	blt     $t0, $t6, less_than # $t0 <  $t6 (data < A[mid])
	addiu	$t2, $t4, 1         # ($t2)lo = ($t4)mid + 1
	j       L1                  # continue from begining.
less_than:
    addiu	$t3, $t4, -1        # ($t3)high = ($t4)mid - 1
    j       L1                  # continue from begining.

end_loop:
    li 		$v0, 1      		# print int
    move 	$a0, $t0			# $a0 = data

    syscall
	li		$v0, 4
	beq		$t1, $zero, msg_nf  # if (isFound == 0)

	la		$a0, msg1           # isFound == 1 display msg
	syscall

	li 		$v0, 1      		#
    move 	$a0, $t4			# $a0 = mid
    syscall
    j 		exit
msg_nf :
    la		$a0, msg2           # isFound == 0 display msg
	syscall
exit:
	li 		$v0, 10     		# exit
    syscall         			#
.end main
