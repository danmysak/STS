#include <stdio.h>

int main()
{
    freopen("multiline.in", "r", stdin);
    freopen("multiline.out", "w", stdout);

    int n;
    scanf("%d", &n);
	for (int i = 0; i < n; i++)
	{
		for (int j = 0; j <= i; j++)
		{
			printf(j > 0 ? " %d" : "%d", j + 1);
		}
		printf("\n");
	}
}
