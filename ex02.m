close all; 
clear all;
% Data���ݸ�ʽ��1-A���ѹ��2-B���ѹ��3-C���ѹ��4-�����ѹ��
%              5-A�������6-B�������7-C�������8-��������� 9-Ƶ��  10-������    
data=load('PMUData');
t=data.t;
Data=data.Data;

%% ��ѹ����
figure;
plot(t,abs(Data(:,1:3))*1e-3,'marker','.');
xlabel('\fontsize{18}\fontname{Times New Roman}\itt\rm(s)');
ylabel('\fontsize{18}\fontname{Times New Roman}��ѹ������ֵ(kV)');
legend('\fontsize{18}A��','\fontsize{18}B��','\fontsize{18}C��');
set(gca,'fontsize',18);

figure;
plot(t,unwrap(angle(Data(:,1:3)))*180/pi,'marker','.');
xlabel('\fontsize{18}\fontname{Times New Roman}\itt\rm(s)');
ylabel('\fontsize{18}\fontname{Times New Roman}��ѹ������λ(��)');
legend('\fontsize{18}A��','\fontsize{18}B��','\fontsize{18}C��');
set(gca,'fontsize',18);

figure;
plot(t,abs(Data(:,4))*1e-3,'marker','.');
xlabel('\fontsize{18}\fontname{Times New Roman}\itt\rm(s)');
ylabel('\fontsize{18}\fontname{Times New Roman}��ѹ������ֵ(kV)');
set(gca,'fontsize',18);

figure;
plot(t,unwrap(angle(Data(:,4)))*180/pi,'marker','.');
xlabel('\fontsize{18}\fontname{Times New Roman}\itt\rm(s)');
ylabel('\fontsize{18}\fontname{Times New Roman}��ѹ������λ(��)');
set(gca,'fontsize',18);

%% ��������
figure;
plot(t,abs(Data(:,5:7)),'marker','.');
xlabel('\fontsize{18}\fontname{Times New Roman}\itt\rm(s)');
ylabel('\fontsize{18}\fontname{Times New Roman}����������ֵ(A)');
legend('\fontsize{18}A��','\fontsize{18}B��','\fontsize{18}C��');
set(gca,'fontsize',18);

figure;
plot(t,unwrap(angle(Data(:,5:7)))*180/pi,'marker','.');
xlabel('\fontsize{18}\fontname{Times New Roman}\itt\rm(s)');
ylabel('\fontsize{18}\fontname{Times New Roman}����������λ(��)');
legend('\fontsize{18}A��','\fontsize{18}B��','\fontsize{18}C��');
set(gca,'fontsize',18);

figure;
plot(t,abs(Data(:,8))*1e-3,'marker','.');
xlabel('\fontsize{18}\fontname{Times New Roman}\itt\rm(s)');
ylabel('\fontsize{18}\fontname{Times New Roman}����������ֵ(A)');
set(gca,'fontsize',18);

figure;
plot(t,unwrap(angle(Data(:,8)))*180/pi,'marker','.');
xlabel('\fontsize{18}\fontname{Times New Roman}\itt\rm(s)');
ylabel('\fontsize{18}\fontname{Times New Roman}����������λ(��)');
set(gca,'fontsize',18);

%% Ƶ�ʲ���
figure;
plot(t,abs(Data(:,9)),'marker','.');
xlabel('\fontsize{18}\fontname{Times New Roman}\itt\rm(s)');
ylabel('\fontsize{18}\fontname{Times New Roman}Ƶ�ʣ�Hz��');
set(gca,'fontsize',18);

%% �й��޹�
figure; hold on;
plot(t,real(Data(:,10)),'marker','.');
plot(t,imag(Data(:,10)),'marker','.','color','r');
xlabel('\fontsize{18}\fontname{Times New Roman}\itt\rm(s)');
ylabel('\fontsize{18}\fontname{Times New Roman}���ʣ�MVA��');
legend('\fontsize{18}�й�����','\fontsize{18}�޹�����');
set(gca,'fontsize',18);

