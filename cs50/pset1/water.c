#include <stdio.h>
#include <cs50.h>

int GetPositiveIntWithMessage(string);

int main(void){
    
    int minutes = GetPositiveIntWithMessage("minutes: ");
    
    printf("bottles: %i\n", minutes*12);
    
    return 0;
}

int GetPositiveIntWithMessage(string message){
    
    int number;
    
    do{
        printf("%s", message);
        number = GetInt();
        
        if(number <= 0){
            printf("Please type the positive number!\n");
        }
        
    } while(number <= 0);
    
    return number;
    
}