function [ x,y ] = circle( radius )
%CIRCLE Summary of this function goes here
%   Detailed explanation goes here
    t=0:0.01:2*pi;                          % cerchio
    x=radius*cos(t); 
    y=radius*sin(t);

end

