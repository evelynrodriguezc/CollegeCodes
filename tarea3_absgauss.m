clc; close all; clear all
%%Absorbedor por Gauss
n=input('ingrese el tamaño de la matriz');
A= zeros(n);
for i=1:length(A)
    for j=1:length(A)
sprintf ('ingrese la posicion,%d%d',[i,j])
A(i,j)=input('ingrese el valor de la posicion');
    end 
end
B= zeros(n,1);
for i=1:n
    B(i)=input('digite el numero');
end
a=[A B];
var_e=0;
  for i=1:length(A)-1
      var_e=var_e+1;% se usa para ir actualizando las variables
      for j=var_e:length(A)-1
          a(j+1,:)=a(j+1,:)-a(j+1,i)/a(i,i)*a(i,:);
      end
  end
n=length(A);
b=a(:,end);
x=zeros(1,n);
for i=n:-1:1
    if i==n
        x(n)=b(n)/a(n,n);
    else
        suma=0;%variable para acumular
        for j=i+1:n
            suma=suma+ a(i,j)*x(j);
        end
        x(i)=(b(i)-suma)/a(i,i);
    end
end
disp('la solucion es: ')
disp(x)
