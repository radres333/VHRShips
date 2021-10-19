%% HieD Main
% Description: This function adjusts the pre-requites
% Date:  2021 05 01
% Author: Serdar KIZILKAYA
% Sections: 1. Input 2. Set-up 
% Prerequites: 1. Trained DLRI networks 2. Test Data 3. Matlab enviroment with appropriate add-ons


%% SECTION -1- Input

% >>> LOAD > test images 
gTruthLabels = testList;
% >>> LOAD > pretrained networks
% Detection
% >>> FILL > your local folder address
load('C:\...\HieD_detection.mat');
netDetect = HieD_detection;
% Localization
% >>> ADD > the path of the cfg and weights folder to the current folder of the MATLAB
cfgfile = 'yolov4-obj_C2.cfg';
weightfile = 'yolov4_HieD_Localization.weights.weights';
% Recognition
% >>> FILL > your local folder address
load('C:\...\HieD_recognition.mat');
netRecog = HieD_recognition;
% Identification
% >>> FILL > your local folder address
load('C:\...\HieD_identification.mat');
netId = HieD_identification;

%% SECTION -2- Set-up

% Detection
imageDim = [720, 1280];
scale_1 = [416, 416];
subImageNum = 4;
detectThres = 0.2;
% Localization
names =   [{'navy_16'};{'nonNavy'}];
classesNames = categorical(names);
scale_2 = [704, 704];
locThres = 0.4;
NMS = 0.75; % non-maximum-suppresion threshold for overlapping of two boundingBox, if it is bigger than this FAlSE
% Recognition
scale_3 = [416, 416];
% Identification
scale_4 = [416, 416];
