:-use_module(library(clpfd)).

%Proyecto Final Programación III
%% Juan Camilo Blanco
%% Evelyn Rodríguez


%menú

menu:-
    nl,nl,write('MENU'),nl,nl,
    write('1. Eliminar un elemento de una lista.'),nl,
    write('2. Búsqueda binaria.'),nl,
    write('3. Determinar el número que mas se repite de una lista.'),nl,
    write('4. Coloreado de mapa.'),nl,
    write('5. Ajedrez 8 Reinas sin atacarse.'),nl,
    write('6. Realizar 5 Tareas.'),nl,
    write('7. Caníbales y Misioneros.'),nl,
    write('8. Salir.'),nl,
    write('Elija una opcion.'),nl,
    read(P),opciones(P).


%%%%%%  opciones

opciones(X):-
    X = 1, write('Digite la lista: '),read(P),
    write('Digite la posicion para eliminar: '),read(E),
    eliminar(E,P,T), write(T), menu.

opciones(X):-
    X = 2, write('Digite la lista: '),read(P),
    busqueda(P),nl,nl, menu.

opciones(X):-
    X = 3, write('Digite la lista: '),read(P),
    repetidos(P), menu.

opciones(X):-
    X = 4,write('Se escogió el mapa de sudamerica:'),nl,nl,nl,
    colorear(A,B,C,D,E,F,G,H,I,J,K,L,M),
    write('Colombia esde color: '), write(A),nl,nl, write('Peru es de color: '), write(B),nl,nl,
    write('Ecuador es de color: '), write(C),nl,nl, write('Chile es de color: '), write(D),nl,nl,
    write('Argentina es de color: '), write(E),nl,nl, write('Bolivia es de color: '), write(F),nl,nl,
    write('Paraguay es de color: '), write(G),nl,nl, write('Uruguay es de color: '), write(H),nl,nl,
    write('Brazil es de color: '), write(I),nl,nl, write('Venezuela es de color: '), write(J),nl,nl,
    write('Surinam es de color: '), write(K),nl,nl, write('Guyana es de color: '), write(L),nl,nl,
    write('Guyana francesa es de color: '), write(M),nl,nl,
    nl,menu.

opciones(X):-
    X= 5, write('Las reinas pueden estar úbicadas de la siguiente forma: '), solucionR(Z), write(Z),nl, nl, menu.

opciones(X):-
    X = 6, tareas,nl,nl, menu.


opciones(X):-
    X = 7, write('Movimientos: '), resolver(3,S),write(S),nl,nl, menu.


opciones(X):-
    X= 8, write("Hasta Luego").



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1

%Eliminar un elemento de una lista.

eliminar(1, [_|Xs], Xs).

eliminar(I, [X|Xs], [X|Ys]):-
          I2 is I - 1,eliminar(I2, Xs, Ys).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 2

%funciones para busqueda binaria

inserta(X,[],[X]).
inserta(X,[H|T],[X,H|T]):-
        X =< H,!.
inserta(X,[H|T],[H|S]):-
        X > H, inserta(X,T,S).

ordenar([],[]). %ordena la lista
ordenar([H|T],S):-
        ordenar(T,R),inserta(H,R,S).

contiene(Lista, Valor):-
    even_division(_,[Valor|_], Lista).
contiene(Lista, Valor):-
    even_division(_, [Centro|SegundaMitad], Lista),
    Centro<Valor, SegundaMitad \= [],
    contiene(SegundaMitad, Valor).

contiene(Lista, Valor):-
    even_division(PrimeraMitad, [Centro|_], Lista),
    Centro>Valor, PrimeraMitad\=[],
    contiene(PrimeraMitad, Valor).

even_division(Primero, Segundo, Aux) :-
    append(Primero, Segundo, Aux),
    length(Primero,F), length(Segundo,S),
    S>=F, S-F=<1.

busqueda(LISTA):-
        write("Ingrese número a buscar: "),read(R),busqueda2(R,LISTA).

busqueda2(R,L):-
    ordenar(L,NL),nl,write("El número "), write(R),
    contiene(NL,R),!,write(' Si está en la lista'),nl;
    not(contiene(L,R)),!,write(' No está en la lista'),!,nl.
%fin de funciones busqueda binaria



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 3

