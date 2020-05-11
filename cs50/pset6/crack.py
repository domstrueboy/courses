import sys
import crypt

if len(sys.argv) == 2:
    if sys.argv[1].isalnum():
        hashed = sys.argv[1]
        
        symbols = ["", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
                    "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]

        for s1 in symbols:
            for s2 in symbols:
                for s3 in symbols:
                    for s4 in symbols:
                        password = s1 + s2 + s3 + s4
                        
                        if crypt.crypt(password, salt="50") == hashed:
                            print(password)
                            exit(0)
                            
    else:
        print("Please enter alphabetic or num symbols next time!")
        exit(1)
else:
     print("Please enter one argument next time!")
     exit(1)