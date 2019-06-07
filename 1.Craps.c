#include <stdio.h>
#include<stdlib.h>
#include <errno.h>
#include<math.h>
#include <signal.h>
#include<conio.h>

int Dados(void)
{
    int Dado1, Dado2, SumaD;
 
    Dado1= 1+(rand()%6);
    Dado2= 1+(rand()%6);
    SumaD= Dado1+Dado2;
     
    printf("Lanzamiento de los dados %d+%d=%d\n",Dado1,Dado2, SumaD);
    
    return SumaD;
}

int main(void)
{
    int Tirada, Suma, Puntos, Opcion=1, i=0;
       
    printf("\nDADOS CRAPS\n\n");

    srand(time(NULL));
    Suma = Dados();
 
    switch(Suma)
    {
        case 7: 
        case 11:
            Tirada =1;
        break;
 
        case 2: 
        case 3: 
        case 12: 
            Tirada = 2;
        break;
 
        default: 
        Tirada= 0;
        Puntos= Suma;
        printf("\n--Punto o Tirada--: %d\n\n", Puntos);
        break;
    }
 
        if(Tirada!= 2)
        {
            while(Tirada==0)
            {
                Suma = Dados();

                if(Suma == Puntos)
                {
                    Tirada = 1;
                }
                else
                {
                    if(Suma == 7)
                    {
                        Tirada = 1;
                    }
                }

            }
        }
 
            if(Tirada == 1)
                printf("\n----GANA (: ----\n");          

            else
            printf("\n----PIERDE ): ----\n");

     return 0;
                    
}
 
 
