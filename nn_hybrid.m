function [Category,Category_output,Emotion,Emotions_output]=nn_hybrid(Features)
MFile= load('nnmodels'); Emotion={};
%Tr_categories=MFile.NNTr_categories;
%Tr_emotions=MFile.NNTr_emotions;
%==================Speech Disorder======================================%
% Test the Network
Features=transpose(Features);
Category_output=MFile.NNStruct_categories(Features);
A=max(Category_output);
if A==Category_output(1)
    Category={'Normal'};
else
   Category={'Special'}; 
end
% Plots
% Uncomment these lines to enable various plots.
% figure, plotperform(tr)
% figure, plottrainstate(tr)
%figure, plotconfusion(targets1,Category_output)
%figure, ploterrhist(Category_errors)
%Categories_errors = gsubtract(targets,frequency_categories_outputs);
%Categories_performance = perform(MFile.NNStruct_frequency_categories,targets,frequency_categories_outputs);
%==================Speech Emotions======================================%
Emotions_output=MFile.NNStruct_emotions(Features);
%frequency_errors = gsubtract(targets,frequency_emotions_outputs);
%frequency_performance = perform(MFile.NNStruct_frequency_emotions,targets,frequency_emotions_outputs);


% Plots
% Uncomment these lines to enable various plots.
% figure, plotperform(tr)
%figure, plottrainstate(tr)
%figure, plotconfusion(targets2,Emotions_output)
%figure, ploterrhist(Emotion_errors)
A=max(Emotions_output);
if A==Emotions_output(1)
    Emotion={'Angry'};
end
if A==Emotions_output(2)
   Emotion={'Happy'}; 
end
if A==Emotions_output(3)
   Emotion={'Neutral'}; 
end
if A==Emotions_output(4)
   Emotion={'Sad'};  
end
%figure, ploterrhist(errors);