close all; clear all;
data=load('WavData.mat'); %��ȡ����
% ���ݸ�ʽ
% t-ʱ�����
% Data- ABC�����ѹ�͵������Σ�1-A���ѹ��2-B���ѹ��3-C���ѹ��
%        4-A�������5-B�������6-C�������
t=data.t;
Data=data.Data;
figure; %���������ѹ����
plot(t,Data(:,1:3)*1e-3);
xlabel('t(s)');
ylabel('��ѹ����(kV)');
legend('A','B','C');
figure; %���������������
plot(t,Data(:,4:6));
xlabel('t(s)');
ylabel('��������(A)');
legend('A','B','C');
