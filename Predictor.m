function [count_1_num, count_2_num, count_3_num] = Predictor(image_dir, net, d1, d2)
    
    %Initializing the count to zero
    count_1_num=0;
    count_2_num=0;
    count_3_num=0;
    
    for l=1:length(image_dir)
    
    %Loading the test Image (Single image)
        testImg=imread(fullfile('./testsamples',image_dir(1).name));
        %imshow(testImg)
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
        size(classifiedTest);
        for i=1:1:(N_x*N_y)
            classifiedTest(i) = classify(net, uint8(testData(:,:,:,i)));
        end

        %Counting each label of classified image
        count_1 = classifiedTest==1;
        count_1_num = count_1_num + sum(count_1);

        count_2 = classifiedTest==2;
        count_2_num = count_2_num + sum(count_2);

        count_3 = classifiedTest==3;
        count_3_num = count_3_num + sum(count_3);
    end

        
    %print('count_1_num= %f; count_2_num= %f; count_3_num= %f', (count_1_num count_2_num count_3_num));
    classifiedImg = testImg;
    fh = figure;
    imshow(classifiedImg);
    %imwrite( frm.cdata, 'savedFileName.png' ); %// save to file
    hold on;
    posx = 1;
    posy = 1;
    c = 'y';
    for i=1:1:(N_x*N_y)
        if classifiedTest(i) == 1
            c = 'r';
            if i <= 6 
                posy = 0;
                posx = posx + 49;
            elseif i <= 12
                posy = 50;
                posx = posx + 49;
            elseif i <= 18
                posy = 100;
                posx = posx + 49;
            elseif i <= 24
                posy = 150;
                posx = posx + 49;
            elseif i <= 30
                posy = 200;
                posx = posx + 49;
            elseif i <= 36
                posy = 250;
                posx = posx + 49;
            end
        elseif classifiedTest(i) == 2
            c = 'g';
            if i <= 6 
                posy = 0;
                posx = posx + 49;
            elseif i <= 12
                posy = 50;
                posx = posx + 49;
            elseif i <= 18
                posy = 100;
                posx = posx + 49;
            elseif i <= 24
                posy = 150;
                posx = posx + 49;
            elseif i <= 30
                posy = 200;
                posx = posx + 49;
            elseif i <= 36
                posy = 250;
                posx = posx + 49;
            end
        elseif classifiedTest(i) == 3
            c = 'y';
            if i <= 6 
                posy = 0;
                posx = posx + 49;
            elseif i <= 12
                posy = 50;
                posx = posx + 49;
            elseif i <= 18
                posy = 100;
                posx = posx + 49;
            elseif i <= 24
                posy = 150;
                posx = posx + 49;
            elseif i <= 30
                posy = 200;
                posx = posx + 49;
            elseif i <= 36
                posy = 250;
                posx = posx + 49;
            end
        end
        if posx > 250
                posx = 1;
        end
        rectangle('Position', [ posx posy 40 40],'EdgeColor',c,'LineWidth',2);
        frm = getframe( fh ); %// get the image+rectangle
    end
    
end
