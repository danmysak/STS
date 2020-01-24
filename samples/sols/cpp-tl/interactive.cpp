#include <stdio.h>

int main()
{
    freopen("interactive.in", "r", stdin);
    freopen("interactive.out", "w", stdout);
	
	while(true);

    int a, b;
    scanf("%d%d", &a, &b);
    printf("%d\n", a + b);
}
