#define M 1000000000
#include <stdio.h>
#include <iostream>

int main()
{
    int a, b, s;
	
	for (int i = 0; i < M; i++)
		s += i;
	
    scanf("%d%d", &a, &b);
	
	std::cerr << "0" << std::flush;
	
	for (int i = 0; i < M; i++)
		s += i;
	
	std::cerr << "1" << std::flush;
	
    printf("%d\n", a + b);
	
	for (int i = 0; i < M; i++)
		s += i;
	
	if (s == 2018)
	{
		printf("2018!");
	}
}
