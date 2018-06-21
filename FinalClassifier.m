%This is the main execution file which needs to be run for classification.
%This file uses two function files 'DLTraining.m' and 'Predictor.m'. Keep
%both these files in the same folder along with this file

clear

%Training the model
%Change the training_path as per directory structure
training_path='./images/';
[net, Val_accuracy, d1, d2, Test_accuracy] = DLTraining(training_path);

%Using trained model to classify image
%Change the test_path as per directory structure
%test_path='./testsamples/I2.jpg';
%[count_1_num, count_2_num, count_3_num] = Predictor(test_path, net, d1, d2)