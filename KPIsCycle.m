%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%KPIs cycle

%Calcolo utenti ammessi
%AdmittedUsers = sum(Users(:,7));
%Percentuale di utenti ammessi
%Percentage = AdmittedUsers/nUsers;

%fprintf('%s%d\n%s%d\n%s%f\n','Cycle ',nCycles,'Utenti ammessi totali: ', AdmittedUsers,'Percentuale utenti totale: ', Percentage);
    
%KPI Base stations di riferimento
ind = find(Users(:,2)<8);
nUsersRif = length(ind);
AdmittedUsers = sum(Users(ind,7));

Percentage = AdmittedUsers/length(ind);
fprintf('%s%d\n%s%d\n%s%f\n','Cycle ',iterator,'Utenti ammessi BS di riferimento: ', AdmittedUsers,'Percentuale utenti ammessi BS di riferimento: ', Percentage);

nUsersTotRif = nUsersTotRif + nUsersRif;
AdmittedUsersTot = AdmittedUsersTot + AdmittedUsers;