%funcion para encontrar el numero con más repetidos en una lista.


contar([],_T,0):-!.
contar([X|Y],T,S):-
    T = X,contar(Y,T,S1),S is 1+S1.
contar([X|Y],T,S):-
    not(T = X),contar(Y,T,S).

posicion([],0,0,0).
posicion([X|_Y],P,P2,N):-
    P = P2,N is X.
posicion([_X|Y],P,P2,N):-
    not(P is P2),P1 is P+1,posicion(Y,P1,P2,N).

cantidad([],0).
cantidad([_X|Y],C):-
    cantidad(Y,C1),C is C1 + 1.


repetidos2([_X|_Y],C,Z,P,S):-
    ((C > Z);(C=Z)),
    write("El numero "),
    write(P),
    write(" con "),
    write(S),
    write(" repetidos.").

repetidos2([X|Y],C,Z,_P,S):-
    C1 is C + 1,
    posicion([X|Y],1,C1,P1),
    contar([X|Y],P1,S1),
    S1>S,repetidos2([X|Y],C1,Z,P1,S1).


repetidos2([X|Y],C,Z,P,S):-
    C1 is C + 1,
    posicion([X|Y],1,C1,P1),
    contar([X|Y],P1,S1),
    not(S1>S),repetidos2([X|Y],C1,Z,P,S).


repetidos([X|Y]):-
    cantidad([X|Y],Z),
    posicion([X|Y],1,2,P),
    contar([X|Y],P,S),
    repetidos2([X|Y],1,Z,P,S).


%Funcion para ordenar
ordenarA([],[]).
ordenarA([X|Y],LR):-
    ordenarA(Y,Z),insertarO(X,Z,LR).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 4

%problema mapa


%a cada pais le damos un color el cual se unifica de Color

vecinos(Color1,Color2):-

    Color=[rojo,amarillo,verde,azul],
    member(Color1,Color),
    member(Color2,Color),
    Color1\=Color2.   %Prueba y garantiza la diferencia de colores

%damos el mapa o la configuracion que se desee  en este caso
%se utilizará el mapa de america del sur.

colorear(Colombia,Peru,Ecuador,Chile,Argentina,Bolivia,Paraguay,Uruguay,Brazil,Venezuela,Surinam,Guyana,GuyanaFrancesa):-

%cada una de estas son las restricciones(que país limita con el otro)

vecinos(Colombia,Ecuador),vecinos(Colombia,Venezuela),vecinos(Colombia,Peru),
vecinos(Colombia,Brazil),
vecinos(Venezuela,Brazil),vecinos(Venezuela,Guyana),vecinos(Ecuador,Peru),
vecinos(Bolivia,Peru),vecinos(Bolivia,Brazil),vecinos(Bolivia,Chile),
vecinos(Bolivia,Argentina),vecinos(Argentina,Brazil),vecinos(Bolivia,Paraguay),vecinos(Argentina,Chile),
vecinos(Argentina,Uruguay),vecinos(Argentina,Paraguay),vecinos(Argentina,Chile),
vecinos(Uruguay,Brazil),vecinos(Brazil,Guyana),vecinos(Brazil,Surinam),
vecinos(Brazil,GuyanaFrancesa),vecinos(Brazil,Peru),vecinos(Brazil,Paraguay),vecinos(Guyana,Surinam),vecinos(Surinam,GuyanaFrancesa).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 5

% 8 Reinas

solucionR(Reinas) :-
 permutation([1,2,3,4,5,6,7,8], Reinas),
 safe(Reinas).
 
permutation([],[]).
 
permutation([Cabeza|Cola],PermList) :-
 permutation(Cola,PermCola),
 del(Cabeza,PermList,PermCola).
 
del(Item,[Item|List],List).
 
del(Item,[Primero|List],[Primero|List1]) :-
 del(Item,List,List1).
 
safe([]).
 
safe([Reina|Piezas]) :-
 safe(Piezas),
 noattack(Reina, Piezas,1).
 
noattack(_,[],_).  %no ataca en posicion
 
noattack(Y,[Y1|Ylist],Xdist) :-
 Y1-Y=\=Xdist,
 Y-Y1=\=Xdist,
 Dist1 is Xdist + 1,
 noattack(Y,Ylist,Dist1).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 6

%TAREAS

