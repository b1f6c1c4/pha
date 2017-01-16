close all; clear all;
data=load('WavData.mat'); %读取数据
% 数据格式
% t-时间变量
% Data- ABC三相电压和电流波形，1-A相电压，2-B相电压，3-C相电压，
%        4-A相电流，5-B相电流，6-C相电流，
t=data.t;
Data=data.Data;
figure; %绘制三相电压波形
plot(t,Data(:,1:3)*1e-3);
xlabel('t(s)');
ylabel('电压波形(kV)');
legend('A','B','C');
figure; %绘制三相电流波形
plot(t,Data(:,4:6));
xlabel('t(s)');
ylabel('电流波形(A)');
legend('A','B','C');
