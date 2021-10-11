%% HieD Main
% Description: This function adjusts the pre-requites
% Date:  2021 05 01
% Author: Serdar KIZILKAYA
% Sections: 1. Input 2. Set-up 
% Prerequites: 1. Trained DLRI networks 2. Test Data 3. Matlab enviroment with appropriate add-ons


%% SECTION -1- Input

% >>> LOAD > test images 
load ('...\testList');
gTruthLabels = testList;
% >>> LOAD > pretrained networks
% Detection
load('C:\Users\PROCOM-13\Dropbox\01_TEZ\00_code\end2end\trainedNets\det_set_1_e50_20210515.mat');
netDetect = GEP_UHU_detXception_e50;
% Localization
cfgfile = 'yolov4-obj_C2.cfg';
weightfile = 'yolov4-obj_11000_final_C2.weights';
% Recognition
load('C:\Users\PROCOM-13\Dropbox\01_TEZ\00_code\end2end\trainedNets\rec_set_1_C16_e50_20210531.mat');
netRecog = GEP_UHU_recXception_16_e50;
% Identification
load('C:\Users\PROCOM-13\Dropbox\01_TEZ\00_code\end2end\trainedNets\ide_set_1_C8_e50_20210603.mat');
netId = GEP_UHU_ideXception_C8_e50_2;

%% SECTION -2- Set-up

% Detection
imageDim = [720, 1280];
scale_1 = [416, 416];
subImageNum = 4;
detectThres = 0.2;
% Localization
names =   [{'navy_16'};{'nonNavy'}];
classesNames = categorical(names{1});
scale_2 = [704, 704];
locThres = 0.4;
NMS = 0.75; % non-maximum-suppresion threshold for overlapping of two boundingBox, if it is bigger than this FAlSE
% Recognition
scale_3 = [416, 416];
% Identification
scale_4 = [416, 416];
