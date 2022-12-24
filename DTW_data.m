function Status = DTW_data()
  File=load('speech');
 %--------------Angry------------
 [rn,cn]=find(strcmp(File.categories,'Normal Angry'));
 Normal_Angry_features=mean(File.features(rn,:));
 save('dtwdata.mat','Normal_Angry_features','-append');
  [rn,cn]=find(strcmp(File.categories,'Special Angry'));
 Special_Angry_features=mean(File.features(rn,:));
 save('dtwdata.mat','Special_Angry_features','-append');
 %----------------Happy--------------------------------
  [rn,cn]=find(strcmp(File.categories,'Normal Happy'));
 Normal_Happy_features=mean(File.features(rn,:));
 save('dtwdata.mat','Normal_Happy_features','-append');
  [rn,cn]=find(strcmp(File.categories,'Special Happy'));
 Special_Happy_features=mean(File.features(rn,:));
 save('dtwdata.mat','Special_Happy_features','-append');
 %-------------Neutral-------------------
  [rn,cn]=find(strcmp(File.categories,'Normal Neutral'));
 Normal_Neutral_features=mean(File.features(rn,:));
 save('dtwdata.mat','Normal_Neutral_features','-append');
   [rn,cn]=find(strcmp(File.categories,'Special Neutral'));
 Special_Neutral_features=mean(File.features(rn,:));
 save('dtwdata.mat','Special_Neutral_features','-append');
 %------------------Sad-------------------------------
  [rn,cn]=find(strcmp(File.categories,'Normal Sad'));
Normal_Sad_features=mean(File.features(rn,:));
 save('dtwdata.mat','Normal_Sad_features','-append');
   [rn,cn]=find(strcmp(File.categories,'Special Sad'));
Special_Sad_features=mean(File.features(rn,:));
 save('dtwdata.mat','Special_Sad_features','-append');
Status='DTW has been Trained.';