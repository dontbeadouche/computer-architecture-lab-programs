#
# int i, sum = 0;
# for (i=0; i < N; i++)
#   sum = sum + i
#

	.data
msg1:   .asciiz "Enter N: "
msg2:   .asciiz "The Sum = "
no:    .word 0
sum:    .word 0
crlf:   .byte 0xd, 0xa, 0

	.text
	.globl main

main:   
	li $v0, 4       # syscall 4 (print_str)
    la $a0, msg1     # argument: string
    syscall         # print the string

    li $v0, 5
    syscall
    sw $v0, no

    li  $t0, 0     # sum = 0
    li  $t1, 1      # $t1 (i = 1)
    lw  $t2, no     # $t2 (t2 = no)
next:
    bgt  $t1, $t2, over
    add  $t0, $t0, $t1 # sum = sum + i;
    addi  $t1, $t1, 1   # i = i + 1
    j    next

over:
    sw  $t0, sum

    li $v0, 4       # syscall 4 (print_str)
    la $a0, crlf     # argument: string
    syscall         # print the string

    li $v0, 4       # syscall 4 (print_str)
    la $a0, msg2     # argument: string
    syscall         # print the string

    li 	$v0, 1
    lw  $a0, sum
    syscall




    li $v0, 10      # 
    syscall         #

 .end main 