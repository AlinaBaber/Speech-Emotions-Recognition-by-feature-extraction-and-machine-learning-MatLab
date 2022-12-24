function [Emotion,Emotion_Score,Emotion_Cost,Emotion_Error] = svm_classification_test(Features)

MFile= load('svmmodels');
%File= load('speech');
%====================Normal===================================%
%-------------------Angry-------------------------------%
[N_Angry_N_Happy_Category,N_Angry_N_Happy_Score,N_Angry_N_Happy_Cost] = predict(MFile.SVMStruct_N_Angry_N_Happy,Features);
[N_Angry_N_Neutral_Category,N_Angry_N_Neutral_Score,N_Angry_N_Neutral_Cost] = predict(MFile.SVMStruct_N_Angry_N_Neutral,Features);
[N_Angry_N_Sad_Category,N_Angry_N_Sad_Score,N_Angry_N_Sad_Cost] = predict(MFile.SVMStruct_N_Angry_N_Sad,Features);
[N_Angry_S_Angry_Category,N_Angry_S_Angry_Score,N_Angry_S_Angry_Cost] = predict(MFile.SVMStruct_N_Angry_S_Angry,Features);
[N_Angry_S_Happy_Category,N_Angry_S_Happy_Score,N_Angry_S_Happy_Cost] = predict(MFile.SVMStruct_N_Angry_S_Happy,Features);
[N_Angry_S_Neutral_Category,N_Angry_S_Neutral_Score,N_Angry_S_Neutral_Cost] = predict(MFile.SVMStruct_N_Angry_S_Neutral,Features);
[N_Angry_S_Sad_Category,N_Angry_S_Sad_Score,N_Angry_S_Sad_Cost] = predict(MFile.SVMStruct_N_Angry_S_Sad,Features);
N_Angry=[N_Angry_N_Happy_Category,N_Angry_N_Neutral_Category,N_Angry_N_Sad_Category,N_Angry_S_Angry_Category,N_Angry_S_Happy_Category,N_Angry_S_Neutral_Category,N_Angry_S_Sad_Category];
%------------------Happy---------------------------------%
[N_Happy_N_Angry_Category,N_Happy_N_Angry_Score,N_Happy_N_Angry_Cost] = predict(MFile.SVMStruct_N_Happy_N_Angry,Features);
[N_Happy_N_Neutral_Category,N_Happy_N_Neutral_Score,N_Happy_N_Neutral_Cost] = predict(MFile.SVMStruct_N_Happy_N_Neutral,Features);
[N_Happy_N_Sad_Category,N_Happy_N_Sad_Score,N_Happy_N_Sad_Cost] = predict(MFile.SVMStruct_N_Happy_N_Sad,Features);
[N_Happy_S_Angry_Category,N_Happy_S_Angry_Score,N_Happy_S_Angry_Cost] = predict(MFile.SVMStruct_N_Happy_S_Angry,Features);
[N_Happy_S_Happy_Category,N_Happy_S_Happy_Score,N_Happy_S_Happy_Cost] = predict(MFile.SVMStruct_N_Happy_S_Happy,Features);
[N_Happy_S_Neutral_Category,N_Happy_S_Neutral_Score,N_Happy_S_Neutral_Cost] = predict(MFile.SVMStruct_N_Happy_S_Neutral,Features);
[N_Happy_S_Sad_Category,N_Happy_S_Sad_Score,N_Happy_S_Sad_Cost] = predict(MFile.SVMStruct_N_Happy_S_Sad,Features);
N_Happy=[N_Happy_N_Angry_Category,N_Happy_N_Neutral_Category,N_Happy_N_Sad_Category,N_Happy_S_Angry_Category,N_Happy_S_Happy_Category,N_Happy_S_Neutral_Category,N_Happy_S_Sad_Category];
%------------------Neutral-------------------------------%
[N_Neutral_N_Happy_Category,N_Neutral_N_Happy_Score,N_Neutral_N_Happy_Cost] = predict(MFile.SVMStruct_N_Neutral_N_Happy,Features);
[N_Neutral_N_Angry_Category,N_Neutral_N_Angry_Score,N_Neutral_N_Angry_Cost] = predict(MFile.SVMStruct_N_Neutral_N_Angry,Features);
[N_Neutral_N_Sad_Category,N_Neutral_N_Sad_Score,N_Neutral_N_Sad_Cost] = predict(MFile.SVMStruct_N_Neutral_N_Sad,Features);
[N_Neutral_S_Angry_Category,N_Neutral_S_Angry_Score,N_Neutral_S_Angry_Cost] = predict(MFile.SVMStruct_N_Neutral_S_Angry,Features);
[N_Neutral_S_Happy_Category,N_Neutral_S_Happy_Score,N_Neutral_S_Happy_Cost] = predict(MFile.SVMStruct_N_Neutral_S_Happy,Features);
[N_Neutral_S_Neutral_Category,N_Neutral_S_Neutral_Score,N_Neutral_S_Neutral_Cost] = predict(MFile.SVMStruct_N_Neutral_S_Neutral,Features);
[N_Neutral_S_Sad_Category,N_Neutral_S_Sad_Score,N_Neutral_S_Sad_Cost] = predict(MFile.SVMStruct_N_Neutral_S_Sad,Features);
N_Neutral=[N_Neutral_N_Happy_Category,N_Neutral_N_Angry_Category,N_Neutral_N_Sad_Category,N_Neutral_S_Angry_Category,N_Neutral_S_Happy_Category,N_Neutral_S_Neutral_Category,N_Neutral_S_Sad_Category];
%------------------Sad-----------------------------------%
[N_Sad_N_Happy_Category,N_Sad_N_Happy_Score,N_Sad_N_Happy_Cost] = predict(MFile.SVMStruct_N_Sad_N_Happy,Features);
[N_Sad_N_Neutral_Category,N_Sad_N_Neutral_Score,N_Sad_N_Neutral_Cost] = predict(MFile.SVMStruct_N_Sad_N_Neutral,Features);
[N_Sad_N_Angry_Category,N_Sad_N_Angry_Score,N_Sad_N_Angry_Cost] = predict(MFile.SVMStruct_N_Sad_N_Angry,Features);
[N_Sad_S_Angry_Category,N_Sad_S_Angry_Score,N_Sad_S_Angry_Cost] = predict(MFile.SVMStruct_N_Sad_S_Angry,Features);
[N_Sad_S_Happy_Category,N_Sad_S_Happy_Score,N_Sad_S_Happy_Cost] = predict(MFile.SVMStruct_N_Sad_S_Happy,Features);
[N_Sad_S_Neutral_Category,N_Sad_S_Neutral_Score,N_Sad_S_Neutral_Cost] = predict(MFile.SVMStruct_N_Sad_S_Neutral,Features);
[N_Sad_S_Sad_Category,N_Sad_S_Sad_Score,N_Sad_S_Sad_Cost] = predict(MFile.SVMStruct_N_Sad_S_Sad,Features);
N_Sad=[N_Sad_N_Happy_Category,N_Sad_N_Neutral_Category,N_Sad_N_Angry_Category,N_Sad_S_Angry_Category,N_Sad_S_Happy_Category,N_Sad_S_Neutral_Category,N_Sad_S_Sad_Category];
%====================Special===================================%
%-------------------Angry-------------------------------%
[S_Angry_S_Happy_Category,S_Angry_S_Happy_Score,S_Angry_S_Happy_Cost] = predict(MFile.SVMStruct_S_Angry_S_Happy,Features);
[S_Angry_S_Neutral_Category,S_Angry_S_Neutral_Score,S_Angry_S_Neutral_Cost] = predict(MFile.SVMStruct_S_Angry_S_Neutral,Features);
[S_Angry_S_Sad_Category,S_Angry_S_Sad_Score,S_Angry_S_Sad_Cost] = predict(MFile.SVMStruct_S_Angry_S_Sad,Features);
[S_Angry_N_Angry_Category,S_Angry_N_Angry_Score,S_Angry_N_Angry_Cost] = predict(MFile.SVMStruct_S_Angry_N_Angry,Features);
[S_Angry_N_Happy_Category,S_Angry_N_Happy_Score,S_Angry_N_Happy_Cost] = predict(MFile.SVMStruct_S_Angry_N_Happy,Features);
[S_Angry_N_Neutral_Category,S_Angry_N_Neutral_Score,S_Angry_N_Neutral_Cost] = predict(MFile.SVMStruct_S_Angry_N_Neutral,Features);
[S_Angry_N_Sad_Category,S_Angry_N_Sad_Score,S_Angry_N_Sad_Cost] = predict(MFile.SVMStruct_S_Angry_N_Sad,Features);
S_Angry=[S_Angry_S_Happy_Category,S_Angry_S_Neutral_Category,S_Angry_S_Sad_Category,S_Angry_N_Angry_Category,S_Angry_N_Happy_Category,S_Angry_N_Neutral_Category,S_Angry_N_Sad_Category];
%------------------Happy---------------------------------%
[S_Happy_S_Angry_Category,S_Happy_S_Angry_Score,S_Happy_S_Angry_Cost] = predict(MFile.SVMStruct_S_Happy_S_Angry,Features);
[S_Happy_S_Neutral_Category,S_Happy_S_Neutral_Score,S_Happy_S_Neutral_Cost] = predict(MFile.SVMStruct_S_Happy_S_Neutral,Features);
[S_Happy_S_Sad_Category,S_Happy_S_Sad_Score,S_Happy_S_Sad_Cost] = predict(MFile.SVMStruct_S_Happy_S_Sad,Features);
[S_Happy_N_Angry_Category,S_Happy_N_Angry_Score,S_Happy_N_Angry_Cost] = predict(MFile.SVMStruct_S_Happy_N_Angry,Features);
[S_Happy_N_Happy_Category,S_Happy_N_Happy_Score,S_Happy_N_Happy_Cost] = predict(MFile.SVMStruct_S_Happy_N_Happy,Features);
[S_Happy_N_Neutral_Category,S_Happy_N_Neutral_Score,S_Happy_N_Neutral_Cost] = predict(MFile.SVMStruct_S_Happy_N_Neutral,Features);
[S_Happy_N_Sad_Category,S_Happy_N_Sad_Score,S_Happy_N_Sad_Cost] = predict(MFile.SVMStruct_S_Happy_N_Sad,Features);
S_Happy=[S_Happy_S_Angry_Category,S_Happy_S_Neutral_Category,S_Happy_S_Sad_Category,S_Happy_N_Angry_Category,S_Happy_N_Happy_Category,S_Happy_N_Neutral_Category,S_Happy_N_Sad_Category];
%------------------Neutral-------------------------------%
[S_Neutral_S_Happy_Category,S_Neutral_S_Happy_Score,S_Neutral_S_Happy_Cost] = predict(MFile.SVMStruct_S_Neutral_S_Happy,Features);
[S_Neutral_S_Angry_Category,S_Neutral_S_Angry_Score,S_Neutral_S_Angry_Cost] = predict(MFile.SVMStruct_S_Neutral_S_Angry,Features);
[S_Neutral_S_Sad_Category,S_Neutral_S_Sad_Score,S_Neutral_S_Sad_Cost] = predict(MFile.SVMStruct_S_Neutral_S_Sad,Features);
[S_Neutral_N_Angry_Category,S_Neutral_N_Angry_Score,S_Neutral_N_Angry_Cost] = predict(MFile.SVMStruct_S_Neutral_N_Angry,Features);
[S_Neutral_N_Happy_Category,S_Neutral_N_Happy_Score,S_Neutral_N_Happy_Cost] = predict(MFile.SVMStruct_S_Neutral_N_Happy,Features);
[S_Neutral_N_Neutral_Category,S_Neutral_N_Neutral_Score,S_Neutral_N_Neutral_Cost] = predict(MFile.SVMStruct_S_Neutral_N_Neutral,Features);
[S_Neutral_N_Sad_Category,S_Neutral_N_Sad_Score,S_Neutral_N_Sad_Cost] = predict(MFile.SVMStruct_S_Neutral_N_Sad,Features);
S_Neutral=[S_Neutral_S_Happy_Category,S_Neutral_S_Angry_Category,S_Neutral_S_Sad_Category,S_Neutral_N_Angry_Category,S_Neutral_N_Happy_Category,S_Neutral_N_Neutral_Category,S_Neutral_N_Sad_Category];
%------------------Sad-----------------------------------%
[S_Sad_S_Happy_Category,S_Sad_S_Happy_Score,S_Sad_S_Happy_Cost] = predict(MFile.SVMStruct_S_Sad_S_Happy,Features);
[S_Sad_S_Neutral_Category,S_Sad_S_Neutral_Score,S_Sad_S_Neutral_Cost] = predict(MFile.SVMStruct_S_Sad_S_Neutral,Features);
[S_Sad_S_Angry_Category,S_Sad_S_Angry_Score,S_Sad_S_Angry_Cost] = predict(MFile.SVMStruct_S_Sad_S_Angry,Features);
[S_Sad_N_Angry_Category,S_Sad_N_Angry_Score,S_Sad_N_Angry_Cost] = predict(MFile.SVMStruct_S_Sad_N_Angry,Features);
[S_Sad_N_Happy_Category,S_Sad_N_Happy_Score,S_Sad_N_Happy_Cost] = predict(MFile.SVMStruct_S_Sad_N_Happy,Features);
[S_Sad_N_Neutral_Category,S_Sad_N_Neutral_Score,S_Sad_N_Neutral_Cost] = predict(MFile.SVMStruct_S_Sad_N_Neutral,Features);
[S_Sad_N_Sad_Category,S_Sad_N_Sad_Score,S_Sad_N_Sad_Cost] = predict(MFile.SVMStruct_S_Sad_N_Sad,Features);
S_Sad=[S_Sad_S_Happy_Category,S_Sad_S_Neutral_Category,S_Sad_S_Angry_Category,S_Sad_N_Angry_Category,S_Sad_N_Happy_Category,S_Sad_N_Neutral_Category,S_Sad_N_Sad_Category];
Category=[N_Angry;N_Happy;N_Neutral;N_Sad;S_Angry;S_Happy;S_Neutral;S_Sad;];
%Sad_Angry_error = loss(MFile.SVMStruct_sad_angry,Features,Emotion_sad_angry);
%--------------------------------------------------------------------------------------
NA=sum(sum(strcmp(Category,'Normal Angry')));
NH=sum(sum(strcmp(Category,'Normal Happy')));
NN=sum(sum(strcmp(Category,'Normal Neutral')));
NS=sum(sum(strcmp(Category,'Normal Sad')));
SA=sum(sum(strcmp(Category,'Special Angry')));
SH=sum(sum(strcmp(Category,'Special Happy')));
SN=sum(sum(strcmp(Category,'Special Neutral')));
SS=sum(sum(strcmp(Category,'Special Sad')));
Em=max([NA,NH,NN,NS,SA,SH,SN,SS]);
if Em==NA
   Emotion ='Normal Angry';
   Emotion_Score= [NA,NH,NN,NS,SA,SH,SN,SS];
   Emotion_Cost= [1,0,0,0,0,0,0,0];
   Emotion_Error= sum([NH,NN,NS,SA,SH,SN,SS]);
