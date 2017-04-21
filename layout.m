%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%      HEXAGONAL LAYOUT GENERATOR       %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Generate hexagonal grid

radius  = 400;                          % Cell Radius 
nBs     = 37;                           % Number of Base Stations

[X , Y] = baseStationPosition(radius);   
  
hold on
plot(X,Y,'b.');                         % BS center
for i = 1:nBs                           
    [xunit,yunit] = hexagon(X(i),Y(i),radius,0);
    plot(xunit, yunit,'k');             % Hexagonal Cell borders
end

%radiusTot = 7*(sqrt(3)/2*radius)+sqrt(3)/6*radius;
%[xunit,yunit] = hexagon(0,0,radiusTot,pi/2);

%plot(xunit, yunit,'k');                 % Hexagon areaTot

%[x,y]=circle(radiusTot);                % Circle plot
%plot(x,y,'k');

axis equal, zoom on
