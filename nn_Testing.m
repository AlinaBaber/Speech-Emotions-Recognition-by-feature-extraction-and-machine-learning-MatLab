function [Categoryerrors,Categoryperformance,Emotionerrors,Emotionperformance]=nn_Testing()
MFile= load('nnmodels');
File=load('speech');
Features= transpose(File.features);
outputs = MFile.NNStruct_categories(Features);
Categoryerrors = gsubtract(transpose(File.categories_nn),outputs);
Categoryperformance = perform(MFile.NNStruct_categories,transpose(File.categories_nn),outputs);
% Plots
figure, plotconfusion(transpose(File.categories_nn),outputs)
figure, ploterrhist(Categoryerrors)
Categoryerrors=transpose(Categoryerrors);
Categoryerrors=mean(Categoryerrors);

outputs = MFile.NNStruct_emotions(Features);
Emotionerrors = gsubtract(transpose(File.emotions_nn),outputs);
Emotionperformance = perform(MFile.NNStruct_emotions,transpose(File.emotions_nn),outputs);
% Plots
figure, plotconfusion(transpose(File.emotions_nn),outputs)
figure, ploterrhist(Emotionerrors)
Emotionerrors=transpose(Emotionerrors);
Emotionerrors=mean(Emotionerrors);
