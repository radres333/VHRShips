# VHRShips: An extensive benchmark dataset for scalable deep learning-based ship detection applications
This study focuses on all stages of ship classification in optical satellite images. We proposed a deep learning-based “Hierarchical Design (HieD)” approach performing Detection, Localization, Recognition, and Identification (DLRI) of the ships in optical satellite images. HieD is an end-to-end approach that allows the optimization of each stage of the DLRI independently. We generated a unique and rich ship dataset (Very High Resolution Ships, VHRShips) using Google Earth images including diversity of ship types and data acquisition conditions. While the Xception network is used in detection, recognition, and identification stages; YOLOv4 is preferred for the localization of the ships. 
We found F1 Scores for DLRI stages are respectively 99.17 / 94.20 / 84.08 / 82.13 percent; end to end F1 Scores are 99.17 / 93.43 / 74.00 / 57.05 for the same order.

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
