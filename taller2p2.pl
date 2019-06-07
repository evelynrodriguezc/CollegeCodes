:-use_module(library(clpfd)).

/*
Predicado persona con:
   persona(Nombre_persona,Color_ojos,Color_cabello,Gafas,Estatura(cm)).

Para color de ojos esta la siguiente informacion:
   1). color de ojos cafe.
   2). color de ojos azul.
   3). color de ojos negro.

Para color de cabello esta la siguiente informacion:
   1). color de cabello negro.
   2). color de cabello amarillo.
   3). color de cabello cafe.
   
Gafs:
1). Tiene Gafas.
    2). No tiene Gafas.
*/

persona("Hugo",3,3,1,175).
persona("Carlos",1,1,2,171).
persona("Catalina",2,2,2,162).
persona("Paulina",1,3,1,162).
persona("Mariana",1,2,2,171).
persona("Julian",3,1,1,168).
persona("Andres",2,2,1,168).

pareja(X,Y,R):-
    persona(X,Cox,_,_,Esx),persona(Y,Coy,_,_,Esy),Esx == Esy,Cox =\= Coy,R=1.
pareja(X,Y,R):-
    persona(X,Cox,Ccx,_,_),persona(Y,Coy,Ccy,_,_),Cox == Coy,Ccx =\= Ccy,R=1.
pareja(X,Y,R):-
    persona(X,_,Ccx,_,Esx),persona(Y,_,Ccy,_,Esy),Ccx == Ccy,Esx =\= Esy,R=1.
pareja(X,Y,R):-
    persona(X,Cox,Ccx,Gx,_),persona(Y,Coy,Ccy,Gy,_),Cox == Coy, Ccx =\= Ccy, (Gx =\= Gy; (Gx == Gy, 2 == Gx)),R=1.
pareja(_,_,R):-
    R = 0.
version 2:
:-use_module(library(clpfd)).

cabello(1).
cabello(2).

ojos(1).
ojos(2).

genero(1).
geneto(2).

estatura(1).
estatura(2).

gafas(1).
gafas(2).

diferencias1(K,K1,Y,Y1):-
    (K#=K1,Y#\=Y1);(K#\=K1,Y#\=Y1);(K#\=K1,Y#=Y1).
diferencias2(Y,Y1,M,M1,X,X1):-
    (Y#=Y1,M#\=1,M1#=2,X#\=X1);(Y#=Y1,M#=2,M1#=1,X#\=X1);(Y#=Y1,M#=1,M1#=1,X#\=X1),
    (Y#\=Y1,M#\=1,M1#=2,X#\=X1);(Y#\=Y1,M#=2,M1#=1,X#\=X1);(Y#\=Y1,M#=1,M1#=1,X#\=X1);(Y#\=Y1,M#=2,M1#=2,X#\=X1),
    (Y#\=Y1,M#\=1,M1#=2,X#=X1);(Y#\=Y1,M#=2,M1#=1,X#=X1);(Y#\=Y1,M#=1,M1#=1,X#=X1);(Y#\=Y1,M#=2,M1#=2,X#=X1).
diferencias3(X,X1,K,K1):-
    (X#=X1,K#\=K1);(X#\=X1,K#\=K1);(X#\=X1,K#=K1).


baile(P1,P2):-
    cabello(X1),cabello(X2),cabello(X3),cabello(X4),ojos(Y1),ojos(Y2),ojos(Y3),ojos(Y4),
    genero(Z1),genero(Z2),estatura(K1),estatura(K2),estatura(K3),estatura(K4),gafas(M1),
    gafas(M2),
    L1=[X1,Y1,Z1,K1,M1],L2=[X2,Y2,Z1,K2,M2],L3=[X3,Y3,Z2,K3,M1],L4=[X4,Y4,Z2,K4,M2],
   diferencias1(K1,K2,Y1,Y2),diferencias1(K3,K4,Y3,Y4),
   diferencias2(Y1,Y2,M1,M2,X1,X2),diferencias2(Y3,Y4,M1,M2,X3,X4),
   diferencias3(X1,X2,K1,K2),diferencias3(X3,X4,K3,K4),

    P1=[L1|L2],P2=[L3|L4].

version 3:
:- use_module(library(clpfd)).

%persona[estatura,ojos,cabello,gafas]
% nombres[Carmelo,Ariel,Regan,Sebastian,Percival,Sheere,Clara,Debora]
% verde 1, negro 2, azul 3, cafe 4, gris 5, rubio 6, rojo 7, no 10, si11

lista:-
    CA=["Carmelo",170,1,4,11],
    AB=["Ariel",170,2,2,10],
    RE=["Regan",172,3,2,10],
    SH=["Sebastian",160,4,6,10],
    PE=["Percival",174,4,3,11],
    SH=["Sheere",160,1,6,11],
    CL=["Clara",159,2,7,11],
    DE=["Debora",150,5,4,10],

solucion([X,A,B,C,D],[Y,E,F,G,H]):-
(A is E, not(B is F), write(X), write(Y)); (B is F, C is G ,not(D is H), write(X), write(Y)); (C is G, not(A is B)).



pared(1).
pared(2).
pared(3).
pared(4).


parejas:-
pared(V),
pared(P),
pared(C),
pared(MN),
pared(A),
pared(M),
pared(CU),
V\=A,V\=MN,V\=C,V\=P,
P\=A,P\=MN,P\=C,P\=M,
C\=M,C\=A,
MN\=A,MN\=M,
A\=CU,A\=M,
write("Ventana: "),write(V),nl,
write("Puerta: "),write(P),nl,
write("Cama: "),write(C),nl,
write("Mesa de Noche: "),write(MN),nl,
write("Armario: "),write(A),nl,
write("Mesa de Estudio: "),write(M),nl,
write("Cuadro: "),write(CU),nl.


%Repartición De Despachos

despacho(1).
despacho(2).
despacho(3).
despacho(4).
despacho(5).
despacho(6).
despacho(7).
%Profesores Tiempo Completo
%T=[U,V,W,X,Z]
%Profesores Tiempo Parcial
%P=[A,B,C,D,E]
oficinas:-
    despacho(U),despacho(V),despacho(W),despacho(X),despacho(Z),despacho(A),despacho(B),despacho(C),despacho(D),despacho(E),U#\=V,U#\=W,U#\=X,U#\=Z,U#\=A,U#\=B,U#\=C,U#\=D,U#\=E,V#\=W,V#\=X,V#\=Z,V\=A,V#\=B,V#\=C,V#\=D,V#\=E,W#\=X,W#\=Z,W#\=A,W#\=B,W#\=C,W#\=D,W#\=E,X#\=Z,X#\=A,X#\=B,X#\=C,X#\=D,X#\=E,Z#\=B,Z#\=C,Z#\=D,Z#\=E,B#\=A,B#\=D,B#\=E,D#\=A,D#\=C,nl,write("Profesores Tiempo Completo"),nl,write("Profesor 1 "),write("Despacho:"),write(U),nl,write("Profesor 2 "),write("Despacho:"),write(V),nl,write("Profesor 3 "),write("Despacho:"),write(W),nl,write("Profesor 4 "),write("Despacho:"),write(X),nl,write("Profesor 5 "),write("Despacho:"),write(Z),nl,nl,write("Profesores Tiempo Parcial"),nl,write("Profesor 1 "),write("Despacho:"),write(A),nl,write("Profesor 2 "),write("Despacho:"),write(B),nl,write("Profesor 3 "),write("Despacho:"),write(C),nl,write("Profesor 4 "),write("Despacho:"),write(D),nl,write("Profesor 5 "),write("Despacho:"),write(E).
