%% Generazione utenti

%meanUsers = 32;                                             %numero medio utenti per esagono                                                %numero di esagoni
radiusTot = 7*(sqrt(3)/2*radius);

areaQ = (2*radiusTot)^2;                                    %area quadrato su cui vengono generati gli users
areaHex = (radius^2)*3*sqrt(3)/2;                           %area singolo esagono
areaCircle = pi*radius^2;                                   %area cerchio circoscritto esagono
areaPlus= (areaCircle-areaHex)/3;
areaTot = nBs*(areaHex+areaPlus);                           %area totate esagoni + area esterna

nUsers = round(areaTot/100);                                %n.utenti fissata la densit?
%nUsers = round((meanUsers*nBs)*areaQ/areaTot);  %numero di users da generare per avere 32users di media all'interno degli esagoni

% generazione su un quadrato
usersPositionX = -radiusTot + (radiusTot-(-radiusTot)).*rand(nUsers,1);
usersPositionY = -radiusTot + (radiusTot-(-radiusTot)).*rand(nUsers,1);

% generazione su un cerchio
%angle = (2*pi).*rand(1184,1);
%r = -radiusTot + (2*radiusTot).*rand(1184,1);
%usersPositionX=r.*cos(angle); 
%usersPositionY=r.*sin(angle);

%plot(usersPositionX,usersPositionY,'o');

%% Calcolo distanze di ogni utente da tutte le base stations e scarto degli utenti fuori dagli esagoni

D       =   zeros(nUsers,nBs);
index   =   ones(nUsers,1);

% MATRICE USERS
% Matrice con: numero utente|Bs in cui ? accampato|distanza da Bs in cui ?
%%accampato |Pr before PC|Ptx after PC|Pr|admission y or n 
Users = zeros(length(D(:,1)),8);

for i=1:nUsers
    cellIndex=1;
    minDistance= radius;
    for j=1:nBs
        D(i,j)=sqrt((abs(usersPositionX(i)-X(j)))^2+(abs(usersPositionY(i)-Y(j)))^2);
        if D(i,j)< minDistance
            minDistance=D(i,j);
            cellIndex = j;
            index(i)=0;                                     %indice utenti buoni
        end
    end
    Users(i,2)= cellIndex;             %Salvo indice BS
    Users(i,3)= minDistance;           %Salvo distanza utente-BS
end

index = logical(index);                                     %vettore convertito in boolean   

D(index,:)=[];                                              %scarto dalla matrice gli utenti indesiderati
nUsers=length(D);                                           %aggiorno numero corretto utenti
Users(index,:)=[];
Users(:,1)= 1:nUsers;

usersPositionX(index)=[];                                   %scarto utenti con index(i)=1
usersPositionY(index)=[];

%plot(usersPositionX,usersPositionY,'o');







