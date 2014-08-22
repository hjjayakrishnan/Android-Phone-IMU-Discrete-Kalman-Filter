clear all
clc
n = 100;
z = zeros(n,1);
% corrected state vectors
x = zeros(n,1);
% corrected error co-variance matrix
P = ones(n,1);
% predicted state vectors
x_p = zeros(n,1);
% predicted error co-variance matrix
P_p = zeros(n,1);
%P_p(1) = 2;

% variance of disturbance noise
Q = .01; 
% variance of sensor noise
R = .1;
 hleg1 = legend('Kalman filtered state','sensor measured state');
    set(hleg1,'Location','SouthWest');
for k=1:n-1
    
    [sensor_x(k+1), sensor_y(k+1), sensor_z(k+1)] = imu_receive();
    
    % prediction
    
    x_p(k+1) = x(k);
    P_p(k+1) = P(k) + Q;
    
    % correction
    
    K = P_p(k+1)/(P_p(k+1) + R);
    x(k+1) = x_p(k+1) + K*(sensor_z(k+1) - x_p(k+1));
    P(k+1) = (1 - K)* P_p(k+1);
    
    % plotting
    
    title('Voltage measured vs time');
    plot(k,x(k),'-ro',k,z(k), '-b*');
    axis([0 k+10 0 20]);
    pause(.0001);
    drawnow
    
    %axis([1 10 .1 .7]);
   
    grid on
    hold on;
       
end
    
    