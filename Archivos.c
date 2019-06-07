/* Escriba un programa que utlice STRUCT, funciones y archivos. Manejar informacion de la UTP
(codigo, nombre, direccion, telefono, (semestre, periodo, promediointegral, #materiascursadas), estado)
creando una estructura anidada y que permita registrar por estudiante hasta 12 periodos academicos.
El programa debe permitir a traves de un menu:
  1.Ingresar un estudiante al sistema. max 100. ingresar datos exepto estado
  2.Definir estado de los Estudiante :
      si promediointegral menor a 2,5 FUERA
      si promediointegral entre 2,5 y 2,9 PRUEBA
      si promediointegral mayor a 3,0 NORMAL
  3.Mostrar toda la informacion de los Estudiante en estado FUERA
  4.Salir
*/


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <time.h>
#include <ctype.h>
#define Archivo "Datos.dat"

struct t_HistorialAcademico
{
  int Semestre;
  int Periodo;
  float PromedioIntegral;
  int MateriasCursadas;
};

struct t_Datos
{
  char Codigo[20];
  char Nombre[50];
  char Direccion[20];
  char Telefono[15];
  struct t_HistorialAcademico HistorialActual[12];
  int Ult_Semestre;
  int Estado;
};

FILE *PunterodeArchivo;

void MensajeError()
{
  printf("\n*Error de lectura ** Verifique que el archivo exista*\n");
}

void SubiraArchivo(struct t_Datos Estudiante)
{
  PunterodeArchivo = fopen(Archivo, "a");  //Archivo esta definido como macro de Datos.dat, Abre archivo en modo añadir.
  if(PunterodeArchivo == NULL) //verifica
    MensajeError();
  else
    fwrite(&Estudiante, sizeof(Estudiante), 1, PunterodeArchivo); //registra (1) archivo en el archivo
  fclose(PunterodeArchivo); //cierra archivo

}

struct t_Datos Limpiar(struct t_Datos Estudiante)
{
  int j;
  strcpy(Estudiante.Codigo,"");
  strcpy(Estudiante.Nombre,"");
  strcpy(Estudiante.Direccion,"");
  strcpy(Estudiante.Telefono,"");
  for(j = 0; j<12; j++){
    Estudiante.HistorialActual[j].Semestre=0;
    Estudiante.HistorialActual[j].Periodo=0;
    Estudiante.HistorialActual[j].PromedioIntegral=0;
    Estudiante.HistorialActual[j].MateriasCursadas=0;
  }
  Estudiante.Ult_Semestre = 0;
  Estudiante.Estado = 0;
  return Estudiante;
}

void MostrarDatos(struct t_Datos Estudiante)
{
  int j;
    printf("\nCodigo: %s",Estudiante.Codigo);
    printf("\nNombre: %s",Estudiante.Nombre);
    printf("\nDireccion: %s",Estudiante.Direccion);
    printf("\nTelefono: %s",Estudiante.Telefono);
    for(j=0; j<Estudiante.Ult_Semestre; j++)
    {
      printf("\n\tSemestre: %i",Estudiante.HistorialActual[j].Semestre);
      printf("\n\tPeriodo: %i",Estudiante.HistorialActual[j].Periodo);
      printf("\n\tPromedio: %.2f",Estudiante.HistorialActual[j].PromedioIntegral);
      printf("\n\tMaterias: %i\n",Estudiante.HistorialActual[j].MateriasCursadas);
    }
}


void Registrar(struct t_Datos Estudiante)
{
  Estudiante = Limpiar(Estudiante);
  int  Semestre_Actual,i;
    Semestre_Actual = 0;
    Estudiante.Estado=3;
    printf("\nIngrese el codigo: ");
    fflush(stdin);
    gets(Estudiante.Codigo);
    printf("\nIngrese los nombre: ");
    fflush(stdin);
    gets(Estudiante.Nombre);
    printf("\nIngrese el direccion: ");
    fflush(stdin);
    gets(Estudiante.Direccion);
    printf("\nIngrese el telefono: ");
    fflush(stdin);
    gets(Estudiante.Telefono);
    do
    {
      printf("\nIngrese semestre actual: ");
      scanf("%i", &Semestre_Actual);
    }while(Semestre_Actual > 12 || Semestre_Actual < 1);
    
    Estudiante.Ult_Semestre = Semestre_Actual;

    for (i = 0; i < Semestre_Actual; i++)
    {
      Estudiante.HistorialActual[i].Semestre = i+1;
      printf("\nIngrese periodo del semestre %d: ",i+1);
      scanf("%i", &Estudiante.HistorialActual[i].Periodo);
      printf("\nIngrese promedio integral del semestre %d: ",i+1);
      scanf("%f", &Estudiante.HistorialActual[i].PromedioIntegral);
      printf("\nIngrese el numero de materias cursadas en el semestre %d: ",i+1);
      scanf("%i", &Estudiante.HistorialActual[i].MateriasCursadas);
    }

    if(Estudiante.HistorialActual[Semestre_Actual-1].PromedioIntegral < 2.5)
    {
        Estudiante.Estado = 1;
    }
    else if(Estudiante.HistorialActual[Semestre_Actual-1].PromedioIntegral >= 2.5 && Estudiante.HistorialActual[Semestre_Actual-1].PromedioIntegral <= 2.9)
    {
        Estudiante.Estado = 2;
    }
    else
    {
        Estudiante.Estado = 3;
    }
    SubiraArchivo(Estudiante);
}