end
if Em==NH
   Emotion ='Normal Happy';
   Emotion_Score= [NA,NH,NN,NS,SA,SH,SN,SS];
   Emotion_Cost= [0,1,0,0,0,0,0,0];
   Emotion_Error=  sum([NA,NN,NS,SA,SH,SN,SS]);
end
if Em==NN
   Emotion='Normal Neutral';
   Emotion_Score= [NA,NH,NN,NS,SA,SH,SN,SS];
   Emotion_Cost= [0,0,1,0,0,0,0,0];
   Emotion_Error= sum([NA,NH,NS,SA,SH,SN,SS]);
end
if Em==NS
    Emotion='Normal Sad'; 
   Emotion_Score= [NA,NH,NN,NS,SA,SH,SN,SS];
   Emotion_Cost= [0,0,0,1,0,0,0,0];
   Emotion_Error= sum([NA,NH,NN,SA,SH,SN,SS]);
end
if Em==SA
   Emotion ='Special Angry';
   Emotion_Score= [NA,NH,NN,NS,SA,SH,SN,SS];
   Emotion_Cost= [0,0,0,0,1,0,0,0];
   Emotion_Error= sum([NA,NH,NN,NS,SH,SN,SS]);
end
if Em==SH
   Emotion ='Special Happy';
   Emotion_Score= [NA,NH,NN,NS,SA,SH,SN,SS];
   Emotion_Cost= [0,0,0,0,0,1,0,0];
   Emotion_Error=  sum([NA,NH,NN,NS,SA,SN,SS]);
end
if Em==SN
   Emotion='Special Neutral';
   Emotion_Score= [NA,NH,NN,NS,SA,SH,SN,SS];
   Emotion_Cost= [0,0,0,0,0,0,1,0];
   Emotion_Error= sum([NA,NH,NN,NS,SA,SH,SS]);
end
if Em==SS
    Emotion='Special Sad'; 
   Emotion_Score= [NA,NH,NN,NS,SA,SH,SN,SS];
   Emotion_Cost= [0,0,0,0,0,0,0,1];
   Emotion_Error= sum([NA,NH,NN,NS,SA,SH,SN]);
end
