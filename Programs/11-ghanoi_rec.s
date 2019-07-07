#  void hanoi(int ndisks, from, to, using)
#  if (ndisks == 1) {
#     printf("Moving disk  %d from %c to %c\n", ndisks, from to);
#     return
#  }
#  hanoi(ndisks-1, from, using, to);
#  printf("Moving disk  %d from %c to %c\n", ndisks, from to);
#  hanoi(ndisks-1, using, to, from);
#
#
#
	.data
n:	.word 4
move_msg: .asciiz "Moving Disk: "
from_msg: .asciiz " From Pole: "
to_msg: .asciiz " To Pole: "
eoln: .byte '\n'

	.text
	.globl 	main
main:
    lw		$a0, n     #  $a0 = n (ndisks)
    li		$a1, 'A'   #  from Pole
    li		$a2, 'B'   #  to Pole
    li		$a3, 'C'   #  using pole 
    jal	hanoi  # 

    li     $v0, 10     #  decent good bye 
    syscall            #

#  void hanoi(int ndisks, from, to, using)
#                    $a0,  $a1, $a2, $a3
hanoi:
	add		$sp,	$sp, -20
	sw		$ra,	0($sp)     # push ret add
	sw		$a0,	4($sp)     # ndisks
	sw		$a1,	8($sp)     # from pole
	sw		$a2,	12($sp)    # to pole
	sw		$a3,	16($sp)    # using pole

    addi    $t0,	$zero, 1   # 
	bgt     $a0,    $t0,   L1  # if ndisks($a0>1) then L1

#  printf("Moving disk  %d from pole %c to pole %c\n", ndisks, from to);
    jal		print

	lw   	$ra, 0($sp)      # retrive return address
    addi 	$sp, $sp, 20     # restore sp
    jr   	$ra              # and return


L1:                         # if ndisks($a0)>1 ...
	addi	$a0, $a0, -1    # ndisks = ndisks-1
	move    $t0, $a2        # tmp = to ($a2)
	move    $a2, $a3        # to($a2) = $a3 (using)
	move    $a3, $t0        # to(a3) = tmp
	jal		hanoi			# hanoi(ndisks-1, from, using, to);

	lw      $a0, 4($sp)		# retrive ndisks
    lw		$a1, 8($sp)     # from
	lw		$a2, 12($sp)   # to
	jal		print

	lw      $a0, 4($sp)		# retrive ndisks
	addi	$a0, $a0, -1    # ndisks = ndisks-1
     
    lw		$a1, 16($sp)  	# from
	lw		$a2, 12($sp)   	# to
	lw		$a3, 8($sp)     # using
	jal		hanoi           # hanoi(ndisks-1, using, to, from);

	lw   	$ra, 0($sp)      # retrive return address
    addi 	$sp, $sp, 20      # restore sp
    jr   	$ra              # and return


#printf("Moving disk  %d from %c to %c\n", ndisks, from to);
print:
	move	$s0, $a0		# disk no
	move	$s1, $a1        # from
	move	$s2, $a2        # to

	li		$v0,	4		 # print_string
	la		$a0,	move_msg # "Moving disk "
	syscall

	li		$v0,	1       # print_int
	move	$a0,	$s0     # disk no
	syscall

	li		$v0,	4        # print_string
	la		$a0,	from_msg # "from pole"
	syscall

	li		$v0,	11      # print_char      
	move	$a0,	$s1     # from pole ($s1)
	syscall

	li		$v0,	4       # print_string
	la		$a0,	to_msg  #  "to pole"
	syscall

	li		$v0,	11      # print_char
	move	$a0,	$s2     # to
	syscall

	li		$v0,	11      # print_char      
	lb		$a0,	eoln    # '\n'
	syscall

	jr		$ra             # return to caller
