""" Python """
fin = open('sum.in', 'r')
fout = open('sum.out', 'w')
result = sum(map(int, fin.readline().strip().split()))
fout.write(str(result)+'\n')
