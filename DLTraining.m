function [net, Val_accuracy, d1, d2, Test_accuracy] =  DLTraining(training_data_path)

    %Importing Folder containing the labeled files. 
    %The function imageDatastore() generates a database of images 
    imds = imageDatastore(training_data_path, 'IncludeSubfolders', true, 'LabelSource', 'foldernames');
    
    %countLabels=countEachLabel(imds);

    %Dividing out dataset into Training and Validation set. This should be
    %roughly in the ratio 2:1
    numTrainFiles = 600;
    
    [TrainingSet, ValidationSet]= splitEachLabel(imds, numTrainFiles, 'randomize');

    %Input layer size is determined by the size of image. Therefore we extract
    %the size in x,y,z dimensions. Z-dimension specify the number of color
    %features in an image.
    image_size=readimage(imds,1);
    d1=size(image_size,1);
    d2=size(image_size,2);
    d3=size(image_size,3);

    %We now define the meta-structure of our Deep Learning Neural Network
    %General Architecture:
    %Conv_Layer->BatchNorm_Layer->ReLU_Layer->Pooling_Layer
    %For our network, we have added 5 Layers between Input and output layer
    % Input_Layer--L1--L2--L3--L4--L5--Output_Layer

    layers = [
        imageInputLayer([d1 d2 d3])

        convolution2dLayer(3,8,'Padding',1)
        batchNormalizationLayer
        reluLayer

        maxPooling2dLayer(2,'Stride',2)

        convolution2dLayer(3,16,'Padding',1)
        batchNormalizationLayer
        reluLayer

        maxPooling2dLayer(2,'Stride',2)

        convolution2dLayer(3,32,'Padding',1)
        batchNormalizationLayer
        reluLayer

        maxPooling2dLayer(2,'Stride',2)

        convolution2dLayer(3,32,'Padding',1)
        batchNormalizationLayer
        reluLayer

        maxPooling2dLayer(2,'Stride',2)


        convolution2dLayer(3,16,'Padding',1)
        batchNormalizationLayer
        reluLayer

        fullyConnectedLayer(3)
        softmaxLayer
        classificationLayer];

    %Options specify the hyperparameters needed to train our network
    options = trainingOptions('sgdm', ...
        'MaxEpochs',12, ...
        'LearnRateSchedule', 'piecewise', ...
        'InitialLearnRate', 0.04, ...
        'LearnRateDropFactor', 0.7, ...,
        'LearnRateDropPeriod', 4, ...
        'ValidationData',ValidationSet, ...
        'ValidationFrequency',10, ...
        'Verbose',false, ...
        'Plots','training-progress');

    %Running the DNN to train on our dataset
    net = trainNetwork(TrainingSet,layers,options);

    %Calculating accuracy on validation set
    YPred = classify(net,ValidationSet);
    YValidation = ValidationSet.Labels;
    Val_accuracy = sum(YPred == YValidation)/numel(YValidation)
    
    %Calculating accuracy on testing set (100 images of each)
    test_data_path='./testing/';
    test_db = imageDatastore(test_data_path, 'IncludeSubfolders', true, 'LabelSource', 'foldernames');
    Y_pred_test = classify(net, test_db);
    Y_test = test_db.Labels;
    Test_accuracy = sum(Y_pred_test == Y_test)/numel(Y_test) 

end


