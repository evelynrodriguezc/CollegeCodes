#include <stdio.h>
#include<stdlib.h>
#include <errno.h>
#include<math.h>
#include <signal.h>
#include<conio.h>

/*
Si el numero dado= 1, terminar proceso

Si es diferente a 1 => preguntar si es par?

Si es par =>  (numero/2)

Si es impar => (numero/*3)+1
*/

int main(void)
{
	int Num;

	printf("Ingrese un numero entero= ");
	scanf("%i", &Num);

	while(Num!=1)
	{
		if(Num%2 == 0)
		{
			Num=Num/2;
			printf("%i ", Num);
		}
		else
		{
			Num=(Num*3)+1;
			printf("%i ", Num);
		} 
	}
	return 0;
}