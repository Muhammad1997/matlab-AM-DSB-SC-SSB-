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
m = Am*cos(2*pi*Fm*t);       %msg
mh = Am*cos(2*pi*Fm*t+90);   %helbert transform of msg
c1 = Ac*cos(2*pi*Fc*t);      %carrier (cos)
c2 = Ac*sin(2*pi*Fc*t);      %carrier (sin)
%SSB(LSB) modulated signal
s1 = m.*c1; 
s2 = mh.*c2;
s = s1+s2;
%------------------------------------------------------------
%demodulation of SSB(LSB)
x = c1.*s;
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

%helbert transform of msg
subplot(2,1,2);
plot(t,mh);
xlabel ('time');
ylabel ('amplitude');
title('helbert transform of msg');

figure(2);
%carrier
subplot(2,1,1);
plot(t,c1);
xlabel ('time');
ylabel ('amplitude');
title('carrier signal');

%carrier
subplot(2,1,2);
plot(t,c2);
xlabel ('time');
ylabel ('amplitude');
title('carrier of helbert signal');

figure(3);
%SSB(LSB) modulated signal
subplot(2,1,1);
plot(t,s); 
xlabel ('time');
ylabel ('amplitude');
title('SSB(LSB)-modulated signal');


%SSB(LSB) demodulated signal
subplot(2,1,2);
plot(t,y);
xlabel ('time');
ylabel ('amplitude');
title('SSB(LSB)-demodulated signal');
