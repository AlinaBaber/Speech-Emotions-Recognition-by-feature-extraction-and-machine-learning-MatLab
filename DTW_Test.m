function [Category_Error_Rate,Category_Accuracy_Rate]= DTW_Test()
File=load('speech');
[row,col]=size(File.features); Categories={}; Emotions={};
for i=1:row
Category = DTW_comparison_test(File.features(i,:));
Categories(i)={Category};
end
DTW_Category_Analysis = classperf(File.categories,Categories);
Category_Error_Rate=DTW_Category_Analysis.ErrorRate;
Category_Accuracy_Rate=DTW_Category_Analysis.CorrectRate;
