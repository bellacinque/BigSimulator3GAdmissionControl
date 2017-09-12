%% ADMISSION CONTROL 
%Due cicli: 1)ammissione BS per BS con ext
%             interference iniziale zero
%           2)ammissione considerando l'interferenza esterna
%             degli utenti ammessi alla rete nel ciclo 1

%%
%Primo ciclo di admission control: interferenza inziale zero
Itot = zeros(37,1);    
Ctot = zeros(37,1);
count = zeros(37,1);
Pnoise = zeros(37,1);
 
%Potenza di rumore singolo utente
Pn = 1.38 * 10^-15;  %%Pn= k*Tsys*Rb where k = 1.38*10^-23, Tsys = 1000?K and Rb = 100 Kbit/s for video traffic only.
     
%Potenza ricevuta utenti ammessi BS 
v = randperm(nBs);                          %Vettore permuta indici BS
for i=1:nBs
    %Selezione utenti accampati in BS i
    ind = find(Users(:,2)==v(i));
    UsersCell= Users(ind, :);               %Matrice degli utenti accampati in BS v(i)
    
    %Calcolo interferenza ricevuta dagli utenti ammessi nelle altre BSs
    Interferers = find(Users(:,7)==1); 
    if (~isempty(Interferers))
        Itot(v(i)) = sum(Pr_withShAllUsers(Interferers,v(i)));
        Ctot(v(i)) = 0;
        Pnoise(v(i)) = Pn;
        loadF = 0;
        n=1;
    else
        Itot(v(i)) = 0;
        Users(UsersCell(1,1),7) = 1;        %primo utente sempre ammesso
        Ctot(v(i)) = UsersCell(1,6);
        Pnoise(v(i)) = Pn;
        Ptot = UsersCell(1,6) + Itot(v(i)) + Pnoise(v(i));
        loadF = UsersCell(1,6)/Ptot;
        n=2;
    end

    count(v(i))=0;
    for k=n:length(ind)
        if count(v(i))<31
            %%calcolo interferenza causata da utente k
            deltaI = UsersCell(k,6)/(1-loadF);
            if Itot(v(i))+deltaI < Imax
                %user k is admitted
                Users(UsersCell(k,1),7) = 1;
                Itot(v(i)) = Itot(v(i))+UsersCell(k,6);
                Ctot(v(i)) = Ctot(v(i)) + UsersCell(k,6);
                Pnoise(v(i)) = Pnoise(v(i)) + Pn;
                Ptot = UsersCell(k,6) + Itot(v(i)) + Pnoise(v(i));
                loadFj = UsersCell(k,6)/Ptot;
                loadF = loadF + loadFj;
                count(v(i)) = count(v(i))+1;
            end
        end
    end
end

%%     
%Secondo ciclo: intererferenza iniziale uguale all'interferenza di tutti gli utenti ammessi alla rete nel ciclo 1
    
v = randperm(nBs);                                %Vettore permuta indici BS  
for i=1:nBs
    %Selction of rows correspondent to BS v(i)
    ind = find(Users(:,2)==v(i)); 
    UsersCell= Users(ind, :);                     %Matrice degli utenti accampati in BS i
  
    %Calcolo interferenza ricevuta dagli utenti ammessi nelle altre BSs
    Interferers = find(Users(:,7)==1);
    Itot(v(i))= sum(Pr_withShAllUsers(Interferers,v(i)));      
    
    for k=1:length(ind)
        if count(v(i))<31
            %%calcolo interferenza causata da utente k
            if Users(UsersCell(k,1),7)==0
                Ptot = UsersCell(k,6) + Itot(v(i)) + Pnoise(v(i)) + Pn;
                Ctot(v(i)) = Ctot(v(i)) + UsersCell(k,6);
            else
                Ptot = Itot(v(i)) + Pnoise(v(i));
            end
            loadF = Ctot(v(i))/Ptot;
            deltaI = UsersCell(k,6)/(1-loadF);
            if Itot(v(i))+deltaI < Imax
                %user k is admitted
                if Users(UsersCell(k,1),7)==0   	% se non era ammesso nel ciclo 1 aumento gli indicatori
                    Users(UsersCell(k,1),7) = 1;
                    Itot(v(i))=Itot(v(i))+ UsersCell(k,6);
                    %Ctot(v(i)) = Ctot(v(i)) + UsersCell(k,6);
                    Pnoise(v(i))=Pnoise(v(i)) + Pn;
                    count(v(i))=count(v(i))+1;
                end
            else
                % user k is non admitted
                if Users(UsersCell(k,1),7)==1       % se era stato ammesso nel ciclo 1 decremento gli indicatori
                    Users(UsersCell(k,1),7)= 0;
                    Itot(v(i)) = Itot(v(i)) - UsersCell(k,6);
                    Ctot(v(i)) = Ctot(v(i)) - UsersCell(k,6);
                    Pnoise(v(i)) = Pnoise(v(i))-Pn;
                    count(v(i))=count(v(i))-1;
                end
            end
        else
            Users(UsersCell(k,1),7) = 0;
        end
    end
end
    
%%
%%%%Directed retry

ind = find(Users(:,7)==0);
UsersNotAd = Users(ind,:);
for i=1:length(UsersNotAd(:,1))
    [max,indBS] = sort((Pr_withShAllUsers(UsersNotAd(i,1),:)),'descend'); %%ordina potenze ricevute alla BS da utente  
    
    for j=1:4
        if count(indBS(j))<31
        %%calcolo interferenza causata da utente k
        Ptot = Itot(indBS(j)) + Pnoise(indBS(j));                         %Ptot= potenza ricevuta utente k + Itot + Pnoise
        loadF = Ctot(indBS(j))/Ptot;
        deltaI = max(j)/(1-loadF);
        %Calcolo interferenza ricevuta dagli utenti ammessi nelle altre BSs
        Interferers = find(Users(:,7)==1);
        Itot(indBS(j)) = sum(Pr_withShAllUsers(Interferers,indBS(j)))-max(j);
        
        if Itot(indBS(j))+deltaI < Imax
         Users(UsersNotAd(i,1),7) = 1;      % utente ammesso
         Users(UsersNotAd(i,1),2) = indBS(j);  % utente accampato alla nuova BS
         Pnoise(indBS(j))=Pnoise(indBS(j)) + Pn;
         count(indBS(j))=count(indBS(j))+1;
         Ctot(indBS(j)) = Ctot(indBS(j)) + max(j);
         break;
         end
        end
    end
    
end



%%
%%%Calcolo C/I di ogni utente, risultato in colonna 8 di "Users"
      Interferers = find(Users(:,7)==1);

  for j=1:37
     %Selction of rows correspondent to BS j
     ind = find(Users(:,2)==j);
     UsersCell = Users(ind, :);           %Matrice degli utenti accampati in BS i
     %Calcolo interferenza ricevuta dagli utenti ammessi
     Itot1= sum(Pr_withShAllUsers(Interferers,j));
     for k=1:length(ind)
         %%Calcolo C/I utente
         Users(UsersCell(k,1),8) = abs(Users(UsersCell(k,1),6)/(Itot1-Users(UsersCell(k,1),6)));
     end
  end
   
%%


        
        