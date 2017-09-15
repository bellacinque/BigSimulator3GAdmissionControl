close all    % Close all open figures
clear        % Reset variables
clc          % Clear the command window

Data=load('1000_8users.txt');
% Data=sortrows(Data,1);

figure1 = figure(1);
plot(Data(:,1),Data(:,2)/100, 'o','LineStyle','-');

hold on; 
grid on;

plot(Data(:,1),Data(:,3)/100,'+','LineStyle','-');

xlabel('I_{max} [W]', 'FontSize', 13);
ylabel('Admission / Outage rate','FontSize', 13);
legend('Admission rate', 'Outage rate');

    title(strcat('R = ', num2str(Data(1,6)),' m, Average users per cell = ', num2str(Data(1,5))));
   