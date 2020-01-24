fin = open('sum.in', 'r')
fout = open('sum.out', 'w')
m = 20000000
arr = []
i = 0
while i<m:
    arr.append(i)
    i = i+1
result = sum(map(int, fin.readline().strip().split()))
fout.write(str(result)+'\n')
