function [gT_catIndex] = confuMatIDe (gT_recog)
%% find index of ground truth according to the identification distribution
temp = categorical(gT_recog);
    switch temp
        %% ----------------------------------------------------------------------
                   
        case categorical({'submarine_100'})
            gT_catIndex = 1;
        case categorical({'aircraft_200'})
            gT_catIndex = 2;
        case categorical({'cruiser_300'})
            gT_catIndex = 3;
        case categorical({'destroyer_400'})
            gT_catIndex = 3;
        case categorical({'frigate_500'})
            gT_catIndex = 3;
        case categorical({'patrolForce_600'})
            gT_catIndex = 3;
        case categorical({'landing_700'})
            gT_catIndex = 4;
        case categorical({'coastGuard_800'})
            gT_catIndex = 5;
        case categorical({'auxilary_900'})
            gT_catIndex = 6;
        case categorical({'serviceCraft_1000'})
            gT_catIndex = 7;
        case categorical({'other_1100'})
            gT_catIndex = 8;   
        otherwise
            gT_catIndex = 9;
    end

end

