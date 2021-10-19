function [labels, falseNegative, assignment, wasDetected] = ...
    checkDet2gT(bbox, groundTruthBoxes, threshold, scores)
% Check detections ground truth  
% Input:
%  bbox and scores are detector outputs
%  groundTruth are ground truth bboxes
%  threshold is the overlap threshold for assignment
%
% Output:
%  labels is the "label" assigned to each detection.
%  falseNegative is the number of false negatives
%  assigment is the ground truth box that the detection is assigned to.


% background label
bgLabel = 0;

% foreground object label
fgLabel = 1;

numDetections = size(bbox,1);

% track which gt a detection is matched to
assignment = zeros(numDetections,1);

labels = repelem(bgLabel,numDetections, 1);

if isempty(groundTruthBoxes)
    falseNegative = 0;
    return
end

if ~isempty(scores)
    % sort detections by score
    [~, idx] = sort(scores, 'descend');
    bbox = bbox(idx,:);
end

iou = bboxOverlapRatio(bbox, groundTruthBoxes, 'union');

% track which gt was detected
wasDetected = false(size(groundTruthBoxes,1),1);

% assign detections to ground truth
for i = 1:numDetections        
    
    [v, assignment(i)] = max( iou(i,:) );
        
    if v >= threshold                
        
        labels(i) = fgLabel;   
                
        wasDetected(assignment(i)) = true;
        
        % remove gt from future consideration. This penalizes multiple
        % detections that overlap one ground truth box, i.e. it is considered
        % a false positive.
        iou(:,assignment(i)) = -inf;  
    else
        % detection not assigned to any ground truth
        labels(i) = bgLabel;
        assignment(i) = 0;
    end
end

% return false negatives, these are ground detections that were missed. 
falseNegative = sum(~wasDetected);

if ~isempty(scores)
    % unsort to keep original order of input.
    unsort(idx) = 1:numel(scores);
    labels = labels(unsort);
    assignment = assignment(unsort);
end

