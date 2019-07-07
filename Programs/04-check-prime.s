	.data
msg1:	.asciiz "Enter the no: "
msg_is_prime:
		.asciiz "The no is prime\n"
msg_is_not_prime:
		.asciiz "The no is not prime\n"
num:    .word 0

newline : .asciiz "\n"
	.text
	.globl main

main:
	li $v0, 4       # syscall 4 (print_str)
    la $a0, msg1     # argument: string
    syscall         # print the string

    li $v0, 5
    syscall
    sw $v0, num

    lw	$t0, num	# $t0 = num
    srl	$t1, $t0, 1	# $t1 = num/2 
    li	$t2, 1		# $t2 = isPrime = 1
    li	$t3, 2		# $t3 = i = 2
next_i:
    bleu $t3, $t1, calc_rem # if (i < num/2) then calc_rem 
    j	 check_is_prime
calc_rem:
    divu $t0, $t3     # num % i
    mfhi $t4  		  # $t4 = rem (hi)
    bne	 $t4, $0, try_next_i  # if (rem != 0) try_next_i
    li   $t2, 0       # if (rem == 0) isPrime = 0; break
    j    check_is_prime  # 
try_next_i:
    addiu $t3, $t3, 1 # i = i + 1
    j     next_i      # goto next_i 

check_is_prime:
	beq	$t2, $0, is_not_prime  # isPrime == 0 
	la  $a0, msg_is_prime 
	j   print_msg
is_not_prime:
    la	$a0, msg_is_not_prime

print_msg:
	li	$v0, 4
	syscall

	li $v0, 10      # exit
    syscall         #

