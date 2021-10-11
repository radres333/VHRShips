%% HieD Evaluator
% Description: This function evaluates the test results
% Date:  2021 05 01
% Author: Serdar KIZILKAYA
% Sections: 1. Set-up 2. Loop 3. Statistics
% Prerequites: 1. sK_HieD_loopV1 2. Matlab enviroment with appropriate add-ons

%% SECTION -1- Set-up

detectionResults = recogIde;

labelNames17 = {'bargePontoon_7';'coaster_35';'container_11';'dredgerReclamation_32';...
    'drill_19';'ferry_2';'floatingDock_36';'generalCargo_1';'lpg_17';'navy_16';...
    'offshore_6';'passanger_4';'roro_3';'smallBoat_34';'tanker_13';'undefined_20';'nonship'};
labelNamesCat = categorical(labelNames17);

labelNamesNavy8 = {'aircraft_200';'auxilary_900';'coastGuard_800';...
    'destroyer_400';'landing_700';'other_1100';'serviceCraft_1000';'submarine_100';'nonNavy'};
labelNamesNavy = categorical(labelNamesNavy8);

GTruth = gTruthLabels;
testGTruth = GTruth(:,2:3);
locThreshold = 0.05; % overlap threshold

% set variables
overlapRatio = [];
recogFit = [];
numDetect = 0;
numRecog = 0;
numMissRecog = 0;
numLocalized = 0;
numGtDetect = 0; % numOf gT pics with ship
numGtShip = 0; % numOf gT ships

det_tP = 0;
det_tN = 0;
det_fP = 0;
det_fN = 0;

loc_tP = 0;
loc_tN = 0;
loc_fP = 0;
loc_fN = 0;

rec_tP = 0;
rec_tP_2 = 0;
rec_tN = 0;
rec_fP = 0;
rec_fP2 = 0;
rec_fN = 0;
recErase_fP2 = 0;

ide_tP = 0;
ide_tP_2 = 0;
ide_tN = 0;
ide_fP = 0;
ide_fP2 = 0;  % due to miss classified navy_16 by recog
ide_fN = 0;

tempLoc = 0;
tempRecog = [];
tempIde = [];

gTdetectFlag = 0;
recogConfu = zeros(36,36);
IdeConfu = zeros(36,36);

missDetect_fN = [];
missDetect_fP = [];
missLoc = cell(imageUpperLimit,1); % list of loc_fP scores 
missLoc_tN = []; % # ships which doesn't exist but detected in the detection phase
missBox = cell(imageUpperLimit,1); % list of loc_fP bboxes
missRec_fP = cell(imageUpperLimit,1); % rec_predicted categories of wrong recognized ships
missRec_fP2 = cell(imageUpperLimit,1); % rec_predicted categories of loc_fP ships 
missIde_fP = cell(imageUpperLimit,1); 
missIde_fN = cell(imageUpperLimit,1);
missNotLocNavy = 0; % # ships gT Navy but not detected/localized >>> ide_fN2
missNotLocBox = cell(imageUpperLimit,1); % list of loc_fN bboxes
missNonShip = 0; % # rec_predicted nonShip
missNonNavy = 0; % # ide_predicted nonNavy

