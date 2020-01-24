#include <stdio.h>

int c[10000][10000];

int main()
{
    freopen("sum.in", "r", stdin);
    freopen("sum.out", "w", stdout);

    int a, b;
    scanf("%d%d", &a, &b);

    for (int i = 0; i < 10000; i++)
        for (int j = 0; j < 10000; j++)
            c[i][j] = i % 2 ? a : b;

    printf("%d\n", c[9998][9998] + c[9999][9999]);
}
