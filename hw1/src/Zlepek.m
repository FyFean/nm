% Razred ustvari objekt tipa Zlepek, sestavljen iz n-1 polinomov tretje stopnje in
% njihovih pripadajočih koeficientov a,b,c,d ter n točk skozi katere
% interpoliramo polinome.
% Vhod:
%		a		vektor a koeficientov za polinome 
%		b		vektor b koeficientov za polinome
%		c		vektor c koeficientov za polinome
% 		d	    vektor d koeficientov za polinome
% 		x	    vektor x koorditat interpolacijskih tock
% 		y	    vektor y koorditat interpolacijskih tock
% Izhod:
%     Zlepek    objekt iz n-1 polinomov tretje stopnje

classdef Zlepek
    properties
        a
        b
        c
        d
        x
        y
    end
    
    methods
        function obj = Zlepek(a, b, c, d, x, y)
            obj.a = a;
            obj.b = b;
            obj.c = c;
            obj.d = d;
            obj.x = x;
            obj.y = y;
        end
        % Funkcija za vračanje vrednosti, kjer y vrednost dobimo z vstavljanjem x vrednosti v enačbo za kubični zlepek. 
        % Najprej z bisekcijo ugotovimo, na kateremu polinomu se nahaja želena vrednost, nato pa vrednost preslikamo v prostor polinoma (torej premaknemo za x).
        % Vhod:
        %	   obj		objekt tipa Zlepek
        %	  x_val		x vrednost tocke, ki jo zelimo vrniti
        % Izhod:
        %     y_val     y vrednost tocke, ki jo zelimo vrniti

        function y_val = vrednost(obj, x_val)
            % Poišči interval, kjer se nahaja x_val z uporabo bisekcijske metode
            n = length(obj.x);
            low = 1;
            high = n;
        
            % Bisekcija za iskanje pravega intervala
            while low < high - 1
                middle = floor((low + high) / 2);
                if x_val < obj.x(middle)
                    high = middle;
                else
                    low = middle;
                end
            end
        
            % Premaknemo v prostor polinoma in vstavimo v enačbo
            premik_x = x_val - obj.x(low);
            y_val = obj.a(low) + obj.b(low) * premik_x + obj.c(low)*premik_x^2 + obj.d(low)*premik_x^3;
        
        end

        % Funkcija za risanje zlepka, kjer je vsak drugi odsek narisan z
        % rdečo in modro barvo
        % Vhod:
        %	   obj		objekt tipa Zlepek
        % Izhod:
        %     plot      graf zlepka
        function plot(obj)
            hold on;
            n = length(obj.x);
            colors = {'r', 'b'};

            for i = 1:n-1
                xx = linspace(obj.x(i), obj.x(i+1), 100);
                yy = obj.a(i) + obj.b(i)*(xx - obj.x(i)) + obj.c(i)*(xx - obj.x(i)).^2 + obj.d(i)*(xx - obj.x(i)).^3;
                plot(xx, yy, colors{mod(i,2)+1}, 'LineWidth', 1);
            end
    
            plot(obj.x, obj.y, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 2);
    
            hold off;
        end
    end
end