tiempo(1).
tiempo(2).
tiempo(3).
tiempo(4).

soluciones(A ,B, C, D, E):-
    A is 2,
    tiempo(B),
    tiempo(C),
    D is 10,
    E is 15,
    B#<4,C#<3,
    F is A+B+C, F#<6.

tareas:-
    soluciones(A, B, C, D, E),
write("Tarea 1 comienza, y termina a los "),write(A),write(" segundo(s)"),nl,
write("la tarea 2 comienza a "), write(A),write(" segundo(s) de Tarea 1, se termina o termina a los 3 segundos."),nl,
write("Tarea 3 comienza a "), write(B),write(" segundo(s) de Tarea 2, se termina o termina a los 2 segundos."),nl,
write("Tarea 4 comienza a "), write(C),write(" segundo(s) de Tarea 3, se termina o termina a los 10 segundos."),nl,
write("Tarea 5 comienza a "), write(D),write(" segundo(s) de Tarea 4, se termina o  termina a los "), write(E), write(" segundo(s)."),nl.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 7

 %Canibales y Misioneros

%ubicamos (X,Y) y utilizamos 5 movimientos:
%X=Canibales
%Y=Misioneros
mover(1,1).
mover(1,0). 
mover(0,1). 
mover(2,0). 
mover(0,2). 


% Movimiento de misioneros y canibales de la orilla A a la B
accion(estado(CanibalA,MisinoeroA,CanibalB,MisioneroB,0),estado(CAF,MAF,CBF,MBF,1)):-
    mover(X,Y),                             
    CAF is CanibalA-X, MAF is MisinoeroA-Y,                % Salen misioneros y canibales de la orilla A
    CBF is CanibalB+X, MBF is MisioneroB+Y,                % Entran misioneros y canibales de la orilla B
    CAF >=0, validarPaso(CAF,MAF,CBF,MBF).                 

% Movimiento de misioneros y canibales de la orilla B a la A
accion(estado(CanibalA,MisinoeroA,CanibalB,MisioneroB,1),estado(CAF,MAF,CBF,MBF,0)):-
    mover(X,Y),                            
    CBF is CanibalB-X, MBF is MisioneroB-Y,               % Salen misioneros y canibales de la orilla B
    CAF is CanibalA+X, MAF is MisinoeroA+Y,               % Entran misioneros y canibales de la orilla B
    CBF >=0, validarPaso(CAF,MAF,CBF,MBF).  


% validamos valores despues de movimientos
validarPaso(CAF,MAF,CBF,MBF):- MAF > 0, MBF>0, CAF =<MAF, CBF =<MBF.    % Existan misioneros en ambas orillas
validarPaso(_,MAF,CBF,MBF):- MAF = 0, MBF>0, CBF =<MBF.                 % Todos los misioneros en orilla B, que haya por lo menos uno en B
validarPaso(CAF,MAF,_,MBF):- MAF > 0, MBF=0, CAF =<MAF.                 % Exista por lo menos 1 misionero en A, No hayan misioneros en B
validarPaso(_,MAF,_,MBF):- MAF = 0, MBF=0.                              % No existan misioneros en ninguna orilla

% Cantidad excedida en cierta orilla
estadoFinal(estado(_,_,CM,CM,1)). 

% manejo de arrays
pertenece(X,[X|_]).                                 % La cabeza de la lista sea el elemento que buscamos.
pertenece(X,[_|Ls]):-pertenece(X,Ls).               % si no lo es, ignora la cabeza y se vuelve a llamar

insertarFinal([],X,[X]).                            % Predicados para insertar al final de la lista de estados
insertarFinal([L|Ls],X,[L|R]):-insertarFinal(Ls,X,R).


busquedaProf(S,V,V):- estadoFinal(S).               % Cuando la busqueda en profundidad
busquedaProf(S,V,LS):- accion(S,NS),                % Predicado para llamar a la validacion de estados
                       not(pertenece(NS,V)),        %  Ver que no exista el estado en la lista
                       insertarFinal(V,NS,NV),      % Actualizo la lista de estados visitados
                       busquedaProf(NS,NV,LS).      % Se pasa al siguiente estado

resolver(CM, S):- busquedaProf(estado(CM,CM,0,0,0),[estado(CM,CM,0,0,0)], S).
