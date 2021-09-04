.text
.global con
con:
                    # rdi has &count[0] and rsi has &str[0]

mov $0, %r9         # i iterator of for loop

.loop1:

    lea (%rsi, %r9 , 1), %r11  # lea a(b,c,d)=a+b+c*d 
    xor %r13 , %r13         # init r13 to 0

    mov (%r11) , %r13b
    
    cmp $0, %r13            # is \0 toh exit
    je .exit


    cmp $123, %r13         # if statement
    jg .skip1
    
    cmp $97, %r13         # if statement
    jl .skip1

    sub $97, %r13

    lea (%rdi , %r13 , 4), %rbx 
    incl (%rbx)
    

.skip1:
    inc %r9

    cmp $32, %r9
    je .exit

    jmp .loop1

.exit:
ret
