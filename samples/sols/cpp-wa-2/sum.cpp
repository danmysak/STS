#include <stdio.h>

int main()
{
    freopen("sum.in", "r", stdin);
    freopen("sum.out", "w", stdout);

    int a, b;
    scanf("%d%d", &a, &b);
    printf("%d %d\n", (a + b) / 10, (a + b) % 10);
}
