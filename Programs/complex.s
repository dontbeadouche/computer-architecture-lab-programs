	.data
c1:  .word 5, 3    # 5+3i
c2:  .word 2, -1   # 2-3i
c3:  .word 0, 0

   .text
   .globl main
 main:
     la $a0, c1     # $a0 = &c1
     la $a1, c2     # $a1 = &c2
     la $a2, c3     # $a3 = &c3    
     jal add_cmplx  # void add_complex(&c1, &c2, &c3) c3 = c1 + c2
     
     #print
     li $v0, 10
     syscall

add_cmplx:
       lw $t1, 0($a0)       # c3->real = c1->real + c2->real;
       lw $t2, 0($a1)                           
       add $t3, $t1,$t2
       sw $t3, 0($a2)
       jr    $r31
