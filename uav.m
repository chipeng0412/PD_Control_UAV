clc;close all;
%Tab =yout.get('Tab').Values.Data;
%Twu =yout.get('Twu').Values.Data;
%Pab = yout.get('Pwu').Values.Data;
u= yout.get('LOCATION').Values.Data;
u0 = u(1,:)
% Twu0 = Twu(:,:,1);
% u0 = Twu0(1:3,4);%無人机座標原點
Rwu = yout.get('Rab').Values.Data;
Rwu0 = Rwu(:,:,1);
ux0= Rwu0 * [1;0;0];%無人机x軸單位長度點
uy0= Rwu0 * [0;1;0];
uz0= Rwu0 * [0;0;1];
L = 1;
w0 = [0;0;0];
L_w = 1;
%% 世界座標系
quiver3(w0(1), w0(2), w0(3), L_w,0,0,   'r', 'LineWidth', 1.5);
hold on
xlabel('World X coordinate')
ylabel('World Y coordinate')
zlabel('World Z coordinate')
quiver3(w0(1), w0(2), w0(3), 0,L_w,0,   'g', 'LineWidth', 1.5);
quiver3(w0(1), w0(2), w0(3), 0,0,L_w, 'b', 'LineWidth', 1.5);
%%
%%無人机座標系
quiver3(u0(1), u0(2), u0(3), L*ux0(1), L*ux0(2), L*ux0(3), 'r--', 'LineWidth', 2,'MaxHeadSize', 0.6);
hold on
quiver3(u0(1), u0(2), u0(3), L*uy0(1), L*uy0(2), L*uy0(3), 'g--', 'LineWidth', 2,'MaxHeadSize', 0.6);
quiver3(u0(1), u0(2), u0(3), L*uz0(1), L*uz0(2), L*uz0(3), 'b--', 'LineWidth', 2,'MaxHeadSize', 0.6);
quiver3(0, 0, 0, u0(1),u0(2),u0(3),0, 'k--', 'LineWidth', 2);
%% 畫 X 型無人機骨架
l = 1.6;      % 每根木板長度
p1_u = [ l/2*cos(pi/4);  l/2*sin(pi/4); 0];%I
p2_u = [-l/2*cos(pi/4); -l/2*sin(pi/4); 0];%III
p3_u = [ l/2*cos(-pi/4);  l/2*sin(-pi/4); 0];%IV
p4_u = [-l/2*cos(-pi/4); -l/2*sin(-pi/4); 0];%II

% 轉到世界座標系 W
p1_w = Rwu0 * p1_u + u0;
p2_w = Rwu0 * p2_u + u0;
p3_w = Rwu0 * p3_u + u0;
p4_w = Rwu0 * p4_u + u0;

plot3([p1_w(1), p2_w(1)], [p1_w(2), p2_w(2)], [p1_w(3), p2_w(3)], ...
      'k-', 'LineWidth', 4);%
plot3([p3_w(1), p4_w(1)], [p3_w(2), p4_w(2)], [p3_w(3), p4_w(3)], ...
      'k-', 'LineWidth', 4);
% 四旋翼
plot3(p1_w(1), p1_w(2), p1_w(3), 'ro', 'MarkerFaceColor', 'r');
plot3(p2_w(1), p2_w(2), p2_w(3), 'ro', 'MarkerFaceColor', 'r');
plot3(p3_w(1), p3_w(2), p3_w(3), 'bo', 'MarkerFaceColor', 'b');
plot3(p4_w(1), p4_w(2), p4_w(3), 'bo', 'MarkerFaceColor', 'b');
% 世界座標軸標註
text(L_w, 0, 0, '$x_w$', ...
     'Interpreter', 'latex', 'FontSize', 13);
text(0, L_w, 0, '$y_w$', ...
     'Interpreter', 'latex', 'FontSize', 13);
text(0, 0, L_w, '$z_w$', ...
     'Interpreter', 'latex', 'FontSize', 13);
mid_T = 0.5 * u0;
% 世界座標系名稱
text(w0(1), w0(2), w0(3), '$\{W\}$', ...
     'Interpreter', 'latex', 'FontSize', 14, ...
     'VerticalAlignment', 'top');
text(mid_T(1), mid_T(2), mid_T(3), '${}^{w}_{u}T$', ...
     'Interpreter', 'latex', 'FontSize', 15, ...
     'HorizontalAlignment', 'center', ...
     'VerticalAlignment', 'bottom');
