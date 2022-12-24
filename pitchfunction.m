function [fp,ff,pitch] = pitchfunction( wav_file )
  [y,fs] = readwav(wav_file);
index1=11000;
frameSize=256;
index2=index1+frameSize-1;
frame=y(index1:index2);
figure('Position', [30 30 800 600], 'PaperPositionMode', 'auto', ... 
              'color', 'w', 'PaperOrientation', 'landscape', 'Visible', 'on' ); 
subplot(3,1,1);
subplot(2,1,1); plot(y); grid on
title(wav_file);
line(index1*[1 1], [-1 1], 'color', 'r');
line(index2*[1 1], [-1 1], 'color', 'r');
subplot(2,1,2); plot(frame, '.-'); grid on
point=[7, 226];
line(point, frame(point), 'marker', 'o', 'color', 'red');

periodCount=6;
fp=((point(2)-point(1))/periodCount)/fs;	% fundamental period (in sec)
ff=1/fp;					% fundamental frequency (in Hz)
pitch=69+12*log2(ff/440);			% pitch (in semitone)
fprintf('Fundamental period = %g second\n', fp);
fprintf('Fundamental frequency = %g Hertz\n', ff);
fprintf('Pitch = %g semitone\n', pitch);