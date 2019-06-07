:-use_module(library(clpfd)).


%%%%%  1
cuenta(0,3).
cuenta(X,R):-
  X>0, R1 is R+1,X1 is X//10,cuenta(X1,R1).

imprimir([]).
imprimir([X|Y]):-
   abs(X,R),cuenta(R,0),write(X),nl,imprimir(Y).
imprimir([X|Y]):-
  abs(X,R),not(cuenta(R,0)),imprimir(Y).


%%%%  2
com(5).
com(X):-
    X>0,X1 is X//10,com(X1).

suma1([],R):-
    write("="),write(R).
suma1([X|Y],R):-
   abs(X,X1),com(X1),R1 is R+X,suma1(Y,R1).
suma1([X|Y],R):-
   abs(X,X1),not(com(X1)),suma1(Y,R).
suma([X|Y]):-
    abs(X,X1),com(X1),suma1(Y,X).
suma([X|Y]):-
    abs(X,X1),not(com(X1)),suma1(Y,0).


%%%%  3
mayor1(X,M):-
    X>M.
lista1([],M):-
    write(M).
lista1([X|Y],M):-
    mayor1(X,M),M1 is X, lista1(Y,M1).
lista1([X|Y],M):-
    not(mayor1(X,M)), lista1(Y,M).
mayor([X|Y]):-
    lista1(Y,X).

%%%%%  4
esprimo(X,X,2):-
    X\=1.
esprimo(X,D,R):-
 X\=1,D<X,0 is X mod D,D1 is D+1,R1 is R+1,esprimo(X,D1,R1).
esprimo(X,D,R):-
 X\=1,D<X,not(0 is X mod D),D1 is D+1,esprimo(X,D1,R).

sumardigi(0,R):-
   R>0,esprimo(R,2,2).
sumardigi(X,R):-
   X>0, R1 is X mod 10, X1 is X//10,R2 is R+R1,sumardigi(X1,R2).

digiprimo([X|Y]):-
    sumardigi(X,0),write(X),nl,digiprimo(Y).

digiprimo([X|Y]):-
    not(sumardigi(X,0)),digiprimo(Y).