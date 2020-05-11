#include <stdio.h>
#include <cs50.h>
#include <math.h>

float GetPositiveFloatWithMessage(string);
int DollarsToCents(float);

int main(void){
    
    printf("O hai! ");
    
    int cents = DollarsToCents( GetPositiveFloatWithMessage("How much change is owed?\n") );
    
    int coins = 0;

    while(cents >= 25){
        cents-=25; coins++;
    }

    while(cents >= 10){
        cents-=10; coins++;
    }

    while(cents >= 5){
        cents-=5; coins++;
    }

    while(cents >= 1){
        cents--; coins++;
    }

    printf("%i\n", coins);
    
    return 0;
}



float GetPositiveFloatWithMessage(string message){
    
    float number;
    bool flag;
    
    do{

        printf("%s", message);
        number = GetFloat();
        
        flag = (number >= 0);
        
        if(!flag){
            printf("Please type the positive number or zero!\n");
        }
        
    } while(!flag);
    
    return number;
    
}

int DollarsToCents(float dollars){
    return (int) roundf(dollars * 100);
}