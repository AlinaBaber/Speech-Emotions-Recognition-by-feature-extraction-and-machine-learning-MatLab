function [Category,Emotion]=hybrid_classification_Test(Hybrid_Features)
%=============SVM===========================%
[SVMCategory,SVMCategory_score,SVMCategory_Cost,SVMCategory_error,SVMEmotion,SVMEmotion_Score,SVMEmotion_Cost,SVMEmotion_Error]= svm_hybrid(Hybrid_Features);
%==============NN==========================%
[NNCategory,NNEmotion]=hybrid_nn_Classification_test(Hybrid_Features);
HybridCategory=[SVMCategory,NNCategory];
No=sum(sum(strcmp(HybridCategory,'Normal')));
S=sum(sum(strcmp(HybridCategory,'Special')));
Ca=max([No,S]);
if Ca==No
   Category ={'Normal'};
else
   Category ={'Special'};
end
HybridEmotion=[SVMEmotion,NNEmotion];


A=sum(sum(strcmp(HybridEmotion,'Angry')));
H=sum(sum(strcmp(HybridEmotion,'Happy')));
N=sum(sum(strcmp(HybridEmotion,'Neutral')));
S=sum(sum(strcmp(HybridEmotion,'Sad')));
Em=max([A,H,N,S]);
if Em==A
   Emotion ={'Angry'};

end
if Em==H
   Emotion ={'Happy'};

end
if Em==N
   Emotion={'Neutral'};

end
if Em==S
    Emotion={'Sad'}; 
end
