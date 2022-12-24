function [Category,Category_cost,Category_output]=neural_network_classification_Test(Features)
%Features= allfeatures_extraction( wav_file );
MFile= load('nnmodels'); %File= load('speech');
%Tr_categories=MFile.NNTr_categories;
%Tr_emotions=MFile.NNTr_emotions;
%[rn,col]=find(strcmp(File.features,Features));
%targets1=transpose(File.categories_nn(col,:));
%targets2=transpose(File.emotions_nn(col,:));
%==================Speech Disorder======================================%
%==================Speech Disorder======================================%
% Test the Network
Features=transpose(Features);
Category_output=MFile.NNStruct_categories(Features);
%Category_errors = gsubtract(targets1,Category_output);
%performance1 = perform(MFile.NNStruct_categories,targets1(1),Category_output);
%performance2 = perform(MFile.NNStruct_categories,targets1(2),Category_output);
%Category_performance= max([performance1,performance2]);
%Category_error=min(Category_errors);
A=max(Category_output);
if A==Category_output(1)
    Category={'Normal Angry'};
    Category_cost=[1,0,0,0,0,0,0,0];
end
if A==Category_output(2)
    Category={'Special Angry'}; 
    Category_cost=[0,1,0,0,0,0,0,0];
end
if A==Category_output(3)
    Category={'Normal Happy'}; 
    Category_cost=[0,0,1,0,0,0,0,0];
end
if A==Category_output(4)
    Category={'Special Happy'}; 
    Category_cost=[0,0,0,1,0,0,0,0];
end
if A==Category_output(5)
    Category={'Normal Neutral'};
    Category_cost=[1,0,0,0,0,0,0,0];
end
if A==Category_output(6)
    Category={'Special Neutral'}; 
    Category_cost=[0,1,0,0,0,0,0,0];
end
if A==Category_output(7)
    Category={'Normal Sad'}; 
    Category_cost=[0,0,1,0,0,0,0,0];
end
if A==Category_output(8)
    Category={'Special Sad'}; 
    Category_cost=[0,0,0,1,0,0,0,0];
end
% Plots
% Uncomment these lines to enable various plots.
% figure, plotperform(tr)
% figure, plottrainstate(tr)
%figure, plotconfusion(targets1,Category_output)
%figure, ploterrhist(Category_errors)
%Categories_errors = gsubtract(targets,frequency_categories_outputs);
%Categories_performance = perform(MFile.NNStruct_frequency_categories,targets,frequency_categories_outputs);
