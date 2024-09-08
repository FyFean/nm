classdef test < matlab.unittest.TestCase
    methods (Test)
        function testInterpolacija(testCase)

   
            % TESTIRANJE KOEFICIENTOV ZLEPKA
            % Linearna interpolacija (y = x + 2)
            x = [0, 2];
            y = [2, 4];

            Z = interpoliraj(x, y);

            expected_a = 2; 
            expected_b = 1; 
            expected_c = 0; 
            expected_d = 0; 
            
            testCase.verifyEqual(Z.a, expected_a, 'AbsTol', 1e-4);
            testCase.verifyEqual(Z.b, expected_b, 'AbsTol', 1e-4);
            testCase.verifyEqual(Z.c, expected_c, 'AbsTol', 1e-4);
            testCase.verifyEqual(Z.d, expected_d, 'AbsTol', 1e-4);
            
            % Interpolacija treh točk
            x2 = [1,2,4];
            y2 = [1,4,2];

            expected_a2 = [1;4]; 
            expected_b2 = [3 + 2/3; -1 + 8/3]; 
            expected_c2 = [0; -2]; 
            expected_d2 = [-2/3; 1/3];

            Z2 = interpoliraj(x2, y2);

            testCase.verifyEqual(Z2.a, expected_a2, 'AbsTol', 1e-4);
            testCase.verifyEqual(Z2.b, expected_b2, 'AbsTol', 1e-4);
            testCase.verifyEqual(Z2.c, expected_c2, 'AbsTol', 1e-4);
            testCase.verifyEqual(Z2.d, expected_d2, 'AbsTol', 1e-4);

            % TESTIRANJE FUNKCIJE ZA VRAČANJE VREDNOSTI
            
            % Kvadratna interpolacija z 20 točkami y = x^2
            x3 = linspace(-4, 4, 20);
            y3 = x3.^2;

            Z3 = interpoliraj(x3, y3);

            y_val1 = Z3.vrednost(1.5);
            y_val2 = Z3.vrednost(-2.5);

            expected_y_val1 = 2.25; 
            expected_y_val2 = 6.25; 

            testCase.verifyEqual(y_val1, expected_y_val1, 'AbsTol', 1e-3);
            testCase.verifyEqual(y_val2, expected_y_val2, 'AbsTol', 1e-3);

            % Linearna interpolacija
            y_val3 = Z.vrednost(6);
            expected_y_val3 = 8; 

            testCase.verifyEqual(y_val3, expected_y_val3, 'AbsTol', 1e-3);

            % Interpolacija treh točk, testiranje robnih vrednosti
            y_val4 = Z2.vrednost(4);
            y_val5 = Z2.vrednost(1);

            expected_y_val4 = 2; 
            expected_y_val5 = 1; 

            testCase.verifyEqual(y_val4, expected_y_val4, 'AbsTol', 1e-3);
            testCase.verifyEqual(y_val5, expected_y_val5, 'AbsTol', 1e-3);


        end
       
    end
end