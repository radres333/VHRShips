%% HieD Visualize
% Description: This function visualizes the output of HieD
% Date:  2021 05 01
% Author: Serdar KIZILKAYA
% Sections: 
% Prerequites: 1. run sK_HieD_mainV1.m 2. run sK_HieD_loopV1.m 3. Matlab enviroment with appropriate add-ons

GTruth = table2cell(gTruthLabels);
gTruthLabels = gTruthLabels;

tempIndex = 1;
for i = 1:size(gTruthLabels,1)
    tempRead = gTruthLabels{i,1};
    image = imread(tempRead{1,1});
    if recogIde{i,1} == 1
        tempBox =  recogIde{i,2};
        tempRecog = recogIde{i,4};
        tempIde = recogIde{i,5};
        navyIndex = 0;
        for x = 1: size(recogIde{i,2},1)
            tempRecogIndex = tempRecog(x,1);
            if categorical(tempRecogIndex) == categorical ({'navy_16'})
                navyIndex = navyIndex +1;
                annotations = string(tempIde(navyIndex,1));
            else
                annotations = string(tempRecog(x,1));
            end
            
            image = insertShape(image,'rectangle',tempBox(x,:)); % ,'LineWidth',2,'Color','red','TextColor','black');
            
            temp = tempBox(x,:);
            circleCoor = [temp(1)+temp(3)/2, temp(2)+temp(4)/2, 5];
            image = insertShape(image,'circle',circleCoor,'LineWidth',2);
            temp2 = [temp(1), temp(2)+temp(4)];
            image = insertText(image,temp2,annotations);
        end
    end
    if isempty(GTruth{i,2}) == 0
        tempBox = GTruth{i,2};
        tempRecog = GTruth{i,3};
        for x = 1: size(tempBox,1)
            temp = classConverter(tempRecog(x,1));
            annotations = string(temp);
            image = insertObjectAnnotation(image,'rectangle',tempBox(x,:),annotations,'LineWidth',...
                2,'Color','red','TextColor','black');%'HorizontalAlignment','right',
        end
    end
    figure (i);
    imshow (image)
    pause
    close
end
