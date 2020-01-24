#include <stdio.h>

int main()
{
    freopen("sum.in", "r", stdin);
    freopen("summ.out", "w", stdout);

    int a, b;
    scanf("%d%d", &a, &b);
    printf("%d\n", a + b);
}
