 
    .data

  msg1: .asciiz "Enter a : "
  msg2: .asciiz "Enter b : "
  msg3: .asciiz "Enter c : "
  msg4: .asciiz "Enter d : "
  msg5: .asciiz "Enter e : "
  msg6: .asciiz "\na = a * b / c % d + e = "

    .text
    .globl main

main:

  li $v0, 4
  la $a0, msg1
  syscall

  li $v0, 5
  syscall
  add $t0, $v0, $zero   # a in $t0

  li $v0, 4
  la $a0, msg2
  syscall

  li $v0, 5
  syscall
  add $t1, $v0, $zero   # b in $t1

  li $v0, 4
  la $a0, msg3
  syscall

  li $v0, 5
  syscall
  add $t2, $v0, $zero   # c in $t2

  li $v0, 4
  la $a0, msg4
  syscall

  li $v0, 5
  syscall
  add $t3, $v0, $zero   # d in $t3

  li $v0, 4
  la $a0, msg5
  syscall

  li $v0, 5
  syscall
  add $t4, $v0, $zero   # e in $t4

  mult $t0, $t1
  mflo $t0              # $t0 = a*b

  div $t0, $t2          # $t0 = a*b/c
  mflo $t0

  div $t0, $t3          # $t0 = (a*b/c)%d
  mfhi $t0

  add $t0, $t0, $t4     # $t0 = (a*b/c)%d+e

  li $v0, 4
  la $a0, msg6
  syscall

  li $v0, 1
  add $a0, $t0, $zero
  syscall

  li $v0, 10
  syscall

.end main
