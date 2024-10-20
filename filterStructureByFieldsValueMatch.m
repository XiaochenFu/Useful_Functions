% 1. Filter for exact field value match
function filteredData = filterStructureByFieldsValueMatch(data, fieldNames, fieldValues)
    % Filter structure for exact match of field values
    validIndices = [];
    for i = 1:length(data)
        if isEntryValueMatch(data(i), fieldNames, fieldValues)
            validIndices = [validIndices, i];
        end
    end
    filteredData = data(validIndices);
end

function isValid = isEntryValueMatch(entry, fieldNames, fieldValues)
    isValid = true;
    for j = 1:length(fieldNames)
        if ~isequal(entry.(fieldNames{j}), fieldValues{j})
            isValid = false;
            break;
        end
    end
end