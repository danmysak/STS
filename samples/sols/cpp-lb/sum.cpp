#include <stdio.h>

int main()
{
    freopen("sum.in", "r", stdin);
    freopen("sum.out", "w", stdout);

    int a, b;
    scanf("%d%d", &a, &b);
    printf("%d", a + b);
}
