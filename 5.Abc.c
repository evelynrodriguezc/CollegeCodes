
#include <stdio.h>
#include<stdlib.h>
#include <errno.h>
#include<math.h>
#include <signal.h>
#include<conio.h>

int ABC(void)
{
	char Letras = 'Z';
	
	do
	{
		printf("%c, ", Letras);
		Letras--;
	}
	
	while(Letras >= 'A');

	return 0;
}

int main(void)
{
	ABC();
	
	return 0;
}