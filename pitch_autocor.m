% Syntax :
% [pitch] = pitch_autocor (signal,start,finish,pitch1,pitch2,Fe)
%
% Grace a une auto_corrélation, cette fonction retourne la tonalité d'un son.
%


function [ pitch_freq_Fo] = pitch_autocor (wave_file)
[y,Fs,bits]=readwav(wave_file);%input: speech segment
max_value=max(abs(y));
y=y/max_value;
t=(1/Fs:1/Fs:(length(y)/Fs))*1000;
%subplot(2,1,1);
%plot(t,y);
%xlabel('A 30 millisecond segment of speech');ylabel('time in milliseconds');
sum1=0;autocorrelation=0;
   for l=0:(length(y)-1)
    sum1=0;
    for u=1:(length(y)-l)
      s=y(u)*y(u+l);
      sum1=sum1+s;
    end
    autocor(l+1)=sum1;
  end
kk=(1/Fs:1/Fs:(length(autocor)/Fs))*1000;
%subplot(2,1,2);
%plot(kk,autocor);
%xlabel('Autocorrelation of the 30 millisecond segment of speech');ylabel('time in milliseconds');
auto=autocor(21:160);
  max1=0;
  for uu=1:140
    if(auto(uu)>max1)
      max1=auto(uu);
      sample_no=uu;
    end 
  end
  pitch_period_To=(20+sample_no)*(1/Fs);
  pitch_freq_Fo=1/pitch_period_To;

