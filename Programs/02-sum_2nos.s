	.data
msg1:   .asciiz "Enter No 1: "
msg2:   .asciiz "Enter No 2: "
msg3:   .asciiz "The sum is: "
no1:    .word 0
no2:    .word 0
sum:    .word 0
crlf:   .byte 0xd, 0xa, 0
newline: .asciiz "\n"

	.text
	.globl main

main:   
	li $v0, 4       # syscall 4 (print_str)
    la $a0, msg1     # argument: string
    syscall         # print the string

    li $v0, 5
    syscall
    sw $v0, no1

    li $v0, 4       # syscall 4 (print_str)
    la $a0, msg2     # argument: string
    syscall         # print the string

    li $v0, 5
    syscall
    sw $v0, no2

    lw  $t0, no1       # $t0 <= no1
    lw  $t1, no2       # $t1 <= no2
    add $t2, $t0, $t1  # $t2 <= $t0 + $t1
    sw  $t2, sum       # sum <= $t2

    # new line 
    li $v0, 4       # syscall 4 (print_str)
    la $a0, newline    # argument: string
    syscall         # print the string

    li $v0, 4       # syscall 4 (print_str)
    la $a0, msg3     # argument: string
    syscall         # print the string

    li 	$v0, 1
    lw  $a0, sum
    syscall



    li $v0, 10      # 
    syscall         #

 .end main 