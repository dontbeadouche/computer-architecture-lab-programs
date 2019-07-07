	.data
pi: .double 3.14
intPi: .word 0
	.text
	.globl main
main:	l.d $f10, pi
	cvt.w.d $f12, $f10
	mfc1 $a0, $f12
	sw $a0, intPi
	li $v0, 1
	syscall
	li $v0, 10
	syscall