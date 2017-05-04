%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%      BIG BIG SIMULATOR       %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all    % Close all open figures
clear        % Reset variables
clc          % Clear the command window

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%variables
radius  = 35;                          % Cell Radius 
nCycles = 1000;

nUsersTotRif     = 0;
AdmittedUsersTot = 0;

baseStationGeneration;
%layout;                               % Plot layout

for iterator=1:nCycles
    
    usersGeneration; %plot(usersPositionX,usersPositionY,'o');
    PowerCalculations;
    admissionControl;
    
    KPIsCycle;
    
end

AdmissionPerc = 100*AdmittedUsersTot/nUsersTotRif;
fprintf('%s%d\n%s%f\n','UtentiTOT ammessi BS di riferimento: ', AdmittedUsersTot,'Percentuale UtentiTOT ammessi BS di riferimento: ', AdmissionPerc);

%plot per vedere i valori di c/i
%plot(Users(:,1),Users(:,8),'ob');




