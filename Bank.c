#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <math.h>
#include <time.h>
#define  archivo "Bank.txt"
FILE *F;

struct t_Producto
{
	int Estado;
	int Codigo;
	char Nombre[25];
	int Tipo;
	float Valor;
};

struct Movimiento
{
	time_t Fecha;
	int Codigo;
	int Tipo;
	float Valor;
};

struct Cliente
{
	char ID[25];
	char Estado;
	char Apellidos[25];
	char Nombre[25];
	char Date[11];
	char Telefono[11];
	char Empresa[25];
	float Salario;
	struct t_Producto Item[5];
	struct Movimiento Transaccion[10];
};



int VerificarID(char ID[25])  //Verifica si el ID ya existe en el archivo
{
	struct Cliente Usuario; 
	int i=0;
	F=fopen(archivo,"rb"); //Se abre el archivo
	while(!feof(F)) //se hace hasta que se llegue al final del archivo
	{
		fread(&Usuario,sizeof(struct Cliente),1,F); //lee secuencialmente cada elemento del archivo y se alamcena en la estructura
		if(strcmp(ID,Usuario.ID)==0) //Verifica si el ID ingresado ya esta en el archivo
		{
			i++; //se le suma uno a i
			break;
		}
	}
	fclose(F);
	return i; //retorna i para acciones futuras
}

void Registrar()
{
	struct Cliente Usuario;
	int Verif, i;
	puts("Enter your personal data Denied\nID:");
	fflush(stdin);
	scanf("%s",Usuario.ID);
	
	Verif=VerificarID(Usuario.ID); //verifica si el ID ya existe
	if(Verif!=0) //si la funcion anterior retorna algo diferente a 0
	{
		puts("You are ALREADY registered in the system.");
		getch();
		system("cls");
	}
	else //si no, se activa el registro del usuario
	{	
		Usuario.Estado='A'; //usuario activo
		puts("Name:");
		fflush(stdin);
		gets(Usuario.Nombre);
		puts("Last name:");
		fflush(stdin);
		gets(Usuario.Apellidos);
		puts("Date of birth:\nDD/MM/YYYY");
		fflush(stdin);
		gets(Usuario.Date);
		puts("Phone number:");
		fflush(stdin);
		gets(Usuario.Telefono);
		puts("Company:");
		fflush(stdin);
		gets(Usuario.Empresa);
		puts("Salary:");
		fflush(stdin);
		scanf("%f",&Usuario.Salario);
		for(i=0;i<5;i++)
		{ //se generar 5 espacios para 5 items, con valor inicial 0;
			Usuario.Item[i].Estado=0;
			Usuario.Item[i].Codigo=0;
			Usuario.Item[i].Tipo=i;
			Usuario.Item[i].Nombre[0]='\0';
			Usuario.Item[i].Valor=0;
		}

		for(i=0;i<10;i++)
		{  //se generan 10 espacios posibles para transacciones, con valor inicial cero
			Usuario.Transaccion[i].Codigo=0;
			Usuario.Transaccion[i].Tipo=0;
			Usuario.Transaccion[i].Valor=0;
			Usuario.Transaccion[i].Fecha=0;
		}
		F=fopen(archivo,"ab"); //se abre el archivo
		fwrite(&Usuario,sizeof(Usuario),1,F); //se guardan los datos registrados en la estructura usuario
		fclose(F);
	}
	puts("\nPlease press any key to continue");
	getch();
	system("cls");
}

struct Cliente Buscar(struct Cliente aux, char ID[25]) //busca una estructura especifica en el archivo
{
	int Longitud=sizeof(struct Cliente);  //se define la longitud de la estructura
	if(!feof(F)) //verifica que el archivo no haya llegado al final
	{
		do{
			if(fread(&aux,sizeof(struct Cliente),1,F)!=Longitud)  //se lee el archivo y se almacenan los datos en el auxiliar
			{
				if(feof(F)) //verifica que este en el final del archivo
				{
					break;
				}
			}
		}while(strcmp(ID,aux.ID)!=0); //se hace si se encuentra el ID ingresado
	}
	return aux; //retorna la estructura del ID ingresado
}


