%% File Root Fixer
% Description: This function changes the root of the test file
% Date:  2021 05 01
% Author: Serdar KIZILKAYA
% Sections: -
% Prerequites: 1. Matlab enviroment with appropriate add-ons

% >>> ENTER > the address of testList
load ('...\testList.mat'); 
gTruthLabels = testList;
tempAddress = table2cell(gTruthLabels(:,1));
oldPathPixelLabel = 'C:\..\testImageFolder\';
% >>> DEFINE > the address of test images' file ("test_c34") in your local
newPathPixelLabel = 'X:\..\testImageFolder\';
newPath = replace(tempAddress, oldPathPixelLabel, newPathPixelLabel);
newPath = cell2table(newPath);
testList(:,1) = newPath;


