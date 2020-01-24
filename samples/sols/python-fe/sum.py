fin = open('sum.in', 'r')
fout = open('summ.out', 'w')
result = sum(map(int, fin.readline().strip().split()))
fout.write(str(result)+'\n')
