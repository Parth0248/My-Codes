#include <stdio.h>

#define N 8

// Function to rotate the matrix 90 degree clockwise
void rotate90AntiClockwise(short int a[N][N]);
// {

//     // Traverse each cycle
//     for (int i = 0; i < N / 2; i++)
//     {
//         for (int j = i; j < N - i - 1; j++)
//         {

//             // Swap elements of each cycle
//             // in anticlockwise direction
//             int temp = a[i][j];
//             a[i][j] = a[j][N - 1 - i];
//             a[j][N - 1 - i] = a[N - 1 - i][N - 1 - j];
//             a[N - 1 - i][N - 1 - j] = a[N - 1 - j][i];
//             a[N - 1 - j][i] = temp;
//         }
//     }
// }

// Function for print matrix
void printMatrix(short int arr[N][N])
{
    for (int i = 0; i < N; i++)
    {
        for (int j = 0; j < N; j++)
            printf("%hd ",arr[i][j]);
        printf("\n");
    }
}

// Driver code
int main()
{
    short int arr[N][N] = {
        {1, 2, 3, 4, 5, 6, 7, 8},
        {9, 10, 11, 12, 13, 14,15, 16},
        {17, 18, 19, 20, 21, 22, 23, 24},
        {25, 26, 27, 28, 29, 30, 31, 32},
        {33, 34, 35, 36, 37, 38, 39, 40},
        {41, 42, 43, 44, 45, 46, 47, 48},
        {49, 50, 51, 52, 53, 54, 55, 56},
        {57, 58, 59, 60, 61, 62, 63, 64},
    };

    rotate90AntiClockwise(arr);
    
    printMatrix(arr);
    return 0;
}