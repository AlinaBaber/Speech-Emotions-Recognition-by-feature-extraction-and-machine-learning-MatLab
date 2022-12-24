function [Status] = knn_training()
File=load('speech');
%==================Speech Disorder======================================%

rng(100);
KNNStruct_categories = fitcknn(File.features,File.categories,'NumNeighbors',5);
save('knnmodels.mat','KNNStruct_categories','-append');
Status= 'KNN Model has been Trained';