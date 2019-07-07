#X = X + Y × Z
#4 × 4 matrices, 64-bit double-precision elements
#void mm (double x[][],double y[][], double z[][])
#{ int i, j, k;
#  for (i = 0; i! = 32; i = i + 1)
#   for (j = 0; j! = 32; j = j + 1)
#   for (k = 0; k! = 32; k = k + 1)
#        x[i][j] = x[i][j] + y[i][k] * z[k][j];
#}
#Addresses of x, y, z in $a0, $a1, $a2, and i, j, k in $s0, $s1, $s2

.data
X: .double	1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0
Y: .double	1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0
Z: .double	1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0

.text
.globl main
main: 	li   $t1, 4       	# $t1 = 4 (row size/loop end)
	li   $s0, 0        	# i = 0; initialize 1st for loop
L1: 	li   $s1, 0    		# j = 0; restart 2nd for loop
L2: 	li   $s2, 0    		# k = 0; restart 3rd for loop
	sll  $t2, $s0, 2   	# $t2 = i * 4 (size of row of x)
	addu $t2, $t2, $s1 	# $t2 = i * size(row) + j
	sll  $t2, $t2, 3   	# $t2 = byte offset of [i][j] 8 bytes *8 = 
	la $a0, X
	addu $t2, $a0, $t2 	# $t2 = byte address of x[i][j] 
	l.d  $f4, 0($t2)   	# $f4 = 8 bytes of x[i][j]
	L3: 	sll  $t0, $s2, 2   	# $t0 = k * 32 (size of row of z)
	addu $t0, $t0, $s1 	# $t0 = k * size(row) + j
	sll  $t0, $t0, 3   	# $t0 = byte offset of [k][j]
	la $a2, Z
	addu $t0, $a2, $t0 	# $t0 = byte address of z[k][j]
	l.d  $f16, 0($t0)  	# $f16 = 8 bytes of z[k][j]
	sll  $t0, $s0, 2        # $t0 = i*32 (size of row of y)
	addu  $t0, $t0, $s2     # $t0 = i*size(row) + k
	sll   $t0, $t0, 3       # $t0 = byte offset of [i][k]
	la $a1, Y
	addu  $t0, $a1, $t0     # $t0 = byte address of y[i][k]
	l.d   $f18, 0($t0)      # $f18 = 8 bytes of y[i][k]
	mul.d $f16, $f18, $f16  # $f16 = y[i][k] * z[k][j]
	add.d $f4, $f4, $f16    # f4=x[i][j] + y[i][k]*z[k][j]
	addiu $s2, $s2, 1       # $k k + 1
	bne   $s2, $t1, L3      # if (k != 32) go to L3
	s.d   $f4, 0($t2)       # x[i][j] = $f4
	addiu $s1, $s1, 1       # $j = j + 1
	bne   $s1, $t1, L2      # if (j != 32) go to L2
	addiu $s0, $s0, 1       # $i = i + 1
	bne   $s0, $t1, L1      # if (i != 32) go to L1
	li $v0, 2
	mov.s $f12,$f4
	syscall
	li $v0, 10
	syscall