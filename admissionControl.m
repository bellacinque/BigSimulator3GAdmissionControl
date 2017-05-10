%% ADMISSION CONTROL 
%Due cicli: 1)ammissione sequenziale a partire da BS numero 1 e ext
%             interference zero
%           2)ammissione sequenziale considerando l'interferenza esterna
%             degli utenti ammessi alla rete nel ciclo 1

%Interferenza massima 
% Imax = 5*10^(-10);
%%
%Primo ciclo di admission control: interferenza inziale zero
 Itot = zeros(37,1);    
 Ctot = zeros(37,1);    %Potenza ricevuta utenti ammessi BS 
 v = randperm(nBs);     %Vettore permuta indici BS
 for i=1:nBs
     %Selezione utenti accampati in BS i
     ind = Users(:,2)==v(i);
     UsersCell= Users(ind, :);           %Matrice degli utenti accampati in BS i
     Users(UsersCell(1,1),7) = 1;        %primo utente sempre ammesso
     %Potenza ricevuta da utenti ammessi nella BS i
     Ctot(v(i),1) = UsersCell(1,6); 
     %Calcolo interferenza ricevuta dagli utenti ammessi nelle altre BSs
     Interferers = find(Users(:,7)==1);
     Itot(v(i)) = sum(Pr_withShAllUsers(Interferers,v(i)));
          
     %Potenza di rumore singolo utente
     Pn = 1.38 * 10^-15;  %%Pn= k*Tsys*Rb where k = 1.38*10^-23, Tsys = 1000?K and Rb = 100 Kbit/s for video traffic only.
     Pnoise= 2*Pn;    %dubbio ???????
     
     count=0;
     for k=2:length(UsersCell(:,1))
         if count<31
         %%calcolo interferenza causata da utente k
          Ptot = UsersCell(k,6) + Itot(v(i)) + Pnoise;                         %Ptot= potenza ricevuta utente k + Itot + Pnoise
          loadF = (UsersCell(k,6)+Ctot(v(i),1))/Ptot;
          deltaI = UsersCell(k,6)/(1-loadF);
            if Itot(v(i))+deltaI < Imax
             %user k is admitted
             Users(UsersCell(k,1),7) = 1;
             Itot(v(i)) = Itot(v(i))+UsersCell(k,6);
             Ctot(v(i)) = Ctot(v(i)) + UsersCell(k,6);
             Pnoise = Pnoise + Pn;
             count = count+1;
            end
         end
     end 
 end

%%     
%Secondo ciclo: intererferenza iniziale uguale all'interferenza di tutti
%               gli utenti ammessi alla rete nel ciclo 1
    v = randperm(nBs);     %Vettore permuta indici BS  
    Ctot = zeros(37,1);    %Potenza ricevuta utenti ammessi BS 
    count = zeros(37,1);
    
    for i=1:37
     %Selction of rows correspondent to BS i
     ind = Users(:,2)==v(i);
     UsersCell= Users(ind, :);           %Matrice degli utenti accampati in BS i
     %Potenza ricevuta da utenti ammessi nella BS i
     Ctot(v(i),1) = UsersCell(1,6); 
     %Calcolo interferenza ricevuta dagli utenti ammessi nelle altre BSs
     Interferers = find(Users(:,7)==1);
     Itot(v(i))= sum(Pr_withShAllUsers(Interferers,v(i)))-sum(Pr_withShAllUsers(UsersCell(:,1),v(i)));
     %Potenza di rumore singolo utente(stessa banda per ogni utente)
     Pn=1.38*10^(-15);
     Pnoise(v(i))=2*Pn;
     
     for k=1:length(UsersCell(:,1))
         if count(v(i))<31
         %%calcolo interferenza causata da utente k
          Ptot = UsersCell(k,6) + Itot(v(i)) + Pnoise(v(i));                         %Ptot= potenza ricevuta utente k + Itot + Pnoise
          loadF = (UsersCell(k,6)+Ctot(v(i)))/Ptot;
          deltaI = UsersCell(k,6)/(1-loadF);
             if Itot(v(i))+deltaI < Imax
                 %user k is admitted
                 Users(UsersCell(k,1),7) = 1;
                 Itot(v(i))=Itot(v(i))+UsersCell(k,6);
                 Pnoise(v(i))=Pnoise(v(i)) + Pn;
                 count(v(i))=count(v(i))+1;
             else
                 Users(UsersCell(k,1),7) = 0;
             end 
         else 
             Users(UsersCell(k,1),7) = 0;
         end
     end
    end
    
%%
%%%%Directed retry

ind = find(Users(:,7)==0);
%Utilizzo UsersCell ma non sono gli utenti della cella, bens? gli utenti
%non ammessi
UsersNotAd = Users(ind,:);
for i=1:length(UsersNotAd(:,1))
    [max,indBS] = sort((Pr_withShAllUsers(UsersNotAd(i,1),:)),'descend'); %%ordina potenze ricevute alla BS da utente  
    
    for j=1:4
        if count(indBS(j))<32
        %%calcolo interferenza causata da utente k
        Ptot = max(j) + Itot(indBS(j)) + Pnoise(indBS(j));                         %Ptot= potenza ricevuta utente k + Itot + Pnoise
        loadF = (Ctot(indBS(j))+max(j))/Ptot;
        deltaI = max(j)/(1-loadF);
        %Calcolo interferenza ricevuta dagli utenti ammessi nelle altre BSs
        Interferers = find(Users(:,7)==1);
        Itot(indBS(j)) = sum(Pr_withShAllUsers(Interferers,indBS(j)));
        
        if Itot(indBS(j))+deltaI < Imax
         Users(UsersNotAd(i,1),7) = 1;      % utente k ammesso
         Users(UsersNotAd(i,1),2) = indBS(j);  % utente accampato alla nuova BS
         Pnoise(indBS(j))=Pnoise(indBS(j)) + Pn;
         count(indBS(j))=count(indBS(j))+1;
         break;
         end
        end
    end
    
end



%%
%%%Calcolo C/I di ogni utente, risultato in colonna 8 di "Users"

  for j=1:37
     %Selction of rows correspondent to BS i
     ind = Users(:,2)==j;
     UsersCell = Users(ind, :);           %Matrice degli utenti accampati in BS i
     %Calcolo interferenza ricevuta dagli utenti ammessi nelle altre BSs
     Interferers = find(Users(:,7)==1);
     Itot= sum(Pr_withShAllUsers(Interferers,j));
     for k=1:length(UsersCell(:,1))
         %%Calcolo C/I utente
         Users(UsersCell(k,1),8) = abs(Users(UsersCell(k,1),6)/(Itot-Users(UsersCell(k,1),6)));
     end
  end
   
%%


        
        