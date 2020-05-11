#include <stdio.h>
#include <cs50.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>

int main(int argc, string argv[]){
    
    if( argc != 2 )
    {
        printf("Please enter one argument next time!\n");
        return 1;
    }
    
    int lenk = strlen(argv[1]);
    
    for(int i = 0;  i < lenk; i++ )
    {
        if(!isalpha(argv[1][i]))
        {
            printf("Please enter alphabetic symbols word as a key next time!\n");
            return 1;
        }
    }
    
    string s = GetString();

    int len = strlen(s);
    int p[len];
    string k = argv[1];
    
    for(int i = 0; i < lenk; i++ )
    {
        if( islower(k[i]) )
        {
            k[i] = k[i] - 97;
        }
        
        else if( isupper(k[i]) )
        {
            k[i] = k[i] - 65;
        }
    }
    
    for (int i = 0, j = 0; i < len; i++)
    {
        if( islower(s[i]) )
        {
            p[i] = s[i] + k[j%lenk];
            
            if(p[i] > 122)
            {
                p[i] = p[i] - 122 + 96;
            }
            
            j++;
        }
        
        else if( isupper(s[i]) )
        {
            p[i] = s[i] + k[j%lenk];
            
            if(p[i] > 90)
            {
                p[i] = p[i] - 90 + 64;
            }
            
            j++;
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