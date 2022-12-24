function [Category_Error_Rate,Category_Accuracy_Rate]= KNN_Test()
MFile=load('knnmodels');
File=load('speech');
%==================Speech Disorder======================================%
[Category,Category_score,Category_cost] = predict(MFile.KNNStruct_categories,File.features);
KNN_Category_Analysis = classperf(File.categories,Category);
Category_Error_Rate=KNN_Category_Analysis.ErrorRate;
Category_Accuracy_Rate=KNN_Category_Analysis.CorrectRate;
