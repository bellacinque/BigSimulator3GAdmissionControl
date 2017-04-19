function [xunit,yunit] = hexagon(x,y,r,angle)
    % Compute hexagon vertices
    th = angle:pi/3:2*pi+angle;
    xunit = round(r * cos(th) + x);
    yunit = round(r * sin(th) + y);
end