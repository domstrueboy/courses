#include<cs50.h>
#include <stdio.h>

int main(void)
{
    printf("Give me an integer: ");
    int x = GetInt();
    
    printf("Give me another integer: ");
    int y = GetInt();
    
    printf("The sum of %i and %i is %i\n", x, y, x+y);
    
}