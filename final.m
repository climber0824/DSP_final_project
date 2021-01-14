clear;
clc;

%cd('D:\downloads');
[y, fs] = audioread('Lisa_noise.wav');
time = (1:length(y))/fs;	% 時間軸的向量
figure(1)
plot(time, y(:,1));	% 畫出時間軸上的波形
[s,f,t,p] = spectrogram(y(:,1),2048,1024,4096,fs);
figure(2)
imagesc(t, f, 20*log10((abs(s))));
xlabel('Samples');
ylabel('Freqency');
colorbar;

A = zeros(1,fs/2);
for i = 1 : 1 :length(A)+1
    if mod(i,250) ~= 0 && mod(i,250) ~= 1 && mod(i,250) ~= 2 && mod(i,250) ~= 3 && mod(i,250) ~= 4 && mod(i,250) ~= 246 && mod(i,250) ~= 247 && mod(i,250) ~= 248 && mod(i,250) ~= 249
        A(i) = 1;
    end
end
    
mbFilt = designfilt('arbmagfir','FilterOrder',60, ...
         'Frequencies',0:1:length(A)-1,'Amplitudes',A, ...
         'SampleRate',fs);
yf = filtfilt(mbFilt,y(:,1));

[s1,f1,t1,p] = spectrogram(yf,2048,1024,4096,fs);
figure(3)
imagesc(t1, f1, 20*log10((abs(s1))));
xlabel('Samples');
ylabel('Freqency');
colorbar;
audiowrite('filtered_lisa.wav', yf, fs);