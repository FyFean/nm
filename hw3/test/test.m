classdef test < matlab.unittest.TestCase
    methods (Test)

       % TESTIRANJE RUNGE-KUTTA ZA TRI ANALITIČNO REŠLJIVE ENAČBE
       function testRungeKutta(testCase)


            %%% Testiranje funckije  y' = y, resitev y = e^x

            % Inicializacija
            y0 = 1;
            t0 = 0;
            h = 0.001;
            t_end = 1;
            num_steps = round(t_end / h);

            % Izračunamo analitično rešitev pri t = 1
            y_analytical = exp(t_end);
            
            % Začetni pogoji za testiranje RK metode
            y_rk4 = y0;
            t = t0;

            % Testiramo funkcijo RK4
            for i = 1:num_steps
                y_rk4 = RK4(h, @(t, y) y, t, y_rk4);
                t = t + h;
            end
            
   
            fprintf('Analitična vrednost (Eksponentna funkcija): %.10f\n', y_analytical);
            fprintf('RK4 aproksimacija (Eksponentna funkcija): %.10f\n', y_rk4);
            testCase.verifyEqual(y_rk4, y_analytical, 'AbsTol', 1e-10);
            fprintf('\n');



            %%% Testiranje funckije  y' = -y, resitev y = e^(-x)

            % Inicializacija
            y0 = 1;
            t0 = 0;
            h = 0.001;       
            t_end = 1;       
            num_steps = round(t_end / h);
        
            % Izračunamo analitično rešitev pri t = 1
            y_analytical = exp(-t_end);
            
            % Začetni pogoji za testiranje RK metode
            y_rk4 = y0;
            t = t0;
        
            % Testiramo funkcijo RK4
            for i = 1:num_steps
                y_rk4 = RK4(h, @(t, y) -y, t, y_rk4);
                t = t + h;
            end
            
            fprintf('Analitična vrednost (Eksponentni padec): %.10f\n', y_analytical);
            fprintf('RK4 aproksimacija (Eksponentni padec): %.10f\n', y_rk4);
            testCase.verifyEqual(y_rk4, y_analytical, 'AbsTol', 1e-10);
            fprintf('\n');




            %%% Testiranje funckije  y' = sin(x), resitev y = 1 - cos(x)

            % Inicializacija
            y0 = 0;
            t0 = 0;
            h = 0.001;
            t_end = 1;
            num_steps = round(t_end / h);
        
            % Izračunamo analitično rešitev pri t = 1
            y_analytical = 1 - cos(t_end);
            
            % Začetni pogoji za testiranje RK metode
            y_rk4 = y0;
            t = t0;
        
            % Testiramo funkcijo RK4
            for i = 1:num_steps
                y_rk4 = RK4(h, @(t, y) sin(t), t, y_rk4);
                t = t + h;
            end
            
            fprintf('Analitična vrednost (Cosinus): %.10f\n', y_analytical);
            fprintf('RK4 aproksimacija (Cosinus): %.10f\n', y_rk4);
            testCase.verifyEqual(y_rk4, y_analytical, 'AbsTol', 1e-10);
            fprintf('\n');
            

            
       end


       % TESTIRANJE FUNKCIJE NIHALO ZA ZELO MAJHNO THETO KJER JE GIBANJE
       % ENAKO HARMONIČNEMU NIHALU
       
       function testNihalo(testCase)

            % Inicializacija
            l = 1;
            g = 9.80665;
            t = 10;
            n = 6000;

            % Začetni pogoji - zelo majhna theta da dosezemo natancnost 1e-10
            theta0 = 0.00000001;
            dtheta0 = 0;
        
            % Testiramo funkcijo nihalo
            odmik = nihalo([g, l, n, t], theta0, dtheta0);
            theta_numerical = odmik(1, :);
        
            % Analitična rešitev za majhne kote
            time = linspace(0, t, n);
            omega = sqrt(g / l);
            theta_analytical = theta0 * cos(omega * time);

            assert(max(abs(theta_numerical - theta_analytical)) < 1e-10, ...
                   'Numerična rešitev nihala ni znotraj tolerance.\n');
        
            fprintf('Numerična rešitev nihala je znotraj tolerance.\n');
        end



     

       
    end
end