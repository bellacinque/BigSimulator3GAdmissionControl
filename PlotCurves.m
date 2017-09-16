close all    % Close all open figures
clear        % Reset variables
clc          % Clear the command window

%Data=load('ImaxAllUsers_100.txt');
% Data=sortrows(Data,1);

% figure1 = figure(1);
% plot(Data(:,1),Data(:,2)/100, 'o','LineStyle','-');
% 
% hold on; 
% grid on;
% 
% plot(Data(:,1),Data(:,3)/100,'+','LineStyle','-');
% 
% xlabel('I_{max} [W]', 'FontSize', 13);
% ylabel('Admission / Outage rate','FontSize', 13);
% legend('Admission rate', 'Outage rate');
% 
%     title(strcat('R = ', num2str(Data(1,6)),' m, Average users per cell = ', num2str(Data(1,5))));



%%%%%%%%%%%%%%%%%%
%% Plot curve admission with different average users 
% 
% I =  dlmread('ImaxAllUsers_100.txt','\t','A1..A10');
% users8 = dlmread('ImaxAllUsers_100.txt','\t','B1..B10');
% users16 = dlmread('ImaxAllUsers_100.txt','\t','B11..B20');
% users24 = dlmread('ImaxAllUsers_100.txt','\t','B21..B30');
% users32 = dlmread('ImaxAllUsers_100.txt','\t','B31..B40');
% 
% figure1 = figure(1);
% plot(I, users8/100,'o','LineStyle','-');
% hold on; 
% plot(I, users16/100,'+','LineStyle','-');
% hold on; 
% plot(I, users24/100,'>','LineStyle','-');
% hold on; 
% plot(I, users32/100,'<','LineStyle','-');
% 
% 
% xlabel('I_{max} [W]', 'FontSize', 13);
% ylabel('Admission rate','FontSize', 13);
% legend('8 users/cell','16 users/cell','24 users/cell','32 users/cell');
% %title('Admission');

%% Plot curve outage with different average users 

% I =  dlmread('ImaxAllUsers_100.txt','\t','A1..A10');
% users8 = dlmread('ImaxAllUsers_100.txt','\t','C1..C10');
% users16 = dlmread('ImaxAllUsers_100.txt','\t','C11..C20');
% users24 = dlmread('ImaxAllUsers_100.txt','\t','C21..C30');
% users32 = dlmread('ImaxAllUsers_100.txt','\t','C31..C40');
% 
% figure1 = figure(1);
% plot(I, users8/100,'o','LineStyle','-');
% hold on; 
% plot(I, users16/100,'+','LineStyle','-');
% hold on; 
% plot(I, users24/100,'>','LineStyle','-');
% hold on; 
% plot(I, users32/100,'<','LineStyle','-');
% 
% 
% xlabel('I_{max} [W]', 'FontSize', 13);
% ylabel('Outage rate','FontSize', 13);
% legend('8 users/cell','16 users/cell','24 users/cell','32 users/cell');
% %title('Admission');

%% Plot curves Directed/no directed
% Dir = load('Imax8_100.txt');
% noDir = load('100_8users.txt');
% 
% figure1 = figure(1);
% plot(Dir(:,1),Dir(:,2)/100,'o','LineStyle','-');
% hold on; 
% plot(noDir(:,1),noDir(:,2)/100,'>','LineStyle','-');
% 
% xlabel('I_{max} [W]', 'FontSize', 13);
% ylabel('Outage rate','FontSize', 13);
% legend('Admission','Admission - no DR');
% 
% title(strcat('R = ', num2str(Dir(1,6)),' m, Average users per cell = 8 '));
% figure2 = figure(2);
% plot(Dir(:,1),Dir(:,3)/100,'+','LineStyle','-');
% hold on; 
% plot(noDir(:,1),noDir(:,3)/100,'<','LineStyle','-');
% xlabel('I_{max} [W]', 'FontSize', 13);
% ylabel('Outage rate','FontSize', 13);
% legend('Outage','Outage - no DR');
% title(strcat('R = ', num2str(Dir(1,6)),' m, Average users per cell = 8 '));


%% Plot curves varying Area

Data = load('Imax8_100.txt');
Data2 = load('Imax8_500.txt');
Data3 = load('Imax8_1000.txt');

figure1 = figure(1);

plot(Data(:,1),Data(:,2)/100,'o','LineStyle','-');
hold on; 
plot(Data(:,1),Data2(:,2)/100,'>','LineStyle','-');
hold on;
plot(Data(:,1),Data3(:,2)/100,'+','LineStyle','-');

xlabel('I_{max} [W]', 'FontSize', 13);
ylabel('Admission rate','FontSize', 13);
legend('1E every 100m^2, R = 18m','1E every 500m^2,  R = 39m','1E every 1000m^2, R = 55m');

figure2 = figure(2);

plot(Data(:,1),Data(:,3)/100,'o','LineStyle','-');
hold on; 
plot(Data(:,1),Data2(:,3)/100,'>','LineStyle','-');
hold on;
plot(Data(:,1),Data3(:,3)/100,'+','LineStyle','-');

xlabel('I_{max} [W]', 'FontSize', 13);
ylabel('Outage rate','FontSize', 13);
legend('1E every 100m^2, R = 18m','1E every 500m^2,  R = 39m','1E every 1000m^2, R = 55m');

%title(strcat('R = ', num2str(Dir(1,6)),' m, Average users per cell = 8 '));

