function [Category_Error] = SVM_Error()
SVM=load('svmmodels');
File=load('speech');
%1
frequency_categories_error = loss(SVM.SVMStruct_frequency_categories,File.frequency,File.categories);
%2
pitch_contour_categories_error = loss(SVM.SVMStruct_pitch_contour_categories,File.pitch_contour,File.categories);
%3
pitch_autocorrelation_categories_error = loss(SVM.SVMStruct_pitch_autocorrelation_categories,File.pitch_autocorrelation,File.categories);
%4
acceleration_categories_error = loss(SVM.SVMStruct_acceleration_categories,File.acceleration,File.categories);
%5
intensity_categories_error = loss(SVM.SVMStruct_intensity_categories,File.intensity,File.categories);
%6
formants_categories_error = loss(SVM.SVMStruct_formants_categories,File.formants,File.categories);
%7
lpcc_categories_error = loss(SVM.SVMStruct_lpcc_categories,File.lpcc,File.categories);
%8
mfcc_categories_error = loss(SVM.SVMStruct_mfcc_categories,File.mfcc,File.categories);
%9
rastaplp_categories_error = loss(SVM.SVMStruct_rastaplp_categories,File.rastaplp,File.categories);
%10
power_categories_error = loss(SVM.SVMStruct_power_categories,File.power,File.categories);
%11
energy_categories_error = loss(SVM.SVMStruct_energy_categories,File.energy,File.categories);
%12
rate_of_zero_passage_categories_error = loss(SVM.SVMStruct_rate_of_zero_passage_categories,File.rate_of_zero_passage,File.categories);
Category_Error=[frequency_categories_error,pitch_contour_categories_error,pitch_autocorrelation_categories_error,acceleration_categories_error,intensity_categories_error,formants_categories_error,lpcc_categories_error,mfcc_categories_error,rastaplp_categories_error,power_categories_error,energy_categories_error,rate_of_zero_passage_categories_error];