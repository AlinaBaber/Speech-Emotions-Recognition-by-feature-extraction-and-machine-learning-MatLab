function [Emotion_Error_Rate,Emotion_Accuracy_Rate]= SVM_Test()
File=load('speech');
%==========================Normal================================%
[row,col]=size(File.features); Categories={}; Emotions={};
for i=1:row
[Emotion,Emotion_Score,Emotion_Cost,Emotion_Error] = svm_classification_test(File.features(i,:));
Emotions(i,:)={Emotion};
end
SVM_Emotion_Analysis = classperf(File.categories,Emotions);
Emotion_Error_Rate=SVM_Emotion_Analysis.ErrorRate;
Emotion_Accuracy_Rate=SVM_Emotion_Analysis.CorrectRate;
