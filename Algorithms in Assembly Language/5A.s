.text
.global hamdist
                        # rdi = n1 ....  rsi =  n2
hamdist:

xor %r11, %r11          # init r11 to 0

mov %edi, %r11d         # storing only last 16 bits of arg1 to r11 

xor %esi, %r11d         # xor the two 16-bit numbers and stored in r11d (16bits)

mov $0, %r9             # i iterator of loop

mov $0, %r10            # count

.loop1:

mov %r11d, %r13d        # storing r11d in r13d

and $1 , %r13           # AND the lsb with 1

add %r13, %r10          # adding the AND value to count

shr $1 , %r11           # right shift by 1     

inc %r9                 # increment i by 1

cmp $15, %r9            # to check if i < 15

jne .loop1              # if not goes repeats loop

mov %r10, %rax          # else moves the final count to eax and ret (exits code)

ret



    
