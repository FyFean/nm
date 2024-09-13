% Funkcija za risanje faznih diagramov, kjer x os predstavlja trenutni odmik v času, 
% y pa trenutno kotno hitrost. Naredimo dva grafa, prvi primerja fazne diagrame glede
% na različne začetne odmike, drugi pa glede na različne začetne kotne hitrosti. 

% Vhod:
%     fixed_vars	  vektor fiksih vrednosti, po vrsti: [gravitacija, dolzina nihala, št. podintervalov, čas]
%	initial_angles	  vektor različnih začetnih odmikov
%	dtheta0_values	  vektor različnih začetnih hitrosti

function plot_phase_diagrams(fixed_vars, initial_angles, dtheta0_values)

    % Graf za primerjavo različnih odmikov
    figure;
    for i = 1:length(initial_angles)

        % Inicializacija, začetna kotna hitrost je 0
        theta0 = initial_angles(i);
        dtheta0 = 0;
        
        % Računamo gibanje nihala glede na trenutni začetni odmik
        odmik = nihalo(fixed_vars, theta0, dtheta0);

        theta = odmik(1, :);
        dtheta = odmik(2, :);

        % Narišemo graf
        subplot(2, ceil(length(initial_angles)/2), i);
        plot(theta,dtheta, 'b', 'LineWidth', 1.5);
        xlabel('\theta');
        ylabel('\theta\prime');
        title(['\theta_0 = ', num2str(rad2deg(theta0)), '°']);
        grid on;
        axis equal;
        xlim([-8, 8]);
        ylim([-8, 8]);
        hold on;
     
    end
    sgtitle('Fazni diagrami za različne začetne odmike');

    % Graf za primerjavo različnih kotnih hitrosti
    figure;
    for j = 1:length(dtheta0_values)

        % Inicializacija, začetni odmik je pi/2
        dtheta0 = dtheta0_values(j);
        theta0 = pi / 2;
        
        % Računamo gibanje nihala glede na trenutno začetno hitrost
        odmik = nihalo(fixed_vars, theta0, dtheta0);

        theta = odmik(1, :);
        dtheta = odmik(2, :);

        % Narišemo graf
        subplot(2, ceil(length(dtheta0_values)/2), j);
        plot(theta,dtheta, 'b', 'LineWidth', 1.5);
        xlabel('\theta');
        ylabel('\theta\prime');
        title(['\theta\prime_0 = ', num2str(dtheta0)]);
        grid on;
        axis equal;
        xlim([-8, 8]);
        ylim([-8, 8]);
        hold on;
    end

    sgtitle('Fazni diagrami za različne začetne hitrosti pri \theta_{0}=pi/2');
end
