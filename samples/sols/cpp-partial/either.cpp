#include <stdio.h>

int main()
{
    freopen("either.in", "r", stdin);
    freopen("either.out", "w", stdout);

    int a, b;
    scanf("%d%d", &a, &b);
    printf("%d\n", b);
}
