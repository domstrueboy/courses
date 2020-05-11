import cs50

def GetPositiveFloatWithMessage(message):
    
    while True:

        print(message)
        
        number = cs50.get_float()
        
        if number >= 0:
            break
        
        print("Please type the positive number or zero!");
        
    return number


print("O hai! ")
    
cents = 100 * GetPositiveFloatWithMessage("How much change is owed?")
    
coins = 0

for i in [25, 10, 5, 1]:
    if cents >= i:
        coins += cents // i
        cents = cents % i
    

print(coins)