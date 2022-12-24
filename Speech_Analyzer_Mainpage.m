function varargout = Speech_Analyzer_Mainpage(varargin)
% SPEECH_ANALYZER_MAINPAGE MATLAB code for Speech_Analyzer_Mainpage.fig
%      SPEECH_ANALYZER_MAINPAGE, by itself, creates a new SPEECH_ANALYZER_MAINPAGE or raises the existing
%      singleton*.
%
%      H = SPEECH_ANALYZER_MAINPAGE returns the handle to a new SPEECH_ANALYZER_MAINPAGE or the handle to
%      the existing singleton*.
%
%      SPEECH_ANALYZER_MAINPAGE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SPEECH_ANALYZER_MAINPAGE.M with the given input arguments.
%
%      SPEECH_ANALYZER_MAINPAGE('Property','Value',...) creates a new SPEECH_ANALYZER_MAINPAGE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Speech_Analyzer_Mainpage_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Speech_Analyzer_Mainpage_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Speech_Analyzer_Mainpage

% Last Modified by GUIDE v2.5 26-Jun-2019 16:57:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Speech_Analyzer_Mainpage_OpeningFcn, ...
                   'gui_OutputFcn',  @Speech_Analyzer_Mainpage_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
    
end
% End initialization code - DO NOT EDIT


% --- Executes just before Speech_Analyzer_Mainpage is made visible.
function Speech_Analyzer_Mainpage_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Speech_Analyzer_Mainpage (see VARARGIN)

% Choose default command line output for Speech_Analyzer_Mainpage
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Speech_Analyzer_Mainpage wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Speech_Analyzer_Mainpage_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function sample_filepath_txt_Callback(hObject, eventdata, handles)
% hObject    handle to sample_filepath_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sample_filepath_txt as text
%        str2double(get(hObject,'String')) returns contents of sample_filepath_txt as a double


% --- Executes during object creation, after setting all properties.
function sample_filepath_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sample_filepath_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in browse_btn.
function browse_btn_Callback(hObject, eventdata, handles)
% hObject    handle to browse_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,FilePath]=uigetfile('*.wav','File Selector');
FullFilePath = strcat(FilePath, FileName);
handles.sample_filepath_txt.String = FullFilePath;
handles.activex7.URL = FullFilePath;








% --- Executes on button press in speech_recognition_svm_btn.
function speech_recognition_svm_btn_Callback(hObject, eventdata, handles)
% hObject    handle to speech_recognition_svm_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%----------------------------MFCC---------------------------------------------
wav_file2=handles.sample_filepath_txt.String;
[PSTATES,STATES,TRANS,EMIS,seq,states,N] = hmm_model_language_disorder(wav_file2);
[Status] = comparison(wav_file2);
handles.recognition_result_text.String = Status;

% --- Executes on button press in pitch_btn.
function pitch_btn_Callback(hObject, eventdata, handles)
% hObject    handle to pitch_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
wav_file=handles.sample_filepath_txt.String;

[Pitch_Contour_min,Pitch_Contour_max,Pitch_Contour_mean,pitch_freq] = pitch_contour_extract( wav_file );
set(handles.result_text,'string',' Average Pitch Contour:');
set(handles.result_text,'string',Pitch_Contour_mean);
set(handles.unit_text,'string','Hz');

 


% --- Executes on button press in format_btn.
function format_btn_Callback(hObject, eventdata, handles)
% hObject    handle to format_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 %get a section of vowel
 wav_file=handles.sample_filepath_txt.String;
[ ffreq ] = formant_extract( wav_file );
set(handles.result_text,'string','Formant Frequency :');
set(handles.result_text,'string',ffreq);
set(handles.unit_text,'string','Hz');




% --- Executes on button press in intensity_btn.
function intensity_btn_Callback(hObject, eventdata, handles)
% hObject    handle to intensity_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 wav_file=handles.sample_filepath_txt.String;
 [Intensity_of_Sound,f]= intensity_extraction(wav_file);
 %intensity= mean(magnitude);
 Rate_of_Intensity_of_Sound= mean(Intensity_of_Sound);
set(handles.result_text,'string','Average Intensity:');
set(handles.result_text,'string',Rate_of_Intensity_of_Sound);
set(handles.unit_text,'string','W/m^2');
  figure,plot(Intensity_of_Sound);
legend('Intensity');
ylabel(' Intensity of Sound (Watt/m^2');
xlabel('Distance from Source (m)');
%stem(f,magnitude)
%ylabel ('Magnitude (dB)');
%xlabel ('Frequency (Hz)');



% --- Executes on button press in mfcc_btn.
function mfcc_btn_Callback(hObject, eventdata, handles)
% hObject    handle to mfcc_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    wav_file = handles.sample_filepath_txt.String;  % input audio filename
    [ MFCCs, FBEs, frames] = melfcc( wav_file );

    
    


% EOF


% --- Executes on button press in rastaplp_btn.
function rastaplp_btn_Callback(hObject, eventdata, handles)
% hObject    handle to rastaplp_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Load a speech waveform
%[d,sr] = readwav(sample_filepath_txt.Field);
wav_file=handles.sample_filepath_txt.String;
 [del,ddel,cepDpDD] = rastaplpfunction( wav_file );

 




% --- Executes on button press in acceleration_btn.
function acceleration_btn_Callback(hObject, eventdata, handles)
% hObject    handle to acceleration_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
wav_file=handles.sample_filepath_txt.String; 
[acceleration1,velocity1,t,t1,rate_of_acceleration]= acceleration_extraction(wav_file);
set(handles.result_text,'string','Rate of Acceleration');
set(handles.result_text,'string',rate_of_acceleration);
set(handles.unit_text,'string','m/s^2');




