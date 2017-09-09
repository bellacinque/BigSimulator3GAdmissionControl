%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%KPIs cycle
  
%KPI Base stations di riferimento
ind = find(Users(:,2)<8);                   % find tutti gli utenti nelle base station di riferimento
nUsersRif = length(ind);
AdmittedUsers = sum(Users(ind,7));
out_events = find(Users(:,2)<8 &  Users(:,8)<CImin & Users(:,7)==1); %vector with users of 7 cells in outage condition(C/I <C/I*)

nUsersTotRif = nUsersTotRif + nUsersRif;
AdmittedUsersTot = AdmittedUsersTot + AdmittedUsers;
eventsCountTot = eventsCountTot + length(out_events);




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%Computation of the Outage Rate for 3G system considering the number of
%%reference BTSs
%%N? of outage events/N? of Admitted Users (for each BTS)
%%Outage event <-> C/I < C/I*(for each BTS)

% rate_out = zeros(1,7); %% vector containing the outage rates for the reference cells
% 
% for j = 1:7  %%for the number of reference BTSs
% 
% %%eventsCount = number of outage events
% eventsCount=0;
% %step 1 -> find admitted users for the specific BS
% 
% bsRows = find(Users(:,2)==j & Users(:,7)==1); %rows of Users satisfying conditions
% 
% %step 2 -> Compute the number of outage events taking into account the
% %admitted users of a BS
% for i = 1:length(bsRows)
% if (Users(bsRows(i),8) < 0.2)
%     eventsCount = eventsCount+1;
% end    
% end
% 
% %step 3 -> Compute the outage rate for that BS
% rate_out(j) = eventsCount/length(bsRows);
% 
% end
% 
% % for k=1:length(rate_out)
% %     fprintf('\n%s%d%s%d\n','Outage Rate for cell ',k,': ',rate_out(k));
% % end
%%%%%%%%%%%%%%%%%
%Number of outage events related to the 7 reference cells over all the
%cycles
%eventsCountTot = number of outage events over all the cycles for the 7
%cells


%%%%%%%%
%Network Load = Number of users admitted in the 7 reference cells/number of
%RU in the 7 cells for a cycle

%admittedUsersRefCells = length(find(Users(:,2)<8 & Users(:,7)==1));
%network_load = admittedUsersRefCells/224; %network load where 224 = 32*7 = total number of Rus in the 7 cells
%fprintf('\n%s%.0f%%\n','Network Load(Percentage) :',network_load*100);
