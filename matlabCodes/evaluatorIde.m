function [ideFlag,ideFlag2] = evaluatorIde (gTruth, pred)
%% E V A L U A T O R
% Evaluates identification according to sub groups -similiar groupscheckSet = testImgs;

ideFlag = 0;
ideFlag2 = 0;

if pred ~= gTruth
    switch pred
  
        case categorical({'cruiser_300'})
            switch gTruth
                case categorical({'destroyer_400'})
                    ideFlag2 = 1;
                case categorical({'frigate_500'})
                    ideFlag2 = 1;
                case categorical({'patrolForce_600'})
                    ideFlag2 = 1;
                otherwise
                    ideFlag = 0;
            end
        case categorical({'destroyer_400'})
            switch gTruth
                case categorical({'cruiser_300'})
                    ideFlag2 = 1;
                case categorical({'frigate_500'})
                    ideFlag2 = 1;
                case categorical({'patrolForce_600'})
                    ideFlag2 = 1;
                otherwise
                    ideFlag = 0;
            end
        case categorical({'frigate_500'})
            switch gTruth
                case categorical({'cruiser_300'})
                    ideFlag2 = 1;
                case categorical({'destroyer_400'})
                    ideFlag2 = 1;
                case categorical({'patrolForce_600'})
                    ideFlag2 = 1;
                otherwise
                    ideFlag = 0;
            end
        case categorical({'patrolForce_600'})
            switch gTruth
                case categorical({'cruiser_300'})
                    ideFlag2 = 1;
                case categorical({'destroyer_400'})
                    ideFlag2 = 1;
                case categorical({'frigate_500'})
                    ideFlag2 = 1;
                otherwise
                    ideFlag = 0;
            end
        otherwise
            ideFlag = 0;
    end
else
    ideFlag = 1;
end
end
