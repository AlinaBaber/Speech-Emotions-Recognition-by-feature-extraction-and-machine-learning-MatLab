function [Category,Category_score,Category_Cost,Category_error,Emotion,Emotion_Score,Emotion_Cost,Emotion_Error]= svm_hybrid(Hybrid_Features)

MFile= load('hybridmodels'); %File= load('speech');
%File= load('speech');
%==================Speech Disorder======================================%
[Category,Category_score,Category_Cost] = predict(MFile.HybridSVMStruct_categories,Hybrid_Features);
Category_error = loss(MFile.HybridSVMStruct_categories,Hybrid_Features,Category);

%==================Speech Emotions======================================%
%====================Angry===================================%
[Emotion_angry_happy,Emotion_angry_happy_score,Emotion_angry_happy_cost] = predict(MFile.HybridSVMStruct_angry_happy,Hybrid_Features);
Angry_Happy_error = loss(MFile.HybridSVMStruct_angry_happy,Hybrid_Features,Emotion_angry_happy);
[Emotion_angry_neutral,Emotion_angry_neutral_score,Emotion_angry_neutral_cost] = predict(MFile.HybridSVMStruct_angry_neutral,Hybrid_Features);
Angry_Neutral_error = loss(MFile.HybridSVMStruct_angry_neutral,Hybrid_Features,Emotion_angry_neutral);
[Emotion_angry_sad,Emotion_angry_sad_score,Emotion_angry_sad_cost] = predict(MFile.HybridSVMStruct_angry_sad,Hybrid_Features);
Angry_Sad_error = loss(MFile.HybridSVMStruct_angry_sad,Hybrid_Features,Emotion_angry_sad);
Angry=[Emotion_angry_happy,Emotion_angry_neutral,Emotion_angry_sad];
Angry_Score=[Emotion_angry_happy_score,Emotion_angry_neutral_score,Emotion_angry_sad_score];
Angry_Cost=[Emotion_angry_happy_cost,Emotion_angry_neutral_cost,Emotion_angry_sad_cost];
Angry_Error=[Angry_Happy_error,Angry_Neutral_error,Angry_Sad_error];
%======================Happy===================================================
[Emotion_happy_angry,Emotion_happy_angry_score,Emotion_happy_angry_cost] = predict(MFile.HybridSVMStruct_happy_angry,Hybrid_Features);
Happy__Angry_error = loss(MFile.HybridSVMStruct_happy_angry,Hybrid_Features,Emotion_happy_angry);
[Emotion_happy_neutral,Emotion_happy_neutral_score,Emotion_happy_neutral_cost] = predict(MFile.HybridSVMStruct_happy_neutral,Hybrid_Features);
Happy_Neutral_error = loss(MFile.HybridSVMStruct_happy_neutral,Hybrid_Features,Emotion_happy_neutral);
[Emotion_happy_sad,Emotion_happy_sad_score,Emotion_happy_sad_cost] = predict(MFile.HybridSVMStruct_happy_sad,Hybrid_Features);
Happy_Sad_error = loss(MFile.HybridSVMStruct_happy_sad,Hybrid_Features,Emotion_happy_sad);
Happy=[Emotion_happy_angry,Emotion_happy_neutral,Emotion_happy_sad];
Happy_Score=[Emotion_happy_angry_score,Emotion_happy_neutral_score,Emotion_happy_sad_score];
Happy_Cost=[Emotion_happy_angry_cost,Emotion_happy_neutral_cost,Emotion_happy_sad_cost];
Happy_Error=[Happy__Angry_error,Happy_Neutral_error,Happy_Sad_error];
    %====================Neutral===================================%
