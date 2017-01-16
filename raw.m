close all; clear all;
%% ����1����ʼ��
%% ��ʼ�������������
f0=50;  %�����������Ƶ��
fs=4800;  %�źŲ���Ƶ��
T=5;  %�������ݳ��ȣ�s��
L=T*fs;  %���������ܳ���
%% ����ϵͳʹ�õ��˲���
N0=fs/f0;
Nh=N0;  %��ͨ�˲�������
h0=ones(Nh,1);
h0=h0/sum(h0);  %��ͨ�˲���
h1=[1,0,-1]*fs/(4*pi);  %1��΢���˲���
h2=[1,-2,1]*fs^2/(2*pi);  %2��΢���˲���

%% ����2�� ���������ź�
df=2;  %Ƶ��ƫ�ƣ�Hz��
A0=1;  %��������
phi0=rand(1,1)*pi;  %��������λ
ka=0.1; kx=0.1;
fm=5;
t=[0:L-1]'/fs;  %�����ź�ʱ������
Data=zeros(length(t),3);  %abc��������ź�
for k=1:3
    Data(:,k)=sqrt(2)*A0*(1+kx*cos(2*pi*fm*t)).*...
        cos(2*pi*f0*t+ka*cos(2*pi*fm*t-pi)+phi0-(k-1)*2*pi/3); %�����źŲ���
end
%% a��������������ֵ
Amp_true=(1+kx*cos(2*pi*fm*(t+0.5/fs)));  %˲ʱ����
Phi_true=ka*cos(2*pi*fm*(t+0.5/fs)-pi)+phi0;  %˲ʱ��λ
X_true=Amp_true.*exp(j*Phi_true);  %��̬����
Freq_true=-ka*fm*sin(2*pi*fm*(t+0.5/fs)-pi);  %˲ʱƵ��ƫ��ֵ
ROCOF_true=-ka*2*pi*fm^2*cos(2*pi*fm*(t+0.5/fs)-pi);  %˲ʱƵ�ʱ仯��

%% ����3��PMU��������
Xabc=zeros(length(t),3);  %ABC����ͬ������
for k=1:3
     Xabc(:,k)=sqrt(2)*fftfilt(h0,Data(:,k).*exp(-j*2*pi*f0*t));
end
Xp_est=zeros(length(Xabc),1);  %������������ֵ
for k=1:3
    Xp_est=Xp_est+Xabc(:,k)*exp(j*2*pi*(k-1)/3)/3;
end
Phi_est=unwrap(angle(Xp_est));  %������λ����
Freq_est=fftfilt(h1,Phi_est);  %��λ����1��΢������Ƶƫ����
ROCOF_est=fftfilt(h2,Phi_est);  %��λ����2��΢������ROCOF

%% ����4�����ͳ��
%����ֵ�͹���ֵʱ�Ӷ��룬�˲��������̬���ݲ��������ͳ��
index0=length(h0)+length(h1):length(Xp_est);
indext=length(h0)/2+length(h1)+1:length(Xp_est)-length(h0)/2+1;
t0=t(indext);  %�������ͳ�ƵĲ���ֵ������ֵͬ��ʱ��
TVE=100*abs((Xp_est(index0)-X_true(indext))./X_true(indext)); %����TVE
FE=Freq_true(indext)-Freq_est(index0);  %����FE
RFE=ROCOF_true(indext)-ROCOF_est(index0);  %����RFE
Rpt=[max(abs(TVE)),max(abs(FE)),max(abs(RFE))]  %ͳ��TVE��FE��RFE���ֵ

%%  ����5��������
%% �˲���Ƶ������
% �������Ƶ�ͨ�˲���Ƶ������
[H0,f]=freqz(h0,1,8192,fs);
figure;  plot(f,20*log10(abs(H0)));
set(gca,'ylim',[-70,5]);
xlabel('f(Hz)'); 
ylabel('��ͨ�˲���������Ӧ ��dB��');
% Ƶ�ʹ���1��΢���˲���Ƶ������
[H1,f]=freqz(h1,1,8192,fs);
figure;  plot(f,abs(H1));
xlabel('f(Hz)');
ylabel('1��΢���˲���������Ӧ');
%  ROCOF����2��΢���˲���Ƶ������
[H2,f]=freqz(h2,1,8192,fs);
figure;  plot(f,abs(H2));
xlabel('f(Hz)');
ylabel('2��΢���˲���������Ӧ');
%% �����źŲ���
figure;  plot(t,Data);
set(gca,'xlim',[0,10/f0]);
xlabel('t(s)');
ylabel('�źŲ���');
%% ����ֵ����ʵֵ���αȽ�
%ͬ����������
figure;  hold on;
plot(t0,real(Xp_est(index0)));
plot(t0,real(X_true(indext)),'color','r');
plot(t0,imag(Xp_est(index0)),'linewidth',2);
plot(t0,imag(X_true(indext)),'color','r','linewidth',2);
xlabel('t(s)');
ylabel('ͬ������');
legend('����ֵʵ��','��ʵֵʵ��','����ֵ�鲿','��ʵֵ�鲿');
%Ƶ��ƫ��ֵ����
figure;  hold on;
plot(t(index0),Freq_est(index0));
plot(t(index0),Freq_true(indext),'r');
xlabel('t(s)');
ylabel('Ƶ��');
legend('����ֵ','��ʵֵ');
%ROCOF����
figure; hold on;
plot(t(index0),ROCOF_est(index0));
plot(t(index0),ROCOF_true(indext),'r');
xlabel('t(s)');
ylabel('ROCOF');
legend('����ֵ','��ʵֵ');
