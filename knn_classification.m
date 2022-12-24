function [Category,Category_score,Categories_error,Category_cost] = knn_classification(wav_file)
Features= allfeatures_extraction( wav_file );
MFile= load('knnmodels');
%==================Speech Disorder======================================%
[Category,Category_score,Category_cost] = predict(MFile.KNNStruct_categories,Features);
Categories_error = loss(MFile.KNNStruct_categories,Features,Category);

