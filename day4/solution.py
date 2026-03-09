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

lines_rep = []
for i in lines:
    arr = []
    for j in i:
        if j=='\n':
           continue
        arr.append(j=='@')
    lines_rep.append(arr)

dimensions = [len(lines_rep[0]),len(lines_rep)]

def runRemoval(lines):
    def checkCase(x,y,lines):
        sum = 0
        for i in checkpositions:
            poschecked = [x+i[0],y+i[1]]
            if not 0<=poschecked[0] < dimensions[0] or not 0<=poschecked[1]<dimensions[1]:
                continue
            if lines[poschecked[1]][poschecked[0]] == True:
                sum+=1
        if sum<4:
            return True
        return False

    s = 0
    removal_array = []
    for i in range(0,dimensions[1]):
        for j in range(0,dimensions[0]):
            if(lines[i][j] == False):
                continue
            res = checkCase(j,i,lines)
            if res:
                removal_array.append([j,i])
            s+=1*(res==1)

            # print([res,[i,j]])
    for i in removal_array:
        lines[i[1]][i[0]] = False
    return s 

count_all = 0
while True:
    count = runRemoval(lines_rep)
    if(count == 0):
        break
    if count_all == 0:
        print(count)
    count_all += count

print(count_all)
