% Racunanje ploscine hipotrohoide s parametrom a = 1, b = -11/7. Ploscino
% racunamo kot 7 * ploscina_krivocrtnega_trikotnika. Slednjo dobimo s
% simpsonovo metodo, kjer zgornjo in spodnjo mejo integrala dolocimo z
% racunanjem presecisca hipotrohoide z x osjo ter z linearno funkcijo y =
% tan(2pi/7)x.  
% Vhod:
%        /
% Izhod:
%	   pl_hipo		ploscina hipotrohoide
%   pl_trikotnika	ploscina krivocrtnega trikotnika
%	     t1		    spodnja meja integrala krivocrtnega trikotnika 
%	     t2		    zgornja meja integrala krivocrtnega trikotnika 


function [pl_hipo, pl_trikotnika, t1, t2] = pl_hipotrohoide()

    a = 1;
    b = -11/7;
    theta = 2*pi/7;
    
    % Parametricni enacbi hipotrohoide in odvodi
    x = @(t) (a + b) * cos(t) + b * cos((a + b) / b * t);
    y = @(t) (a + b) * sin(t) + b * sin((a + b) / b * t);
    
    dx = @(t) -(a + b) * sin(t) - (a + b) * sin((a + b) / b * t);
    dy = @(t) (a + b) * cos(t) + (a + b) * cos((a + b) / b * t);
    
    % RACUNANJE ZGORNJE MEJE INTEGRALA - PRESECISCA HIPOTROHOIDE IN PREMICE Z NAKLONOM 2pi/7
    
    % Enacbi presecisca hipotrohoide in premice z naklonom 2pi/7 ter odvodi
    f1 = @(t, r) x(t) - r * cos(theta);
    f2 = @(t, r) y(t) - r * sin(theta);
    
    df1_dt = @(t, r) dx(t);
    df1_dr = @(t, r) -cos(theta);
    df2_dt = @(t, r) dy(t);
    df2_dr = @(t, r) -sin(theta);
    
    % Zacetni prblizek za presecisce
    t = 11;
    r = 2;
    x0 = [t; r];
    
    % Resevanje sistema enacb
    [t2, r] = newt_iteracija(f1, f2, x0, df1_dt, df1_dr, df2_dt, df2_dr, 1e-10, 100);
    
    
    % RACUNANJE SPODNJE MEJE INTEGRALA - PRESECISCA HIPOTROHOIDE IN X OSI 
    
    % Enacba presecisca hipotrohide in x osi ter odvodi
    f3 = @(t, r) y(t);
    f4 = @(t, r) r;                                        
    
    df3_dt = df2_dt;
    df3_dr = @(t, r) 0;
    df4_dt = @(t, r) 0;
    df4_dr = @(t, r) 1;
    
    % Zacetni priblizek za presecisce, r = poljubno stevilo
    x0 = [10; 0];
    
    % Resevanje sistema enacb
    [t1, r] = newt_iteracija(f3, f4, x0, df3_dt, df3_dr, df4_dt, df4_dr, 1e-10, 100);
    
    
    % RACUNANJE INTEGRALA
    
    % Definiranje in racunanje integrala s simpsonovo metodo
    integral_trikotnika = @(t) x(t) .* dy(t) - dx(t) .* y(t);
    pl_trikotnika = 0.5 * simp_metoda(t1, t2, 80, integral_trikotnika);
    
    % Ploscina hipotrohoide
    pl_hipo = 7 * pl_trikotnika;

end

