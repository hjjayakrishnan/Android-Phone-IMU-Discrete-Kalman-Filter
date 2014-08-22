function [buffer] = imu_receive
clc
clear all

k=1;
temp=zeros(1,9);
   
 Y = judp('RECEIVE',5555,200);
 Y(Y==44) = ' ' % Make separator be a space.
 temp  = cell2mat(textscan(char(Y),'%f'));
 temp = temp.';
   
    for m=1:5
       x(k,m)=temp(m);                         
    end
    
 buffer = x(k,5);      
 k=k+1; 
 
end
           