void MostrarFuera(struct t_Datos Estudiante)
{
  int j;
  if(Estudiante.Estado==1)
  {
    printf("\nCodigo: %s",Estudiante.Codigo);
    printf("\nNombre: %s",Estudiante.Nombre);
    printf("\nDireccion: %s",Estudiante.Direccion);
    printf("\nTelefono: %s",Estudiante.Telefono);
    for(j=0; j<Estudiante.Ult_Semestre; j++)
    {
      if(Estudiante.HistorialActual[j].Semestre > 0)
      {
          printf("\n\tSemestre: %i",Estudiante.HistorialActual[j].Semestre);
          printf("\n\tPeriodo: %i",Estudiante.HistorialActual[j].Periodo);
          printf("\n\tPromedio: %.2f",Estudiante.HistorialActual[j].PromedioIntegral);
          printf("\n\tMaterias: %i\n",Estudiante.HistorialActual[j].MateriasCursadas);
      }
    }
    switch(Estudiante.Estado)
    {
      case 1: printf("\nEstado: FUERA\n"); break;
      case 2: printf("\nEstado: PRUEBA\n"); break;
      case 3: printf("\nEstado: NORMAL\n"); break;
    }
  }
}


void MostrarLista()
{
  struct t_Datos Estudiante;
  int Longitud;
  Longitud = sizeof (struct t_Datos);
  PunterodeArchivo = fopen(Archivo, "r");
  if(PunterodeArchivo == NULL)
    MensajeError();
  else
  {
    do
    {
      if(fread (&Estudiante, sizeof(struct t_Datos), 1, PunterodeArchivo) != Longitud)
      {
        MostrarFuera(Estudiante);
        system("pause");
      }
    }
    while(!feof(PunterodeArchivo));

    fclose(PunterodeArchivo);
    printf("\nFin de la lista\n");
  }
}

void MostrarListaFuera()
{
  struct t_Datos Estudiante;
  int Longitud;
  Longitud = sizeof (struct t_Datos);
  PunterodeArchivo = fopen(Archivo, "r");
  if(PunterodeArchivo == NULL)
    MensajeError();
  else
  {
    do
    {
      if(fread (&Estudiante, sizeof(struct t_Datos), 1, PunterodeArchivo) != Longitud)
      {
        MostrarFuera(Estudiante);
        //system("pause");
      }
    }
    while(!feof(PunterodeArchivo));

    fclose(PunterodeArchivo);
    printf("\nFin de la lista\n");
  }
}

void UltimoEstadoIngresado()
{
  struct t_Datos Estudiante;
  int Longitud;
  Longitud = sizeof (struct t_Datos);
  PunterodeArchivo = fopen(Archivo, "r");
  if(PunterodeArchivo == NULL)
    MensajeError();
  else
  {
    do
    {
      fread (&Estudiante, sizeof(struct t_Datos), 1, PunterodeArchivo);
    }
    while(!feof(PunterodeArchivo));
    switch(Estudiante.Estado)
    {
      case 1: printf("FUERA\n"); break;
      case 2: printf("PRUEBA\n");  break;
      case 3: printf("NORMAL\n");  break;
    }
    fclose(PunterodeArchivo);
  }
}


void Menu()
{

  printf("\nMENU\n");
  printf("1. Ingresar estudiante: \n");
  printf("2. Definir estado de estudiante: \n");
  printf("3. Estudiantes en estado FUERA\n");
  printf("4. Salir");
  printf("\nDigite una opcion: ");

}

int main()
{
  struct t_Datos Estudiante;
  int Opcion=0;
  do
  {
    system("cls");
    Menu();
    scanf("%d", &Opcion);
    Estudiante = Limpiar(Estudiante);
    switch(Opcion)
    {

      case 1: Registrar(Estudiante); break;
      case 2: UltimoEstadoIngresado(); break;
      case 3: MostrarListaFuera(); break;
      case 4: printf("\nAdios");
    }
    system("pause");
  } while(Opcion!=4);
}














