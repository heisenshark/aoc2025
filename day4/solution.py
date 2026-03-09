lines = None

checkpositions = [
        [-1,1],
        [0,1],
        [1,1],
        [-1,0],
        [1,0],
        [-1,-1],
        [0,-1],
        [1,-1],
        ]
with open("data.txt",'r') as file:
    lines = file.readlines()
# lines = '''..@@.@@@@.
# @@@.@.@.@@
# @@@@@.@.@@
# @.@@@@..@.
# @@.@@@@.@@
# .@@@@@@@.@
# .@.@.@.@@@
# @.@@@.@@@@
# .@@@@@@@@.
# @.@.@@@.@.'''.split("\n")
print(lines)

dimensions = [len(lines[0])-1,len(lines)]

def checkCase(x,y,lines):
    sum = 0
    for i in checkpositions:
        poschecked = [x+i[0],y+i[1]]
        if not 0<=poschecked[0] < dimensions[0] or not 0<=poschecked[1]<dimensions[1]:
            continue
        if lines[poschecked[1]][poschecked[0]] == '@':
            sum+=1
        print([poschecked,sum,lines[poschecked[1]][poschecked[0]]])
    print(sum)
    if sum<4:
        return True
    return False

s = 0
for i in range(0,dimensions[1]):
    for j in range(0,dimensions[0]):
        if(lines[i][j] == '.'):
            continue
        res = checkCase(j,i,lines)
        print([res,[i,j]])
        s+=1*(res==1)
print(s)
