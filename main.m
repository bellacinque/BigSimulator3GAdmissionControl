%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%      BIG BIG SIMULATOR       %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all    % Close all open figures
clear        % Reset variables
clc          % Clear the command window

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%variables
nCycles = 100;
areaErl = 100;                                  % 1 Erlang ogni areaErl metri quadri
radius = round(sqrt((31 * areaErl * 2)/(3 * sqrt(3))));
%radius = 20;
Imax = 10^(-10);

% % Cicli densit? utenti variabile
% for areaErl=100:200:2000
%    radius = sqrt((31 * areaErl)/pi);          % Cell radius (calcolo raggio dalla densit?)


% % Cicli Interferenza di soglia
% Interferenze = [5*10^(-13),10^(-12) , 5*10^(-12), 10^(-11), 5*10^(-11)];
% for j=1:length(Interferenze)   
%     Imax = Interferenze(j);


nUsersTotRif     = 0;
AdmittedUsersTot = 0;
eventsCountTot   = 0; %Initialization of outage events for outage rate computation

baseStationGeneration;
%layout;                               % Plot layout

for iterator=1:nCycles
    
    usersGeneration; %plot(usersPositionX,usersPositionY,'o');
    PowerCalculations;
    admissionControl;
    KPIsCycle;
    
end

%plot(usersPositionX,usersPositionY,'o');    %plot users ultimo ciclo

AdmissionPerc = 100*AdmittedUsersTot/nUsersTotRif;
OutageRateTot  = eventsCountTot/AdmittedUsersTot;
NetworkLoadTot = AdmittedUsersTot/(31*7*nCycles);

fprintf('%s%d\n','Average utenti presenti in ogni BS di riferimento: ', round(nUsersTotRif/7));
fprintf('%s%d\n','UtentiTOT ammessi BS di riferimento: ', AdmittedUsersTot);
fprintf('%s%f%%\n','Percentuale UtentiTOT ammessi BS di riferimento: ', AdmissionPerc);
fprintf('%s%f%%\n','Network Load related to reference cells over all cycles: ',NetworkLoadTot*100);
fprintf('%s%f%%\n','Outage Rate related to reference cells over all cycles: ', OutageRateTot*100);

%plot per vedere i valori di c/i
%plot(Users(:,1),Users(:,8),'ob');

% Print to file
% Remove the comments to print in an output file
% filename = 'KPIpotMinNotLimited.txt';
% fid = fopen(filename,'at');
% fprintf(fid,'%d\t%f\t%f\t%f\n', Imax, AdmissionPerc ,OutageRateTot*100, NetworkLoadTot*100);
% fclose(fid);


