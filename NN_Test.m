function [Categories,Category_Error_Rate,Category_Accuracy_Rate]= NN_Test()
File=load('speech');
[row,col]=size(File.features); Categories={}; Emotions={};
for i=1:row
[Category,Category_cost,Category_output]=neural_network_classification_Test(File.features(i,:));
Categories(i)=Category;

end
SVM_Category_Analysis = classperf(File.categories,Categories);
Category_Error_Rate=SVM_Category_Analysis.ErrorRate;
Category_Accuracy_Rate=SVM_Category_Analysis.CorrectRate;

