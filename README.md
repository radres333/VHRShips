# VHRShips: An extensive benchmark dataset for scalable deep learning-based ship detection applications
This study focuses on all stages of ship classification in optical satellite images. We proposed a deep learning-based “Hierarchical Design (HieD)” approach performing Detection, Localization, Recognition, and Identification (DLRI) of the ships in optical satellite images. HieD is an end-to-end approach that allows the optimization of each stage of the DLRI independently. We generated a unique and rich ship dataset (Very High Resolution Ships, VHRShips) using Google Earth images including diversity of ship types and data acquisition conditions. While the Xception network is used in detection, recognition, and identification stages; YOLOv4 is preferred for the localization of the ships. 
We found F1-Scores for DLRI stages are respectively 99.17 / 94.20 / 84.08 / 82.13 percent; end to end F1-Scores are 99.17 / 93.43 / 74.00 / 57.05 for the same order.

The Steps to be Followed to Run the Code:
1. Download "matlabCodes" and "YOLOV4" folders 
2. Download "testList.mat", "trainedNets_Weights" and "test_c34.7z" (test images) from https://drive.google.com/drive/folders/1cl0vQa78Yhslxdry5QGHUOhqNCYPQXjx?usp=sharing
3. Open MATLAB
4. Add the path of downloaded files at the step 1 and 2
5. open "sK_HieD_fileRootFixerV1.m", execute the orders defined with ">>>" sign and, execute the script
6. open "sK_HieD_mainV1.m", execute the orders defined with ">>>" sign and, execute the script
7. open "sK_HieD_loopV1.m", execute the orders defined with ">>>" sign and, execute the script
8. open "sK_HieD_evaluatorV1.m", execute the orders defined with ">>>" sign and, execute the script
9. execute "sK_HieD_visualizeV1.m"

# Dataset
VHRShips comprises of 6312 optical satellite images collected from Google Earth. While 1000 images don’t include any ship, rest of them consist 11337 ships in 34 different classes. VHRShips has high definition, inshore and offshore images from various locations, rich metafile content and includes noisy images representing real scenarios.

Metafile\
Image Order\tab               : 1-6312\
Image Location            : (List of the locations given in the article)\
Image Date                : YYYYMMDD (Year Month Day)\
Image Quality             : 1-3 (3: good (clear); 2: moderate (low resolution, glint); 1: poor (cloudy, haze))\
Ship Existence            :  0 / 1 (0: non-exist; 1: exist)\
Number of ship(s)         : 0-118\
Length of the longest ship: 7-408 meters\
Explanation_1             : 1-7 (1:Alongside vessel, 2: Ship in ballast, 3: Open hatch, 4: Be towed, 5: Discharging water, 6: Tagging, 7: At pier)\
Explanation_2             : Free style comment\
Name of 23 parent classes and 11 eleven child classes (navy is excluded) : x, y, width, height (Bounding box information of ship(s) distributed to the classes)\