% 旋翼編號標註
text(p1_w(1), p1_w(2), p1_w(3), '$M_{fl}$', ...
     'Interpreter', 'latex', 'FontSize', 12, 'VerticalAlignment', 'bottom');
text(p2_w(1), p2_w(2), p2_w(3), '$M_{br}$', ...
     'Interpreter', 'latex', 'FontSize', 12, 'VerticalAlignment', 'bottom');
text(p3_w(1), p3_w(2), p3_w(3), '$M_{fr}$', ...
     'Interpreter', 'latex', 'FontSize', 12, 'VerticalAlignment', 'bottom');
text(p4_w(1), p4_w(2), p4_w(3), '$M_{bl}$', ...
     'Interpreter', 'latex', 'FontSize', 12, 'VerticalAlignment', 'bottom');
% 無人機座標軸標註
text(u0(1)+L*ux0(1), u0(2)+L*ux0(2), u0(3)+L*ux0(3), '$x_u$', ...
     'Interpreter', 'latex', 'FontSize', 13);
text(u0(1)+L*uy0(1), u0(2)+L*uy0(2), u0(3)+L*uy0(3), '$y_u$', ...
     'Interpreter', 'latex', 'FontSize', 13);
text(u0(1)+L*uz0(1), u0(2)+L*uz0(2), u0(3)+L*uz0(3), '$z_u$', ...
     'Interpreter', 'latex', 'FontSize', 13);
% 無人機座標系名稱
text(u0(1), u0(2), u0(3), '$\{U\}$', ...
     'Interpreter', 'latex', 'FontSize', 14, ...
     'VerticalAlignment', 'bottom');
view([346.500 33.000])

clc; close all;

u = yout.get('LOCATION').Values.Data;
Rwu = yout.get('Rab').Values.Data;

N = size(u,1);

%% 初始位置
u0 = u(1,:)';

%% Figure
figure('Color','w');

hold on
grid on
axis equal

xlabel('World X')
ylabel('World Y')
zlabel('World Z')

view([346.500 33.000])

%% 世界座標系
L_w = 1;

quiver3(0,0,0, L_w,0,0, ...
    'r','LineWidth',1.5);

quiver3(0,0,0, 0,L_w,0, ...
    'g','LineWidth',1.5);

quiver3(0,0,0, 0,0,L_w, ...
    'b','LineWidth',1.5);

%% 無人機尺寸
l = 1.6;

p1_u = [ l/2*cos(pi/4);  l/2*sin(pi/4); 0];
p2_u = [-l/2*cos(pi/4); -l/2*sin(pi/4); 0];

p3_u = [ l/2*cos(-pi/4);  l/2*sin(-pi/4); 0];
p4_u = [-l/2*cos(-pi/4); -l/2*sin(-pi/4); 0];

%% 初始旋轉矩陣
R0 = Rwu(:,:,1);

%% 初始世界座標
p1_w = R0*p1_u + u0;
p2_w = R0*p2_u + u0;

p3_w = R0*p3_u + u0;
p4_w = R0*p4_u + u0;

%% 畫無人機骨架

arm1 = plot3( ...
    [p1_w(1), p2_w(1)], ...
    [p1_w(2), p2_w(2)], ...
    [p1_w(3), p2_w(3)], ...
    'k-', 'LineWidth',4);

arm2 = plot3( ...
    [p3_w(1), p4_w(1)], ...
    [p3_w(2), p4_w(2)], ...
    [p3_w(3), p4_w(3)], ...
    'k-', 'LineWidth',4);

%% 四個旋翼

rotor1 = plot3( ...
    p1_w(1), p1_w(2), p1_w(3), ...
    'ro','MarkerFaceColor','r');

rotor2 = plot3( ...
    p2_w(1), p2_w(2), p2_w(3), ...
    'ro','MarkerFaceColor','r');

rotor3 = plot3( ...
    p3_w(1), p3_w(2), p3_w(3), ...
    'bo','MarkerFaceColor','b');

rotor4 = plot3( ...
    p4_w(1), p4_w(2), p4_w(3), ...
    'bo','MarkerFaceColor','b');

%% 軌跡線

traj = plot3( ...
    u0(1),u0(2),u0(3), ...
    'm--','LineWidth',1.5);

