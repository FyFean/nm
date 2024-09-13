% Izračuna gibanje matematičnega nihala s podanim začetnim odmikom ter začetno kotno hitrostjo 
% s pomočjo Runge-Kutta metode reda 4.  
% Vhod:
%   fixed_vars	vektor fiksih vrednosti, po vrsti: [gravitacija, dolzina nihala, št. podintervalov, čas opazovanja]
%	  theta0	začetni odmik
%	  dtheta0	začetna kotna hitrost
% Izhod:
%	  odmik	    2xn matrika, prva vrsta predstavja odmike v času, druga pa kotno hitrost v času
	  
function odmik = nihalo(fixed_vars, theta0, dtheta0)

    g = fixed_vars(1);
    l = fixed_vars(2);
    n = fixed_vars(3);
    t = fixed_vars(4);

    % Dolzina koraka
    h = t / n;

    % Inicializacija
    odmik = zeros(2, n);
    y = [theta0; dtheta0];
    odmik(:, 1) = y;

    % Računamo približek diferencialne enačbe gibanja nihala z RK metodo
    for i = 1:n-1
        y = RK4(h, @(t, y) f(t, y, g, l), h*i, y);
        odmik(:, i+1) = y;
    end
end


% Definiramo diferencialno enačbo nihala, ki opisuje kako se kotni odmik (theta)
% in kotna hitrost (dtheta) nihala spreminjata skozi čas glede na gravitacijo in dolžino nihala.
% Vhod:
%      y        vektor stanj, kjer y(1) predstavlja kotni odmik, y(2) pa kotno hitrost 
%	   g 	    gravitacijski pospešek
%	   l	    dolžina nihala
% Izhod:
%	  eq	    vektor odvodov, eq(1) je trenutna kotna hitrost, eq(2) je trenutni odvod kotne hitrosti, torej kotni pospešek
function eq = f(~, y, g, l)
    eq = [y(2); -(g/l) * sin(y(1))];
end


