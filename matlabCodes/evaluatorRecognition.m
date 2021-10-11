function [recogFlag,recogFlag2] = evaluatorRecognition (gTruth, pred)
%% E V A L U A T O R
% Evaluates recognition according to sub groups -similiar groupscheckSet = testImgs;

recogFlag = 0;
recogFlag2 = 0;

if pred ~= gTruth
    switch pred
        %% ----------------------------------------------------------------------
        case categorical({'bulkCarrier_10'})
            switch gTruth
                case categorical({'oreCarrier_14'})
%                     recogFlag = 1;
                    recogFlag2 = 1;
                case categorical({'generalCargo_1'})
%                     recogFlag = 1;
                    recogFlag2 = 1;
                otherwise
                    recogFlag = 0;
            end
        case categorical({'generalCargo_1'})
            switch gTruth
                case categorical({'bulkCarrier_10'})
%                     recogFlag = 1;
                    recogFlag2 = 1;
                case categorical({'oreCarrier_14'})
%                     recogFlag = 1;
                    recogFlag2 = 1;
                otherwise
                    recogFlag = 0;
            end
        case categorical({'oreCarrier_14'})
            switch gTruth
                case categorical({'generalCargo_1'})
%                     recogFlag = 1;
                    recogFlag2 = 1;
                case categorical({'bulkCarrier_10'})
%                     recogFlag = 1;
                    recogFlag2 = 1;
                otherwise
                    recogFlag = 0;
            end
            %% ----------------------------------------------------------------------
        case categorical({'dredging_15'})
            switch gTruth
                case categorical({'bargePontoon_7'})
%                     recogFlag = 1;
                    recogFlag2 = 1;
                otherwise
                    recogFlag = 0;
            end
        case categorical({'bargePontoon_7'})
            switch gTruth
                case categorical({'dredging_15'})
%                     recogFlag = 1;
                    recogFlag2 = 1;
                otherwise
                    recogFlag = 0;
            end
       
            % -----------------------------------------------------------------------
        
        case categorical({'oilTanker_12'})
            switch gTruth
                case categorical({'tanker_13'})
%                     recogFlag = 1;
                    recogFlag2 = 1;
%                 case categorical({'lpg_17'})
%                     recogFlag = 1;
%                     recogFlag2 = 1;
                otherwise
                    recogFlag = 0;
            end
        case categorical({'tanker_13'})
            switch gTruth
                case categorical({'oilTanker_12'})
%                     recogFlag = 1;
                    recogFlag2 = 1;
%                 case categorical({'lpg_17'})
%                     recogFlag = 1;
%                     recogFlag2 = 1;
                otherwise
                    recogFlag = 0;
            end
            % -----------------------------------------------------------------------
        case categorical({'smallBoat_34'})
            switch gTruth
                case categorical({'yatch_18'})
%                     recogFlag = 1;
                    recogFlag2 = 1;
                case categorical({'smallPassangerShip_33'})
%                     recogFlag = 1;
                    recogFlag2 = 1;
                case categorical({'tug_5'})
%                     recogFlag = 1;
                    recogFlag2 = 1;
                case categorical({'fishing_9'})
%                     recogFlag = 1;
                    recogFlag2 = 1;
                otherwise
                    recogFlag = 0;
            end
        case categorical({'smallPassangerShip_33'})
            switch gTruth
                case categorical({'yatch_18'})
%                     recogFlag = 1;
                    recogFlag2 = 1;
                case categorical({'smallBoat_34'})
%                     recogFlag = 1;
                    recogFlag2 = 1;
                case categorical({'tug_5'})
%                     recogFlag = 1;
                    recogFlag2 = 1;
                case categorical({'fishing_9'})
%                     recogFlag = 1;
                    recogFlag2 = 1;
                otherwise
                    recogFlag = 0;
            end
        case categorical({'yatch_18'})
            switch gTruth
                case categorical({'smallBoat_34'})
%                     recogFlag = 1;
                    recogFlag2 = 1;
                case categorical({'smallPassangerShip_33'})
%                     recogFlag = 1;
                    recogFlag2 = 1;
                case categorical({'tug_5'})
%                     recogFlag = 1;
                    recogFlag2 = 1;
                case categorical({'fishing_9'})
%                     recogFlag = 1;
                    recogFlag2 = 1;
                otherwise
                    recogFlag = 0;
            end
        case categorical({'tug_5'})
            switch gTruth
                case categorical({'smallBoat_34'})
%                     recogFlag = 1;
                    recogFlag2 = 1;
                case categorical({'smallPassangerShip_33'})
%                     recogFlag = 1;
                    recogFlag2 = 1;
                case categorical({'yatch_18'})
%                     recogFlag = 1;
                    recogFlag2 = 1;
                case categorical({'fishing_9'})
%                     recogFlag = 1;
                    recogFlag2 = 1;
                otherwise
                    recogFlag = 0;
            end
            
        case categorical({'fishing_9'})
            switch gTruth
                case categorical({'smallBoat_34'})
%                     recogFlag = 1;
                    recogFlag2 = 1;
                case categorical({'tug_5'})
%                     recogFlag = 1;
                    recogFlag2 = 1;
                case categorical({'smallPassangerShip_33'})
%                     recogFlag = 1;
                    recogFlag2 = 1;
                case categorical({'yatch_18'})
%                     recogFlag = 1;
                    recogFlag2 = 1;
                case categorical({'fishing_9'})
%                     recogFlag = 1;
                    recogFlag2 = 1;
                otherwise
                    recogFlag = 0;
            end
 
% -----------------------------------------------------------------------                    
        case categorical({'navy_16' })
            switch gTruth
                case categorical({'submarine_100'})
%                     recogFlag = 1;
                    recogFlag2 = 1;
                case categorical({'aircraft_200'})
%                     recogFlag = 1;
                    recogFlag2 = 1;
                case categorical({'cruiser_300'})
%                     recogFlag = 1;
                    recogFlag2 = 1;
                case categorical({'destroyer_400'})
%                     recogFlag = 1;
                    recogFlag2 = 1;
                case categorical({'frigate_500'})
%                     recogFlag = 1;
                    recogFlag2 = 1;
                case categorical({'patrolForce_600'})
%                     recogFlag = 1;
                    recogFlag2 = 1;
                case categorical({'landing_700'})
%                     recogFlag = 1;
                    recogFlag2 = 1;
                case categorical({'coastGuard_800'})
%                     recogFlag = 1;
                    recogFlag2 = 1;
                case categorical({'auxilary_900'})
%                     recogFlag = 1;
                    recogFlag2 = 1;
                case categorical({'serviceCraft_1000'})
%                     recogFlag = 1;
                    recogFlag2 = 1;
                case categorical({'other_1100'})
%                     recogFlag = 1;
                    recogFlag2 = 1;
                otherwise
                    recogFlag = 0;
            end
        otherwise 
            recogFlag = 0;
    end
else
    recogFlag = 1;
end

