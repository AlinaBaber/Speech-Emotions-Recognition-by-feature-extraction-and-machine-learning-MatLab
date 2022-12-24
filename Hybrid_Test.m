function [Category_Error_Rate,Category_Accuracy_Rate,Emotion_Error_Rate,Emotion_Accuracy_Rate]= Hybrid_Test()
File=load('speech');
[row,col]=size(File.hybrid_features); Categories={}; Emotions={};
for i=1:row
[Category,Emotion]=hybrid_classification_Test(File.hybrid_features(i,:));
Categories(i)=Category;
Emotions(i)=Emotion;
end
SVM_Category_Analysis = classperf(File.categories,Categories);
Category_Error_Rate=SVM_Category_Analysis.ErrorRate;
Category_Accuracy_Rate=SVM_Category_Analysis.CorrectRate;
SVM_Emotion_Analysis = classperf(File.emotions,Emotions);
Emotion_Error_Rate=SVM_Emotion_Analysis.ErrorRate;
Emotion_Accuracy_Rate=SVM_Emotion_Analysis.CorrectRate;