% --- Executes on button press in time_btn.
function time_btn_Callback(hObject, eventdata, handles)
% hObject    handle to time_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in help_btn.
function help_btn_Callback(hObject, eventdata, handles)
% hObject    handle to help_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in about_btn.
function about_btn_Callback(hObject, eventdata, handles)
% hObject    handle to about_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in waveform.
function waveform_Callback(hObject, eventdata, handles)
% hObject    handle to waveform (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
wav_file=handles.sample_filepath_txt.String;
[Frequency,t,x,f,magnitude,q,amplitude] = frequency( wav_file );
figure('Position', [30 30 800 600], 'PaperPositionMode', 'auto', ... 
              'color', 'w', 'PaperOrientation', 'landscape', 'Visible', 'on' ); 
subplot(3,1,1);
%subplot(300);
plot(t,x);
legend('Waveform');
xlabel('Time(s)');
ylabel('Amplitude');
handles.result_tag_txt.String= 'Peak Frequency';
handles.result_text.String=Frequency;
handles.unit_txt.String='gHz';










% --- Executes on button press in datacorpus_btn.
function datacorpus_btn_Callback(hObject, eventdata, handles)
% hObject    handle to datacorpus_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in exit_btn.
function exit_btn_Callback(hObject, eventdata, handles)
% hObject    handle to exit_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in lpcc_btn.
function lpcc_btn_Callback(hObject, eventdata, handles)
% hObject    handle to lpcc_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
wav_file=handles.sample_filepath_txt.String;
p=128;
[LPCCs_Coeff,LPCSs,LPCCscepDpDD]= lpccs(wav_file,p);[d,sr] = readwav(wav_file);
figure;
subplot(311);
specgram(d, 256, sr);
title('Original Spectrogram');
subplot(312)% .. and plot them
imagesc(10*log10(LPCSs)); % Power spectrum, so dB is 10log10
% Set color map to grayscale
title('LPC Spectra Features');
subplot(313);
imagesc(LPCCs_Coeff);
title('LPC cepstra  Features');
figure;
subplot(211)% .. and plot them
plot(mean(LPCSs)); % Power spectrum, so dB is 10log10
% Set color map to grayscale
title('Average LPC Spectra Features');
subplot(212);
plot(mean(LPCCs_Coeff));
title('Average LPC cepstra  Features');


% --- Executes on button press in save_btn.
function save_btn_Callback(hObject, eventdata, handles)
% hObject    handle to save_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton32.



% --- Executes on button press in search_btn.
function search_btn_Callback(hObject, eventdata, handles)
% hObject    handle to search_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in edit_btn.
function edit_btn_Callback(hObject, eventdata, handles)
% hObject    handle to edit_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in open_db_btn.
function open_db_btn_Callback(hObject, eventdata, handles)
% hObject    handle to open_db_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3


% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4


% --- Executes on button press in lpc_btn.
function lpc_btn_Callback(hObject, eventdata, handles)
% hObject    handle to lpc_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in datacorpus_btn.
function fft_btn_Callback(hObject, eventdata, handles)
% hObject    handle to datacorpus_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in mfdwc_btn.
function mfdwc_btn_Callback(hObject, ~, handles)
% hObject    handle to mfdwc_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in autocorrelation_btn.
function autocorrelation_btn_Callback(hObject, eventdata, handles)
% hObject    handle to autocorrelation_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
wav_file=handles.sample_filepath_txt.String;
[rmax,PFr] = autocorrelation(wav_file);
handles.result_tag_txt.String= 'Frequency';
handles.result_text.String=rmax;
handles.unit_txt.String='g';
handles.result1_tag_txt.String= 'Peak Frequency';
handles.result1_txt.String=PFr;
handles.unit1_txt.String='gHz';


% --- Executes on button press in htk_mfcc_btn.
function htk_mfcc_btn_Callback(hObject, eventdata, handles)
% hObject    handle to htk_mfcc_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function activex2_Error(hObject, eventdata, handles)
% hObject    handle to activex2 (see GCBO)
% eventdata  structure with parameters passed to COM event listener
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton43.
function pushbutton43_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton44.
function pushbutton44_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in kmeans_btn.
function kmeans_btn_Callback(hObject, eventdata, handles)
% hObject    handle to kmeans_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function result_text_Callback(hObject, eventdata, handles)
% hObject    handle to result_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of result_text as text
%        str2double(get(hObject,'String')) returns contents of result_text as a double


% --- Executes during object creation, after setting all properties.
function result_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to result_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in spectrum_btn.
function spectrum_btn_Callback(hObject, eventdata, handles)
% hObject    handle to spectrum_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
wav_file=handles.sample_filepath_txt.String;
[Frequency,t,x,f,magnitude,q,amplitude] = frequency( wav_file );
figure('Position', [30 30 800 600], 'PaperPositionMode', 'auto', ... 
              'color', 'w', 'PaperOrientation', 'landscape', 'Visible', 'on' ); 
subplot(3,1,1);
plot(f,magnitude);
legend('Spectrum');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');



% --- Executes on button press in ceptrum_btn.
function ceptrum_btn_Callback(hObject, eventdata, handles)
% hObject    handle to ceptrum_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
wav_file=handles.sample_filepath_txt.String;
[Frequency,t,x,f,magnitude,q,amplitude] = frequency( wav_file );
figure('Position', [30 30 800 600], 'PaperPositionMode', 'auto', ... 
              'color', 'w', 'PaperOrientation', 'landscape', 'Visible', 'on' ); 
subplot(3,1,1);
plot(q,amplitude);
legend('Cepstrm');
xlabel('Quefrency (S)');
ylabel('Amplitude');


% --- Executes on button press in short_term_analysis_btn.
function short_term_analysis_btn_Callback(hObject, eventdata, handles)
% hObject    handle to short_term_analysis_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
wav_file=handles.sample_filepath_txt.String;;
[x,Fs]=readwav(wav_file);
sampling_rate = Fs; 
windowsize_s = 0.020;
windowsize = sampling_rate*windowsize_s;
framesize_s = 0.010;
framesize = sampling_rate*framesize_s;
[result, nframes] = windowize(x, windowsize, framesize);
[Average_Energy] = average_energy(result);
figure('Position', [30 30 800 600], 'PaperPositionMode', 'auto', ... 
              'color', 'w', 'PaperOrientation', 'landscape', 'Visible', 'on' ); 
subplot(3,1,1);
plot(Average_Energy);
legend('Spectrum');
title('Average Energy','FontSize',12,'Color','b');
[Rate_Zero_Passages] = rate_zero_passages(result, windowsize);
subplot(3,1,1);
plot(Rate_Zero_Passages);
title('Rate of Passages par Zero','FontSize',12,'Color','b');
[Average_Power] = average_power(result, windowsize);
subplot(3,1,1);
plot(Average_Power);
title('Average Power','FontSize',12,'Color','b');




% --- Executes on button press in homomorphic_analysis_btn.
function homomorphic_analysis_btn_Callback(hObject, eventdata, handles)
% hObject    handle to homomorphic_analysis_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in synthesis_btn.
function synthesis_btn_Callback(hObject, eventdata, handles)
% hObject    handle to synthesis_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in prediction_btn.
function prediction_btn_Callback(hObject, eventdata, handles)
% hObject    handle to prediction_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in analysis_by_frames_btn.
function analysis_by_frames_btn_Callback(hObject, eventdata, handles)
% hObject    handle to analysis_by_frames_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in decision_voice_btn.
function decision_voice_btn_Callback(hObject, eventdata, handles)
% hObject    handle to decision_voice_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton57.
function pushbutton57_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton57 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in frequency_btn.
function frequency_btn_Callback(hObject, eventdata, handles)
% hObject    handle to frequency_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
wav_file=handles.sample_filepath_txt.String;
[Frequency,t,x,f,magnitude,q,amplitude] = frequency( wav_file );
set(handles.result_text,'string',' Frequency :');
set(handles.result_text,'string',Frequency);
set(handles.unit_text,'string','Hz');


% --- Executes on button press in speech_recognition_btn.
function speech_recognition_btn_Callback(hObject, eventdata, handles)
% hObject    handle to speech_recognition_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
wav_file=handles.sample_filepath_txt.String;
data = getappdata(gcbf, 'metricdata');
Classification_Model=data.Classification_Model;
%if(Classification_Model==1) end
%if(Classification_Model==2)
%[SVM_Result,SVM_Score,SVM_Cost] = svm_classification(wav_file); 
%[rn1,cn1]=find(strcmp(SVM_Result,'Normal'));
%[rn2,cn2]=find(strcmp(SVM_Result,'Special'));
%Normal=sum(rn1); Special=sum(rn2);
%Normal_Percentage= (Normal/12)*100;
%Special_Percentage= (Special/12)*100;
%Percentage=[Normal_Percentage;Special_Percentage];
%set(handles.result_seldar_text,'string',Percentage);
%end
if(Classification_Model==3)

set(handles.speech_recognition_result_txt,'string',Percentage);
%if(Classification_Model==4)
end



% --- Executes on button press in frequency_domain_analysis_btn.
function frequency_domain_analysis_btn_Callback(hObject, eventdata, handles)
% hObject    handle to frequency_domain_analysis_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
wav_file=handles.sample_filepath_txt.String;
[Frequency,t,x,f,magnitude,q,amplitude] = frequency( wav_file );
%figure('Position', [30 30 800 600], 'PaperPositionMode', 'auto', ...               'color', 'w', 'PaperOrientation', 'landscape', 'Visible', 'on' ); 
%subplot(3,1,1);
%subplot(300);
%plot(t,x);
%legend('Waveform');
%xlabel('Time(s)');
%ylabel('Amplitude');
handles.result_tag_txt.String= 'Peak Frequency';
handles.result_text.String=Frequency;
handles.unit_txt.String='gHz';


% --- Executes on button press in pushbutton73.
function pushbutton73_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton73 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in lpc_val.
function lpc_val_Callback(hObject, eventdata, handles)
% hObject    handle to lpc_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns lpc_val contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lpc_val


% --- Executes during object creation, after setting all properties.
function lpc_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lpc_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in spectrogram_btn.
function spectrogram_btn_Callback(hObject, eventdata, handles)
% hObject    handle to spectrogram_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
wav_file=handles.sample_filepath_txt.String;
[x,Fs,bits]=wavread(wav_file);
figure('Position', [30 30 800 600], 'PaperPositionMode', 'auto', ... 
              'color', 'w', 'PaperOrientation', 'landscape', 'Visible', 'on' );
spectrogram(x,Fs,bits);
%spectrogram(x,Fs);

function operation_val_Callback(hObject, eventdata, handles)
% hObject    handle to operation_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
operation = get(hObject,'Value');
data = getappdata(gcbf, 'metricdata');
data.operation= operation;
setappdata(gcbf, 'metricdata', data);
% --- Executes on button press in real_ceptrum.
function real_ceptrum_Callback(hObject, eventdata, handles)
% hObject    handle to real_ceptrum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
wav_file=handles.sample_filepath_txt.String;
[x,Fs]=readwav(wav_file);
data = getappdata(gcbf, 'metricdata');
operation_val=data.operation;
ms1=Fs/1000;
ms20=Fs/50;
if operation_val==1
Y=fft(x.*hamming(length(x)));
end

if operation_val==2
Y=fft(x.*hann(length(x)));
end

if operation_val==3
Y=fft(x.*bartlett(length(x)));
end

if operation_val==4
Y=fft(x.*blackman(length(x)));
end

C=fft(log(abs(Y)+eps));
q=(ms1:ms20)/Fs;
figure('Position', [30 30 800 600], 'PaperPositionMode', 'auto', ... 
              'color', 'w', 'PaperOrientation', 'landscape', 'Visible', 'on' ); 
subplot(3,1,1); 
plot(q,abs(C(ms1:ms20)));
legend('Cepstre');
xlabel('Quefrence (s)','fontsize',14);
ylabel('Amplitude','fontsize',14);
[c,fx]=max(abs(C(ms1:ms20)));

%set(handles.fondamentale,'string',);
handles.result_tag_txt.String= 'Initial Frequency';
handles.result_text.String=Fs/(ms1+fx-1);
handles.unit_txt.String='Hz';


% --- Executes on button press in timeline_btn.
function timeline_btn_Callback(hObject, eventdata, handles)
% hObject    handle to timeline_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
wav_file=handles.sample_filepath_txt.String;
[x,Fs]=readwav(wav_file);
Length=size(x);
t = (1:Length(1))/Fs;
figure('Position', [30 30 800 600], 'PaperPositionMode', 'auto', ... 
              'color', 'w', 'PaperOrientation', 'landscape', 'Visible', 'on' ); 
subplot(3,1,1); 
plot(t,x);zoom xon;
xlabel(['Time [s]'],'FontSize',14,'Color','b');
ylabel(['Amplitude'],'FontSize',14,'Color','b');
legend('product');


% --- Executes on button press in fourier_transform_btn.
function fourier_transform_btn_Callback(hObject, eventdata, handles)
% hObject    handle to fourier_transform_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
wav_file=handles.sample_filepath_txt.String;
[x,Fs]=readwav(wav_file);
Y=fft(x.*hamming(length(x)));

hz5000=5000*length(Y)/Fs;

f=(0:hz5000)*Fs/length(Y); 
figure('Position', [30 30 800 600], 'PaperPositionMode', 'auto', ... 
              'color', 'w', 'PaperOrientation', 'landscape', 'Visible', 'on' ); 

plot(f,20*log10(abs(Y(1:length(f)))+eps));

legend('Spectrum');
title('Fourier Transform','FontSize',12,'Color','b');
xlabel('Frequence (Hz)');

ylabel('Magnitude (dB)');


% --- Executes on button press in pushbutton72.
function pushbutton72_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton72 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in average_energy_btn.
function average_energy_btn_Callback(hObject, eventdata, handles)
% hObject    handle to average_energy_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
wav_file=handles.sample_filepath_txt.String;
[Average_Energy]= logenergy(wav_file);
figure('Position', [30 30 800 600], 'PaperPositionMode', 'auto', ... 
              'color', 'w', 'PaperOrientation', 'landscape', 'Visible', 'on' ); 
subplot(3,1,1);
plot(Average_Energy);
legend('Spectrum');
title('Average Energy','FontSize',12,'Color','b');


% --- Executes on button press in rate_of_passages_btn.
function rate_of_passages_btn_Callback(hObject, ~, handles)
% hObject    handle to rate_of_passages_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
wav_file=handles.sample_filepath_txt.String;
[Rate_Zero_Passages] = rate_zero_passages(wav_file);
figure; 
plot(Rate_Zero_Passages);
title('Rate of Passages par Zero','FontSize',12,'Color','b');



% --- Executes on button press in average_power_btn.
function average_power_btn_Callback(hObject, eventdata, handles)
% hObject    handle to average_power_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
wav_file=handles.sample_filepath_txt.String;
[son,Fs]=readwav(wav_file);
sampling_rate = Fs; 
windowsize_s = 0.020;
windowsize = sampling_rate*windowsize_s;
framesize_s = 0.010;
framesize = sampling_rate*framesize_s;
[result, nframes] = windowize(son, windowsize, framesize);
[Average_Power] = average_power(result, windowsize);
figure; plot(Average_Power);
title('Average Power','FontSize',12,'Color','b');


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1

% --- Executes on selection change in num_coeff_val.
function num_coeff_val_Callback(hObject, eventdata, handles)
% hObject    handle to num_coeff_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)choice=get(hObject,'Value');
num_coeff = get(hObject,'Value');
data = getappdata(gcbf, 'metricdata');
data.num_coeff= num_coeff;
setappdata(gcbf, 'metricdata', data);