void Actualizar()
{
	int i; //indice
	struct Cliente aux; //estructura donde se almacenaran los datos encontrados
	char j, ID[11]; //j=Opcion escogida en el menu
	float Cuenta=0; //Verifica que la cuenta exista
	puts("\tWelcome to UPDATE DATA menu\nEnter your DI:");
	fflush(stdin);
	gets(ID); //captura el ID
	if(VerificarID(ID)==0)  //verifica si el ID ya no se encuentra en el archivo
	{
		puts("This ID is NOT YET registered"); //si no esta
	}
	else  //si si esta
	{
		F=fopen(archivo,"rb+");
		aux=Buscar(aux,ID);  //busca la estructura relacionada con el ID
		
		do //muestra el menu para actualizar datos
		{
			system("cls");
			puts("\tOPTIONS");
			puts("Change:");
			puts("a. Phone number");
			puts("b. Company");
			puts("c. Salary");
			puts("d. Account state");
			puts("___________________");
			puts("e. Go to main menu");
			printf("Enter any key option: ");
			fflush(stdin);
			switch(j=toupper(getche())) //se evalua la opcion 
			{
				case 'A':
					puts("\nEnter the new phone number:");
					fflush(stdin); gets(aux.Telefono);
					break;
				case 'B':
					puts("\nEnter the new company:");
					fflush(stdin); gets(aux.Empresa);
					break;
				case 'C':
					puts("\nEnter the new salary:");
					fflush(stdin);
					scanf("%f",&aux.Salario);
					break;
				case 'D': //Activar o desactivar el estado de la cuenta
					for(i=0;i<5;i++)
					{
						Cuenta+=fabs(aux.Item[i].Valor);  //suma el valor de todas las cuentas
					}
					if(Cuenta!=0) //verifica si el saldo de la cuenta esta 0 para poder cancelarla
					{
						puts("\nYour account state is not available to change"); //si hay algo$ en la cuenta, no puede cambiar el estado de esta
						system("pause");
					}
					else //si no, le pide si quiere activar o desactivar el perfil
					{
						do
						{
							puts("Enter any of this account states:\n\tA: Active\tI: Inactive ");
							fflush(stdin);
							aux.Estado=toupper(getche()); //obtiene el caracter de estado
						}while(aux.Estado!='A' && aux.Estado!='I'); //mientras el caracter ingresado no sea A o I

						if(aux.Estado=='I') //si se desactiva el perfil
						{
							for(i=0;i<5;i++)
							{
								aux.Item[i].Estado=-1; //desactiva todas las cuentas relacionadas
							}
						}
					}
					break;
				case 'E':
					puts("\nProcess ended");
					break;
				default:
					puts("\nERROR, Wrong option, please try again");
					break;
			}
		}while(j!='E');
	}
	fseek(F, (long)-sizeof(struct Cliente), SEEK_CUR); //se relocaliza el puntero en el archivo
	fwrite(&aux,sizeof(aux), 1, F); //se guardan los cambios
	fclose(F); 
	puts("\nPress any key to continue");
	getch();
	system("cls");
}

void MensajeCuenta(int i, int a) //tipos de cuenta
{
	switch(a)
	{
		case 0:
		printf("a. Savings account"); 
		break;
		case 1:
		printf("b. Ordinary account "); 
		break;
		case 2:
		printf("c. Personal credit "); 
		break;
		case 3:
		printf("d. Visa\t\t"); 
		break;
		case 4:
		printf("e. Master Card\t"); 
		break;
	}
}

int VerifTipo(int i)  //verififica el estado de la cuenta (tipo de cuenta)
{
	if(i==1) //si ya esta tomada
	{
		puts("This account type is already taken.");
		return 1;
	} 
	else 
		return 0;
}

void EstadoNulo(struct t_Producto a[5])
{
	int i; 
	puts("\tACCOUNT TYPES");
	for(i=0;i<5;i++) //5 veces porque son 5 tipos de cuenta
	{
		if(a[i].Estado<=0) //si el estado es menor o igual a 0
		{
			MensajeCuenta(i,a[i].Tipo);  //se muestra el tipo de cuenta
			//si el estado= -1  .   verdadero=desactivado,      falso=disponible
			printf(a[i].Estado==-1 ? "\tIt is deactivated\n" : "\tIt is available\n");
		}
	}
}

void CuentaActiva(struct t_Producto a[5]) //muestra cuentas activas
{
	int i;
	puts("\tACCOUNT TYPES");
	for(i=0;i<5;i++) //5 veces porque son 5 tipos de cuenta
	{
		if(a[i].Estado==1)  //si la cuenta esta activa
		{
			MensajeCuenta(i,a[i].Tipo);  //muestra el tipo de cuenta
			puts("");
		}
	}
}

