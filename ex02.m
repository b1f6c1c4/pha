close all; 
clear all;
% Data数据格式：1-A相电压，2-B相电压，3-C相电压，4-正序电压，
%              5-A相电流，6-B相电流，7-C相电流，8-正序电流， 9-频率  10-复功率    
data=load('PMUData');
t=data.t;
Data=data.Data;

%% 电压测量
figure;
plot(t,abs(Data(:,1:3))*1e-3,'marker','.');
xlabel('\fontsize{18}\fontname{Times New Roman}\itt\rm(s)');
ylabel('\fontsize{18}\fontname{Times New Roman}电压相量幅值(kV)');
legend('\fontsize{18}A相','\fontsize{18}B相','\fontsize{18}C相');
set(gca,'fontsize',18);

figure;
plot(t,unwrap(angle(Data(:,1:3)))*180/pi,'marker','.');
xlabel('\fontsize{18}\fontname{Times New Roman}\itt\rm(s)');
ylabel('\fontsize{18}\fontname{Times New Roman}电压相量相位(度)');
legend('\fontsize{18}A相','\fontsize{18}B相','\fontsize{18}C相');
set(gca,'fontsize',18);

figure;
plot(t,abs(Data(:,4))*1e-3,'marker','.');
xlabel('\fontsize{18}\fontname{Times New Roman}\itt\rm(s)');
ylabel('\fontsize{18}\fontname{Times New Roman}电压相量幅值(kV)');
set(gca,'fontsize',18);

figure;
plot(t,unwrap(angle(Data(:,4)))*180/pi,'marker','.');
xlabel('\fontsize{18}\fontname{Times New Roman}\itt\rm(s)');
ylabel('\fontsize{18}\fontname{Times New Roman}电压相量相位(度)');
set(gca,'fontsize',18);

%% 电流测量
figure;
plot(t,abs(Data(:,5:7)),'marker','.');
xlabel('\fontsize{18}\fontname{Times New Roman}\itt\rm(s)');
ylabel('\fontsize{18}\fontname{Times New Roman}电流相量幅值(A)');
legend('\fontsize{18}A相','\fontsize{18}B相','\fontsize{18}C相');
set(gca,'fontsize',18);

figure;
plot(t,unwrap(angle(Data(:,5:7)))*180/pi,'marker','.');
xlabel('\fontsize{18}\fontname{Times New Roman}\itt\rm(s)');
ylabel('\fontsize{18}\fontname{Times New Roman}电流相量相位(度)');
legend('\fontsize{18}A相','\fontsize{18}B相','\fontsize{18}C相');
set(gca,'fontsize',18);

figure;
plot(t,abs(Data(:,8))*1e-3,'marker','.');
xlabel('\fontsize{18}\fontname{Times New Roman}\itt\rm(s)');
ylabel('\fontsize{18}\fontname{Times New Roman}电流相量幅值(A)');
set(gca,'fontsize',18);

figure;
plot(t,unwrap(angle(Data(:,8)))*180/pi,'marker','.');
xlabel('\fontsize{18}\fontname{Times New Roman}\itt\rm(s)');
ylabel('\fontsize{18}\fontname{Times New Roman}电流相量相位(度)');
set(gca,'fontsize',18);

%% 频率测量
figure;
plot(t,abs(Data(:,9)),'marker','.');
xlabel('\fontsize{18}\fontname{Times New Roman}\itt\rm(s)');
ylabel('\fontsize{18}\fontname{Times New Roman}频率（Hz）');
set(gca,'fontsize',18);

%% 有功无功
figure; hold on;
plot(t,real(Data(:,10)),'marker','.');
plot(t,imag(Data(:,10)),'marker','.','color','r');
xlabel('\fontsize{18}\fontname{Times New Roman}\itt\rm(s)');
ylabel('\fontsize{18}\fontname{Times New Roman}功率（MVA）');
legend('\fontsize{18}有功功率','\fontsize{18}无功功率');
set(gca,'fontsize',18);

