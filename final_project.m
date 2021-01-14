clear;
clc;

[signal, fs] = audioread('Lisa_noise.wav');
N = length(signal);

signal_fft = fft(signal, N);
t = (0: N-1)/fs;

figure(1)
subplot(2, 1, 1); plot(t, signal_fft);
title('origin'); xlabel('time(s)'); ylabel('magnitude');

fp = 1500; ft = 3000; as = 60;
wp = 2*pi*fp/fs;
ws = 2*pi*ft/fs;
bt = ws - wp;
M = ceil((as-8)/2.285/bt);
wc = (wp + ws)/2/pi;
alpha = 0.203*(as-15);
hn = fir1(M, wc, kaiser(M+1, alpha));

signal_filtered = fftfilt(hn, signal);
signal_filtered_fft = fft(signal_filtered);
n2 = length(signal_filtered_fft);
figure(1)
subplot(2,1,2);
plot(t, signal_filtered_fft);
title('after filtering'); xlabel('time(s)'); ylabel('mag');
%audiowrite('filtered_lisa.wav', abs(signal_filtered_fft), fs);