void MostrarDiferente(struct t_Producto a[5])  //muestra cuentas activas e inactivas
{
	int i;
	puts("\tInactive or Active accounts: ");
	for(i=0;i<5;i++)  //5 veces porque son 5 tipos de cuentas
	{
		if(a[i].Estado!=0)
		{
			MensajeCuenta(i,a[i].Tipo);  //muestra el tipo de cuenta
			//si el estado= -1  .   verdadero=desactivado,      falso=disponible
			printf(a[i].Estado==1 ? "\tITS ACTIVE\n" : "\tITS DEACTIVATED\n");
		}
	}
}

void Producto()  //registra los productos
{
	struct Cliente aux;
	char Continuar, Opcion, ID[11];
	int i, EstadoCuenta=0, Indice, o=0; //o=bandera
	puts("\tWelcome to PRODUCTS Menu\nTo start enter your ID:");
	fflush(stdin);
	gets(ID);
	if(VerificarID(ID)==0)  //obtiene y verifica ID
	{
		puts("\nthis ID is NOT YET registered");  //si no existe el ID
	}
	else  //si existe el ID
	{
		F=fopen(archivo,"rb+");  //se abre el archivo en modo lectura y escritura binaria
		aux=Buscar(aux,ID);  //se obtiene la estructura que corresponde al ID ingresado
		do
		{
			EstadoCuenta=0;
			for(i=0;i<5;i++)  //5 veces porque son 5 tipos de cuentas
			{
				EstadoCuenta+=fabs(aux.Item[i].Estado);  //hace la suma de las cuentas
			}
			if(EstadoCuenta==5)  //si tiene 5 cuentas, se muestra en pantalla que ya paso el # de cuentas permitidas
			{
				puts("\nYou passed out the allowed accounts capacity");
			}
			else  //si tiene menos de 5 cuentas
			{
				system("cls");
				EstadoNulo(aux.Item);  //muestra las cuentas disponibles
				puts("\nPlease enter the account type that you are going to create:");
				Opcion=toupper(getche());  //toma el caracter de la opcion escogida
				srand(time(NULL)); //funcion time para obtener fecha y hora
				switch(Opcion)
				{
					case 'A':
						Indice=0;
						strcpy(aux.Item[Indice].Nombre,"My savings");
						printf("\nSaving account");
						break;
					case 'B':
						Indice=1;
						strcpy(aux.Item[Indice].Nombre,"Ordinary account");
						printf("\nOrdinary account");
						break;
					case 'C':
						Indice=2;
						strcpy(aux.Item[Indice].Nombre,"My credit");
						printf("Enter the total amount of your credit request: ");
						scanf("%f",&aux.Item[Indice].Valor);
						aux.Item[Indice].Valor*=-1;//inhabilita la cuenta
						printf("\nPersonal credit");
						break;
					case 'D':
						Indice=3;
						strcpy(aux.Item[Indice].Nombre,"My visa");
						printf("\nVisa");
						break;
					case 'E':
						Indice=4;
						strcpy(aux.Item[Indice].Nombre,"My MasterCard");
						printf("\nMaster");
						break;
					default: puts("ERROR, Wrong option, please type any key to continue ");
					o=1;//si o =1 termina porque el usuario se equiovoco
					getch();
					break;
				}
				if(aux.Item[Indice].Valor>aux.Salario*-0.2) //no se puede endeudar mas del 20%
				{
					if(o==0)  //si o = 0, o sea no se equivoco, hace:
					{
						if(VerifTipo(aux.Item[Indice].Estado)==0)
						{
							aux.Estado='A';  //activa el perfil
							if(aux.Item[Indice].Estado==-1)  //si el estado de la cuenta es -1
							{
								printf("Successfully activated\n");
								aux.Item[Indice].Estado=1;  //cambia estado a 1
							}
							else //si no
							{
								aux.Item[Indice].Estado=1;  //cuenta en estado activo
								aux.Item[Indice].Codigo=1+rand()%1000;  //codigo aleatorio para la estructura
								printf("Successfully created\n"); 
							}
						}
					}
				}
				else
				{
					aux.Item[Indice].Valor=0;
					puts(" Denied\nThis account value exceeds the limit value based on the 20percent of your salary");
				}
				puts("\nWant to add another account?\nY.YES N.NO");
				fflush(stdin);
				Continuar=toupper(getche());
			}
		}while(Continuar!='N' && EstadoCuenta!=5);
		fseek(F, (long)-sizeof(struct Cliente), SEEK_CUR);
		fwrite(&aux,sizeof(aux), 1, F); //actualiza la estrcutura
		fclose(F);
	}
	puts("\nPlease press any key to continue");
	getch();
	system("cls");
}

