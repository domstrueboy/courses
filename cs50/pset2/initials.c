#include <stdio.h>
#include <cs50.h>
#include <string.h>
#include <ctype.h>

int Capitalize(int);

int main(void){
    
    string s = GetString();
    int output[100];
    int counter = 0;
    
    for(int i = strlen(s) - 2 ; i >= 0 ; i--)
    {
        if( (int) s[i] == 32 )
        {
            
            output[counter] = Capitalize(s[i+1]);
            counter++;
        }
            
        if(i == 0)
        {
            
            output[counter] = Capitalize(s[0]);
            counter++;
        }
    }
    
    for(int i = counter-1; i >= 0; i--)
    {
        printf( "%c", output[i] );
    }

    printf( "\n");
}

int Capitalize(int let)
{
    if( islower(let) )
    {
        return let-32;
    }
    
    else if( isupper(let) )
    {
        return let;
    }
    
    else
    {
        return 1;
    }
}