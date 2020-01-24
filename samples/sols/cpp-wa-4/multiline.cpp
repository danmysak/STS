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
			if (i < n - 1 || j < i)
			{
				printf(" %d ", j + 1);
			}
			else
			{
				printf(" %d ", j);
			}							
		}
		printf("\n");
	}
}
