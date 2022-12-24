function [Error_rate,Hinge_Loss] = algorithm_analysis(Model_File)
Model= load(Model_File);
Speech=load('speech.mat');
%=================Speech Disorder=======================
%----------------Binomial deviance-----------
%----------------Classification error-------------
%----------------Exponential----------------------
%----------------Hinge--------------------------------
%----------------Logistic----------------------------
%----------------Minimal expected misclassification cost (for classification scores that are posterior probabilities)
%----------------Quadratic