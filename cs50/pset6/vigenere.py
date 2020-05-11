import sys

if len(sys.argv) == 2:
    if sys.argv[1].isalpha():
        k = sys.argv[1]
        kk = ""

        s = input()
        ss = ""
       
        for symbol in k:
            
            if symbol.islower():
                kk += chr(ord(symbol) - 97)
            
            elif symbol.isupper():
                kk += chr(ord(symbol) - 65)

        j = 0
        for symbol in s:
            
            if symbol.islower():
                ascii = ord(symbol) + ord(kk[j%len(k)])
                
                if ascii > 122:
                    ascii = ascii - 122 + 96
                
                buf = chr(ascii)
                j += 1
            
            elif symbol.isupper():
                ascii = ord(symbol) + ord(kk[j%len(k)])
                
                if ascii > 90:
                    ascii = ascii - 90 + 64
                
                buf = chr(ascii)
                j += 1
            
            else:
                buf = symbol
            
            ss += buf
        
        print(ss)

    else:
        print("Please enter alphabetic symbols word as a key next time!")
else:
     print("Please enter one argument next time!")