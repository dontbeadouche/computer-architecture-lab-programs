.data
const5: .float 5.0
const9: .float 9.0
const32: .float 32.0
constf: .float 50.0
.text
.globl main
main: 
l.s  $f16, const5
l.s  $f18, const9
div.s $f16, $f16, $f18
l.s  $f12, constf
l.s  $f18, const32
sub.s $f18, $f12, $f18
mul.s $f12,  $f16, $f18
li $v0, 2
syscall
li $v0, 10
syscall