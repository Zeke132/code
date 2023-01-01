clc
clear all
close all
%% Import the signal
load('AAS012R01.mat');
y=sum(signal,2)/64;
t=(0:length(y)-1)/240;
fs=1/(t(2)-t(1));
N_letter=4; %%%%alphabet number
n1=fix(length(y)/N_letter);

%% Draw the unprocessed three-letter signal
figure(1)
plot(t(1:n1),y(1:n1),'g')
hold on
plot(t(n1+1:2*n1),y(n1+1:2*n1),'r')
hold on
plot(t(2*n1+1:3*n1),y(2*n1+1:3*n1),'k')
hold on
plot(t(3*n1+1:4*n1),y(3*n1+1:4*n1),'y')
title('FOOD')

%%  Take out the corresponding signal of each letter for periodic average
n_s=fix(n1/15);
a=1:n_s;
b=n1+1:n1+1+n_s;
c=2*n1+1:2*n1+1+n_s;
d=3*n1+1:3*n1+1+n_s;
z_1=y(a);
z_2=y(b);
z_3=y(c);
z_4=y(d);
s_1=z_1;
s_2=z_2;
s_3=z_3;
s_4=z_4;
for k=1:14
    a=a+n_s;b=b+n_s;c=c+n_s;
    z_1=y(a);z_2=y(b);z_3=y(c);z_4=y(d);
    s_1=s_1+z_1;s_2=s_2+z_2;s_3=s_3+z_3;s_4=s_4+z_3;
end
s_1=s_1/15;s_2=s_2/15;s_3=s_3/15;s_4=s_4/15;
v=(0:n_s-1)/240;
v1=(0:n_s)/240;
figure(2)
subplot(4,1,1)
plot(v,s_1)
title('15 Character F waveform after period averaging')
subplot(4,1,2)
plot(v1,s_2)
title('15 Character O waveform after period averaging')
subplot(4,1,3)
plot(v1,s_3)
title('15 Character O waveform after period averaging')
subplot(4,1,4)
plot(v1,s_4)
title('15 Character D waveform after period averaging')

%% Low-pass filtering is performed on the signal after averaging (brain signal is generally below 5Hz)  
d_1=lowp(s_1,8,10,0.1,30,fs);
d_2=lowp(s_2,8,10,0.1,30,fs);
d_3=lowp(s_3,8,10,0.1,30,fs);
d_4=lowp(s_4,8,10,0.1,30,fs);

figure(3)
subplot(4,1,1)
plot(v,d_1)
title('Character F waveform after low pass filtering')
subplot(4,1,2)
plot(v1,d_2)
title('Character O waveform after low pass filtering')
subplot(4,1,3)
plot(v1,d_3)
title('Character O waveform after low pass filtering')
subplot(4,1,4)
plot(v1,d_4)
title('Character D waveform after low pass filtering')


