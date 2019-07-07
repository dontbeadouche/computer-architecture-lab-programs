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
msg3: .asciiz "Concatenated String (1) : "

str1: .space 20
str2: .space 20

newline: .asciiz "\n"

	.text
	.globl main

main:
	
	li $v0, 4       # print msg1
    la $a0, msg1
    syscall

    li $v0, 8       # input str1
    la $a0, str1
    li $a1, 20		# max length = 20
    syscall

    move $a2, $a0	# $a2 = *str1 = *dst

    li $v0, 4       # print msg2
    la $a0, msg2
    syscall

    li $v0, 8       # input str2
    la $a0, str2
    li $a1, 20		# max length = 20
    syscall

    move $a3, $a0	# $a3 = *str2 = *src

    # arguments : *str1 in $a2 and *str2 in $a3 
    
    jal strcat		# call strcat()

    # return address in $v1 even though it doesn't matter since $v1 = $a2 ie. address of str1/dst

    li $v0, 4       # print msg3
    la $a0, msg3
    syscall

    li $v0, 4       # print result
    la $a0, 0($a2)
    syscall

    li $v0, 10		# exit
    syscall

strcat:
		li $t0, 0	# $t0 = i = 0
		li $t3, 0	# $t3 = j = 0
		
	loop1:
		add $t1, $t0, $a2	# $t1 = addr of str1[i]
		lbu $t2, 0($t1)		# $t2 = str1[i]
		
		beq $t2, $zero, remove_newline 	# if *str1 == 0 { goto remove_newline }

		addi $t0, $t0, 1	# i++
		j loop1

	remove_newline:
		addi $t1, $t1, -1	# remove newline from the end of dst/str1 coz it counts as a character (lol)

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
		jr $ra				# return to caller


































