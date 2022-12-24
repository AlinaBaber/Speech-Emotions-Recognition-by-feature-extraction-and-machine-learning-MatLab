function Status = nn_training()
File=load('speech');
%==================Speech Disorder======================================%
%----(1)----------Frequency--------------

[NNStruct_categories,NNTr_categories] = neural_network_training(File.features,File.categories_nn);
save('nnmodels.mat','NNStruct_categories','-append');
save('nnmodels.mat','NNTr_categories','-append');
figure, plotperform(NNTr_categories);
figure, plottrainstate(NNTr_categories);
Status= 'NN Model has been Trained';