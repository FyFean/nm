% Racunanje vrednosti integralskega sinusa Si(x) s pomožnimi funkcijami za
% določeno mejo x. Funkciji si(x) in Ci(x) - iz pomoznih funkcij - sta aproksimirani s simpsonovo metodo.  
% Vhod:
%		x		zgornja meja integrala Si(x)
%		n		stevilo podintervalov pri simpsonovi metodi
% Izhod:
%		Si		priblizek za vrednost integrala

function Si = aproksimiraj_Si(x,n)

    if x < 0
       error('MATLAB:aproksimiraj_Si:InputError', ...
            'x mora biti pozitivno število, če ne prihaja do večjih napak pri aproksimaciji integrala, ker obravnavamo ln(x) kot kompleksno število.');
    end
    if x == 0
        error('MATLAB:aproksimiraj_Si:InputError', ...
            'x vrednost ne sme biti 0, saj funkcija pri x=0 ni definirana.');
    end

    eulergamma = 0.577215664901532;
    
    % Ci(x)
    Ci_integral = @(t) (cos(t)-1) ./ t;
    I_Ci = simp_metoda(1e-12, x, n, Ci_integral);
    Ci = eulergamma + log(x) + I_Ci;
    
    % si(x)
    si_integral = @(t) -exp(-x * cos(t)) .* cos(x * sin(t));
    I_si = simp_metoda(0, pi/2, n, si_integral);
    si = I_si;
    
    % pomozni funkciji f(x) in g(x)
    f = Ci * sin(x) - si * cos(x);
    g = -Ci * cos(x) - si * sin(x);
    
    % Si(x)
    Si = pi/2 - f*cos(x) - g*sin(x);

end