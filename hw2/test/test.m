classdef test < matlab.unittest.TestCase
    methods (Test)

        % TESTIRANJE PRVEGA DELA NALOGE: INTEGRACIJSKI SINUS
        function testAproksimiraj_Si(testCase)

            % -- TESTIRANJE RAZLIČNO VELIKIH MEJ PRI INTEGRALU
            x_xxs= 0.000001;
            x_xs= 0.01;
            x_s= 1;
            x_m= 300;
            x_l= 2000;
            x_xl= 50000;


            Si_xxxs = aproksimiraj_Si(x_xxs,10);
            Si_x_xs = aproksimiraj_Si(x_xs,100);
            Si_x_s = aproksimiraj_Si(x_s,100);
            Si_x_m = aproksimiraj_Si(x_m,4000);
            Si_x_l = aproksimiraj_Si(x_l,20000);
            Si_x_xl = aproksimiraj_Si(x_xl,90000);

            expected_Si_xxxs = integral(@(t) sin(t)./t, 0, x_xxs, 'ArrayValued', true);
            expected_Si_x_xs = integral(@(t) sin(t)./t, 0, x_xs, 'ArrayValued', true);
            expected_Si_x_s = integral(@(t) sin(t)./t, 0, x_s, 'ArrayValued', true);
            expected_Si_x_m = integral(@(t) sin(t)./t, 0, x_m, 'ArrayValued', true);
            expected_Si_x_l  = integral(@(t) sin(t)./t, 0, x_l, 'ArrayValued', true);
            expected_Si_x_xl = integral(@(t) sin(t)./t, 0, x_xl, 'ArrayValued', true);
            
            testCase.verifyEqual(Si_xxxs, expected_Si_xxxs, 'AbsTol', 1e-10);
            testCase.verifyEqual(Si_x_xs, expected_Si_x_xs, 'AbsTol', 1e-10);
            testCase.verifyEqual(Si_x_s, expected_Si_x_s, 'AbsTol', 1e-10);
            testCase.verifyEqual(Si_x_m, expected_Si_x_m, 'AbsTol', 1e-10);
            testCase.verifyEqual(Si_x_l, expected_Si_x_l, 'AbsTol', 1e-10);
            testCase.verifyEqual(Si_x_xl, expected_Si_x_xl, 'AbsTol', 1e-10);
   
        end

         % -- TESTIRANJE ČE ZA x VSTAVIMO NEGATIVNO ŠTEVILO ALI 0
         function testNegativeXError(testCase)

            x_neg = -1;
            n = 100;

            expectedErrorID = 'MATLAB:aproksimiraj_Si:InputError';
            testCase.verifyError(@() aproksimiraj_Si(x_neg, n), expectedErrorID);

            x_zero = 0;
            n = 100;

            expectedErrorID2 = 'MATLAB:aproksimiraj_Si:InputError';
            testCase.verifyError(@() aproksimiraj_Si(x_zero, n), expectedErrorID2);
         end


         % TESTIRANJE DRUGEGA DELA NALOGE: PLOSCINA HIPOTROHOIDE
         function testPovrsinaHipotrohoide(testCase)

                [pl_hipo, pl_trikotnika, t1, t2] = pl_hipotrohoide();
                

                % -- TESTIRANJE PLOSCINE KRIVOCRTNEGA TRIKOTNIKA
                a = 1;
                b = -11/7;
                
                x = @(t) (a + b) * cos(t) + b * cos((a + b) / b * t);
                y = @(t) (a + b) * sin(t) + b * sin((a + b) / b * t);
                dx = @(t) -(a + b) * sin(t) - (a + b) * sin((a + b) / b * t);
                dy = @(t) (a + b) * cos(t) + (a + b) * cos((a + b) / b * t);
                
                integral_trikotnika = @(t) x(t) .* dy(t) - dx(t) .* y(t);
               
                % Uporabimo matlabovo vgrajeno funkcijo za racunanje integrala
                pl_trikotnika_expected = 0.5 * integral(integral_trikotnika, t1, t2);
                testCase.verifyEqual(pl_trikotnika, pl_trikotnika_expected, 'AbsTol', 1e-10);



                % -- TESTIRANJE PLOSCINE HIPOTROHOIDE
                ploscina_malega_kroga = pi * 2.083^2;
                ploscina_velikega_kroga = pi * 2.130^2;
            
                % Gledamo ce je ploscina znotraj velikega in malega vcrtanega kroga
                testCase.verifyGreaterThanOrEqual(pl_hipo, ploscina_malega_kroga, ...
                    'Ploscina hipotrohoide je pod pricakovano vrednostjo.');
                testCase.verifyLessThanOrEqual(pl_hipo, ploscina_velikega_kroga, ...
                    'Ploscina hipotrohoide je nad pricakovano vrednostjo.');

         end


       
    end
end