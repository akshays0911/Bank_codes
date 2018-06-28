/*
Parallel programming addition of Two numbers
*/

#include<stdio.h>
 __global__ void add(int *a, int *b)
 {   
     int c;
     c = *a + *b;
     return(c);
 }
int main(void)
{   
    add(2, 3);
    printf("Addition \t", c);
    return 0;
}
