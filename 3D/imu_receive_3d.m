function [buffer_x ,buffer_y, buffer_z] = imu_receive_3d()
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
    
 buffer_z = x(k,3);
 buffer_y = x(k,4);
 buffer_x = x(k,5);      
 
 
end
           