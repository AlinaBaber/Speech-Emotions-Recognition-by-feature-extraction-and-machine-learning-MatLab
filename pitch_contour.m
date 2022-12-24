function [ Pitch_Contour_min, Pitch_Contour_max,Pitch_Contour_mean,pitch_freq ] = pitch_contour( wav_file )
[y,Fs,bits]=wavread(wav_file);
data=y;
y=data;
pitch_freq1=0;o=1;
Frame_size=30;pitch_freq = 0;
Frame_shift=10;
max_value=max(abs(y));
y=y/max_value;
window_period=Frame_size/1000;
shift_period=Frame_shift/1000;
t=1/Fs:1/Fs:(length(y)/Fs);
%subplot(2,1,1);plot(t,y);xtitle('Speech signal waveform');
window_length = window_period*Fs
sample_shift = shift_period*Fs
sum1=0;energy=0;autocorrelation=0;
for i=1:(floor((length(y))/sample_shift)-ceil(window_length/sample_shift))
k=1;yy=0;
for j=(((i-1)*sample_shift)+1):(((i-1)*sample_shift)+window_length)
yy(k)=y(j);
k=k+1;
end
t=1/Fs:1/Fs:(length(yy)/Fs);
t=(t(1:length(t)/2))*1000;
dfty=abs(fft(yy));
dfty1=dfty(1:length(dfty)/2);
tt=linspace(1/Fs,Fs,length(dfty1));
for i=1:length(dfty)
if (dfty(i)==0)
dfty(i)=1D-16;
end
end
dftylog=log10(dfty);
dftylog1=dftylog(1:length(dftylog)/2);
yy=10*dftylog1;
%xtitle('Log Magnitude Spectrum','frequency in Hz');
real_ceps=abs(ifft(dftylog));
real_ceps=real_ceps(1:length(real_ceps)/2);
%real_ceps=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 2 3 4 5 6 5 4 3 2 1];
real_ceps_pitch=real_ceps(16:length(real_ceps));
max1=max(real_ceps_pitch);
%max1=0;
for uu=1:length(real_ceps_pitch)
uu;
real_ceps_pitch(uu);
max1;
if(real_ceps_pitch(uu)==max1)
%max1=real_ceps_pitch(uu);
sample_no=uu;
end
end
pitch_freq1=1/((16+sample_no)*(1/Fs));
pitch_freq(o)= pitch_freq1;
o=o+1;
%pitch_freq(i)=1/(16+sample_no);
end
kk=1/Fs:shift_period:(length(pitch_freq)*shift_period);
Pitch_Contour_min= min(pitch_freq);
Pitch_Contour_max= max(pitch_freq);
Pitch_Contour_mean= mean(pitch_freq);
Pitch_Contour=pitch_freq;
%subplot(4,1,3);plot(kk,pitch_freq,'.'); title('Pitch Contour obtained by cepstrum pitch estimation method');