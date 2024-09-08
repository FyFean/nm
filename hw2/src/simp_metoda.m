% Racunanje vrednosti dolocenega integrala s simpsonovo metodo. Interval
% razdelimo na n podintervalov, kjer integral na vsakem podintervalu aproksimiramo s parabolo. 
% Vhod:
%		a		spodnja meja integrala
%		b		zgornja meja integrala
%		n		stevilo podintervalov
% 		f	    funkcija, ki jo zelimo integrirati
% Izhod:
%		S		priblizek za vrednost integrala
function S = simp_metoda(a, b, n, f)
    
    h = (b-a) / (n*2);
    S = (f(a) + f(b) + 4*f(a+h));
       for i = 1:n-1
          S = S + 2*f(a+2*i*h) + 4*f(a+2*i*h+h);
       end
    S = S*h/3;
end


