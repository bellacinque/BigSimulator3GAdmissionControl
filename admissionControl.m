%% ADMISSION CONTROL 
%Due cicli: 1)ammissione sequenziale a partire da BS numero 1 e ext
%             interference zero
%           2)ammissione sequenziale considerando l'interferenza esterna
%             degli utenti ammessi alla rete nel ciclo 1

%Interferenza massima 
Imax= 10^(-11);
%%
%Primo ciclo di admission control: interferenza inziale zero
 Itot=0;
 
 for i=1:37
     
     %Selction of rows correspondent to BS i
     ind = Users(:,2)==i;
     UsersCell= Users(ind, :);           %Matrice degli utenti accampati in BS i
     %primo utente sempre ammesso
     Users(UsersCell(1,1),7) = 1;
     %Calcolo interferenza ricevuta dagli utenti ammessi nelle altre BSs
     Interferers = find(Users(:,7)==1);
     Itot= sum(Pr_allUsers(Interferers,i));
     %Itot= Itot+ UsersCell(1,6);     %aggiunta di interferenza causata da utente 1
     %potenza di rumore singolo utente
     %%Pn= k*Tsys*Rb where k = 1.38*10^-23, Tsys = 1000°K and Rb = 100 Kbit/s for video traffic only.
     Pn = 1.38 * 10^-15;  %% Power in Watt
     Pnoise= Pn;
     %Potenza totale ricevuta 
     Ptot= Itot+Pn;
     %load factor
     loadF = 0;
   
     count=0;
     for k=2:length(UsersCell)
         if count<32
         %%calcolo interferenza causata da utente k
          Ptot = UsersCell(k,6) + Itot + Pnoise;                         %Ptot= potenza ricevuta utente k + Itot + Pnoise
          loadF = loadF+UsersCell(k,6)/Ptot;
          deltaI = UsersCell(k,6)/(1-loadF);
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
      
    for i=1:37
     %Selction of rows correspondent to BS i
     ind = Users(:,2)==i;
     UsersCell= Users(ind, :);           %Matrice degli utenti accampati in BS i
     %Calcolo interferenza ricevuta dagli utenti ammessi nelle altre BSs
     Interferers = find(Users(:,7)==1);
     Itot= sum(Pr_allUsers(Interferers,i))-sum(Pr_allUsers(UsersCell(:,1),i));
     %Potenza di rumore singolo utente(stessa banda per ogni utente)
     Pn=10^(-15);
     Pnoise=Pn;
     %Potenza totale ricevuta 
     Ptot= Itot+Pn;
     %load factor
     loadF = 0;
    
     count=0;
     for k=1:length(UsersCell)
         
         if count<32
         %%calcolo interferenza causata da utente k
          Ptot = UsersCell(k,6) + Itot + Pnoise;                         %Ptot= potenza ricevuta utente k + Itot + Pnoise
          loadF = loadF+UsersCell(k,6)/Ptot;
          deltaI = UsersCell(k,6)/(1-loadF);
     if Itot+deltaI < Imax
         %user k is admitted
         Users(UsersCell(k,1),7) = 1;
         Itot=Itot+UsersCell(k,6);
         Pnoise=Pnoise + Pn;
         count=count+1;
     else
         Users(UsersCell(k,1),7) = 0;
     end 
         else 
             Users(UsersCell(k,1),7) = 0;
         end
     end
    end
    
    
        
        