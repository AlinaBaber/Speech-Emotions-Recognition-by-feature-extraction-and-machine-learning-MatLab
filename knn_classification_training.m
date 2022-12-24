function [Category,Category_score,Category_cost] = knn_classification_training()
MFile= load('knnmodels');
File= load('speech');
%==================Speech Disorder======================================%
[Category,Category_score,Category_cost] = predict(MFile.KNNStruct_categories,File.features);


