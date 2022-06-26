.equ kernel,   0x80
.equ exit,     0x01
.equ stdin,    0x00
.equ stdout,   0x01
.equ read,     0x03
.equ write,    0x04
.equ open,     0x05
.equ close,    0x06
.equ flags,    0
.equ mode,     0x180

.data
.text
.global FILENAME
FILENAME:
   pushl %ebp
   movl %esp, %ebp

   movl 8(%ebp), %eax

#fin:
   leave
   ret
#   movl %ebp, %esp
#   popl %ebp
#   ret
