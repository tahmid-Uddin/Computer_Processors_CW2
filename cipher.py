import random

def xor(a, b):
    return int((a and not b) or (not a and b))

def f(a, b):
    return int(xor(a, not b))

def rotate(a):
    temp = a.pop(0)
    a.append(temp)
    return a

inpt = [random.randint(0,1) for x in range(0,16)]
key = [random.randint(0,1) for x in range(0,8)]

print(f"input: {inpt}\nkey:   {key}\n")

for j in range(0,4):
    left = inpt[0:8]
    right = inpt[8:]

    for i in range(0, 8):
        right[i] = f(right[i], key[i])

    for i in range(0, 8):
        left[i] = xor(left[i], right[i])

    rotate(key)

    print(f"iter{j}: {left+right}")
    print(f"key{j}:  {key}\n")

    temp = left
    left = right
    right = temp

output = left + right
print(f"output: {output}")