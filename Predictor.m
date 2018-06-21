function [count_1_num, count_2_num, count_3_num] = Predictor(image_path, net, d1, d2)

    %Loading the test Image (Single image)
    testImg=imread(image_path);

    N_x=size(testImg,1)./d1;
    N_y=size(testImg,2)./d2;

    %Cropping and stacking the images one over the other in one database
    testData=zeros(50,50,3, (N_x*N_y));
    n=1;
    for i=1:d1:300
        for j = 1:d2:300
            testData(:,:,:,n)=(testImg(i:(i+d1-1),j:(j+d2-1),:));
            n=n+1;
        end
    end

    %Performing classification on test dataBase
    classifiedTest=zeros(N_x*N_y,1);
    for i=1:1:(N_x*N_y)
        classifiedTest(i) = classify(net, uint8(testData(:,:,:,i)));
    end

    %Counting each label of classified image
    count_1 = classifiedTest==1;
    count_1_num = sum(count_1);

    count_2 = classifiedTest==2;
    count_2_num = sum(count_2);

    count_3 = classifiedTest==3;
    count_3_num = sum(count_3);
    
    %print('count_1_num= %f; count_2_num= %f; count_3_num= %f', (count_1_num count_2_num count_3_num));

end
