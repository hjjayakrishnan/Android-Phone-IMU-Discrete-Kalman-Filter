clear all
clc
n = 200;
z = zeros(n,1);
% corrected state vectors
x = zeros(n,1);
y = zeros(n,1);
z = zeros(n,1);
% corrected error co-variance matrix
P_x = ones(n,1);
P_y = ones(n,1);
P_z = ones(n,1);
% predicted state vectors
x_p = zeros(n,1);
x_p = zeros(n,1);
x_p = zeros(n,1);
% predicted error co-variance matrix
P_p_x = zeros(n,1);
P_p_y = zeros(n,1);
P_p_z = zeros(n,1);
%P_p(1) = 2;

% variance of disturbance noise
Q = .01; 
% variance of sensor noise
R = .1;
 
for k=1:n-1
    
    [sensor_x(k+1), sensor_y(k+1), sensor_z(k+1)] = imu_receive_3d();
    
    % Z axis
    % prediction
    
    z_p(k+1) = z(k);
    P_p_z(k+1) = P_z(k) + Q;
    
    % correction
    
    K_z = P_p_z(k+1)/(P_p_z(k+1) + R);
    z(k+1) = z_p(k+1) + K_z*(sensor_z(k+1) - z_p(k+1));
    P_z(k+1) = (1 - K_z)* P_p_z(k+1);
    
    % plotting
    
    title('Z axis accelerometer ');
    subplot(3,1,1);
    plot(k,z(k),'-ro',k,sensor_z(k), '-b*');
    axis([0 k+10 0 20]);
    pause(.0001);
    drawnow
    grid on
    hold on;
    
    % Y axis
    % prediction
    
    y_p(k+1) = y(k);
    P_p_y(k+1) = P_y(k) + Q;
    
    % correction
    
    K_y = P_p_y(k+1)/(P_p_y(k+1) + R);
    y(k+1) = y_p(k+1) + K_y*(sensor_y(k+1) - y_p(k+1));
    P_y(k+1) = (1 - K_y)* P_p_y(k+1);
    
    % plotting
    
    title('Y axis accelerometer ');
    subplot(3,1,2);
    plot(k,y(k),'-ro',k,sensor_y(k), '-b*');
    axis([0 k+10 0 20]);
    pause(.0001);
    drawnow
    grid on
    hold on;
    
    % X axis
    % prediction
    
    x_p(k+1) = x(k);
    P_p_x(k+1) = P_x(k) + Q;
    
    % correction
    
    K_x = P_p_x(k+1)/(P_p_x(k+1) + R);
    x(k+1) = x_p(k+1) + K_x*(sensor_x(k+1) - x_p(k+1));
    P_x(k+1) = (1 - K_x)* P_p_x(k+1);
    
    % plotting
    
    title('X axis accelerometer ');
    subplot(3,1,3);
    plot(k,x(k),'-ro',k,sensor_x(k), '-b*');
    axis([0 k+10 0 20]);
    pause(.0001);
    drawnow
    grid on
    hold on;
       
end
    
    