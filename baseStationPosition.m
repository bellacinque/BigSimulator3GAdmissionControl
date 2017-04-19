function [xunit,yunit] = baseStationPosition(radius)
    
    xunit = zeros(37,1);                    %Allocazione del vettore x
    yunit = zeros(37,1);                    %Allocazione del vettore y
    xunit(1) = 0;                           %la prima base station è centrata nel punto [0,0]
    yunit(1) = 0;
    
    %% Base stations 1st tier
    r=sqrt(3)*radius;                       %raggio 1st tier
    j=2;                                    %j=indice vettore
    for th= pi/2:pi/3:7/3*pi                
        xunit(j) = round( r * cos(th) );
        yunit(j) = round( r * sin(th) );
        j=j+1;
    end
    
    %% Base stations 2st tier
    r2=sqrt(3)*2*radius;                     %raggio 2st tier
    k1=j;                                    %salva variabile contatore
    for th= pi/2:pi/3:7/3*pi                
        xunit(j) = round( r2 * cos(th) );
        yunit(j) = round( r2 * sin(th) );
        j=j+2;
    end
    j=k1+1;
    r2=3*radius;                             %raggio 2st tier delle base station più vicine al centro
    for th = 2/3*pi:pi/3:7/3*pi
        xunit(j) = round( r2 * cos(th) );
        yunit(j) = round( r2 * sin(th) );
        j=j+2;
    end
    
    %% Base stations 3st tier
    k2=j;
    j=j-1;
    r3=sqrt(3)*3*radius;                            %raggio 3st tier

    for th= pi/2:pi/3:7/3*pi
        xunit(j) = round( r3 * cos(th) );
        yunit(j) = round( r3 * sin(th) );
        j=j+3;
    end
    j=k2;
    r3=sqrt((4.5*radius)^2+(sqrt(3)/2*radius)^2);   %raggio 3st tier delle base station più vicine al centro
    angle1=asin(1.5*radius/r3);
    for th= pi/2+angle1:pi/3:(2*pi)+(pi/2)
        xunit(j) = round( r3 * cos(th) );
        yunit(j) = round( r3 * sin(th) );
        j=j+3;
    end
    j=k2+1;
    angle2=asin(3*radius/r3);
    for th= pi/2+angle2:pi/3:(2*pi)+(pi/2)
        xunit(j) = round( r3 * cos(th) );
        yunit(j) = round( r3 * sin(th) );
        j=j+3;
    end

end

%plot(xunit, yunit,'o');

    
    
