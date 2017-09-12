close all    % Close all open figures
clear        % Reset variables
clc          % Clear the command window

Data=load('KPIptMinLimited_10users_noDirectedRetry.txt');
% Data=sortrows(Data,1);

figure1 = figure(1);
plot(Data(:,1),Data(:,2)/100);

hold on; 
grid on;

plot(Data(:,1),Data(:,3)/100);

xlabel('I_{max} [W]');
ylabel('Adm / Out');
legend('Admission rate', 'Outage rate');

    title(strcat('R = ', num2str(Data(1,6)),' m, Average users per cell = ', num2str(Data(1,5)), ', Pt_{min} = 4*10^8 W'));
   