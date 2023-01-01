clc
clear all
close all
%% Import the signal
load('AAS010R02.mat');
y=sum(signal,2)/64;
t=(0:length(y)-1)/240;
fs=1/(t(2)-t(1));
n1=length(y)/3;
%% Draw the unprocessed three-letter signal
figure(1)
plot(t(1:n1),y(1:n1),'g')
hold on
plot(t(n1+1:2*n1),y(n1+1:2*n1),'r')
hold on
plot(t(2*n1+1:3*n1),y(2*n1+1:3*n1),'b')
title('DOG')
axis([t(1) t(end)+10 -1.2*max(y) 1.2*max(y)]);

%%  Take out the corresponding signal of each letter for periodic average
a=1:585;b=8777:9361;c=17553:18137;
z_1=y(a);z_2=y(b);z_3=y(c);
s_1=z_1;s_2=z_2;s_3=z_3;
for k=1:14
    a=a+585;b=b+585;c=c+585;
    z_1=y(a);z_2=y(b);z_3=y(c);
    s_1=s_1+z_1;s_2=s_2+z_2;s_3=s_3+z_3;
end
s_1=s_1/15;s_2=s_2/15;s_3=s_3/15;
v=(0:584)/240;
figure(2)
subplot(3,1,1)
plot(v,s_1)
title('15 Character D waveform after period averaging')
subplot(3,1,2)
plot(v,s_2)
title('15 Character O waveform after period averaging')
subplot(3,1,3)
plot(v,s_3)
title('15 Character G waveform after period averaging')
%% 对平均后的信号进行低通滤波（脑信号一般5Hz以下）
d_1=lowp(s_1,8,10,0.1,30,fs);
d_2=lowp(s_2,8,10,0.1,30,fs);
d_3=lowp(s_3,8,10,0.1,30,fs);

figure(2)
subplot(3,1,1)
plot(v,d_1)
title('Character C waveform after low pass filtering')
subplot(3,1,2)
plot(v,d_2)
title('Character C waveform after low pass filtering')
subplot(3,1,3)
plot(v,d_3)
title('Character C waveform after low pass filtering')

