.text
.global rotate90AntiClockwise
    # rdi has a[0][0]
rotate90AntiClockwise:

movq $7, %r8 
movq $-1, %r9     # r9 is i = 0

.L2:
incq %r9             # i++
cmpq $4 , %r9
jge .EXIT
movq %r9, %r10      # r10 (j) has i

.L3:

movq %r8, %rdx
subq %r9, %rdx    # N - i - 1    

movq %r8, %rcx
subq %r10, %rcx   # N - j - 1

cmpq %rdx , %r10    # j vs 7 - i
jge .L2              # jumps to outer loop

leaq (%r10 , %r9 , 8) , %r11     # r11 has a[i][j]
leaq (%rdi , %r11 , 2), %r11
movw (%r11) , %r12w               # r12 = temp

leaq (%rdx , %r10 , 8) , %r13     
leaq (%rdi , %r13 , 2), %r13    # r13 has a[j][7-i] 
movw (%r13) , %bx               # r13 = a[j][7-i]
movw %bx  , (%r11)              # a[i][j] = a[j][7-i]

leaq (%rcx , %rdx , 8) , %r14     
leaq (%rdi , %r14 , 2), %r14    # r14 has a[7-i][7-j] 
movw (%r14) , %bx               # r14 = a[7-i][7-j]
movw %bx  , (%r13)              # a[j][7-i] = a[7-i][7-j]

leaq (%r9 , %rcx , 8) , %r15     
leaq (%rdi , %r15 , 2), %r15    # r15 has a[7-j][i] 
movw (%r15) , %bx               # r14 = a[7-j][i]
movw %bx  , (%r14)              # a[7-i][7-j] = a[7-j][i]

movw %r12w , (%r15)
incq %r10
jmp .L3

.EXIT:
ret
