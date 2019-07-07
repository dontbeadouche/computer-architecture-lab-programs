# stored program comp
# there is not distiction between code and data
for (i = ..)
   for (j...)
       if (option == 0)     for every element this is done
          if a[i] > a[j]    ascending
             swap
       else 
           if a[i] < a[j]    descening..

main:
       la  $t0, L1
       lw  $t1, 0($t0)
       #modify $t1 with opcode of blt
       sw  $t1, 0($t0)

       jal  sort
  

 sort:                
      li   $t0, 0
      add  $t1, $t0, 1


  L1 :    bgt .... 

       jr   $r31

