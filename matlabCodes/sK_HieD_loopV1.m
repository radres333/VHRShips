%% HieD Loop
% Description: This function tests the trainned HieD network
% Date:  2021 05 01
% Author: Serdar KIZILKAYA
% Sections: 1. Set-up 2. Loop
% Prerequites: 1. sK_HieD_mainV1 has to be worked 2. Matlab enviroment with appropriate add-ons

%% SECTION -1- Set-up
testData = gTruthLabels(:,1);
imageIndex = 0;
recogIdeIndex = 0;
recogIde = cell(size(testData,1),8);
tempCoorRefIndex = 0;
% Preset min image size 
minY = 2;
minX = 2;
imageLowerLimit = 1;
imageUpperLimit = size (testData,1);
navyCat= {'navy_16'};

%% SECTION -2- Loop
for imageIndex = imageLowerLimit: imageUpperLimit
    tempBoxes= [];
    tempRecog = [];
    tempPreRecog = [];
    tempIde = [];
    tempPreIde = [];
    tempScores = [];
    data = testData{imageIndex,1};
    I = imread(data{1,1});
    img_13 = imresize (I, scale_1);
    prob = predict(netDetect, img_13);
    if prob(1,2) > detectThres
        recogIde{imageIndex,1} = 1;
        % --------LOCALIZE-------
        img_2 = imresize (I, scale_2);
        outFeatures = yolov3v4Predict(cfgfile,weightfile,img_2); % @[Cui, 2021]
        scores = outFeatures(:,5);
        outFeatures = outFeatures(scores>locThres,:);
        allBBoxes = outFeatures(:,1:4);
        allScores = outFeatures(:,5);
        [maxScores,indxs] = max(outFeatures(:,6:end),[],2);
        allScores = allScores.*maxScores;
        allLabels = [];
        for s = 1:numel(indxs)
            allLabels = [allLabels; classesNames(1)]; %
        end
        bboxes = [];
        scores = [];
        labels = [];
        if ~isempty(allBBoxes)
            [bboxes,scores,labels] = selectStrongestBboxMulticlass(allBBoxes,allScores,allLabels,...
                'RatioType','Min','OverlapThreshold',NMS);
        end
        % --------ROI SEGMENTATION -------------
        if isempty(bboxes) == 0 % if a target is located
            numbboxes = size(bboxes,1);
            for g = 1 : numbboxes
                scoreTemp = scores (g,1);
                % ---------RETURN ORIGINAL SIZE -------------
                bboxesX = bboxes(g,1) * imageDim(1,2)/scale_2(1,2);
                bboxesY = bboxes(g,2) * imageDim(1,1)/scale_2(1,1);
                bboxesYW = bboxes(g,3) * imageDim(1,2)/scale_2(1,2);
                bboxesYH = bboxes(g,4) * imageDim(1,1)/scale_2(1,1);
                results.Boxes{imageIndex} = [bboxesX,bboxesY, bboxesYW, bboxesYH] ;
                results.Scores{imageIndex} = scores;
                results.Labels{imageIndex} = labels;
                % enlarge boundingbox in diagonal
                tempX = bboxesX;
                tempY = bboxesY;
                tempWidth = bboxesYW;
                tempHeight = bboxesYH;
                if tempX < 1
                    tempX = 1;
                end
                if tempY < 1
                    tempY = 1;
                end
                if tempY + tempHeight > imageDim(1,1)
                    tempHeight = imageDim(1,1) - tempY ;
                end
                if tempX + tempWidth > imageDim(1,2)
                    tempWidth = imageDim(1,2) - tempX;
                end
                % ***********enlarge ROI ************
                newX1 = int16(tempX);
                newY1 = int16(tempY);
                newX2 = int16(tempX +  tempWidth);
                newY2 = int16(tempY + tempHeight);
                if newX1 < 1
                    newX1 = 1;
                end
                if newY1 < 1
                    newY1 = 1;
                end
                if newY2 > imageDim(1,1)
                    newY2 = imageDim(1,1);
                end
                if newX2 > imageDim(1,2)
                    newX2 = imageDim(1,2);
                end  
                img_3 = I (newY1:newY2, newX1:newX2, :); % detected & localized & enlarged ROI
                % Rotate long size of the ROI in x direction
                [row, col, dim] = size (img_3);
                if row > col
                    img_3 = imrotate (img_3, 90);
                end
                % check recognition dimension
                [row, col, dim] = size (img_3);
                if row> minY && col > minX
                    if col > scale_3(1,2)
                        scale = scale_3(1,2) / col;
                        img_3 = imresize(img_3,scale);
                    end
                    img_31 = overlay(img_3,scale_3(1,1), scale_3(1,2) );
                    
                    % ********************** RECOGNITION *******************************
                    checkRecog = classify(netRecog,img_31);
                    predictRecog = predict(netRecog,img_31);
                    % *********************** IDENTIFICATION ******************************
                    if checkRecog == navyCat
                        checkIde = classify(netId,img_31);
                        predictIde = predict(netId,img_31);
                        tempIde = [tempIde; checkIde] ;
                        tempPreIde = [tempPreIde; predictIde];
                    end
                    tempBoxes= [tempBoxes; int16([tempX,tempY,tempWidth,tempHeight])];
                    tempRecog = [tempRecog; checkRecog];
                    tempPreRecog = [tempPreRecog; predictRecog];
                    tempScores = [tempScores; scoreTemp];
                end
            end
        end
    end
    recogIde {imageIndex, 2} = tempBoxes;
    recogIde {imageIndex, 3} = tempScores;
    recogIde {imageIndex, 4} = tempRecog;
    recogIde {imageIndex, 5} = tempIde;
    recogIde {imageIndex, 6} = tempPreRecog;
    recogIde {imageIndex, 7} = tempPreIde;
    recogIde {imageIndex, 8} = prob; % detection prediction probability
end
