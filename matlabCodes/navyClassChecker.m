function [navyFlag] = navyClassChecker (class2checked)
%% E V A L U A T O R
% check if class belongs to Navy or SubNavy class
switch class2checked
    case categorical({'submarine_100'})
        navyFlag = 1;
    case categorical({'aircraft_200'})
        navyFlag = 1;
    case categorical({'cruiser_300'})
        navyFlag = 1;
    case categorical({'destroyer_400'})
        navyFlag = 1;
    case categorical({'frigate_500'})
        navyFlag = 1;
    case categorical({'patrolForce_600'})
        navyFlag = 1;
    case categorical({'landing_700'})
        navyFlag = 1;
    case categorical({'coastGuard_800'})
        navyFlag = 1;
    case categorical({'auxilary_900'})
        navyFlag = 1;
    case categorical({'serviceCraft_1000'})
        navyFlag = 1;
    case categorical({'other_1100'})
        navyFlag = 1;
    case categorical({'navy_16'})
        navyFlag = 1;
    otherwise
        navyFlag = 0;
end

end
