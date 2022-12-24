function [Category,Category_Cost,Category_Score,Category_Error,DTW_Categories] = comparison(wav_file)
 % Read speech samples, sampling rate and precision from file
DTWFile=load('dtwdata');
features= allfeatures_extraction( wav_file );
[Normal_AngryDist,NormalD,Normalk,Normalw]=dtw(DTWFile.Normal_Angry_features,features);
[Special_AngryDist,SpecialD,Specialk,Specialw]=dtw(DTWFile.Special_Angry_features,features);
[Normal_HappyDist,NormalD,Normalk,Normalw]=dtw(DTWFile.Normal_Happy_features,features);
[Special_HappyDist,SpecialD,Specialk,Specialw]=dtw(DTWFile.Special_Happy_features,features);
[Normal_NeutralDist,NormalD,Normalk,Normalw]=dtw(DTWFile.Normal_Neutral_features,features);
[Special_NeutralDist,SpecialD,Specialk,Specialw]=dtw(DTWFile.Special_Neutral_features,features);
[Normal_SadDist,NormalD,Normalk,Normalw]=dtw(DTWFile.Normal_Sad_features,features);
[Special_SadDist,SpecialD,Specialk,Specialw]=dtw(DTWFile.Special_Sad_features,features);
    DTW_Categories=[Normal_AngryDist;Special_AngryDist;Normal_HappyDist;Special_HappyDist;Normal_NeutralDist;Special_NeutralDist;Normal_SadDist;Special_SadDist];
    A=min(DTW_Categories);
      if A== DTW_Categories(1,1)
        Category={'Normal Angry'};
        Category_Cost=[1,0,0,0,0,0,0,0];
        Category_Score=DTW_Categories(1,1);
        Category_Error=max(DTW_Categories);
        end
        if A== DTW_Categories(2,1)
        Category={'Special Angry'};
        Category_Cost=[0,0,0,0,1,0,0,0];
        Category_Score=DTW_Categories(1,1);
        Category_Error=max(DTW_Categories);
        end
        if A== DTW_Categories(3,1)
        Category={'Normal Happy'};
        Category_Cost=[0,1,0,0,0,0,0,0];
        Category_Score=DTW_Categories(1,1);
        Category_Error=max(DTW_Categories);
        end
        if A== DTW_Categories(4,1)
        Category={'Special Happy'};
        Category_Cost=[0,0,0,0,0,1,0,0];
        Category_Score=DTW_Categories(1,1);
        Category_Error=max(DTW_Categories);
        end
        if A== DTW_Categories(5,1)
        Category={'Normal Neutral'};
        Category_Cost=[0,0,1,0,0,0,0,0];
        Category_Score=DTW_Categories(1,1);
        Category_Error=max(DTW_Categories);
        end
        if A== DTW_Categories(6,1)
        Category={'Special Neutral'};
        Category_Cost=[0,0,0,0,0,0,1,0];
        Category_Score=DTW_Categories(1,1);
        Category_Error=max(DTW_Categories);
        end
        if A== DTW_Categories(7,1)
        Category={'Normal Sad'};
        Category_Cost=[0,0,0,1,0,0,0,0];
        Category_Score=DTW_Categories(1,1);
        Category_Error=max(DTW_Categories);
        end
        if A== DTW_Categories(8,1)
        Category={'Special Sad'};
        Category_Cost=[0,0,0,0,0,0,0,1];
        Category_Score=DTW_Categories(1,1);
        Category_Error=max(DTW_Categories);
        end

