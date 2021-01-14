clear;
clc;
%https://www.mathworks.com/matlabcentral/answers/357022-can-you-help-remove-the-noise-from-this-audio-file#answer_282048

[y, fs]= audioread('Lisa_noise.wav'); 

m = length(y);
n = pow2(nextpow2(m));

N = length(y);
t = (0: N-1)/fs;

fn = fs/2;
wp = 1000/fn;
ws = 1010/fn;
rp = 1;
rs = 150;
[n, ws] = cheb2ord(wp, ws, rp, rs);
[z, p, k] = cheby2(n, rs, ws, 'low');
[soslp, glp] = zp2sos(z, p, k);

filtered_sound = filtfilt(soslp, glp, y);
figure(1)
plot(t, filtered_sound);
figure(2)
plot(t, y);
%audiowrite('filtered_lisa.wav', filtered_sound, fs);