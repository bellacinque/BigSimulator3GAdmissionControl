%% Calcolo potenze

%%Potenza ricevuta dalla BS dalla richiesta di ammissione alla rete (Pt max = 2W)
Ptmax = 2;     
h1 = 30;       %height of BS
f =  2000;     %frequency in MHz
std_Dev_dB = 6;%standard deviation between 6 dB and 10 dB in urban environment

%%Path Loss from Okumura Hata formula
PL_dB =  46.33 + (44.9-(6.55*log10(h1)))*log10(Users(:,3)/1000) + 33.9*log10(f) - 13.82*log10(h1);
PL = 10.^(PL_dB/10);

%%Received Power at first request with shadowing
Pr_mean = Ptmax./PL;                   
Pr_mean_dB = 10*log10(Pr_mean); 
shadowing_dB = std_Dev_dB.*randn(nUsers,1); 
Pr_shadowing_dB = Pr_mean_dB + shadowing_dB; 
Users(:,4) = 10.^(Pr_shadowing_dB/10);
%% Potenza trasmessa dall'utente dopo Power Control
Pro = 10^(-13);         %Potenza ricevuta fissata (appena sopra Rx sensitivity, in modo da ricevere correttamente)
Pro_dB = 10*log10(Pro);

% Half compensation PC
% PL_half_dB = 10*log(sqrt(PL));
% Pt_dB = Pro_dB + PL_half_dB - shadowing_dB;

%%full compensation PC
 Pt_dB = Pro_dB + PL_dB - shadowing_dB;

Users(:,5) = 10.^(Pt_dB/10);

%% Limite potenza trasmessa minima e massima
index = Users(:,5)<(4*10^-8);
Users(index,5)=(4*10^-8);
index = find(Users(:,5)>2);
Users(index,5)= 2;

%% Potenza ricevuta dalla BS dopo PC  
Pt_dB = 10*log10(Users(:,5)); 
Pr_dB = Pt_dB - PL_dB + shadowing_dB;
Users(:,6) = 10.^(Pr_dB/10);

%% Potenza ricevuta da tutti gli utenti  % non ha senso un nuovo shadowing per le potenze già calcolate in precedenza: come risolvere?? mbo 
                                         % forse da tenere presente in
                                         % admission control
% matrice avente in (x,y) la potenza ricevuta dall'utente x alla BS y

%%Path Loss from Okumura Hata formula
PL_dB_allUsers =  46.33 + (44.9-(6.55*log10(h1)))*log10(D/1000) + 33.9*log10(f) - 13.82*log10(h1);
PL_allUsers = 10.^(PL_dB_allUsers/10);

    x = zeros(nUsers, nBs);
% for i=1:37
%    x(:,i) = Users(:,5);
% end
% Pr_mean_allUsers = x./PL_allUsers;               
Pr_mean_allUsers = Users(:,5)./PL_allUsers; 

% Considering shadowing I don't take Power Control (that counteracts it)
Pr_mean_allUsers_dB = 10*log10(Pr_mean_allUsers);
 for i=1:nBs
     x(:,i) = std_Dev_dB.*randn(nUsers,1); 
 end
 for i=1:nUsers
     x(i,Users(i,2))=shadowing_dB(i);               %inserisco lo shadowing già calcolato per ogni utente
 end
Pr_withShAllUsers_dB = Pr_mean_allUsers_dB + x;
Pr_withShAllUsers = 10.^(Pr_withShAllUsers_dB/10);

%%

      
