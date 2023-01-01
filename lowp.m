function y=lowp(x,f1,f3,rp,rs,Fs)
%LPF(Lowpass filtering)
%Note: the selection range of cut-off frequency of pass band or stop band should not exceed half of the sampling rate  
%That is, f1 and F3 are both less than Fs/2
%x:A sequence that requires bandpass filtering
% f 1£ºPassband cutoff frequency
% f 3£ºStopband cutoff frequency
%rp£ºStopband cutoff frequency side band attenuation DB number set
%rs£ºSet the number of attenuation DB in the cut-off area
%FS£ºThe sampling frequency of sequence X
% rp=0.1;rs=30;%Passband side attenuation DB value and stopband side attenuation DB value
% Fs=2000;%sampling frequency 
%
wp=2*pi*f1/Fs;
ws=2*pi*f3/Fs;
% Design chebyshev filter£»
[n,wn]=cheb1ord(wp/pi,ws/pi,rp,rs);
[bz1,az1]=cheby1(n,rp,wp/pi);
%View the curve for designing the filter
% [h,w]=freqz(bz1,az1,256,Fs);
% h=20*log10(abs(h));
% figure;plot(w,h);title('The passband curve of the designed filter');grid on;
%
y=filter(bz1,az1,x);%After filtering the sequence X, the sequence Y is obtained
end
