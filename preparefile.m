function [status]= preparefile(FilePath,FileName,wav_file)

[SVMCategory,SVMCategory_Score,SVMCategory_Cost,SVMCategory_Error] = svm_classification(wav_file);
[KNNCategory,KNNCategory_score,KNNCategories_error,KNNCategory_cost] = knn_classification(wav_file);
[NNCategory,NNCategory_cost,NNCategory_output,NNCategory_error]=neural_network_classification(wav_file);
[DTWCategory,DTWCategory_Cost,DTWCategory_Score,DTWCategory_Error,DTW_Categories] = comparison(wav_file);
 %------(1)--------- Features-----------
%File_features=Features; 
%File.frequency(end+1,end+1)=File_Frequency; 
%features=[File.features;File_features;];
%save('speech.mat','features','-append');
File_hybrid_features=[SVMCategory_Score,SVMCategory_Cost,KNNCategory_score,KNNCategory_cost,NNCategory_cost,transpose(NNCategory_output),DTWCategory_Cost,transpose(DTW_Categories)];
hybrid_features=[File.hybrid_features;File_hybrid_features];
save('speech.mat','hybrid_features','-append');
File_emotions=[SVMCategory,KNNCategory,NNCategory,DTWCategory];
%File.emotions(end+1,:)=File_emotions; 
results=[File.results;File_emotions]; 
save('speech.mat','results','-append');
status=' All Features are Extracted ,File is Prepared for Training';