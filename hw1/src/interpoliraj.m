% Funkcija interpoliraj sprejeme vektorja točk x,y in ustvari objekt
% Zlepek, ki je sestavljen iz več polinomov tretje stopnje, tako da so
% prehodi med točkami čimbolj gladki.

function Z = interpoliraj(x, y)
    % Preverimo, da so točke sortirane po x koordinati
    if any(diff(x) <= 0)
        error('Točke morajo biti sortirane in različne.');
    end
    
    n = length(x);
    h = diff(x);
    desna_stran = zeros(n,1);
    
    % Nastavitev desne strani tridiagonalnega sistema
    for i = 2:n-1
        desna_stran(i) = 3 * ((y(i+1) - y(i))/h(i) - (y(i) - y(i-1))/h(i-1));
    end
    
    % Reševanje tridiagonalnega sistema, ki ga iterativno pretvorimo v zgornje trikotno
    % matriko z odstranjevanjem elementov pod diagonalo.

    main_diag = ones(n,1);
    desna_updated = zeros(n,1);
    mulpl = zeros(n,1);
    main_diag(1) = 1; 
    main_diag(n) = 1; 
    desna_updated(1) = 0; 
    desna_updated(n) = 0;
   
    for i = 2:n-1
  
        % Nastavitev vektorja glavne diagonale sestavljenega iz razlik h
        main_diag(i) = 2*(x(i+1) - x(i-1));

        % Posodobitev glavne diagonale, da upoštevamo eliminacijo
        main_diag(i) = main_diag(i) - h(i-1) * mulpl(i-1);
        mulpl(i) = h(i)/main_diag(i);

        % Posodobitev vektorja desnih strani, da upoštevamo eliminacijo
        desna_updated(i) = (desna_stran(i) - h(i-1) * desna_updated(i-1)) / main_diag(i);
    end

    % Izračun koeficientov z obratnim vstavljanjem, kjer sledimo enačbam
    c = zeros(n,1);
    b = zeros(n-1,1);
    d = zeros(n-1,1);
    a = zeros(n-1,1);
  
    for j = n-1:-1:1
        a(j) = y(j);
        c(j) = desna_updated(j) - mulpl(j)*c(j+1);
        b(j) = (y(j+1) - y(j)) / h(j) - (h(j)*(2*c(j) + c(j+1)))/3;
        d(j) = (c(j+1) - c(j)) / (3*h(j));
    end
    
    % Ustvarimo objekt Zlepek z izračunanimi koeficienti
    Z = Zlepek(a, b, c(1:n-1), d, x, y);
end

