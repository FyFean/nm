% Funkcija za risanje grafa nihajnega časa/periode glede na različne začetne kotne hitrosti v primerjavi s harmoničnim nihalom. 
% Primerja tudi različne začetne odmike. 
% Vhod:
%     fixed_vars	  vektor fiksih vrednosti, po vrsti: [gravitacija, dolzina nihala, št. podintervalov, čas]
%	 theta0_values	  vektor različnih začetnih odmikov
%	dtheta0_values	  vektor različnih začetnih hitrosti

function analyze_periods(fixed_vars, theta0_values, dtheta0_values)
    
    periods = zeros(length(theta0_values), length(dtheta0_values));
    time = linspace(0, fixed_vars(4), fixed_vars(3));
    
    % Računanje periode harmonicnega nihala, ki je konstantna izračunana po
    % formuli
    T_SHO = 2 * pi * sqrt(fixed_vars(2) / fixed_vars(1));
    
    % Računamo periode za različne začetne odmike in različne začetne hitrosti
    for j = 1:length(theta0_values)
        theta0 = theta0_values(j);

        for i = 1:length(dtheta0_values)
            dtheta0 = dtheta0_values(i);
            
            % Računamo gibanje nihala glede na trenutni začetni odmik
            odmik = nihalo(fixed_vars, theta0, dtheta0);

            % Najdemo periodo kjer gledamo prehode odmika čez theta = 0
            zero_crossings = find(diff(sign(odmik(1,:))) ~= 0);

            if length(zero_crossings) > 1
                % Ocenimo periodo
                periods(j, i) = 2 * (time(zero_crossings(2)) - time(zero_crossings(1)));
            else
                % Če ne najdemo prehoda
                periods(j, i) = NaN;
            end
        end
    end
    
    % Izrišemo grafe
    figure;
    hold on;
    colors = ['b', 'r', 'g', 'm'];
    for j = 1:length(theta0_values)
        plot(dtheta0_values, periods(j, :), [colors(j), '-', 'o'], 'LineWidth', 1.5, ...
            'DisplayName', sprintf('\\theta_0 = %.1f°', rad2deg(theta0_values(j))));
    end
    plot(dtheta0_values, T_SHO * ones(size(dtheta0_values)), 'k--', 'LineWidth', 2, 'DisplayName', 'Har. nihalo');
    xlabel('\theta\prime_0 (rad/s)');
    ylabel('Nihajni čas (s)');
    title('Primerjava nihajnega časa in začetne hitrosti pri različnih začetnih odmikih');
    legend show;
    grid on;
    hold off;
end
