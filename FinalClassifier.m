%This is the main execution file which needs to be run for classification.
%This file uses two function files 'DLTraining.m' and 'Predictor.m'. Keep
%both these files in the same folder along with this file

clear
clc

%Training the model
%Change the training_path as per directory structure
fprintf('Training the Neural Network Model ....')
training_path='./cellsDataset/';
[net, Val_accuracy, d1, d2] = DLTraining(training_path);
fprintf('Training Complete')

%Saving the trained network
save net

%Using trained model to classify image
%Change the test_path as per directory structure
fprintf('Classifying the test images...')
test_dir=dir('./testsamples/*jpg');
[count_1_num, count_2_num, count_3_num] = Predictor(test_dir, net, d1, d2);
fprintf('Classification complete!')

