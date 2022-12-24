function spectrogram(x,fs,bw)
% Plot grayscale spectrogram with variable sampling rate and bandwidth
% Evan Ruzanski, ECE259, 2/26/2003

% Set minimum FFT length
fftmin = 256;

% Set 2*fs/bw variable window length for good resolution  with long block length
% will provide higher frequency resolution as main-lobe of the window 
% function will be narrow and short block length will provide higher time 
% resolution as less averaging across samples is performed for each 
% STFT value 
winlen = floor(2*fs/bw);

% Get FFT length 
fftlen = max([winlen fftmin]);

% Create window (Hamming for favorable sidelobe attenuation) and zero pad accordingly
win = [hamming(winlen) ; zeros(fftlen-winlen,1)]; 
win = win/sum(win);
windel =  (0:(length(win)-1)) * win;

% Set overlap (Effects expansion of spectrogram display as no overlap plots
% fftlen data points and maximum overlap gives 1 data point) 
ntime = 500; % Choose based on trial-and-error for best looking plot
overlap = floor(max(fftlen/2, (ntime*fftlen-length(x))/(ntime-1)));
ntime = floor((length(x)-overlap)/(fftlen-overlap));

% Create arrays
c1=(1:fftlen)';
r1=(0:ntime-1)*(fftlen-overlap);

% Take FFT of real data
b = fft(x(c1(:,ones(1,ntime))+r1(ones(fftlen,1),:)).*win(:,ones(1,ntime)));
if size(b,1) == 1
    m = length(b1);
    b(floor((m+4)/2):m) = [];
else
    m=size(b,1);
    b(floor((m+4)/2):m,:) = [];
end
b = b.*conj(b);

% Setup pixel locations for plot on frequency axis and time axis
f=(0:fftlen/2)*fs/fftlen; % Point spacing
t = (r1+windel)/fs;

% Set limit for dB scale
lim = max(b(:))*0.0001;

% Set dB scale
b=2.5*log10(max(b,lim));

% Plot
imh = imagesc(t,f/1000,b);

% Set up axis and labels for plot
axis('xy');
title('Spectrogramme');
xlabel('Time (s)');
ylabel('Frequency (kHz)');

% Set and apply grayscale levels
colormap(jet);
map2 = colormap;
%map2 = 1 - map2;
colormap(map2);
%colorbar; % Applies color legend to plot
%orient landscape;
