# Hierarchical-Design-for-DLRI-of-Navy-Ships-in-the-Optical-Satellite-Image
This study focuses on all stages of ship classification in the optical satellite images. The proposed “Hierarchical Design (HieD)” approach, which is based on deep learning techniques, performs Detection, Localization, Recognition and Identification (DLRI) of the ships in the optical satellite images. HieD is an end-to-end approach which allows the optimization of each stage of the DLRI independently. A unique and rich ship dataset (High Resolution Ships, HRShips), which is formed by the Google Earth Pro software, is used in this study. While Xception network is used in detection, recognition and identification stages; YOLOv4 is preferred for the localization of the ships. 

The Steps to be Followed to Run the Code:
1. Download "matlabCodes" and "YOLOv4" folders (https://drive.google.com/drive/folders/1cl0vQa78Yhslxdry5QGHUOhqNCYPQXjx?usp=sharing)
2. Download testData, testList, trainedNets and weights
3. Open MATLAB
4. Add the path of folders which are downloaded at step 2
5. open "sK_HieD_fileRootFixerV1.m", execute the orders defined with ">>>" sign and, execute the script
6. open "sK_HieD_mainV1.m", execute the orders defined with ">>>" sign and, execute the script
7. open "sK_HieD_loopV1.m", execute the orders defined with ">>>" sign and, execute the script
8. open "sK_HieD_evaluatorV1.m", execute the orders defined with ">>>" sign and, execute the script
