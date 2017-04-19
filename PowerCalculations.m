%% Calcolo potenze

%% MATRICE USERS
% Matrice con: numero utente|Bs in cui ? accampato|distanza da Bs in cui ?
%%accampato |Pr before PC|Ptx after PC|Pr|admission y or n               
%Users = zeros(length(D),7);                
%Users(:,1)= 1:length(D);
    
%%Calcolo BS a distanza minima rispetto all' utente
%    for i=1:length(D)
%        cellIndex=1;
%          minDistance= D(i,1);
%        for j=1:nBs    
%            if D(i,j)< minDistance
%            minDistance=D(i,j);
%            cellIndex = j;
%            end
%        end
%      Users(i,2)= cellIndex;             %Salvo indice BS
%      Users(i,3)= minDistance;           %Salvo distanza utente-BS
%    end
    
%%Potenza ricevuta dalla BS dalla richiesta di ammissione alla rete (Pt max = 2W)
Ptmax = 2;
h1 = 30;       %height of BS
f =  2000;     %frequency in MHz

%%Path Loss from Okumura Hata formula
PL_dB =  46.33 + (44.9-(6.55*log10(h1)))*log10(Users(:, 3)/1000) + 33.9*log10(f) - 13.82*log10(h1);
PL = 10.^(PL_dB/10);
%%Received Power at first request
Users(:,4) = Ptmax./PL;                   %%%AGGIUNGERE SHADOWING

%%Considering Shadowing with standard deviation between 6 dB and 10 dB in
%%urban environment.

% Pr_mean_dB = 10^(Users(:,4)./10); 
% 
% std_Dev_dB = 8;
% 
% %%Generate values from a normal distribution with mean Pr_mean_dB
%         %%and standard deviation std_Dev_dB (for .
% 
% Pr_shadowing_dB = Pr_mean_dB + std_Dev_dB.*randn(D,1);


%%Potenza trasmessa dall'utente dopo Power Control 
Pro = 10^(-13);         %Potenza ricevuta fissata (appena sopra Rx sensitivity, in modo da ricevere correttamente)
Users(:,5) = Pro.*PL;

%%Potenza ricevuta dalla BS dopo PC 
Users(:,6)= Users(:,5)./PL;                     %% ?! = Pro  
  
%% Potenza ricevuta da tutti gli utenti
% matrice avente in (x,y) la potenza ricevuta dall'utente x alla BS y

%%Path Loss from Okumura Hata formula
PL_dB_allUsers =  46.33 + (44.9-(6.55*log10(h1)))*log10(D/1000) + 33.9*log10(f) - 13.82*log10(h1);
PL_allUsers = 10.^(PL_dB_allUsers/10);

%    x = zeros(length(D), 37);
%for i=1:37
%    x(:,i) = Users(:,5);
%end
%Pr_allUsers = x./PL_allUsers;               
Pr_allUsers = (Users(:,5)./PL_allUsers); 
%%

