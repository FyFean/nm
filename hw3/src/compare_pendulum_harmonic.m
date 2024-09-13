% Funkcija za primerjavo nihanja harmoničnega nihala ter matetmatičnega
% glede na različne začetne odmike. 

% Vhod:
%     fixed_vars	  vektor fiksih vrednosti, po vrsti: [gravitacija, dolzina nihala, št. podintervalov, čas]
%	theta0_values	  vektor različnih začetnih odmikov, ki bi jih radi primerjali


function compare_pendulum_harmonic(fixed_vars, theta0_values)

    % Izračunamo krožno frekvenco za harmonično nihalo (je konstantna)
    omega = sqrt(fixed_vars(1) / fixed_vars(2));
    time = linspace(0, fixed_vars(4), fixed_vars(3));

    % Izrisujemo grafe nihanja za različne začetne odmike
    figure; 
    for j = 1:length(theta0_values)
        theta0 = theta0_values(j);

        % Začetna kotna hitrost je nastavljena na 0
        dtheta0 = 0;

       % Računamo gibanje matematičnega nihala glede na trenutni začetni odmik
        odmik = nihalo(fixed_vars, theta0, dtheta0);

        % Računamo gibanje harmoničnega nihala glede na trenutni začetni
        % odmik (sinus del lahko zanemarimo zaradi dtheta0 = 0)
        theta_harmonic = theta0 * cos(omega * time) + (dtheta0 / omega) * sin(omega * time);
        
        % Izris rgafov
        subplot(length(theta0_values), 1, j);
        hold on;
        plot(time, odmik(1,:), 'b', 'LineWidth', 1.5, 'DisplayName', sprintf('Mat. nihalo'));
        plot(time, theta_harmonic, 'r--', 'LineWidth', 1.5, 'DisplayName', sprintf('Har. nihalo'));
        xlabel('Čas (s)');
        ylabel('Odmik (rad)');
        title(sprintf('Primerjava za \\theta_{0}=%.1f°', rad2deg(theta0)));
        legend show;
        grid on;
        hold on;
    end
end


