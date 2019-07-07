
# non recursive gcd algorithm :
#   for(i=1; i <= n1 && i <= n2; ++i)
 #     {
 #         if(n1%i==0 && n2%i==0)
 #             gcd = i;
 #     }

    .data

msg1: .asciiz "Enter number 1: "
msg2: .asciiz "Enter number 2: "
msg3: .asciiz "GCD : "

num1: .word 0
num2: .word 0
res: .word 0

newline: .asciiz "\n"

    .text
    .globl main

main:
    
    li $v0, 4       # print msg1
    la $a0, msg1
    syscall

    li $v0, 5
    syscall         # getting input num1
    sw $v0, num1

    li $v0, 4       # print msg2
    la $a0, msg2
    syscall

    li $v0, 5
    syscall         # getting input num2
    sw $v0, num2

    lw $t1, num1
    lw $t2, num2
    li $t0, 1       # i = 1
    li $t3, 0       # gcd = 0

    loop: 
        bgt $t0, $t1, end_loop
        bgt $t0, $t2, end_loop

        divu $t1, $t0
        mfhi $t4    # t4 = num1%i
        bne $t4, 0, try_next_i

        divu $t2, $t0
        mfhi $t4    # t4 = num2%i
        bne $t4, 0, try_next_i

        move $t5, $t0     # if(n1%i==0 && n2%i==0) {gcd = $t5 = i;}
        

    try_next_i:
        addiu $t0, $t0, 1   # i++
        j loop

    end_loop:
        sw $t5, res     # store result

        li $v0, 4       # print msg3
        la $a0, msg3
        syscall

        li $v0, 1
        lw $a0, res     # output gcd
        syscall

        li $v0, 10      # exit
        syscall     












