function  output = reflection(input, minlimit, maxlimit)
%% REFLECTION
    output = minlimit + abs(input - minlimit);
    output = maxlimit - abs(maxlimit - output);
    
    rereflectCondition = or(output < minlimit,  output > maxlimit);
    rereflect = output(rereflectCondition);
    
    if ~isempty(rereflect)
        output(rereflectCondition) = reflection(rereflect, minlimit, maxlimit);
    end
end