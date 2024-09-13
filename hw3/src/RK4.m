% Funkcija implementira Runge-Kutta metodo reda 4 za reševanje
% diferencialnih enačb.
% Vhod:
%      h        časovni korak
%	   f 	    diferencialna enačba
%	   t	    trenutni čas
%	   y	    vektor zač.stanj (pri nihalu y(1) predstavlja kotni odmik, y(2) pa kotno hitrost)
% Izhod:
%	 y_next	    naslednji vektor stanja v iteraciji izračunan z RK metodo

function y_next = RK4(h, f, t, y)
    k1 = h * f(t, y);
    k2 = h * f(t + h/2, y + k1/2);
    k3 = h * f(t + h/2, y + k2/2);
    k4 = h * f(t + h, y + k3);
    y_next = y + (k1 + 2*k2 + 2*k3 + k4) / 6;
end
