#include <stdio.h>
#include <cs50.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>

int main(int argc, string argv[]){
    
    if( argc != 2)
    {
        printf("Please enter one argument next time!\n");
        return 1;
    }
    
    int k = atoi(argv[1]);
    
    string s = GetString();
    
    int p[strlen(s)];
    
    for (int i = 0, len = strlen(s); i < len; i++)
    {
        if( islower(s[i]) )
        {
            
            p[i] = s[i] + k%26;
            
            if(p[i] > 122)
            {
                p[i] = p[i] - 122 + 96;
            }
            
        }
        
        else if( isupper(s[i]) )
        {
            p[i] = s[i] + k%26;
            
            if(p[i] > 90)
            {
                p[i] = p[i] - 90 + 64;
            }
            
        }
        
        else
        {
            p[i] = s[i];
        }
        
        printf("%c", p[i]);
    }
    
    printf("\n");
    
    return 0;
}