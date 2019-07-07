#Sieve Of Eratosthenes
#int sieve[101];
#int n = 100;
#for (int pno = 2; pno*pno <= n; pno++) {
#	if (sieve[pno]) {
#      for (int i = pno*pno; i <= n; i += pno)  
#          sieve[i]=false;
#    }
# }


	.data
num:	.word 100
sieve:	.space 101 	# 
msg0:	.asciiz "Checking index:"
msg1:   .asciiz " Val:"
msg2:   .asciiz "   Marking Index:"
msg3:   .asciiz "Primes are:"


	.text
	.globl	main
main:
	lw  	$t0, num #$t0=num
	li		$t1, 0    #i=0
	li		$t2, 1  
L0:
	bgt		$t1, $t0, begin # if ($t1 > $t0) goto begin
	sb		$t2, sieve($t1) # sieve[i] = 1
	addiu   $t1, $t1, 1
	j		L0

begin:
	lw  	$t0, num #$t0=num
	li		$t1, 2    #pno
L1:
	multu	$t1, $t1 #hi:lo=pno*pno
	mflo 	$t2	  #$t2 = lo (=pno*pno)
	bgt	 	$t2, $t0, end_loop # if ($t2 > $t0) then goto end_loop
	li		$v0, 4
	la		$a0, msg0
	syscall
	li		$v0, 1
	move    $a0, $t1
	syscall
	li		$v0, 4
	la		$a0, msg1
	syscall
	lbu	 	$t4, sieve($t1) # $t4=sieve[pno]
	li		$v0, 1
	move    $a0, $t4
	syscall
    beq		$t4, $zero, inc_pno # if sieve[pno]==0, skip sieving sieve[pno]
    li		$v0, 4
	la		$a0, msg2
	syscall
    move 	$t5, $t2             # $t5 = i (= pno*pno)
L2:
    bgt  	$t5, $t0, inc_pno # $t5 > $t0 (i > n)
    li		$v0, 1
	move    $a0, $t5
	syscall
	li  	$v0, 11
    li		$a0, ' '
    syscall
    sb   	$zero,  sieve($t5) # sieve[pno] = 0
    addu 	$t5, $t5, $t1      # $t5 = $t5 + $t1 (i+=pno)
    j    	L2
inc_pno:
	li  	$v0, 11
    li		$a0, '\n'
    syscall
	addiu 	$t1, $t1, 1      # $t1++ (=pno++)
    j    	L1
end_loop:
	
	li  	$v0, 11
    li		$a0, '\n'
    syscall

    li		$v0, 4
	la		$a0, msg3
	syscall

	li 		$t2, 2          #i=2
L3:
	bgt 	$t2, $t0, over  # i>n
	lb  	$t3, sieve($t2) # $t3=sieve[i]
	beq 	$t3, $zero, inc_i # if sieve[i]==0 then next_i
    
    li  	$v0, 1
    move 	$a0, $t2       # $v0=1, $a0 = i (sieve[i]==1)
    syscall                # print the num

    li  	$v0, 11
    li		$a0, ' '
    syscall

inc_i:
	addiu $t2, $t2, 1
	j	L3

over:
	li  	$v0, 11
    li		$a0, '\n'
    syscall
	li		$v0, 10
    syscall

#Sieve Of Eratosthenes
#unsigned char sieve[101];
#int n = 100;
#for (int pno = 2; pno*pno <= n; pno++) {
#	if (sieve[pno]) {
#      for (int i = pno*pno; i <= n; i += pno)  
#          sieve[i]=false; //Marking Index
#    }
# }