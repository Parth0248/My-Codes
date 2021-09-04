.data
		# add data
arr:
	.word 10 , 8 , 5 , 23 , 1 , 3
arrsize:
	.word 6

.text

.global swap
			# rdi rsi rdx rcx
swap:
	mov (%rdi) , %r10w		# r10 is *a
	mov (%rsi) , %r11w		# r11 is *b
	mov %r10w , (%rsi)
	mov %r11w , (%rdi)
	ret

.global main

main:

mov arr@GOTPCREL(%rip), %rcx	# rcx has &arr[0]
mov arrsize@GOTPCREL(%rip), %rsi 
mov (%rsi) , %rdx		# rdx has N

mov $0 , %rbx			# isSorted Bool

.L1:

cmp $1 , %rbx			# while (!isSorted) 
je .EXIT

mov $1 , %rbx			# isSorted = true
mov %rdx , %r14			# r14 has N
sub $2 , %r14			# N - 2

mov $-1 , %r8			# r8 is i
mov $-2 , %r12			# r12 is i for 2nd loop

.L2:

add $2 , %r8			# i = 1
cmp %r14 , %r8			# checking i <= N-2
jg .L3

lea (%rcx , %r8, 2) , %r9	# r9 has &arr[i]
mov (%r9) , %r10w			# r10 has arr[i]
add $2 , %r9				# r9 has &arr[i+1]
mov (%r9) , %r11w 			# r11 has arr[i+1]

cmp %r11w , %r10w			# arr[i] > arr[i+1]
jle .L2

mov %r9 , %rsi
sub $2 , %r9
mov %r9 , %rdi
mov $0 , %rbx				# isSorted = false
call swap

jmp .L2

.L3:

add $2 , %r12				# i = 0

cmp %r14 , %r12				# i <= N - 2
jg .L1


lea (%rcx , %r12, 2) , %r9	# r9 has &arr[i]
mov (%r9) , %r10w			# r10 has arr[i]
add $2 , %r9				# r9 has &arr[i+1]
mov (%r9) , %r11w 			# r11 has arr[i+1]

cmp %r11w , %r10w			# arr[i] > arr[i+1]
jle .L3

mov %r9 , %rsi				
sub $2 , %r9
mov %r9 , %rdi
mov $0 , %rbx				# isSorted = false
call swap

jmp .L3

.EXIT:	
		# uncomment these lines to check the sorted order ... which is stored in %rsi
	# mov     $0,                  %rdx
	# .L_test:
    # xor     %rsi,                %rsi
    # movw    (%rcx,%rdx,2),       %si
    # inc     %rdx
    # cmp     $6 ,                 %rdx
    # jne     .L_test
	
	ret



