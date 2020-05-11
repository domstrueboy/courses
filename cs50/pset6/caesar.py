import cs50
import sys

if len(sys.argv) == 2:
    k =  int(sys.argv[1])
    
    s = input()
    ss = ""
    
    for symbol in s:
        
        if symbol.islower():
            ascii = ord(symbol) + k%26
            
            if ascii > 122:
                ascii = ascii - 122 + 96
                
            buf = chr(ascii)
        
        elif symbol.isupper():
            ascii = ord(symbol) + k%26
            
            if ascii > 90:
                ascii = ascii - 90 + 64
                
            buf = chr(ascii)
            
        else:
            buf = symbol
                
        ss += buf

    print(ss)
    
else:
    print("Please enter one argument next time!")