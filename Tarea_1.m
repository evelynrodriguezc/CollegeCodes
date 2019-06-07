clc; close all; clear all
%%grafica de volumen contra profundidad
r=input('ingresar el radio: ');
if r<=0
    disp('el radio no puede ser negativo');
end
l=input('ingresar la longitud: ');
if l<=0
    disp('ingrese una longitud valida')
end
H=1:1:2*r;
n=2*r;
for i=1:n;
    v=(r^2*acos((r-H(i))/r)-(r-H(i))*sqrt(2*r.*H(i)-(H(i).^2)));
    V(i)=v;
end
%grafica
plot(H,V)
grid on
grid minor
title('volumen vs profundidad')
xlabel('profundidad')
ylabel('volumen')
axis([0,6,0,15])
my_results=[H,V];
