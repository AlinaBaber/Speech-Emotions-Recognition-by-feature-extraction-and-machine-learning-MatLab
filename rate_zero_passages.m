function [Rate_Zero_Passages] = rate_zero_passages(wav_file)
% rate_zero_passages
[son,Fs]=readwav(wav_file);
sampling_rate = Fs; 
windowsize_s = 0.020;
windowsize = sampling_rate*windowsize_s;
framesize_s = 0.010;
framesize = sampling_rate*framesize_s;
[result, nframes] = windowize(son, windowsize, framesize);
s = size(result);
y1 = [zeros(1, s(2)); result];
y2 = [result; zeros(1, s(2))];
Rate_Zero_Passages = sum(abs(sign(y1)-sign(y2))/2)/windowsize;