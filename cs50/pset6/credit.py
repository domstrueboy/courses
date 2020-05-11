def GetCardNum():
    
    while True:

        number = input("Please input card number: ")
        
        if len(number) > 0:
            break
        
    return number


num = GetCardNum()

buf = ""
count = 0

i = len(num) - 2
while i >= 0:
    buf += str(int(num[i], 10) * 2)
    i-=2

for i in range(len(buf)):
    count += int(buf[i], 10)

i = len(num) - 1
while i >= 0:
    count += int(num[i], 10)
    i-=2
    
if str(count)[len(str(count))-1] == "0":
    print(count)
else:
    print("INVALID NUMBER")