void CestProd()
{
	struct Cliente aux; 
	char Continuar, Opcion, ID[11];
	int i, EstadoCuenta=0, Estado, Indice;
	puts("\tWelcome to PRODUCT'S STATE Menuo\nTo start enter your ID:");
	fflush(stdin);
	gets(ID);
	if(VerificarID(ID)==0)
	{
		puts("this ID is not yet registered");
	}
	else
	{
		F=fopen(archivo,"rb+");
		aux=Buscar(aux,ID);  //busca la estructura del ID ingresado
		do
		{
			EstadoCuenta=0;

			for(i=0;i<5;i++)  //5 veces porque son 5 tipos de cuenta
			{
				if(aux.Item[i].Estado!=0)  //si el estado es diferente a 0
				{
					EstadoCuenta++;  //suma 1
				}
			}
			if(EstadoCuenta==0)  //si las cuentas = 0
			{
				puts("\n\tADVICE!\n\nyou do not have ACTIVE ACCOUNTS.\nYour actual PROFILE is now INACTIVE.\nto reactivate your PROFILE please create another PRODUCT.");
				aux.Estado='I';  //perfil inactivo
			}
			else  //si no
			{

				//booleano true or false
				printf(Estado==0? "Now please enter the account type you want to cancel.\n":"now please enter the account type you want to deactivate temporarily.\n");
				MostrarDiferente(aux.Item);  //muestra las cuentas del usuario
				Opcion=toupper(getche());
				switch(Opcion)
				{
					case 'A':
						Indice=0;
						break;
					case 'B':
						Indice=1;
						break;
					case 'C':
						Indice=2;
						break;
					case 'D':
						Indice=3;
						break;
					case 'E':
						Indice=4;
						break;
					default:
						puts("Wrong option");
						Indice=-1;
						break;
				}
				if(Indice!=-1)
				{
					do
					{
						puts("\n\tEnter the account state you want to change it for\n\n-1.deactive account temporarily.\t\t0.cancel account.");
						scanf("%i",&Estado);
					}while(Estado!=-1 && Estado!=0);

					if(aux.Item[Indice].Valor!=0)
					{
						puts("\nDue to the total amount of this account, the account state is not able to be changed");
					}
					else
					{
						if(aux.Item[Indice].Estado==Estado)  //si el estado el cual se eligió es el mismo en el que ya se encontraba
						{
							puts("\nThis account is already in the state you choose.");
						}
						else
						{
							switch(Estado) //estado=opcion que usuario eligio
							{
							case 0: //estado 0 y se cancela la cuenta 
								aux.Item[Indice].Estado=0;  //estado de producto =0
								aux.Item[Indice].Codigo=0;  //codigo de producto =0
								break;
							case -1:  //estado -1 y desactiva la cuenta
								aux.Item[Indice].Estado=-1; //estado de producto =-1
								break;
							}
							puts("\nChange successfully done");
						}
					}
				}
				puts("\nDo you want to continue in this menu?\nY.YES\tN.NO");
				fflush(stdin);
				Continuar=toupper(getche());
			}
		}while(Continuar!='N' && EstadoCuenta!=0);
		fseek(F, (long)-sizeof(struct Cliente), SEEK_CUR);
		fwrite(&aux,sizeof(aux),1,F);  //se guardan los cambios
		fclose(F);
	}
	puts("\nPlease press any key to continue");
	getch();
	system("cls");
}

void Acomodar(struct Movimiento a[10])  //reacomoda vector 
{
	int i;
	for(i=1;i<10;i++)
	{
		a[i-1]=a[i];  //reacomoda el vector
	}
}

struct Cliente RegistrarTrans(struct Cliente a, int Indice, float Valor,int Tipo)  //registra en la estructura los datos ingresados
{
	Acomodar(a.Transaccion);  //reacomoda las transacciones anteriores
	a.Transaccion[9].Codigo=a.Item[Indice].Codigo;  //registra el codigo de la cuenta
	a.Transaccion[9].Fecha=time(NULL);  //obtiene la fecha 
	a.Transaccion[9].Tipo=Tipo;  //guarda el tipo de transacc
	a.Transaccion[9].Valor=Valor;  //guarda el valor de la transacc
	a.Item[Indice].Valor+=Valor;  //suma el valor ingresado al valor de la cuenta
	return a;  //retorna la estructura
}

