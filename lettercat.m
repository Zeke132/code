clc
clear all
close all
%% Import the signal
load('AAS010R01.mat');
y=sum(signal,2)/64;
t=(0:length(y)-1)/240;
fs=1/(t(2)-t(1));

%% Draw the unprocessed three-letter signal
figure(1)
plot(t(1:8776),y(1:8776),'g')
hold on
plot(t(8776:17752),y(8776:17752),'r')
hold on
plot(t(17753:26328),y(17753:26328),'b')
title('CAT')
axis([t(1) t(end)+10 -1.2*max(y) 1.2*max(y)]);
%%   Take out the corresponding signal of each letter for periodic average
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
title('15 Character C waveform after period averaging')
subplot(3,1,2)
plot(v,s_2)
title('15 Character A waveform after period averaging')
subplot(3,1,3)
plot(v,s_3)
title('15 Character T waveform after period averaging')

%% Low-pass filtering is performed on the signal after averaging (brain signal is generally below 5Hz)
d_1=lowp(s_1,8,10,0.1,30,fs);
d_2=lowp(s_2,8,10,0.1,30,fs);
d_3=lowp(s_3,8,10,0.1,30,fs);

figure(3)
subplot(3,1,1)
plot(v,d_1)
title('Character C waveform after low pass filtering')
subplot(3,1,2)
plot(v,d_2)
title('Character A waveform after low pass filtering')
subplot(3,1,3)
plot(v,d_3)
title('Character T waveform after low pass filtering')

