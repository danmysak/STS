#include <stdio.h>

int main()
{
    freopen("sum.in", "r", stdin);
    freopen("sum.out", "w", stdout);

    int a, b = 3/0;
    scanf("%d%d", &a, &b);
    printf("%d\n", a + b);
}
