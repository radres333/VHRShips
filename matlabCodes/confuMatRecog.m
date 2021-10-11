function [gT_catIndex] = confuMatRecog (gT_recog)
%% find index of ground truth according to the recognition class dist
temp = categorical(gT_recog);
    switch temp
        %% ----------------------------------------------------------------------
        case categorical({'bulkCarrier_10'})
            gT_catIndex = 1;
        case categorical({'generalCargo_1'})
            gT_catIndex = 1;
        case categorical({'oreCarrier_14'})
            gT_catIndex = 1;
            
        case categorical({'ferry_2'})
            gT_catIndex = 2;
        case categorical({'roro_3'})
            gT_catIndex = 3;
        case categorical({'passanger_4'})
            gT_catIndex = 4;
        case categorical({'offshore_6'})
            gT_catIndex = 5;
            
        case categorical({'bargePontoon_7'})
            gT_catIndex = 6;
        case categorical({'dredging_15'})
            gT_catIndex = 6;
            
        case categorical({'smallBoat_34'})
            gT_catIndex = 14;
        case categorical({'smallPassanger_33'})
            gT_catIndex = 14;
        case categorical({'tug_5'})
            gT_catIndex = 14;
        case categorical({'fishing_9'})
            gT_catIndex = 14;
        case categorical({'yatch_18'})
            gT_catIndex = 14;
        
        case categorical({'container_11'})
            gT_catIndex = 7;
            
        case categorical({'oilTanker_12'})
            gT_catIndex = 8;
        case categorical({'tanker_13'})
            gT_catIndex = 8;
            
        case categorical({'submarine_100'})
            gT_catIndex = 9;
        case categorical({'aircraft_200'})
            gT_catIndex = 9;
        case categorical({'cruiser_300'})
            gT_catIndex = 9;
        case categorical({'destroyer_400'})
            gT_catIndex = 9;
        case categorical({'frigate_500'})
            gT_catIndex = 9;
        case categorical({'patrolForce_600'})
            gT_catIndex = 9;
        case categorical({'landing_700'})
            gT_catIndex = 9;
        case categorical({'coastGuard_800'})
            gT_catIndex = 9;
        case categorical({'auxilary_900'})
            gT_catIndex = 9;
        case categorical({'serviceCraft_1000'})
            gT_catIndex = 9;
        case categorical({'other_1100'})
            gT_catIndex = 9;
        case categorical({'navy_16'})
            gT_catIndex = 9;
            
        case categorical({'lpg_17'})
            gT_catIndex = 10;
        case categorical({'drill_19'})
            gT_catIndex = 11;
        case categorical({'undefined_20'})
            gT_catIndex = 12;
        case categorical({'dredgerReclamation_32'})
            gT_catIndex = 13;
        case categorical({'coaster_35'})
            gT_catIndex = 15;
        case categorical({'floatingDock_36'})
            gT_catIndex = 16;
        otherwise
            gT_catIndex = 17;
    end

end