void TransRegistr()
{
	struct Cliente aux; 
	char Continuar, Opcion, ID[11];
	int i, Tipo, Indice;
	float Sueldo,Valor;
	puts("\tWELCOME TO TRANSACTIONS MENU\nTo start please enter your ID:");
	gets(ID);
	if(VerificarID(ID)==0)
	{
		puts("This ID is not yet registered");
	}
	else
	{
		F=fopen(archivo,"rb+");
		aux=Buscar(aux,ID);
		Sueldo=aux.Salario*-0.2; //calcula el 20% del salario 
		printf("Su rango de transacción es de : $%f",Sueldo);  //rango posible de transaccion
		do
		{
			do
			{
				puts("\n\tPLEASE ENTER THE TRANSACTION TYPE YOU WANT TO DO\n\n-1.credit.\t\t1.debit.");
				scanf("%i",&Tipo);
			}while(Tipo!=-1 && Tipo!=1);
			
			do
			{
				puts("Now please enter the account in which you are going to do the transaction:");
				CuentaActiva(aux.Item);  //muestra cuentas activas
				//PENDIENTE: validar si el usuario tiene cuentas activas
				Opcion=toupper(getche());
				switch(Opcion)
				{
				case 'A':
					Indice=0;
					break;
				case 'B':
					Indice=1;
					break;
				case 'C':
					Indice=2;
					break;
				case 'D':
					Indice=3;
					break;
				case 'E':
					Indice=4;
					break;
				default:
					puts("Wrong option");
					Indice=-1;
					break;
				}
			}while(Indice==-1);
			puts("Now enter the total amount of the transaction");
			scanf("%f",&Valor);  //obtiene el valor de la transaccion
			Valor=fabs(Valor)*Tipo;  //si es debito o credito el valor sera positivo o negativo segun el caso
			if(aux.Item[Indice].Estado==1) 
			{
				if(aux.Item[Indice].Valor+Valor>Sueldo)  //si el valor de la transaccion es mayor al 20% del sueldo
				{
					switch(Indice)
					{
						case 0:
							if(aux.Item[Indice].Valor+Valor>-20)  //si el valor de la cuenta más el valor de la transaccion son mayores a 20 dolares 
							{
								aux=RegistrarTrans(aux,Indice,Valor,Tipo);  //se registra la transaccion
							}
							else{
								puts("This transactions exceeds the limit debt of 20 for saving accounts");
							} 
							break;
						case 1:
							if(aux.Item[Indice].Valor+Valor>-20)  //si el valor de la cuenta más el valor de la transaccion son mayores a 20 dolares 
							{
								aux=RegistrarTrans(aux,Indice,Valor,Tipo);  //se registra la transacc
							}
							else{ //si no
								puts("This transactions exceeds the limit debt of 20 for ordinary accounts");
							}
							break;
						case 2:
							if(Tipo==1)
							{
								aux=RegistrarTrans(aux,Indice,Valor,Tipo);  //se registra la transacc
								if(aux.Item[Indice].Valor>=0) //si el valor despues de la transaccion es mayor o igual a 0
								{
									puts("Your credit has been fully paid\nNow you are allowed to request another personal credit");
									aux.Item[Indice].Codigo=0;
									aux.Item[Indice].Estado=0;
									aux.Item[Indice].Nombre[0]='\0';  //se limpia el nombre de la cuenta
									aux.Item[Indice].Valor=0;
								}
							}
							else{  //si no
								puts("This transaction type is not allowed for personal credits account");
							}
							break;
						default:
							aux=RegistrarTrans(aux,Indice,Valor,Tipo);  //se registra la transaccion
							break;
					}
				}
				else{
					puts("This transaction exceeds the limit value based on the 20percent of your salary");
				}
			}
			else{
				puts("This account is NOT YET active");
			}
			puts("\nWant to continue in this menu?\nY.YES\tN.NO");
			fflush(stdin);
			Continuar=toupper(getche());  //obtiene opcion
		}while(Continuar!='N');
	}
	fseek(F, (long)-sizeof(struct Cliente), SEEK_CUR);
	fwrite(&aux,sizeof(aux), 1 ,F);  //guarda los nuevos datos
	fclose(F);
	puts("\nplease press any key to continue");
	getch();
	system("cls");
}