% --- Executes on button press in lpcc_analysis_btn.
function lpcc_analysis_btn_Callback(hObject, eventdata, handles)
% hObject    handle to lpcc_analysis_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
wav_file=handles.sample_filepath_txt.String;
data = getappdata(gcbf, 'metricdata');
p=data.num_coeff;
[lpc_data ]= lpc_function( wav_file, p );



% Hints: contents = cellstr(get(hObject,'String')) returns num_coeff_val contents as cell array
%        contents{get(hObject,'Value')} returns selected item from num_coeff_val


% --- Executes during object creation, after setting all properties.
function num_coeff_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num_coeff_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in operation_val.


% Hints: contents = cellstr(get(hObject,'String')) returns operation_val contents as cell array
%        contents{get(hObject,'Value')} returns selected item from operation_val


% --- Executes during object creation, after setting all properties.
function operation_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to operation_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function lpcc_analysis_btn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lpcc_analysis_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton80.
function pushbutton80_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton80 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in log_power_btn.




function train_path_txt_Callback(hObject, eventdata, handles)
% hObject    handle to train_path_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of train_path_txt as text
%        str2double(get(hObject,'String')) returns contents of train_path_txt as a double


% --- Executes during object creation, after setting all properties.
function train_path_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to train_path_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in browse_train_file_btn.
function browse_train_file_btn_Callback(hObject, eventdata, handles)
% hObject    handle to browse_train_file_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 set(handles.training_progress_text,'string','Add Data..');
[FileName,FilePath]=uigetfile('*.wav','File Selector');
FullFilePath = strcat(FilePath, FileName);
handles.train_path_txt.String = FullFilePath;
handles.activex9.URL = FullFilePath;
data = getappdata(gcbf, 'metricdata');
data.TrainFilename=FileName;  data.TrainFilePath=FullFilePath;
setappdata(gcbf, 'metricdata', data);


