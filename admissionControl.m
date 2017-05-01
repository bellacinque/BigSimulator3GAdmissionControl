%% ADMISSION CONTROL 
%Due cicli: 1)ammissione sequenziale a partire da BS numero 1 e ext
%             interference zero
%           2)ammissione sequenziale considerando l'interferenza esterna
%             degli utenti ammessi alla rete nel ciclo 1

%Interferenza massima 
Imax= 5*10^(-11);
%%
 Itot=0;    %Primo ciclo di admission control: interferenza inziale zero
 loadF = zeros(37,1);        %load factor
 v = randperm(nBs);     %Vettore permuta indici BS
 
 for j=1:nBs
     
     %Selction of rows correspondent to BS i
     ind = Users(:,2)==v(j);
     UsersCell= Users(ind, :);           %Matrice degli utenti accampati in BS i
     %primo utente sempre ammesso
     Users(UsersCell(1,1),7) = 1;
     %Calcolo interferenza ricevuta dagli utenti ammessi nelle altre BSs
     Interferers = find(Users(:,7)==1);
     Itot= sum(Pr_withShAllUsers(Interferers,v(j)));
     %Itot= Itot+ UsersCell(1,6);     %aggiunta di interferenza causata da utente 1
     %potenza di rumore singolo utente
     %%Pn= k*Tsys*Rb where k = 1.38*10^-23, Tsys = 1000?K and Rb = 100 Kbit/s for video traffic only.
     Pn = 1.38 * 10^-15;  %% Power in Watt
     Pnoise= Pn;
     %Potenza totale ricevuta 
     Ptot= Itot+Pn;
     
     count=0;
     for k=2:length(UsersCell(:,1))
         if count<32
         %%calcolo interferenza causata da utente k
          Ptot = UsersCell(k,6) + Itot + Pnoise;                         %Ptot= potenza ricevuta utente k + Itot + Pnoise
          loadF(v(j)) = loadF(v(j))+UsersCell(k,6)/Ptot;
          deltaI = UsersCell(k,6)/(1-loadF(v(j)));
     if Itot+deltaI < Imax
         %user k is admitted
         Users(UsersCell(k,1),7) = 1;
         Itot=Itot+UsersCell(k,6);
         Pnoise=Pnoise + Pn;
         count= count+1;
     end
     
         end
     end
     
 end

%%     
%Secondo ciclo: intererferenza iniziale uguale all'interferenza di tutti
%               gli utenti ammessi alla rete nel ciclo 1
    v = randperm(nBs);     %Vettore permuta indici BS  
    loadF = zeros(37,1);      %load factor
    count = zeros(37,1);

    for j=1:37
     %Selction of rows correspondent to BS i
     ind = Users(:,2)==v(j);
     UsersCell= Users(ind, :);           %Matrice degli utenti accampati in BS i
     %Calcolo interferenza ricevuta dagli utenti ammessi nelle altre BSs
     Interferers = find(Users(:,7)==1);
     Itot= sum(Pr_withShAllUsers(Interferers,v(j)))-sum(Pr_withShAllUsers(UsersCell(:,1),v(j)));
     %Potenza di rumore singolo utente(stessa banda per ogni utente)
     Pn=1.38*10^(-15);
     Pnoise(v(j))=Pn;
     %Potenza totale ricevuta 
     Ptot= Itot+Pn;
     
     for k=1:length(UsersCell(:,1))
         
         if count(v(j))<32
         %%calcolo interferenza causata da utente k
          Ptot = UsersCell(k,6) + Itot + Pnoise(v(j));                         %Ptot= potenza ricevuta utente k + Itot + Pnoise
          loadF(v(j)) = loadF(v(j))+UsersCell(k,6)/Ptot;
          deltaI = UsersCell(k,6)/(1-loadF(v(j)));
     if Itot+deltaI < Imax
         %user k is admitted
         Users(UsersCell(k,1),7) = 1;
         Itot=Itot+UsersCell(k,6);
         Pnoise(v(j))=Pnoise(v(j)) + Pn;
         count(v(j))=count(v(j))+1;
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
%%Utilizzo UsersCell ma non sono gli utenti della cella, bens? gli utenti
%%non ammessi
UsersNotAd = Users(ind,:);
for i=1:length(UsersNotAd)
    [max,ind1] = sort((Pr_withShAllUsers(UsersNotAd(i,1),:)),'descend'); %%ordina potenze ricevute alla BS da utente  
    
    for j=1:4
        if count(ind1(j))<32
        %%calcolo interferenza causata da utente k
        Ptot = max(j) + Itot + Pnoise(ind1(j));                         %Ptot= potenza ricevuta utente k + Itot + Pnoise
        loadF(ind1(j)) = loadF(ind1(j))+max(j)/Ptot;
        deltaI = max(j)/(1-loadF(ind1(j)));
        %Calcolo interferenza ricevuta dagli utenti ammessi nelle altre BSs
        Interferers = find(Users(:,7)==1);
        Itot= sum(Pr_withShAllUsers(Interferers,ind1(j)));
        
        if Itot+deltaI < Imax
         Users(UsersNotAd(i,1),7) = 1;      %user k is admitted
         Pnoise(ind1(j))=Pnoise(ind1(j)) + Pn;
         count(ind1(j))=count(ind1(j))+1;
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
     UsersCell= Users(ind, :);           %Matrice degli utenti accampati in BS i
     %Calcolo interferenza ricevuta dagli utenti ammessi nelle altre BSs
     Interferers = find(Users(:,7)==1);
     Itot= sum(Pr_withShAllUsers(Interferers,j));
     count=0;                                   %?!?!?!
     for k=1:length(UsersCell(:,1))
         %%Calcolo C/I utente
         Users(UsersCell(k,1),8) = Users(UsersCell(k,1),6)/(Itot-Users(UsersCell(k,1),6));
     end
  end
   
%%


        
        