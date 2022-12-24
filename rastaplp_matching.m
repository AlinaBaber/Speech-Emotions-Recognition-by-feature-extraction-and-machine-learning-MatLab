function [RastaPLPcepDpDD] = rastaplp_matching( wav_file )
[d,sr] = readwav(wav_file);
%figure('Position', [30 30 800 600], 'PaperPositionMode', 'auto','color', 'w', 'PaperOrientation', 'landscape', 'Visible', 'on' );
%subplot(311);
% Set color map to grayscale
% Look at its regular spectrogram
%specgram(d, 256, sr);
[cep1, spec1] = rastaplp(d, sr); % Calculate basic RASTA-PLP cepstra and spectr
%title('Original Spectrogram');
%subplot(312)% .. and plot them
%imagesc(10*log10(spec1)); % Power spectrum, so dB is 10log10
% Set color map to grayscale
%title('RASTA-PLP Spectra Features');
%subplot(313);
%imagesc(cep1);
% Set color map to grayscale
%colormap( 1-colormap('gray') );
% Notice the auditory warping of the frequency axis to give more
% space to low frequencies and the way that RASTA filtering
% emphasizes the onsets of static sounds like vowels
% Calculate 12th order PLP features without RASTA
[cep2, spec2] = rastaplp(d, sr, 0, 12);
% .. and plot them
%title('RASTA-PLP cepstra Features')
%subplot(414);
%imagesc(10*log10(spec2));
%title('12th Order PLP Spectra');
% Set color map to grayscale
%colormap( 1-colormap('gray') );
% Notice the greater level of temporal detail compared to the
% RASTA-filtered version.  There is also greater spectral detail
% because our PLP model order is larger than the default of 8
% Append deltas and double-deltas onto the cepstral vectors
del = deltas(cep2);
% Double deltas are deltas applied twice with a shorter window
ddel = deltas(deltas(cep2,5),5);
% Composite, 39-element feature vector, just like we use for speech recognition
RastaPLPcepDpDD = [cep2;del;ddel];