% --- Executes on selection change in train_data_list.
function train_data_list_Callback(hObject, eventdata, handles)
% hObject    handle to train_data_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns train_data_list contents as cell array
%        contents{get(hObject,'Value')} returns selected item from train_data_list
[status] = train_data(audio_folder);


% --- Executes during object creation, after setting all properties.
function train_data_list_CreateFcn(hObject, eventdata, handles)
% hObject    handle to train_data_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in train_data_btn.
function train_data_btn_Callback(hObject, eventdata, handles)
% hObject    handle to train_data_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%data = getappdata(gcbf, 'metricdata');
%FileName=data.TrainFilename;`


%MFCCs=MFCCscepDpDD; Data=MFCCs;
%[MFCC_PSTATES,MFCC_STATES,TRANS_EST2, EMIS_EST2,seq,states,N] = hmm_model(Data);
%figure();
%stairs(MFCC_PSTATES, 'LineWidth',2);
%set(gca, 'YGrid','on', 'YLim',[0 N+1]);
%xlabel('time'), ylabel('states');
%title('sequence of states');
%hold on; stairs(MFCC_STATES, 'LineWidth',2);
%LPCCs=LPCCscepDpDD;
%Data=LPCCs;
%[LPCC_PSTATES,LPCC_STATES,TRANS_EST2, EMIS_EST2,seq,states,N] = hmm_model(Data);
%figure();
%stairs(LPCC_PSTATES, 'LineWidth',2);
%set(gca, 'YGrid','on', 'YLim',[0 N+1]);
%xlabel('time'), ylabel('states');
%title('sequence of states');
%hold on; stairs(LPCC_STATES, 'LineWidth',2);
%RastaPLPs=RastaPLPcepDpDD;
%Data=RastaPLPs;
%[RastaPLP_PSTATES,RastaPLP_STATES,TRANS_EST2, EMIS_EST2,seq,states,N] = hmm_model(Data);
%figure();
%stairs(RastaPLP_PSTATES, 'LineWidth',2);
%set(gca, 'YGrid','on', 'YLim',[0 N+1]);
%xlabel('time'), ylabel('states');
%title('sequence of states');
%hold on; stairs(RastaPLP_STATES, 'LineWidth',2);





% --------------------------------------------------------------------
function activex4_Error(hObject, eventdata, handles)
% hObject    handle to activex4 (see GCBO)
% eventdata  structure with parameters passed to COM event listener
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton84.
function pushbutton84_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton84 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton85.
function pushbutton85_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton85 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in log_power_btn.
function log_power_btn_Callback(hObject, eventdata, handles)
% hObject    handle to log_power_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
wav_file=handles.sample_filepath_txt.String;
[Average_Power]= logpower(wav_file);
figure('Position', [30 30 800 600], 'PaperPositionMode', 'auto', ... 
              'color', 'w', 'PaperOrientation', 'landscape', 'Visible', 'on' ); 
subplot(3,1,1);
plot(Average_Power);
title('Average Power','FontSize',12,'Color','b');


% --- Executes on button press in log_energy_btn.
function log_energy_btn_Callback(hObject, eventdata, handles)
% hObject    handle to log_energy_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
wav_file=handles.sample_filepath_txt.String;
[Average_Energy]= logenergy(wav_file);
figure,plot(Average_Energy);
title('Average Power','FontSize',12,'Color','b');



% --- Executes during object creation, after setting all properties.
function speech_recognition_svm_btn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to speech_recognition_svm_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in svm_training_btn.
function svm_training_btn_Callback(hObject, eventdata, handles)
% hObject    handle to svm_training_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[Status] = svm_training();
set(handles.training_progress_text,'string',Status);


% --- Executes on button press in pushbutton88.
function pushbutton88_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton88 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in data_set_btn.
function data_set_btn_Callback(hObject, eventdata, handles)
% hObject    handle to data_set_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file_path=handles.train_path_txt.String ;
%audio_signals = randn(1,13); data = getappdata(gcbf, 'metricdata'); FileName=data.TrainFilename;
 %emotions = randn(1,13); mfccs =randn(1,13);[dim1 N1]= size(audio_signals);[dim2 N2]= size(emotions);
% audio_signals(dim1 + 1,:) = {file_path}; %#ok<AGROW>
% emotions(dim2 + 1,:) = FileName; %#ok<AGROW>
 [ mfc] = melfccformatching(file_path );mfccs =randn(1,13);
  a=transpose(mfc);
  mfc=mean(a); [dim N]= size(mfccs);
   mfccs(dim + 1,:)=mfc; 
  set(handles.training_progress_text,'string',mfccs); 
              


% --- Executes on button press in add_to_file_btn.
function add_to_file_btn_Callback(hObject, eventdata, handles)
% hObject    handle to add_to_file_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%Flag=0;
data = getappdata(gcbf, 'metricdata');
wav_file=handles.train_path_txt.String;
FilePath=data.TrainFilePath; FileName=data.TrainFilename;
File=load('speech.mat');
DataPaths=File.FilePath;
tf=strcmp(DataPaths,wav_file);
[rn,cn]=find(strcmp(DataPaths,wav_file));
Flag=tf(rn,cn); 
if (Flag==1)
 set(handles.training_progress_text,'string','This File Data already exists.');   end
set(handles.training_progress_text,'string','Extracting and Adding File Features.'); 
[status]= preparefile(FilePath,FileName,wav_file);
 set(handles.training_progress_text,'string',status); 
 


% --- Executes on button press in delete_data_btn.
function delete_data_btn_Callback(hObject, eventdata, handles)
% hObject    handle to delete_data_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Flag=1;
[status]= cleardata(Flag);
set(handles.training_progress_text,'string',status); 


% --- Executes on button press in delete_specific_data_btn.
function delete_specific_data_btn_Callback(hObject, eventdata, handles)
% hObject    handle to delete_specific_data_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in knn_training_btn.
function knn_training_btn_Callback(hObject, eventdata, handles)
% hObject    handle to knn_training_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[Status] = knn_training();
set(handles.training_progress_text,'string',Status);


% --- Executes on button press in pushbutton95.
function pushbutton95_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton95 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function activex6_Error(hObject, eventdata, handles)
% hObject    handle to activex6 (see GCBO)
% eventdata  structure with parameters passed to COM event listener
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in hmm_rbtn.
function hmm_rbtn_Callback(hObject, eventdata, handles)
% hObject    handle to hmm_rbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of hmm_rbtn
Classification_Model = '1';
data = getappdata(gcbf, 'metricdata');
data.Classification_Model= Classification_Model;
setappdata(gcbf, 'metricdata', data);


% --- Executes on button press in svm_rbtn.
function svm_rbtn_Callback(hObject, eventdata, handles)
% hObject    handle to svm_rbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of svm_rbtn
Classification_Model = '2';
data = getappdata(gcbf, 'metricdata');
data.Classification_Model= Classification_Model;
setappdata(gcbf, 'metricdata', data);


% --- Executes on button press in gmm_rbtn.
function gmm_rbtn_Callback(hObject, eventdata, handles)
% hObject    handle to gmm_rbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of gmm_rbtn
Classification_Model = '4';
data = getappdata(gcbf, 'metricdata');
data.Classification_Model= Classification_Model;
setappdata(gcbf, 'metricdata', data);


% --- Executes on button press in knn_rbtn.
function knn_rbtn_Callback(hObject, eventdata, handles)
% hObject    handle to knn_rbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of knn_rbtn
Classification_Model = '3';
data = getappdata(gcbf, 'metricdata');
data.Classification_Model= Classification_Model;
setappdata(gcbf, 'metricdata', data);


% --- Executes on button press in dtw_rbtn.
function dtw_rbtn_Callback(hObject, eventdata, handles)
% hObject    handle to dtw_rbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of dtw_rbtn
Classification_Model = '5';
data = getappdata(gcbf, 'metricdata');
data.Classification_Model= Classification_Model;
setappdata(gcbf, 'metricdata', data);


% --- Executes on button press in pushbutton98.
function pushbutton98_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton98 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton99.
function pushbutton99_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton99 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in save_excel.
function save_excel_Callback(hObject, eventdata, handles)
% hObject    handle to save_excel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in save_pdf.
function save_pdf_Callback(hObject, eventdata, handles)
% hObject    handle to save_pdf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in merge_all_rbtn.
function merge_all_rbtn_Callback(hObject, eventdata, handles)
% hObject    handle to merge_all_rbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of merge_all_rbtn
Classification_Model = '6';
data = getappdata(gcbf, 'metricdata');
data.Classification_Model= Classification_Model;
setappdata(gcbf, 'metricdata', data);


% --- Executes on button press in pitch_autocorrelation.
function pitch_autocorrelation_Callback(hObject, eventdata, handles)
% hObject    handle to pitch_autocorrelation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
wav_file=handles.sample_filepath_txt.String;
[ pitch_freq_Fo] = pitch_autocor_extraction (wav_file);

set(handles.result_text,'string','Pitch Frequency:');
set(handles.result_text,'string',pitch_freq_Fo);
set(handles.unit_text,'string','Hz');



% --- Executes on button press in zero_passages.
function zero_passages_Callback(hObject, eventdata, handles)
% hObject    handle to zero_passages (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in help_btn.
function pushbutton106_Callback(hObject, eventdata, handles)
% hObject    handle to help_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton107.
function pushbutton107_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton107 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton108.
function pushbutton108_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton108 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox6


% --- Executes on button press in checkbox7.
function checkbox7_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox7


% --- Executes on button press in checkbox8.
function checkbox8_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox8


% --- Executes on button press in checkbox9.
function checkbox9_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox9


% --- Executes on button press in checkbox10.
function checkbox10_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox10


% --- Executes on button press in checkbox11.
function checkbox11_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox11


% --- Executes on button press in pushbutton109.
function pushbutton109_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton109 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton110.
function pushbutton110_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton110 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in cnn_training_btn.
function cnn_training_btn_Callback(hObject, eventdata, handles)
% hObject    handle to cnn_training_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in dnn_training_btn.
function dnn_training_btn_Callback(hObject, eventdata, handles)
% hObject    handle to dnn_training_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in dbn_traning_btn.
function dbn_traning_btn_Callback(hObject, eventdata, handles)
% hObject    handle to dbn_traning_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton113.
function pushbutton113_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton113 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton114.
function pushbutton114_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton114 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton115.
function pushbutton115_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton115 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in gmm_training_btn.
f
unction gmm_training_btn_Callback(hObject, eventdata, handles)
% hObject    handle to gmm_training_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[Status] = gmm_training();
set(handles.training_progress_text,'string',Status);



% --- Executes on button press in pushbutton120.
function pushbutton120_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton120 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton121.
function pushbutton121_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton121 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton122.
function pushbutton122_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton122 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton123.
function pushbutton123_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton123 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in hmm_training_btn.
function hmm_training_btn_Callback(hObject, eventdata, handles)
% hObject    handle to hmm_training_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in dbn_training_btn.
function dbn_training_btn_Callback(hObject, eventdata, handles)
% hObject    handle to dbn_training_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in sae_training_btn.
function sae_training_btn_Callback(hObject, eventdata, handles)
% hObject    handle to sae_training_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton128.
function pushbutton128_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton128 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton129.
function pushbutton129_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton129 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton130.
function pushbutton130_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton130 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton131.
function pushbutton131_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton131 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in dnn_btn.
function dnn_btn_Callback(hObject, eventdata, handles)
% hObject    handle to dnn_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of dnn_btn


% --- Executes on button press in cnn_btn.
function cnn_btn_Callback(hObject, eventdata, handles)
% hObject    handle to cnn_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cnn_btn


% --- Executes on button press in dbn_btn.
function dbn_btn_Callback(hObject, eventdata, handles)
% hObject    handle to dbn_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of dbn_btn


% --- Executes on button press in sae_btn.
function sae_btn_Callback(hObject, eventdata, handles)
% hObject    handle to sae_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of sae_btn


% --- Executes on button press in radiobutton11.
function radiobutton11_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton11


% --- Executes on button press in radiobutton12.
function radiobutton12_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton12


% --- Executes on button press in radiobutton13.
function radiobutton13_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton13


% --- Executes on button press in radiobutton14.
function radiobutton14_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton14


% --- Executes on button press in nn_training_btn.
function nn_training_btn_Callback(hObject, eventdata, handles)
% hObject    handle to nn_training_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 Status = nn_training();
set(handles.training_progress_text,'string',Status);

% --- Executes on button press in pushbutton137.
function pushbutton137_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton137 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton138.
function pushbutton138_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton138 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton139.
function pushbutton139_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton139 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton140.
function pushbutton140_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton140 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton141.
function pushbutton141_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton141 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton142.
function pushbutton142_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton142 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton143.
function pushbutton143_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton143 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton144.
function pushbutton144_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton144 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in svm_recognition_btn.
function svm_recognition_btn_Callback(hObject, eventdata, handles)
% hObject    handle to svm_recognition_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 wav_file=handles.sample_filepath_txt.String;
[Emotion,Emotion_Score,Emotion_Cost,Emotion_Error] = svm_classification(wav_file);
C = get(handles.Category_table, 'data');
Category_Score=num2cell(max(Emotion_Score)/56);
Categories_Error=num2cell(Emotion_Error/56);

C(1,1)= {Emotion};%assign a cell array
C(1,2)= Category_Score;
C(1,3)= Categories_Error;
set(handles.Category_table, 'data', C);
axes(handles.category_graph)
bar(Emotion_Score);
xlabel(' (1) Normal  (2) Special'); 
title('SVM Language Disorder Result');



% --- Executes on button press in knn_recognition_btn.
function knn_recognition_btn_Callback(hObject, eventdata, handles)
% hObject    handle to knn_recognition_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
wav_file=handles.sample_filepath_txt.String;
[Category,Category_score,Categories_error,Category_cost] = knn_classification(wav_file);
C = get(handles.Category_table, 'data');
Category_Score=num2cell(max(Category_score));
Categories_Error=num2cell(Categories_error);

C(2,1)= Category;%assign a cell array
C(2,2)= Category_Score;
C(2,3)= Categories_Error;
set(handles.Category_table, 'data', C);
axes(handles.category_graph)
bar(Category_score);
xlabel(' (1) Normal  (2) Special'); 
title('KNN Language Disorder Result');


% --- Executes on button press in cnn_recognition_btn.
function cnn_recognition_btn_Callback(hObject, eventdata, handles)
% hObject    handle to cnn_recognition_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in dtw_classification_btn.
function dtw_classification_btn_Callback(hObject, eventdata, handles)
% hObject    handle to dtw_classification_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
wav_file=handles.sample_filepath_txt.String;
[Category,Category_Cost,Category_Score,Category_Error,DTW_Categories] = comparison(wav_file);
C = get(handles.Category_table, 'data');
Category_Score=num2cell(Category_Score);
Categories_Error=num2cell(Category_Error);
C(4,1)= Category;%assign a cell array
C(4,2)= Category_Score;
C(4,3)= Categories_Error;
set(handles.Category_table, 'data', C);
axes(handles.category_graph)
bar(DTW_Categories);
xlabel(' (1) Normal  (2) Special'); 
title('DTW Distance');




% --- Executes on button press in nn_recogntion_btn.
function nn_recogntion_btn_Callback(hObject, eventdata, handles)
% hObject    handle to nn_recogntion_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
wav_file=handles.sample_filepath_txt.String;
[Category,Category_cost,Category_output,Category_error]=neural_network_classification(wav_file);
C = get(handles.Category_table, 'data');
Category_Score=num2cell(max(Category_output));
Categories_Error=num2cell(Category_error);

C(3,1)= Category;%assign a cell array
C(3,2)= Category_Score;
C(3,3)= Categories_Error;
set(handles.Category_table, 'data', C);
axes(handles.category_graph)
bar(Category_output);
xlabel(' (1) NA  (2) SA (3)NH (4)SH (5)NN (6)SN (7)NS (8)SS'); 
title('NN Language Disorder Result');



% --- Executes on button press in save_excel_png_btn.
function save_excel_png_btn_Callback(hObject, eventdata, handles)
% hObject    handle to save_excel_png_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in compare_btn.
function compare_btn_Callback(hObject, eventdata, handles)
% hObject    handle to compare_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in save_anlysis_btn.
function save_anlysis_btn_Callback(hObject, eventdata, handles)
% hObject    handle to save_anlysis_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in save_excel_btn.
function save_excel_btn_Callback(hObject, eventdata, handles)
% hObject    handle to save_excel_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in manage_btn.
function manage_btn_Callback(hObject, eventdata, handles)
% hObject    handle to manage_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in dtw_data_preperation_btn.
function dtw_data_preperation_btn_Callback(hObject, eventdata, handles)
% hObject    handle to dtw_data_preperation_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Status = DTW_data();
set(handles.training_progress_text,'string',Status);



% --- Executes on button press in svm_error_performace_btn.
function svm_error_performace_btn_Callback(hObject, eventdata, handles)
% hObject    handle to svm_error_performace_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in knn_error_performace_btn.
function knn_error_performace_btn_Callback(hObject, eventdata, handles)
% hObject    handle to knn_error_performace_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in nn_error_performace_btn.
function nn_error_performace_btn_Callback(hObject, eventdata, handles)
% hObject    handle to nn_error_performace_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in nn_analysis_btn.
function nn_analysis_btn_Callback(hObject, eventdata, handles)
% hObject    handle to nn_analysis_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[Category_Error_Rate,Category_Accuracy_Rate,Emotion_Error_Rate,Emotion_Accuracy_Rate]= NN_Test();
C = get(handles.error_table, 'data');
C(3,1)= num2cell(Category_Error_Rate);%assign a cell array
C(3,2)= num2cell(Category_Accuracy_Rate);
set(handles.error_table, 'data', C);
E = get(handles.algo_emotion_table, 'data');
E(3,1)= num2cell(Emotion_Error_Rate);%assign a cell array
E(3,2)= num2cell(Emotion_Accuracy_Rate);
set(handles.algo_emotion_table, 'data', E);


% --- Executes on button press in svm_analysis_btn.
function svm_analysis_btn_Callback(hObject, eventdata, handles)
% hObject    handle to svm_analysis_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[Normal_Error_Rate,Normal_Accuracy_Rate,Special_Error_Rate,Special_Accuracy_Rate]= SVM_Test();

C = get(handles.error_table, 'data');
C(1,1)= num2cell(Normal_Error_Rate(1,1));%assign a cell array
C(1,2)= num2cell(Normal_Error_Rate(1,2));
C(1,3)= num2cell(Normal_Error_Rate(1,3));%assign a cell array
C(1,4)= num2cell(Normal_Error_Rate(1,4));
C(1,5)= num2cell(Special_Error_Rate(1,1));%assign a cell array
C(1,6)= num2cell(Special_Error_Rate(1,2));
C(1,7)= num2cell(Special_Error_Rate(1,3));%assign a cell array
C(1,8)= num2cell(Special_Error_Rate(1,4));
set(handles.error_table, 'data', C);
E = get(handles.performance_table, 'data');
E(1,1)= num2cell(Normal_Accuracy_Rate(1,1));%assign a cell array
E(1,2)= num2cell(Normal_Accuracy_Rate(1,2));
E(1,3)= num2cell(Normal_Accuracy_Rate(1,3));%assign a cell array
E(1,4)= num2cell(Normal_Accuracy_Rate(1,4));
E(1,5)= num2cell(Special_Accuracy_Rate(1,1));%assign a cell array
E(1,6)= num2cell(Special_Accuracy_Rate(1,2));
E(1,7)= num2cell(Special_Accuracy_Rate(1,3));%assign a cell array
E(1,8)= num2cell(Special_Accuracy_Rate(1,4));
set(handles.performance_table, 'data', E);



% --- Executes on button press in knn_analysis_btn.
function knn_analysis_btn_Callback(hObject, eventdata, handles)
% hObject    handle to knn_analysis_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[Normal_Error_Rate,Normal_Accuracy_Rate,Special_Error_Rate,Special_Accuracy_Rate]= KNN_Test();
C = get(handles.error_table, 'data');
C(2,1)= num2cell(Normal_Error_Rate(1,1));%assign a cell array
C(2,2)= num2cell(Normal_Error_Rate(1,2));
C(2,3)= num2cell(Normal_Error_Rate(1,3));%assign a cell array
C(2,4)= num2cell(Normal_Error_Rate(1,4));
C(2,5)= num2cell(Special_Error_Rate(1,1));%assign a cell array
C(2,6)= num2cell(Special_Error_Rate(1,2));
C(2,7)= num2cell(Special_Error_Rate(1,3));%assign a cell array
C(2,8)= num2cell(Special_Error_Rate(1,4));
set(handles.error_table, 'data', C);
E = get(handles.performance_table, 'data');
E(2,1)= num2cell(Normal_Accuracy_Rate(1,1));%assign a cell array
E(2,2)= num2cell(Normal_Accuracy_Rate(1,2));
E(2,3)= num2cell(Normal_Accuracy_Rate(1,3));%assign a cell array
E(2,4)= num2cell(Normal_Accuracy_Rate(1,4));
E(2,5)= num2cell(Special_Accuracy_Rate(1,1));%assign a cell array
E(2,6)= num2cell(Special_Accuracy_Rate(1,2));
E(2,7)= num2cell(Special_Accuracy_Rate(1,3));%assign a cell array
E(2,8)= num2cell(Special_Accuracy_Rate(1,4));
set(handles.performance_table, 'data', E);

% --- Executes on button press in dtw_analysis_btn.
function dtw_analysis_btn_Callback(hObject, eventdata, handles)
% hObject    handle to dtw_analysis_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in hybrid_analysis_btn.
function hybrid_analysis_btn_Callback(hObject, eventdata,handles)
% hObject    handle to hybrid_analysis_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[Category_Error_Rate,Category_Accuracy_Rate,Emotion_Error_Rate,Emotion_Accuracy_Rate]= Hybrid_Test();
C = get(handles.error_table, 'data');
C(5,1)= num2cell(Category_Error_Rate);%assign a cell array
C(5,2)= num2cell(Category_Accuracy_Rate);
set(handles.error_table, 'data', C);
E = get(handles.algo_emotion_table, 'data');
E(5,1)= num2cell(Emotion_Error_Rate);%assign a cell array
E(5,2)= num2cell(Emotion_Accuracy_Rate);
set(handles.algo_emotion_table, 'data', E);


% --- Executes on button press in hybrid_algo_btn.
function hybrid_algo_btn_Callback(hObject, eventdata, handles)
% hObject    handle to hybrid_algo_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
wav_file=handles.sample_filepath_txt.String;
[Category,Category_Score,Category_Cost,Category_Error,Emotion,Emotion_Score, Emotion_Cost,Emotion_Error]=hybrid_Classification(wav_file);
C = get(handles.Category_table, 'data');
Categories_Score=num2cell(max(Category_Score)/2);
Categories_Error=num2cell(Category_Error/2);
Emotions_Score=num2cell(max(Emotion_Score)/2);
Emotion_Error=num2cell(Emotion_Error/2);

C(5,1)= Category;%assign a cell array
C(5,2)= Categories_Score;
C(5,3)= Categories_Error;
C(5,4)= Emotion;
C(5,5)=Emotions_Score;
C(5,6)=Emotion_Error;
set(handles.Category_table, 'data', C);
axes(handles.category_graph)
bar(Category_Score);
xlabel(' (1) Normal  (2) Special'); 
title('	Hybrid Language Disorder Result');
axes(handles.emotion_graph)
bar(Emotion_Score); xlabel('(1) Angry (2) Happy (3) Neutral (4) Sad'); 
title('Hybrid Emotions Result');
