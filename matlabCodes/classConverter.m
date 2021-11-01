function [output] = classConverter (input)
%% E V A L U A T O R

% convert class variable from c34 distribution to c24
input = categorical(input);


    switch input
        %% ----------------------------------------------------------------------
        case categorical({'ferry_2'})
           output = categorical({'ferry_2'});
        case categorical({'roro_3'})
           output = categorical({'roro_3'});
        case categorical({'passanger_4'})
           output = categorical({'passanger_4'});
        case categorical({'offshore_6'})
           output = categorical({'offshore_6'});
        case categorical({'container_11'})
           output = categorical({'container_11'});  
        case categorical({'lpg_17'})
           output = categorical({'lpg_17'});
        case categorical({'drill_19'})
           output = categorical({'drill_19'});           
        case categorical({'undefined_20'})
           output = categorical({'undefined_20'});  
        case categorical({'dredgerReclamation_32'})
           output = categorical({'dredgerReclamation_32'});  
        case categorical({'coaster_35'})
           output = categorical({'coaster_35'});  
        case categorical({'floatingDock_36'})
           output = categorical({'floatingDock_36'});  
         
        case categorical({'bulkCarrier_10'})
           output = categorical({'generalCargo_1'});
        case categorical({'generalCargo_1'})
            output = categorical({'generalCargo_1'});
        case categorical({'oreCarrier_14'})
            output = categorical({'generalCargo_1'});
            
        case categorical({'dredging_15'})
            output = categorical({'bargePontoon_7'});
        case categorical({'bargePontoon_7'})
            output = categorical({'bargePontoon_7'});

        case categorical({'oilTanker_12'})
            output = categorical({'tanker_13'});
        case categorical({'tanker_13'})
            output = categorical({'tanker_13'});

        case categorical({'smallBoat_34'})
            output = categorical({'smallBoat_34'});
        case categorical({'yatch_18'})
            output = categorical({'smallBoat_34'});
        case categorical({'smallPassanger_33'})
            output = categorical({'smallBoat_34'});
        case categorical({'tug_5'})
            output = categorical({'smallBoat_34'});
        case categorical({'fishing_9'})
            output = categorical({'smallBoat_34'});            
                    
%         case categorical({'navy_16' })
 
        case categorical({'submarine_100'})
            output = categorical({'submarine_100'});
        case categorical({'aircraft_200'})
            output = categorical({'aircraft_200'});
            
        case categorical({'cruiser_300'})
            output = categorical({'destroyer_400'});
        case categorical({'destroyer_400'})
            output = categorical({'destroyer_400'});
        case categorical({'frigate_500'})
            output = categorical({'destroyer_400'});
        case categorical({'patrolForce_600'})
            output = categorical({'destroyer_400'});
            
        case categorical({'landing_700'})
            output = categorical({'landing_700'});
        case categorical({'coastGuard_800'})
            output = categorical({'coastGuard_800'});
        case categorical({'auxilary_900'})
            output = categorical({'auxilary_900'});
        case categorical({'serviceCraft_1000'})
            output = categorical({'serviceCraft_1000'});
        case categorical({'other_1100'})
            output = categorical({'other_1100'});    

end

