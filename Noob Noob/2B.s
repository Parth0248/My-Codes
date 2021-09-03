.data
arr:
    # ADD data / Array here
    .word 2, 4, 10, 15, 25, 40
arrsize:
    .word 6
x:
    .word 25

.text

.global main

# %rdi = &arr[0]  %rsi = l  %rdx = r  %rcx = x 

main:
mov arr@GOTPCREL(%rip), %rdi
mov arrsize@GOTPCREL(%rip), %rbx
xor %rdx , %rdx
mov (%rbx) , %dx    # r stored
mov x@GOTPCREL(%rip), %rbx
xor %rcx , %rcx
mov (%rbx), %cx     # x stored


mov $0 , %r10      # r10 contains l
mov %rdx, %r11      # r11 contains r

# mov %r11, %rax
.REC:

cmp %r10, %r11      # compares if left is <= right
jl .EXIT

# xor %r13, %r13      # init r13
mov %r11 , %r13     # copying r in r13
add %r10 , %r13     # adding r13 (i.e, r) by l
shr $1 , %r13       # dividing r13 by 2 by right shifting by 1 bit

lea (%rdi, %r13, 2), %r14 # storing the value in arr[mid] in r14
movw (%r14), %r15w
cmp %cx, %r15w      # compares if arr[mid] == x
je .MID
jg .LEFT
jl .RIGHT

.LEFT:
mov %r13 , %r11     # overwrites r11 (i.e. r) with mid
dec %r11            # decreases by 1
jmp .REC            # repeats recursion

.RIGHT:
mov %r13, %r10      # overwrites r10 (i.e. l) with mid
inc %r10            # increment by 1
jmp .REC            # repeats recursion

.MID:
mov %r13 , %rax     # sets value of rax to mid value
jmp .RETURN

.EXIT:
mov $-1, %rax       # sets value to -1 

.RETURN:
ret