%% SECTION -2- Loop
for x=imageLowerLimit: imageUpperLimit
    tempMissLoc = [];
    tempMissRec = [];
    tempMissIde = [];
    tempMissBox = [];
    tempMissRec_fP2 = [];
    % prediction
    pre_detec =  detectionResults{x,1};
    pre_bboxes = detectionResults{x,2};
    pre_scores = detectionResults{x,3};
    pre_recog = detectionResults{x,4};
    pre_ide = detectionResults{x,5};
    preVal_recog = detectionResults{x,6};
    preVal_ide = detectionResults{x,7};
    preVal_det = detectionResults{x,8};
    % Ground Truth
    gTBox = cell2mat(testGTruth{x,1});
    if size(gTBox,1)>0
        gT_detec = 1;
    else
        gT_detec = 0;
    end
    gT_boxes = gTBox;
    gT_recog = testGTruth{x,2};
    gT_recog = gT_recog{1,1};
    
    %% ************************ D E T E C T I O N **********************
    if gT_detec == 1
        if pre_detec == 1 
            det_tP = det_tP + 1;
        else
            det_fN = det_fN + 1; 
            missDetect_fN = [missDetect_fN, x];
        end
    else
        if pre_detec == 1
            det_fP = det_fP + 1;
            missDetect_fP = [missDetect_fP, x];
        else
            det_tN = det_tN + 1;
        end
    end
    %% ***************** L O C A L I Z A T I O N ************************
    if isempty(pre_bboxes) && isempty(gT_boxes)
        if pre_detec == 1
            % LOC TN
            loc_tN = loc_tN + 1;
            missLoc_tN = [missLoc_tN, x];
        end
    elseif checkDet2gT(pre_bboxes, gT_boxes, locThreshold, pre_scores) == 0
        if isempty(pre_bboxes)
           loc_fN = loc_fN + size(gT_boxes,1);
        end
        if isempty(gT_boxes)
           loc_fP = loc_fP +  size(pre_bboxes,1);
        end
    else
        % localization HIT analyse
        [labels, falseNegative, assignment, wasDetected] = ...
            checkDet2gT(pre_bboxes, gT_boxes, locThreshold, pre_scores); 
        % LABELS (prediction analyse) = 1s for TP ; 0s for FP ; 
        % ASSIGNMENT (prediction gTruth match analyse) = order of matched gTruths
        % WASDETECTED (gTruth analyse): 1s detected gT ships ; 0s not detected gT ships
        % FALSE NEGATIVE : # not detected gT ships
        tempNotLoc = (~wasDetected).*gT_boxes;
        missNotLocBox{x,1} = tempNotLoc(all(tempNotLoc,2),:);
        % missed Navy Ship Analyse for Identification (ide_fN2)
        for zz = 1: size (wasDetected,1)
            if wasDetected (zz) == 0
                if navyClassChecker(categorical(gT_recog(zz,1))) == 1
                    missNotLocNavy = missNotLocNavy + 1;
                end
            end
        end      
        % LOC TP
        loc_tP = loc_tP + sum(labels);
        % LOC FN
        loc_fN = loc_fN + falseNegative;
        if size(labels,1) - sum(labels) > 0
            % LOC FP
            loc_fP = loc_fP + (size(labels,1) - sum(labels));
            tempMissLoc = mod(labels+1,2) .* pre_scores;
            [V, tempMissBoxFinder, ] =  find(mod(labels+1,2)== 1);
            for v = 1:size(tempMissBoxFinder)
                tempMissBox = [tempMissBox; pre_bboxes(tempMissBoxFinder(v),:)];
                tempMissRec_fP2 = [tempMissRec_fP2; pre_recog(tempMissBoxFinder(v),:)];
                if pre_recog(tempMissBoxFinder(v),:) == labelNamesCat(17)
                    recErase_fP2 = recErase_fP2 + 1;
                end
            end
            missLoc{x,1} = tempMissLoc;
            missBox{x,1} = tempMissBox;
            missRec_fP2 {x,1} = tempMissRec_fP2;
        end
    
    %% ********************  R E C O G N I T I O N ************************
    gT_navyFlagCounter = 0;
    ideNavyIndex = 0;
    recogFlag = 0;
    for a = 1 : size(assignment,1)
        if assignment(a,1) ~= 0
            tempIndex = assignment(a,1);
            [recogFlag,recogFlag2] = evaluatorRecognition (categorical(gT_recog(tempIndex)), pre_recog(a));
            % REC TP
            rec_tP = rec_tP + recogFlag;
            % REC TP2
            rec_tP_2 = rec_tP_2 + recogFlag2;
            if recogFlag == 0 && recogFlag2 == 0 
                % REC FP
                rec_fP = rec_fP + 1;
                tempMissRec = [tempMissRec, a];
                if pre_recog(a)~= labelNamesCat(17)
                missNonShip = missNonShip +1;
                end
            end
            % confusion matrix RECOG
            gT_catIndex = confuMatRecog (gT_recog(tempIndex));
            pre_catIndex = find (labelNamesCat == pre_recog(a));
            tempConfu = recogConfu(pre_catIndex, gT_catIndex) ;
            recogConfu(pre_catIndex, gT_catIndex) = tempConfu +1;
            %% ************** I D E N T I F I C A T I O N ****************
            gTnavyFlag = navyClassChecker (categorical(gT_recog(tempIndex)));
            if gTnavyFlag == 1
                gT_navyFlagCounter = gT_navyFlagCounter+1;
            end
            preNavyFlag = navyClassChecker (pre_recog(a));
            if preNavyFlag == 1
                ideNavyIndex = ideNavyIndex +1;
                if gTnavyFlag == 1
                    [ideFlag,ideFlag2] = evaluatorIde (categorical(gT_recog(tempIndex)), pre_ide(ideNavyIndex));
                    % IDE TP
                    ide_tP = ide_tP + ideFlag;
                    % IDE TP2
                    ide_tP_2 = ide_tP_2 + ideFlag2;
                    % confusion matrix IDE
                    gT_IdeIndex = confuMatIDe(gT_recog(tempIndex));
                    pre_IdeIndex =  confuMatIDe(pre_ide(ideNavyIndex)) ;
                    tempConfu = IdeConfu(pre_IdeIndex, gT_IdeIndex) ;
                    IdeConfu(pre_IdeIndex, gT_IdeIndex) = tempConfu +1;
                    if ideFlag == 0 && ideFlag2 == 0
                        % IDE FP
                        ide_fP = ide_fP + 1;
                        tempMissIde = [tempMissIde,a];
                        if pre_ide(ideNavyIndex)~= labelNamesNavy(9)
                        missNonShip = missNonShip +1;    
                        end

                    end
                else
                    % IDE FP2 (labeled as navyShip even there is not)
                    ide_fP2 = ide_fP2 +1;
                end
            end
            if gTnavyFlag == 1
                if preNavyFlag == 0
                    % IDE FN (couldn’t be recognized as Navy)
                    ide_fN = ide_fN + 1;
                end
            end
        end
    end
    missRec_fP = [missRec_fP; tempMissRec];
    missIde_fP = [missIde_fP; tempMissIde];
    % REC FN
    rec_fN = rec_fN + falseNegative;
    end