[Emotion_neutral_angry,Emotion_neutral_angry_score,Emotion_neutral_angry_cost] = predict(MFile.HybridSVMStruct_neutral_angry,Hybrid_Features);
Neutral_Angry_error = loss(MFile.HybridSVMStruct_neutral_angry,Hybrid_Features,Emotion_neutral_angry);
[Emotion_neutral_happy,Emotion_neutral_happy_score,Emotion_happy_neutral_cost] = predict(MFile.HybridSVMStruct_neutral_happy,Hybrid_Features);
Neutral_Happy_error = loss(MFile.HybridSVMStruct_neutral_happy,Hybrid_Features,Emotion_neutral_happy);
[Emotion_neutral_sad,Emotion_neutral_sad_score,Emotion_neutral_sad_cost] = predict(MFile.HybridSVMStruct_neutral_sad,Hybrid_Features);
Neutral_Sad_error = loss(MFile.HybridSVMStruct_neutral_sad,Hybrid_Features,Emotion_neutral_sad);
Neutral=[Emotion_neutral_angry,Emotion_neutral_happy,Emotion_neutral_sad];
Neutral_Score=[Emotion_neutral_angry_score,Emotion_neutral_happy_score,Emotion_neutral_sad_score];
Neutral_Cost=[Emotion_neutral_angry_cost,Emotion_happy_neutral_cost,Emotion_neutral_sad_cost];
Neutral_Error=[Neutral_Angry_error,Neutral_Happy_error,Neutral_Sad_error];
%=====================Sad=============================================
[Emotion_sad_angry,Emotion_sad_angry_score,Emotion_sad_angry_cost] = predict(MFile.HybridSVMStruct_sad_angry,Hybrid_Features);
Sad_Angry_error = loss(MFile.HybridSVMStruct_sad_angry,Hybrid_Features,Emotion_sad_angry);
[Emotion_sad_happy,Emotion_sad_happy_score,Emotion_sad_neutral_cost] = predict(MFile.HybridSVMStruct_sad_happy,Hybrid_Features);
Sad_Happy_error = loss(MFile.HybridSVMStruct_sad_happy,Hybrid_Features,Emotion_sad_happy);
[Emotion_sad_neutral,Emotion_sad_neutral_score,Emotion_neutral_sad_cost] = predict(MFile.HybridSVMStruct_sad_neutral,Hybrid_Features);
Sad_Neutral_error = loss(MFile.HybridSVMStruct_sad_neutral,Hybrid_Features,Emotion_sad_neutral);
Sad=[Emotion_sad_angry,Emotion_sad_happy,Emotion_sad_neutral];
Sad_Score=[Emotion_sad_angry_score,Emotion_sad_happy_score,Emotion_sad_neutral_score];
Sad_Cost=[Emotion_sad_angry_cost,Emotion_sad_neutral_cost,Emotion_neutral_sad_cost];
Sad_Error=[Sad_Angry_error,Sad_Happy_error,Sad_Neutral_error];
%--------------------------------------------------------------------------------------
Emotion=[Angry;Happy;Neutral;Sad];
Emotion_Score=[Angry_Score;Happy_Score;Neutral_Score;Sad_Score];
Emotion_Cost=[Angry_Cost,Happy_Cost,Neutral_Cost,Sad_Cost];
Emotion_error=[Angry_Error;Happy_Error;Neutral_Error;Sad_Error];
A=sum(sum(strcmp(Emotion,'Angry')));
H=sum(sum(strcmp(Emotion,'Happy')));
N=sum(sum(strcmp(Emotion,'Neutral')));
S=sum(sum(strcmp(Emotion,'Sad')));
Em=max([A,H,N,S]);
if Em==A
   Emotion ={'Angry'};
   Emotion_Score= [A,H,N,S];
   Emotion_Cost= mean(Angry_Cost);
   Emotion_Error= Angry_Error;
end
if Em==H
   Emotion ={'Happy'};
   Emotion_Score= [A,H,N,S];
   Emotion_Cost= mean(Happy_Cost);
   Emotion_Error= Happy_Error;
end
if Em==N
   Emotion={'Neutral'};
   Emotion_Score= [A,H,N,S];
   Emotion_Cost= mean(Neutral_Cost);
   Emotion_Error= Neutral_Error;
end
if Em==S
    Emotion={'Sad'}; 
   Emotion_Score= [A,H,N,S];
   Emotion_Cost= mean(Sad_Cost);
   Emotion_Error= Sad_Error;
end
