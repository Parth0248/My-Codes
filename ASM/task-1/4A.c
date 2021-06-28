#include <stdio.h>
#include <string.h>

void con(int count[26], char str[33]);

int main()
{
    char str[33] = "aaaaaaaaaassssssssssddddddddddff";
    // scanf("%s", str);      

    int count[26] = {0};

    con(count, str);

    for (int i = 0; i < 26; i++)
    {
        printf("%c = %d \n", 'a' + i, count[i]);
    }

    return 0;
}