end

%% SECTION -3- Statistics
% Check for #ships in non-detected images
tempNum = 0;
for z = 1:size (missDetect_fN,2)
    tempRow = testGTruth{missDetect_fN(z),2};
    tempRow = tempRow{:};
    tempNum = tempNum + size(tempRow,1);
end
loc_fN = loc_fN - tempNum;
loc_fN2 = tempNum;
rec_fP2 = loc_fP;
ide_fN2 = missNotLocNavy;
ide_tN = 0;

% # TOTAL SHIP
totalShipNum = 0;
for z = 1:size (testGTruth,1)
    tempRow = testGTruth{z,2};
    tempRow = tempRow{:};
    totalShipNum = totalShipNum + size(tempRow,1);
end

totalNavyNum = 0;
for z = 1:size (testGTruth,1)
    tempNavyNum = 0;
    for nn = 1 : 11
        tempRow = GTruth{z,21+nn};
        tempRow = tempRow{:};
        tempNavyNum = tempNavyNum + size(tempRow,1);
    end
    totalNavyNum = totalNavyNum + tempNavyNum;
end

totalImage = imageUpperLimit
totalShipNum
totalNavyNum
% DET
st_det_ACC = (det_tP + det_tN)/(det_tP + det_tN + det_fP + det_fN)
st_det_RECAL = (det_tP)/(det_tP + det_fN)
st_det_PRE = (det_tP)/(det_tP + det_fP)
st_det_F1 = 2 *((st_det_PRE * st_det_RECAL)/(st_det_PRE + st_det_RECAL))

% LOC
st_loc_ACC = (loc_tP + loc_tN)/(loc_tP + loc_tN + loc_fP + loc_fN + loc_fN2)
st_loc_RECAL = (loc_tP)/(loc_tP + loc_fN + loc_fN2)
st_loc_PRE = (loc_tP)/(loc_tP + loc_fP)
st_loc_F1 = 2 *((st_loc_PRE * st_loc_RECAL)/(st_loc_PRE + st_loc_RECAL))

% REC
st_rec_ACC = (rec_tP + rec_tP_2 + rec_tN)/(rec_tP + rec_tP_2 + rec_tN + rec_fP + rec_fP2 + rec_fN)
st_rec_RECAL = (rec_tP + rec_tP_2)/(rec_tP + rec_tP_2 + rec_fN+rec_fP)
st_rec_PRE = (rec_tP + rec_tP_2)/(rec_tP + rec_tP_2 + rec_fP + rec_fP2)
st_rec_F1 = 2 *((st_rec_PRE * st_rec_RECAL)/(st_rec_PRE + st_rec_RECAL))

% IDE 
st_ide_ACC = (ide_tP + ide_tP_2 + ide_tN)/(ide_tP + ide_tP_2 + ide_tN + ide_fP + ide_fP2 + ide_fN + ide_fN2)
st_ide_RECAL = (ide_tP + ide_tP_2)/(ide_tP + ide_tP_2 + ide_fN + ide_fN2+ ide_fP)
st_ide_PRE = (ide_tP + ide_tP_2)/(ide_tP + ide_tP_2 + ide_fP + ide_fP2)
st_ide_F1 = 2 *((st_ide_PRE * st_ide_RECAL)/(st_ide_PRE + st_ide_RECAL))
