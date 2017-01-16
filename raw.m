close all; clear all;
%% 步骤1：初始化
%% 初始化仿真基本参数
f0=50;  %电网基波标称频率
fs=4800;  %信号采样频率
T=5;  %试验数据长度（s）
L=T*fs;  %采样序列总长度
%% 测量系统使用的滤波器
N0=fs/f0;
Nh=N0;  %低通滤波器长度
h0=ones(Nh,1);
h0=h0/sum(h0);  %低通滤波器
h1=[1,0,-1]*fs/(4*pi);  %1阶微分滤波器
h2=[1,-2,1]*fs^2/(2*pi);  %2阶微分滤波器

%% 步骤2： 产生电网信号
df=2;  %频率偏移（Hz）
A0=1;  %基波幅度
phi0=rand(1,1)*pi;  %基波初相位
ka=0.1; kx=0.1;
fm=5;
t=[0:L-1]'/fs;  %采样信号时钟序列
Data=zeros(length(t),3);  %abc三相采样信号
for k=1:3
    Data(:,k)=sqrt(2)*A0*(1+kx*cos(2*pi*fm*t)).*...
        cos(2*pi*(f0+df)*t+ka*cos(2*pi*fm*t-pi)+phi0-(k-1)*2*pi/3); %试验信号波形
end
%% a相和正序分量理论值
Amp_true=(1+kx*cos(2*pi*fm*(t+0.5/fs)));  %瞬时幅度
Phi_true=2*pi*df*t+ka*cos(2*pi*fm*(t+0.5/fs)-pi)+phi0;  %瞬时相位
X_true=Amp_true.*exp(j*Phi_true);  %动态相量
Freq_true=df-ka*fm*sin(2*pi*fm*(t+0.5/fs)-pi);  %瞬时频率偏移值
ROCOF_true=-ka*2*pi*fm^2*cos(2*pi*fm*(t+0.5/fs)-pi);  %瞬时频率变化率

%% 步骤3：PMU测量过程
Xabc=zeros(length(t),3);  %ABC三相同步相量
for k=1:3
     Xabc(:,k)=sqrt(2)*fftfilt(h0,Data(:,k).*exp(-j*2*pi*f0*t));
end
Xp_est=zeros(length(Xabc),1);  %正序相量测量值
for k=1:3
    Xp_est=Xp_est+Xabc(:,k)*exp(j*2*pi*(k-1)/3)/3;
end
Phi_est=unwrap(angle(Xp_est));  %计算相位序列
Freq_est=fftfilt(h1,Phi_est);  %相位序列1阶微分生成频偏估计
ROCOF_est=fftfilt(h2,Phi_est);  %相位序列2阶微分生成ROCOF

%% 步骤4：误差统计
%理论值和估计值时钟对齐，滤波引起的暂态数据不进入误差统计
index0=length(h0)+length(h1):length(Xp_est);
indext=length(h0)/2+length(h1)+1:length(Xp_est)-length(h0)/2+1;
t0=t(indext);  %进行误差统计的测量值与理论值同步时钟
TVE=100*abs((Xp_est(index0)-X_true(indext))./X_true(indext)); %计算TVE
FE=Freq_true(indext)-Freq_est(index0);  %计算FE
RFE=ROCOF_true(indext)-ROCOF_est(index0);  %计算RFE
Rpt=[max(abs(TVE)),max(abs(FE)),max(abs(RFE))]  %统计TVE、FE和RFE最大值

%%  步骤5：结果输出
%% 滤波器频响特性
% 相量估计低通滤波器频响特性
[H0,f]=freqz(h0,1,8192,fs);
figure;  plot(f,20*log10(abs(H0)));
set(gca,'ylim',[-70,5]);
xlabel('f(Hz)'); 
ylabel('低通滤波器幅度响应 （dB）');
% 频率估计1阶微分滤波器频响特性
[H1,f]=freqz(h1,1,8192,fs);
figure;  plot(f,abs(H1));
xlabel('f(Hz)');
ylabel('1阶微分滤波器幅度响应');
%  ROCOF估计2阶微分滤波器频响特性
[H2,f]=freqz(h2,1,8192,fs);
figure;  plot(f,abs(H2));
xlabel('f(Hz)');
ylabel('2阶微分滤波器幅度响应');
%% 采样信号波形
figure;  plot(t,Data);
set(gca,'xlim',[0,10/f0]);
xlabel('t(s)');
ylabel('信号波形');
%% 测量值与真实值波形比较
%同步相量波形
figure;  hold on;
plot(t0,real(Xp_est(index0)));
plot(t0,real(X_true(indext)),'color','r');
plot(t0,imag(Xp_est(index0)),'linewidth',2);
plot(t0,imag(X_true(indext)),'color','r','linewidth',2);
xlabel('t(s)');
ylabel('同步相量');
legend('估计值实部','真实值实部','估计值虚部','真实值虚部');
%频率偏移值波形
figure;  hold on;
plot(t(index0),Freq_est(index0));
plot(t(index0),Freq_true(indext),'r');
xlabel('t(s)');
ylabel('频率');
legend('估计值','真实值');
%ROCOF波形
figure; hold on;
plot(t(index0),ROCOF_est(index0));
plot(t(index0),ROCOF_true(indext),'r');
xlabel('t(s)');
ylabel('ROCOF');
legend('估计值','真实值');
