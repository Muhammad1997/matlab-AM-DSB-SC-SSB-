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
s = (1+m/Ac).*c;         %AM modulated signal
%------------------------------------------------------------
%demodulation of AM
y = amdemod(s,Fc,Fs);    %built in function for AM-DEmodulation
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
%AM modulated signal
subplot(2,1,1);
plot(t,s); hold on;
plot (t,Ac*(1+m/Ac),'r:'); hold on;
plot (t,-Ac*(1+m/Ac),'r:'); hold on;
xlabel ('time');
ylabel ('amplitude');
title('AM-modulated signal');


%AM demodulated signal
subplot(2,1,2);
plot(t,y);
xlabel ('time');
ylabel ('amplitude');
title('AM-demodulated signal');
