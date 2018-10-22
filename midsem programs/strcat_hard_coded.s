# strcat algo :
#	char* strcat (char * dst, char * src){
#	   char* originalDst = dst;
#	   while(*dst){ //i
#	dst++; }
#	   while(*src){	//j
#	      *dst = *src;
#	      dst++;
#	      src++;
#	   }
#	   *dst = *src; 	// = '/0'
#	   return originalDst;
#	}


	.data

msg1: .asciiz "Enter String 1 : "
msg2: .asciiz "Enter String 2 : "
msg3: .asciiz "Concatenated String : "

str1: .asciiz "Hello"
str2: .asciiz "World"

	.text
	.globl main

main:
    la $a2, str1	# $a2 = *str1 = *dst
    la $a3, str2	# $a3 = *str2 = *src

    # arguments : *str1 in $a2 and *str2 in $a3
    # return address in $v1

    jal strcat

    li $v0, 4       # print msg2
    la $a0, msg3
    syscall

    li $v0, 4       # print result
    la $a0, 0($v1)
    syscall

    li $v0, 10
    syscall
.end main

strcat:
		li $t0, 0	# $t0 = i = 0
		li $t3, 0	# $t3 = j = 0

	loop1:
		add $t1, $t0, $a2	# $t1 = addr of str1[i]
		lbu $t2, 0($t1)		# $t2 = str1[i]

		beq $t2, $zero, loop2 	# if *str1 == 0 { goto loop2 }

		addi $t0, $t0, 1	# i++
		j loop1

	loop2:
		add $t4, $t3, $a3	# $t4 = addr of str2[i]
		lbu $t5, 0($t4)		# $t5 = str2[i]

		beq $t5, $zero, end_loop	# if *str2 == 0 { goto end_loop }

		sb $t5, 0($t1)		# str1[i] = str2[j]

		addi $t1, $t1, 1	#	dst++
		addi $t3, $t3, 1	#	src++
		j loop2

	end_loop:

		lb $t6, 0($t4)				# *dst = *src = '/0'
		sb $t6, 0($t1)

		move $v1, $a2
		jr $ra
.end strcat