void MostrarTransacciones()
{
	struct Cliente aux;
	int i;
	char ID[11];
	puts("Enter your ID:");
	scanf("%s",&ID);
	if(VerificarID(ID)==0)
	{
		puts("This ID is NOT YET registered");
	}
	else{
		F=fopen(archivo,"rb");
		aux=Buscar(aux,ID);
		for(i=0;i<10;i++)
		{
			if(aux.Transaccion[i].Tipo!=0)
			{
				puts("------------------------------------------------");
				printf("Date:\t\t\t%s",asctime(localtime(&aux.Transaccion[i].Fecha)));
				printf("Account Code:\t\t%i\n",aux.Transaccion[i].Codigo);  //codigo de la cuenta rand
				printf(aux.Transaccion[i].Tipo==1? "TRANSACTION TYPE:\tDEBIT\n" : "TRANSACTION TYPE:\tCREDIT\n");  //muestra tipo de transaccion
				printf("TRANSACTION VALUE:\t%f\n",aux.Transaccion[i].Valor);  //muestra valor de la transacc
			}
		}
		puts("_________________________________________");
	}
	fclose(F);
	puts("\nPress any key to continue");
	getch();
	system("cls");
}

void MostrarPortafolio(){
	struct Cliente aux;
	int i;
	char ID[11];
	puts("Enter your ID:");
	fflush(stdin);
	gets(ID);
	if(VerificarID(ID)==0){
		puts("This ID is NOT YET registered");
	}
	else{
		F=fopen(archivo,"rb");
		aux=Buscar(aux,ID);
		system("cls");
		printf(aux.Estado=='A'? "This profile is ACTIVE\n\n" : "This profile is INACTIVE\n\t");
		printf("ID:\t\t%s\n",aux.ID);
		printf("Last name:\t%s\n",aux.Apellidos);
		printf("Name:\t\t%s\n",aux.Nombre);
		printf("Phone:\t\t%s\n",aux.Telefono);
		printf("Company:\t%s\n",aux.Empresa);
		printf("Birthdate:\t%s\n",aux.Date);
		printf("Salary:\t\t%f\n",aux.Salario);
		puts("\n\tAccount");
		for(i=0;i<5;i++)
		{
			if(aux.Item[i].Estado!=0)
			{
			puts("_______________________________________________");
			printf(aux.Item[i].Estado==1? "This account is ACTIVE\n" : "This account is INACTIVE\n");
			printf("Account name:\t%s\n",aux.Item[i].Nombre);
			printf("Code:\t\t%i\n",aux.Item[i].Codigo);
			printf("Account type:");
			switch(aux.Item[i].Tipo)
			{
				case 0:
					puts("\tSavings account");
					break;
				case 1:
					puts("\tOrdinary account");
					break;
				case 2:
					puts("\tPersonal Credit");
					break;
				case 3:
					puts("\tVisa");
					break;
				case 4:
					puts("\tMasterCard");
					break;
			}
			printf("Total Amount:\t%f\n",aux.Item[i].Valor);  //valor de la cuenta
			}
		}
		puts("_____________________________________________");
	}
	fclose(F);
	getch();
	system("cls");
}

void Opciones()
{
	puts("\t---MAIN MENU---");
	puts("  a.Sign up");
	puts("  b.Data update");
	puts("  c.Create accounts");
	puts("  d.Deactivate or cancel accounts");
	puts("  e.Transactions");
	puts("  f.Show profile");
	puts("  g.Show transactions");
	puts("  h.Exit");
	puts("\nEnter any of this options: ");
}

void main()
{
	F=fopen(archivo,"ab"); //archivo en modo añadir
	fclose(F);
	//verifica que el archivo haya sido creado
	char opcion;
	do
	{
		Opciones();
		opcion=toupper(getche());
		system("cls");
		switch(opcion)
		{
			case 'A':
				Registrar();
				break;
			case 'B':
				Actualizar();
				break;
			case 'C':
				Producto();
				break;
			case 'D':
				CestProd();
				break;
			case 'E':
				TransRegistr();
				break;
			case 'F':
				MostrarPortafolio();
				break;
			case 'G':
				MostrarTransacciones();
				break;
			case 'H':
				puts("Thanks for using our bank.\n:");
				break;
			default:
				puts("ERROR, Wrong option please enter a valid option"); 
				getch(); 
				system("cls");
				break;
		}
	}while(opcion!='H');
}


