#include <stdio.h>
#include <cs50.h>

int GetPositiveIntWithMessage(string);

int main(void){
    
    int height = GetPositiveIntWithMessage("height: ");
    
    for(int i = 0; i < height; i++){
        
        for(int j = height-i-1; j > 0; j--){
            printf(" ");
        }
        
        for(int j = 0; j < i+2; j++){
            printf("#");
        }
        
        printf("\n");
    }
    
    return 0;
}



int GetPositiveIntWithMessage(string message){
    
    int number;
    bool flag;
    
    do{

        printf("%s", message);
        number = GetInt();
        
        flag = (number >= 0) && (number <= 23);
        
        if(!flag){
            printf("Please type the number from 0 to 23!\n");
        }
        
    } while(!flag);
    
    return number;
    
}