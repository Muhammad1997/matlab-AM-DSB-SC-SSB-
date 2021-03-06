%to clear all old parameters
clear all;
close all;
clc;
%time setting
Fs = 800000;             %sample freq
tmin = 0;                %initial time
tmax = 0.001;            %max time
step = 1/Fs;             %sample time
t = tmin:step:tmax;      %time periode of signal
%amplitude setting
Am = 1;                  %msg amplitude
Ac = 2;                  %carrier amplitude
Fm = 2000;
Fc = 100000;

%------------------------------------------------------------
%generate msg & carrier & modulated signals
m = Am*cos(2*pi*Fm*t);   %msg
c = Ac*cos(2*pi*Fc*t);   %carrier
s = m.*c;                %DSB-SC modulated signal
%------------------------------------------------------------
%demodulation of DSB-SC
x = s.*c;
Wn = Fc/(Fs/2);             % Normalozed cutoff frequency
[b a] = butter(5,Wn,'low'); %5th order low-pass filter
y = filter(b,a,x);
%------------------------------------------------------------
%plotting

figure(1);
%msg
subplot(2,1,1);
plot(t,m);
xlabel ('time');
ylabel ('amplitude');
title('msg signal');


%carrier
subplot(2,1,2);
plot(t,c);
xlabel ('time');
ylabel ('amplitude');
title('carrier signal');

figure(2);
%DSB-SC modulated signal
subplot(2,1,1);
plot(t,s); hold on;
plot (t,Ac*m,'r:'); hold on;
plot (t,-Ac*m,'r:'); hold on;
xlabel ('time');
ylabel ('amplitude');
title('DSB-SC modulated signal');


%DSB-SC demodulated signal
subplot(2,1,2);
plot(t,y);
xlabel ('time');
ylabel ('amplitude');
title('DSB-SC demodulated signal');
