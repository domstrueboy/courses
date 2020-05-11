import cs50

while True:
    print("Please type the number from 0 to 23! ")
    height = cs50.get_int()
    
    if 0 <= height <= 23:
        break
    
for i in range(height):
    print(" " * (height-i), end="")
    print("#" * (i*2-1))
    