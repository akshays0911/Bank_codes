/*
This is a basic code to compare between Host Code(CPU) and Device Code(GPU)
*/

#include<stdio.h>
 __global__ void mykernel(void){}
int main(void)
{   
    mykernel<<<1,1>>>();  // Kernel Launch
    printf("Hello World \n");
    return 0;
}
