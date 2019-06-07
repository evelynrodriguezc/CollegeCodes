
#include <stdio.h>
#include<stdlib.h>
#include <errno.h>
#include<math.h>
#include <signal.h>
#include<conio.h>

int Usuario(int Code, int Pass)
{
  printf("\nIngrese codigo: ");
    scanf("%i", &Code);
  
    printf("\nIngrese contrase%ca: ", 164); 
  scanf("%i", &Pass);
  
   

  if(Code!=1024 || Pass!=4567)
  {
    printf("\nCodigo y/o contrase%ca incorrecto(s)", 164);
    printf("\nIntentelo de nuevo");
    Usuario(Code, Pass);
  }
  else 
  exit(-1);
}


int main(void)
{
  int Code=0, Pass=0;
 
  Usuario(Code, Pass);

  return 0;
}