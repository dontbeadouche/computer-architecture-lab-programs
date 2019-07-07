	.data
arr: .word 10, 20, 30, 40
num: .word 4
msg: .asciiz "The sum of nos = "
sum: .word 0

	.text
	.globl main
main:
	li 		$t0, -1
	li		$t0, 0		# $t0=sum=0
	li		$t1, 0		# $t1=i=0
	lw 		$t2, num	# $t2=num
next_i:
	bge		$t1, $t2, end_loop # if i>=num goto over
	sll		$t3, $t1, 2 # $t3 = $t2 (i) << 2
	lw  	$t4, arr($t3) #$t4 = Arr(i)
	add 	$t0, $t0, $t4 # sum = sum + arr(i)
	addu 	$t1, $t1, 1   # i = i +i
	j		next_i
end_loop:
	sw		$t0, sum	# sum=$t0
	
	li		$v0, 4
	la		$a0, msg
	syscall

	li 		$v0, 1      #
    lw  	$a0, sum
    syscall

	

    li 		$v0, 10      # exit
    syscall         #