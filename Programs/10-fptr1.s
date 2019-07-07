
.data
x:	.word 10
y:	.word 6
z: 	.word 0
op: 	.word 2  #ADD=0, SUB=1, etc.

plus_str: .asciiz " PLUS "
minus_str:.asciiz " MINUS "
mul_str:  .asciiz " MUL "
div_str:  .asciiz " DIV " 
mod_str:  .asciiz " MOD "
equ_str:  .asciiz " = "

# addresses of functions (array of func pointers)
# int (*fptr[])(int, int) = { f_add, f_sub, f_mul, d_div, f_mod};

fptrs:
	.word f_add, f_sub, f_mul, f_div, f_mod

# addresses of strs (array of char *)
# char *op_str[] = {"PLUS", "MINUS", "MUL", "DIV", "MOD"};
op_str:
	.word plus_str, minus_str, mul_str, div_str, mod_str


	.text
	.globl main

main:
	lw	$a0, x     # arg 1
	lw	$a1, y     # arg 2
	lw	$a2, op    # op = ADD (0), SUB(1) etc
	jal     do_op      # call do_op( z = fptr[0](x,y))
	sw      $v0, z     # z = $v0 

	li      $v0, 1     # print int
	lw      $a0, x     # $a0 = x
	syscall

	li      $v0, 4     # print str
        lw	$t0, op     # op = ADD (0), SUB(1) etc
        sll     $t0, $t0, 2 # $t0 = $t0 * 4 (size of addr)
        lw      $a0, op_str($t0) # $a0 = addr(plus), addr(minus) etc
        syscall

        li      $v0, 1     # print int
	lw      $a0, y     # $a0 = y
	syscall

	li      $v0, 4     # print str
        la      $a0, equ_str   # equ_str: "="
    	syscall

    	li      $v0, 1     # print int
	lw      $a0, z     # $a0 = z (result)
	syscall

	li		$v0, 10    # exit
    	syscall

do_op:
    	addi   $sp, $sp, -4   # make place to save ra
    	sw     $ra, 0($sp)    # save ra
    
    	sll    $t0, $a2, 2    # $t0 = $a0 << 4 (size of a ptr)
    	lw     $t1, fptrs($t0) # $t1 = fptrs[i] (addr of func)
    	jalr   $t1             # jmp to the function pointed by $t1
    	lw     $ra, 0($sp)    # retrive the return add
    	addi   $sp, $sp, 4   # restore sp
    	jr     $ra           # return

f_add:
    	add     $v0, $a0, $a1 # add: result in $v0
	jr      $ra           # return

f_sub:
	sub     $v0, $a0, $a1
	jr      $ra

f_mul:
	mul    $v0, $a0, $a1
	jr      $ra


f_div:
    	div     $v0, $a0, $a1
	jr      $ra

f_mod:
    	rem     $v0, $a0, $a1
	jr      $ra