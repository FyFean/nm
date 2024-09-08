% Newtonova iteracija za iskanje nicel nelinearnega sistema F dveh enacb f1(t) in f2(r). 
% Sistem preoblikujemo v obliko Jf(x) * delta_x = -F(x), kjer je Jf Jacobijeva
% matrika parcialnih odvodov funkcije F, ter nove priblizke za nicle
% najdemo kot x_new = x + delta_x, kjer je x vektor iskanih spremenljivk
% t in r.
% Vhod:
%	   f1		prva nelinearna enacba
%	   f2		druga nelinearna enacba
%	   x0		stolpicni vektor zacetnih priblizkov za t in r
%	  df1_td    parcialni odvod f1 po t
%	  df1_tr    parcialni odvod f1 po r
%	  df2_td    parcialni odvod f2 po t
%	  df2_tr    parcialni odvod f2 po r
%	   tol		Toleranca za konvergenco
%    max_iter   Maksimalno stevilo iteracij
% Izhod:
%	 [t, r]		priblizek nicle f1 in f2

function [t, r] = newt_iteracija(f1, f2, x0, df1_dt, df1_dr, df2_dt, df2_dr, tol, max_iter)

    t = x0(1);
    r = x0(2);
    iter = 0;

    while iter < max_iter

        % Preoblikujemo enacbi f1 in f2 v sistem F(x)
        F = [f1(t, r); f2(t, r)];
    
        % Racunanje Jacobijeve matrike
        J = [df1_dt(t, r), df1_dr(t, r);
             df2_dt(t, r), df2_dr(t, r)];
    
        % Racunanje nove aproksimacije t-ja in r-ja
        delta = -J\F;
        t = t + delta(1);
        r = r + delta(2);

        if norm(delta) < tol
            break;
        end
    
        iter = iter + 1;
    end
end
