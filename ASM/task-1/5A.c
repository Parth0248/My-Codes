#include <stdio.h>

int hamdist(int n1, int n2);    // coded in assembly lang.

int main()
{
    int n1, n2;
    scanf("%d %d", &n1, &n2);
   
    printf("%d \n", hamdist(n1, n2));

    return 0;
}