%% 動畫

for k = 1:N

    %% 位置
    uk = u(k,:)';

    %% 姿態
    Rk = Rwu(:,:,k);

    %% 四個旋翼世界座標

    p1_w = Rk*p1_u + uk;
    p2_w = Rk*p2_u + uk;

    p3_w = Rk*p3_u + uk;
    p4_w = Rk*p4_u + uk;

    %% 更新骨架

    arm1.XData = [p1_w(1), p2_w(1)];
    arm1.YData = [p1_w(2), p2_w(2)];
    arm1.ZData = [p1_w(3), p2_w(3)];

    arm2.XData = [p3_w(1), p4_w(1)];
    arm2.YData = [p3_w(2), p4_w(2)];
    arm2.ZData = [p3_w(3), p4_w(3)];

    %% 更新旋翼位置

    rotor1.XData = p1_w(1);
    rotor1.YData = p1_w(2);
    rotor1.ZData = p1_w(3);

    rotor2.XData = p2_w(1);
    rotor2.YData = p2_w(2);
    rotor2.ZData = p2_w(3);

    rotor3.XData = p3_w(1);
    rotor3.YData = p3_w(2);
    rotor3.ZData = p3_w(3);

    rotor4.XData = p4_w(1);
    rotor4.YData = p4_w(2);
    rotor4.ZData = p4_w(3);

    %% 更新軌跡

    traj.XData = u(1:k,1);
    traj.YData = u(1:k,2);
    traj.ZData = u(1:k,3);

    %% 刷新
    pause(0.01)

    drawnow

