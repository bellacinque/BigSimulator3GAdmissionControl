%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%      BIG BIG SIMULATOR       %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all    % Close all open figures
clear        % Reset variables
clc          % Clear the command window

layout;
usersGeneration;
PowerCalculations;
admissionControl;

%Calcolo utenti ammessi
AdmittedUsers = sum(Users(:,7));
%Percentuale di utenti ammessi
Percentage = AdmittedUsers/nUsers;

fprintf('%s%d\n%s%f\n','Utenti ammessi totali: ', AdmittedUsers,'Percentuale utenti totale: ', Percentage);
    
%KPI Base stations di riferimento
ind = find(Users(:,2)<8);
AdmittedUsers = sum(Users(ind,7));

Percentage = AdmittedUsers/length(ind);
fprintf('%s%d\n%s%f\n','Utenti ammessi BS di riferimento: ', AdmittedUsers,'Percentuale utenti ammessi BS di riferimento: ', Percentage);