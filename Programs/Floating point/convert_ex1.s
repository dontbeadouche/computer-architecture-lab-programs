	.data
iNum: .word 42
fNum: .float 0.0
	.text
	.globl main
main:	lw $t0, iNum
	mtc1 $t0, $f6
	cvt.s.w $f12, $f6
	s.s $f12, fNum
	li $v0, 2
	syscall
	li $v0, 10
	syscall