end
z = u(:,3);
figure('Color','w');
plot(tout, z, 'LineWidth', 1.8);
grid on;
xlabel('Time t / s');
ylabel('UAV Z position / m');
title('UAV Z-axis Position Response');
% %%圖二備分 RPY 000 XYZ 330
% annotation("arrow", [0.7103 0.7233], [0.5793 0.5726])
% annotation("arrow", [0.7206 0.7216], [0.5626 0.6244])
% annotation("arrow", [0.594 0.594], [0.4381 0.5025])
% annotation("arrow", [0.7538 0.7538], [0.4648 0.5626])
% annotation("arrow", [0.5598 0.5598], [0.5399 0.6461])
% annotation("arrow", [0.5538 0.5467], [0.5833 0.5843])
% annotation("ellipse", [0.5768 0.4457 0.03518 0.03506])
% annotation("ellipse", [0.5427 0.5826 0.03518 0.03506], "Color", [0.1490, 0.5490, 0.8667], "LineStyle", "--", "LineWidth", 0.5)
% annotation("ellipse", [0.7367 0.5025 0.03518 0.03506])
% annotation("ellipse", [0.7035 0.576 0.03518 0.03506])
% view([348.000 54.000])
% % 文字偏移量：沿無人機 z_u 軸方向抬高
% hF = 0.25;      % 力文字高度
% hM = 0.45;      % 反力矩文字高度
% % 四個旋翼升力標註
% text(p1_w(1)+hF*uz0(1), p1_w(2)+hF*uz0(2), p1_w(3)+hF*uz0(3), '$F_{fl}$', ...
%      'Interpreter', 'latex', 'FontSize', 12, ...
%      'HorizontalAlignment', 'center', ...
%      'VerticalAlignment', 'bottom');
% text(p3_w(1)+hF*uz0(1), p3_w(2)+hF*uz0(2), p3_w(3)+hF*uz0(3), '$F_{fr}$', ...
%      'Interpreter', 'latex', 'FontSize', 12, ...
%      'HorizontalAlignment', 'center', ...
%      'VerticalAlignment', 'bottom');
% text(p4_w(1)+hF*uz0(1), p4_w(2)+hF*uz0(2), p4_w(3)+hF*uz0(3), '$F_{bl}$', ...
%      'Interpreter', 'latex', 'FontSize', 12, ...
%      'HorizontalAlignment', 'center', ...
%      'VerticalAlignment', 'bottom');
% text(p2_w(1)+hF*uz0(1), p2_w(2)+hF*uz0(2), p2_w(3)+hF*uz0(3), '$F_{br}$', ...
%      'Interpreter', 'latex', 'FontSize', 12, ...
%      'HorizontalAlignment', 'center', ...
%      'VerticalAlignment', 'bottom');
% % 四個旋翼旋轉反力矩標註
% text(p1_w(1)+hM*uz0(1), p1_w(2)+hM*uz0(2), p1_w(3)+hM*uz0(3), '$\tau_{fl}$', ...
%      'Interpreter', 'latex', 'FontSize', 12, ...
%      'HorizontalAlignment', 'center', ...
%      'VerticalAlignment', 'bottom');
% text(p3_w(1)+hM*uz0(1), p3_w(2)+hM*uz0(2), p3_w(3)+hM*uz0(3), '$\tau_{fr}$', ...
%      'Interpreter', 'latex', 'FontSize', 12, ...
%      'HorizontalAlignment', 'center', ...
%      'VerticalAlignment', 'bottom');
% text(p4_w(1)+hM*uz0(1), p4_w(2)+hM*uz0(2), p4_w(3)+hM*uz0(3), '$\tau_{bl}$', ...
%      'Interpreter', 'latex', 'FontSize', 12, ...
%      'HorizontalAlignment', 'center', ...
%      'VerticalAlignment', 'bottom');
% text(p2_w(1)+hM*uz0(1), p2_w(2)+hM*uz0(2), p2_w(3)+hM*uz0(3), '$\tau_{br}$', ...
%      'Interpreter', 'latex', 'FontSize', 12, ...
%      'HorizontalAlignment', 'center', ...
%      'VerticalAlignment', 'bottom');
% %% 合力與合反力矩標註
% hTotalF = 0.75;
% hTotalM = 1.00;
% text(u0(1)+hTotalF*uz0(1), u0(2)+hTotalF*uz0(2), u0(3)+hTotalF*uz0(3), ...
%      '$F_{u}$', ...
%      'Interpreter', 'latex', 'FontSize', 13, ...
%      'HorizontalAlignment', 'center', ...
%      'VerticalAlignment', 'bottom');
% text(u0(1)+hTotalM*uz0(1), u0(2)+hTotalM*uz0(2), u0(3)+hTotalM*uz0(3), ...
%      '$\tau_{z,u}$', ...
%      'Interpreter', 'latex', 'FontSize', 13, ...
%      'HorizontalAlignment', 'center', ...
%      'VerticalAlignment', 'bottom');
% annotation("arrow", [0.6599 0.6607], [0.499 0.7063])
% annotation("arrow", [0.7526 0.7429], [0.5016 0.5063], "Color", [0.1490, 0.5490, 0.8667], "LineStyle", "--")
% annotation("arrow", [0.7103 0.7233], [0.5793 0.5726], "Color", [0.9608, 0.4667, 0.1608], "LineStyle", "--")
% annotation("arrow", [0.5818 0.5907], [0.4603 0.4524], "Color", [0.9608, 0.4667, 0.1608], "LineStyle", "--")
% annotation("arrow", [0.7214 0.7224], [0.5626 0.6244])
% annotation("arrow", [0.6566 0.6469], [0.6254 0.6302])
% annotation("ellipse", [0.7367 0.5025 0.03518 0.03506], "Color", [0.1490, 0.5490, 0.8667], "LineStyle", "--")
% annotation("ellipse", [0.7035 0.576 0.03518 0.03506], "Color", [0.9608, 0.4667, 0.1608], "LineStyle", "--")
% annotation("ellipse", [0.576 0.4552 0.03518 0.03506], "Color", [0.9608, 0.4667, 0.1608], "LineStyle", "--")
% annotation("ellipse", [0.6387 0.6254 0.04312 0.03651])
% 
% view([348.000 54.000])
% hText = findobj(gcf,"Type","text")
% hText(7).Position = [2.5103,2.1714,0.2110]
% hText(3).Position = [2.0750,1.5798,0.3030]
% hText(8).Position = [2.5518,3.5519,0.2518]
% hText(4).Position = [2.1024,2.8400,0.3242]
% hText(2).Position = [3.0385,2.5881,0.6862]
% hText(1).Position = [2.5289,1.7543,0.7875]
% hText(9).Position = [3.6511,2.4049,0.2482]
% hText(5).Position = [3.2589,1.6920,0.3225]
% hText(10).Position = [3.6777,3.4185,0.2305]
% hText(6).Position = [3.2233,2.6291,0.2906]
% hText(11).Position = [3.0634,3.2445,0.0407]
% %%